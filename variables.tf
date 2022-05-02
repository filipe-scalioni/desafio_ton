variable "aws_access_key_id" {
    description = "ID da AWS." 
}
variable "aws_secret_access_key" {
    description = "Chave da API." 
}

variable "aws_region" {
    description = "Região AWS." 
    default     = "us-east-2" 
}

variable "key_name" { 
    description = " SSH key" 
    default     =  "minha_chave" 
}

variable "instance_type" { 
    description = "Tipo da Instância ec2" 
    default     =  "t2.micro" 
}

variable "security_group" { 
    description = "Nome do security group" 
    default     = "Admin" 
}

variable "tag_name" { 
    description = "Tag para Instância Ec2" 
    default     = "nginx_server" 
} 
variable "ami_id" { 
    description = "AMI do Ubuntu para Ec2" 
    default     = "ami-0b9064170e32bde34" 
}