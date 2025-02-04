resource "aws_instance" "vm" {  
         ami           = "ami-0c614dee691cbbf37"  
         availability_zone = "us-east-1"
          instance_type = "t2.micro"   
          
      tags = {     
           Name = "instance"  
          } 
}