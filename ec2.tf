resource "aws_instance" "vm" {  
         ami           = "ami-0550c2ee59485be53"  
         availability_zone = "us-east-1"
          instance_type = "t2.micro"   
          
      tags = {     
           Name = "instance"  
          } 
}