# Define a security group for public instances in the VPC.
resource "aws_security_group" "sg_public_instance" {
  name        = "Public Instance SG"
  description = "Allow SSH inbound traffic and ALL egress traffic"
  vpc_id      = var.vpc_id

  # Dynamically create ingress rules based on the provided list of ingress ports.
  dynamic "ingress" {
    for_each = var.ingress_ports_list
    content {
      from_port = ingress.value
      to_port   = ingress.value
      protocol  = "tcp"
      # If the port is SSH (22), use the dedicated SSH allowed CIDR block. Otherwise, use the general ingress CIDR.
      cidr_blocks = ingress.value == 22 ? [var.ssh_allowed_cidr] : [var.sg_ingress_cidr]
    }
  }

  # Dynamically create egress rules based on the provided list of egress ports.
  dynamic "egress" {
    for_each = var.egress_ports_list
    content {
      from_port = egress.value
      to_port   = egress.value
      protocol  = "tcp"
      # If the port is HTTPS (443), allow traffic to all destinations. Otherwise, use the general egress CIDR.
      cidr_blocks = egress.value == 443 ? ["0.0.0.0/0"] : [var.sg_egress_cidr]
    }
  }

  # Add tags to the security group for better resource identification.
  tags = {
    Name = "public-sg-${local.sufix}"
  }
}
