# Creates Security Group For public-alb
resource "aws_security_group" "alb_public" {
  name                  = "roboshop-${var.ENV}-public-alb-sg"
  description           = "allows public traffic"
  vpc_id                = data.terraform_remote_state.vpc.outputs.VPC_ID

  ingress {
       description      = "allows extrenal http traffic"
       from_port        = 80
       to_port          = 80
       protocol         = "tcp"
       cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
       from_port        = 0
       to_port          = 0
       protocol         = "-1"
       cidr_blocks      = ["0.0.0.0/0"]
       ipv6_cidr_blocks = ["::/0"]
  }

    tags = {
      Name = "roboshop-${var.ENV}-public-alb-sg"
    }
}
 
# Creates Security Group For private-alb
resource "aws_security_group" "alb_private" {
  name                  = "roboshop-${var.ENV}-private-alb-sg"
  description           = "allows private traffic"
  vpc_id                = data.terraform_remote_state.vpc.outputs.VPC_ID

  ingress {
       description      = "allows internal http traffic"
       from_port        = 80
       to_port          = 90
       protocol         = "tcp"
       cidr_blocks      = [data.terraform_remote_state.vpc.outputs.VPC_CIDR]
  }

  egress {
       from_port        = 0
       to_port          = 0
       protocol         = "-1"
       cidr_blocks      = ["0.0.0.0/0"]
       ipv6_cidr_blocks = ["::/0"]
  }

    tags = {
      Name = "roboshop-${var.ENV}-private-alb-sg"
    }
}