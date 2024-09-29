locals {
  name   = "test-robb"
  region = "eu-west-3"

  vpc_cidr = "10.0.0.0/16"
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)

  cluster_autoscaler_enabled = false
  
  ec2_client_vpn_enabled = true
  vpn_allowed_cidr_blocks = ["xxx.xxx.xxx.xxx/32"]
  vpn_client_cidr = "10.1.0.0/22"

  tags = {
    Test = "test"
  }
}