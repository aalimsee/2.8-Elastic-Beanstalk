/* resource "aws_security_group" "elb_sg" {
  //vpc_id = aws_vpc.my_vpc.id
  vpc_id = module.vpc.vpc_id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "aalimsee-tf-beanstalk-elb-security-group"
  }
}

resource "aws_security_group" "ec2_sg" {
  //vpc_id = aws_vpc.my_vpc.id
  vpc_id = module.vpc.vpc_id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.elb_sg.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "aalimsee-tf-beanstalk-ec2-security-group"
  }
}
 */