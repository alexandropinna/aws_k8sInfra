resource "aws_security_group" "sg_public_instance" {
  name        = "Public Instance SG"
  description = "Allow SSH inbound traffic and ALL egress traffic"
  vpc_id = var.vpc_id

  dynamic "ingress" {
    for_each = var.ingress_ports_list
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ingress.value == 22 ? [var.ssh_allowed_cidr] : [var.sg_ingress_cidr]
    }
  }

  dynamic "egress" {
    for_each = var.egress_ports_list
    content {
      from_port   = egress.value
      to_port     = egress.value
      protocol    = "tcp"
      cidr_blocks = egress.value == 443 ? ["0.0.0.0/0"] : [var.sg_egress_cidr]
    }
  }

  tags = {
    Name = "public-sg-${local.sufix}"
  }
}
