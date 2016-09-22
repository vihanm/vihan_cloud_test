variable control_cidr {
  description = "CIDR for maintenance: inbound traffic will be allowed from this IPs"
}

variable default_keypair_public_key {
  description = "Public Key of the default keypair"
}

variable default_keypair_name {
  description = "Name of the KeyPair used for all nodes"
  default = "kubernetes-key"
}


variable vpc_name {
  description = "Name of the VPC"
  default = "kubernetes"
}

variable elb_name {
  description = "Name of the ELB for Kubernetes API"
  default = "kubernetes"
}

variable owner {
  default = "Vihan"
}

variable ansibleFilter {
  description = "`ansibleFilter` tag value added to all instances, to enable instance filtering in Ansible dynamic inventory"
  default = "Kubernetes01" # IF YOU CHANGE THIS YOU HAVE TO CHANGE instance_filters = tag:ansibleFilter=Kubernetes01 in ./ansible/hosts/ec2.ini
}

# Networking setup
variable region {
  default = "us-west-1"
}

variable zone {
  default = "us-west-1c"
}

variable vpc_cidr {
  default = "10.43.0.0/16"
}

variable kubernetes_pod_cidr {
  default = "10.200.0.0/16"
}


# Instances Setup
variable default_ami {
  description = "Default AMI for all nodes"
  default = "ami-049d8641" // Unbuntu 14.04 
}
variable default_instance_user {
  default = "ubuntu"
}

variable etcd_instance_type {
  default = "t2.micro"
}
variable controller_instance_type {
  default = "t2.micro"
}
variable worker_instance_type {
  default = "t2.micro"
}


variable kubernetes_cluster_dns {
  default = "10.31.0.1"
}
