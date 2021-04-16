resource "aws_instance" "instance" {
  ami                    = var.ami
  key_name               = aws_key_pair.key_pair.key_name
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.sg.id]
  source_dest_check      = var.source_dest_check
}

resource "aws_security_group" "sg" {
  name   = "${var.name}_security_group"
  vpc_id = var.vpc.vpc_id

  ingress = [{
    cidr_blocks = [
      "0.0.0.0/0",
    ]
    description      = ""
    from_port        = 22
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = []
    self             = false
    to_port          = 22
    }, {
    cidr_blocks = [
      "10.0.0.0/16",
      "10.1.0.0/16",
    ]
    description      = ""
    from_port        = -1
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "icmp"
    security_groups  = []
    self             = false
    to_port          = -1
    },
    {
      cidr_blocks = [
        "10.0.0.0/16",
        "10.1.0.0/16",
      ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 65535
  }]

  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "key_pair" {
  key_name   = "${var.name}_key_pair"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDXgfyUC1a64YNRVpwJz1IsGJDd9MWgYFjOcdkmrOWKDws4pVud+lxve+/g9V3Caer/cwZI1mxaRLd5WMf44WYhHWSW6w8KmaDwX6xrMLlTr/AsiyQn3eaXppJWNKt1dW66i0asa4jvDqV9Qx37Q+xh7+gLsj3f8yo2X+bvjk/M3ZwEW11gVYVwMyolQqNHjG/72XWyxDnwATP6Yw8pAs4x8OGyiwUUOTYdt5bDlMjiMgAmYz/5zVXOAHhgAcnhY0iwpRv1npZE+pSk38PfNwmg/27WE8Fd4qjqE2LB+j04+kR1pqIub5OVh6u2MXcd2Yd+LJAkJh7JcoRcuL9nCFaALAjByUNtVHjzQOAFW13FTq+3NYOnknDAz/zqpAYTPsz3cmj4Hm89EQfh5tb9MH2+yP8SJOwGGL8cGoKR68ZnciabRU4Gw9c+wVsVVdSnDA4LMOYSSUmP5QB8DzgMfGOo+ELEszn+oDVgqEcXZsUDxosWl5a4/zl9Y+U5f85+T8z4Gwc59pP+CbUMymBlMWQy8aVKnW4CHDORUo1Q0kGYUINDs9mN0oZV6Cp2m7HT2A2be7MqEt2jHFRICK1y8LGE91/glSLgi19qPp5Rdnuw2wrkVkcXLkm1iaB/Fe581W82S015bd+GpAf0TclJRY9TyDtNLdEwyf8K9Vp1XLuGXw== your_email@example.com"
}