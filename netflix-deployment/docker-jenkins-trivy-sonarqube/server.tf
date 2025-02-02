module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "netflix-server"

  instance_type          = var.instance_type
  key_name               = var.key_name
  ami                    = var.ami_id
  monitoring             = true
  vpc_security_group_ids = [module.sg.security_group_id]
  subnet_id              = var.subnet_id
  user_data              = file("install.sh")
  root_block_device = [
    {
      volume_size = "25"
      volume_type = "gp3"
    }
  ]

  tags = {
    Terraform   = "true"
    Environment = "dev"
    name        = "netflix-server"
  }
}

resource "aws_eip" "eip" {
  instance = module.ec2_instance.id
  domain   = "vpc"
}