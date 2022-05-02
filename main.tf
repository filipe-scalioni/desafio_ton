#Cria a Instância
resource "aws_instance" "desafio_ton" {
  ami             = var.ami_id
  key_name        = var.key_name
  instance_type   = var.instance_type
  security_groups = [var.security_group]
  tags = {
    Name = var.tag_name
  }
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install nginx -y",
      "sudo /etc/init.d/nginx start"
    ]
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("/home/filipe/.ssh/id_rsa_pv.pem")
      host        = self.public_ip
    }
  }
}

#Cria o Security Group com as regras de Firewall
resource "aws_security_group" "security_desafio_ton_grp" {
  name        = var.security_group
  description = "security group for desafio_ton"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #Outbound do servidor
  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    Name = var.security_group
  }
}

#Cria o CloudWatch Alarm
resource "aws_cloudwatch_metric_alarm" "CPU" {
  alarm_name                = "terraform-desafio_ton-CPU"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = "80"
  alarm_description         = "Utilização de CPU alta"
  insufficient_data_actions = []
}

# Cria o Elastic IP address
resource "aws_eip" "elasticIPDesafio_ton" {
  vpc      = true
  instance = aws_instance.desafio_ton.id
  tags = {
    Name = "desafio_ton_elastic_ip"
  }
}
