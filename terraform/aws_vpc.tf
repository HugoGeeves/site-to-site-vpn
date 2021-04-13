module "aws_network" {
  source                    = "./modules/network"
  vpc_cidr_block            = "10.0.0.0/16"
  public_subnet_cidr_block  = "10.0.1.0/24"
  private_subnet_cidr_block = "10.0.2.0/24"
}

resource "aws_instance" "bastion" {
  ami                    = "ami-096cb92bb3580c759"
  key_name               = aws_key_pair.bastion_key.key_name
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.bastion-sg.id]
  subnet_id              = module.aws_network.public_subnet_id
}

resource "aws_security_group" "bastion-sg" {
  name   = "bastion-security-group"
  vpc_id = module.aws_network.vpc_id

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "bastion_key" {
  key_name   = "your_key_name"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDXgfyUC1a64YNRVpwJz1IsGJDd9MWgYFjOcdkmrOWKDws4pVud+lxve+/g9V3Caer/cwZI1mxaRLd5WMf44WYhHWSW6w8KmaDwX6xrMLlTr/AsiyQn3eaXppJWNKt1dW66i0asa4jvDqV9Qx37Q+xh7+gLsj3f8yo2X+bvjk/M3ZwEW11gVYVwMyolQqNHjG/72XWyxDnwATP6Yw8pAs4x8OGyiwUUOTYdt5bDlMjiMgAmYz/5zVXOAHhgAcnhY0iwpRv1npZE+pSk38PfNwmg/27WE8Fd4qjqE2LB+j04+kR1pqIub5OVh6u2MXcd2Yd+LJAkJh7JcoRcuL9nCFaALAjByUNtVHjzQOAFW13FTq+3NYOnknDAz/zqpAYTPsz3cmj4Hm89EQfh5tb9MH2+yP8SJOwGGL8cGoKR68ZnciabRU4Gw9c+wVsVVdSnDA4LMOYSSUmP5QB8DzgMfGOo+ELEszn+oDVgqEcXZsUDxosWl5a4/zl9Y+U5f85+T8z4Gwc59pP+CbUMymBlMWQy8aVKnW4CHDORUo1Q0kGYUINDs9mN0oZV6Cp2m7HT2A2be7MqEt2jHFRICK1y8LGE91/glSLgi19qPp5Rdnuw2wrkVkcXLkm1iaB/Fe581W82S015bd+GpAf0TclJRY9TyDtNLdEwyf8K9Vp1XLuGXw== your_email@example.com"
}