## Testing myBlogApp provisioning on infrastructure cluster using AWS, Terraform, Ansible, Kubernetes

- AWS VPC
- 3 EC2 instances for HA Kubernetes Control Plane: Kubernetes API, Scheduler and Controller Manager
- 3 EC2 instances for *etcd* cluster
- 3 EC2 instances as Kubernetes Workers (aka Minions or Nodes)
- Kubenet Pod networking (using CNI)
- HTTPS between components and control API
- *nginx* service deployed to check everything works

## *This is a testing exercise, not a production-ready setup*

## Requirements on control machine:

- Terraform (tested with Terraform 0.7.0)
- Python (tested with Python 2.7.12)
- Python *netaddr* module
- Ansible (tested with Ansible 2.1.0.0)
- Kubernetes CLI
- SSH Agent
- AWS CLI

### AWS KeyPair

A valid AWS Identity (`.pem`) file and the corresponding Public Key should be generated / facilitated (if exist). Ansible uses the Identity to SSH into machines.

### Terraform and Ansible authentication

Both Terraform and Ansible expect AWS credentials set in environment variables:
```
$ export AWS_ACCESS_KEY_ID=<access-key-id>
$ export AWS_SECRET_ACCESS_KEY="<secret-key>"
```

If you plan to use AWS CLI you have to set `AWS_DEFAULT_REGION`.

Ansible expects the SSH identity loaded by SSH agent:
```
$ ssh-add <keypair-name>.pem
```

## Defining the environment

Terraform expects some variables to define your working environment:

- `control_cidr`: The CIDR of your IP. All instances will accept only traffic from this address only. Note this is a CIDR, not a single IP. e.g. `123.45.67.89/32` (mandatory)
- `default_keypair_public_key`: Valid public key corresponding to the Identity you will use to SSH into VMs. e.g. `"ssh-rsa AAA....xyz"` (mandatory)

**Note that Instances and Kubernetes API will be accessible only from the "control IP"**. If you fail to set it correctly, you will not be able to SSH into machines or run Ansible playbooks.

You may optionally redefine:

- `default_keypair_name`: AWS key-pair name for all instances.  (Default: "k8s-not-the-hardest-way")
- `vpc_name`: VPC Name. Must be unique in the AWS Account (Default: "kubernetes")
- `elb_name`: ELB Name for Kubernetes API. Can only contain characters valid for DNS names. Must be unique in the AWS Account (Default: "kubernetes")
- `owner`: `Owner` tag added to all AWS resources. No functional use. It becomes useful to filter your resources on AWS console if you are sharing the same AWS account with others. (Default: "kubernetes")


The easiest way is creating a `terraform.tfvars` [variable file](https://www.terraform.io/docs/configuration/variables.html#variable-files) in `./terraform` directory. Terraform automatically imports it.

Sample `terraform.tfvars`:
```
default_keypair_public_key = "ssh-rsa AAA...zzz"
control_cidr = "123.45.67.89/32"
default_keypair_name = "vihan-glf"
vpc_name = "Vihan ETCD"
elb_name = "vihan-etcd"
owner = "Vihan"
```


### Changing AWS Region

By default, the project uses `us-west-1`. To use a different AWS Region, set additional Terraform variables:

- `region`: AWS Region (default: "us-west-1").
- `zone`: AWS Availability Zone (default: "us-west-1c")
- `default_ami`: Pick the AMI for the new Region from https://cloud-images.ubuntu.com/locator/ec2/: Ubuntu 14.04 LTS (deb), HVM:EBS-SSD

