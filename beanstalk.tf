
resource "aws_elastic_beanstalk_application" "app" {
  name        = "aalimsee-tf-beanstalk-app"
  description = "My Elastic Beanstalk Application"
}

resource "aws_elastic_beanstalk_environment" "env" {
  name                = "aalimsee-tf-beanstalk-env"
  application         = aws_elastic_beanstalk_application.app.name
  solution_stack_name = "64bit Amazon Linux 2023 v4.4.0 running Python 3.13"
  //"64bit Amazon Linux 2 v3.5.10 running Python 3.8"  # Change version if needed
  // https://docs.aws.amazon.com/elasticbeanstalk/latest/platforms/platform-history-python.html



  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    //value     = aws_vpc.my_vpc.id
    value = module.vpc.vpc_id
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    //value     = aws_subnet.public_subnet.id
    value     = join(",",module.vpc.private_subnets)
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "ELBSubnets"
    //value     = aws_subnet.public_subnet.id
    value     = join(",",module.vpc.public_subnets)
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = "arn:aws:iam::255945442255:instance-profile/aws-elasticbeanstalk-ec2-role"
  //  value     = "aws-elasticbeanstalk-ec2-role" # <<<
  }
    setting {
      namespace = "aws:elasticbeanstalk:environment"
      name = "ServiceRole"
      value = "arn:aws:iam::255945442255:role/service-role/aws-elasticbeanstalk-service-role"
  } # <<<
    setting {
        namespace = "aws:autoscaling:launchconfiguration"
        name = "EC2KeyName"
        value = "aalimsee-keypair"
    }
    setting {
        namespace = "aws:autoscaling:launchconfiguration"
        name      = "InstanceType"
        value     = "t2.micro"
    }
/*   setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "SecurityGroups"
    value     = aws_security_group.ec2_sg.id
  } */
  
  # include if ec2 on public subnet 
/*   setting {
    namespace = "aws:ec2:vpc"
    name      = "AssociatePublicIpAddress"
    value     =  "True"
  } */
  
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "LoadBalancerType"
    value     = "application"
  }
/*   setting {
    namespace = "aws:elbv2:loadbalancer"
    name      = "SecurityGroups"
    value     = aws_security_group.elb_sg.id
  } */
  setting {
    namespace = "aws:elasticbeanstalk:environment:process:default"
    name      = "MatcherHTTPCode"
    value     = "200"
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "LoadBalancerType"
    value     = "application"
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "ELBScheme"
    value     = "internet facing"
  }
  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MinSize"
    value     = 2
  }
  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MaxSize"
    value     = 2
  }
  setting {
    namespace = "aws:elasticbeanstalk:healthreporting:system"
    name      = "SystemType"
    value     = "enhanced"
  }
}

