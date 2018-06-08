resource "aws_route53_record" "airflow" {
  zone_id                     = "ZBVO8OQHTFSNO"
  name                        = "airflow.erich.com"
  type                        = "CNAME"
  ttl                         = "60"
  records                     = ["${aws_instance.airflow.public_dns}"]
}

resource "aws_instance" "airflow" {
  ami                         = "${lookup(var.AmiLinux, var.region)}"
  instance_type               = "t2.micro"
  associate_public_ip_address = "true"
  subnet_id                   = "${aws_subnet.PublicAZA.id}"
  vpc_security_group_ids      = ["${aws_security_group.FrontEnd.id}"]
  key_name                    = "${var.key_name}"
  # TODO: make this instance profile have access to private chef bucket
  iam_instance_profile        = "${aws_iam_instance_profile.ssm_profile.id}"
   provisioner "file" {
    source                    = "/Users/ej/.ssh/id_rsa"
    destination               = "/home/ec2-user/.ssh/id_rsa"
    connection {
      user                    = "ec2-user"
      agent                   = "false"
      type                    = "ssh"
      private_key             = "${file("/Users/ej/.ssh/ej_key_pair.pem")}"
      timeout                 = "300s"
    }
   }
   provisioner "file" {
    source                    = "./files/airflow_user_data.sh"
    destination               = "/home/ec2-user/airflow_user_data.sh"
    connection {
      user                    = "ec2-user"
      agent                   = "false"
      type                    = "ssh"
      private_key             = "${file("/Users/ej/.ssh/ej_key_pair.pem")}"
      timeout                 = "300s"
      }
   }
   provisioner "file" {
     source                    = "./files/airflow-webserver.conf"
     destination               = "/home/ec2-user/airflow-webserver.conf"
     connection {
       user                    = "ec2-user"
       agent                   = "false"
       type                    = "ssh"
       private_key             = "${file("/Users/ej/.ssh/ej_key_pair.pem")}"
       timeout                 = "300s"
     }
   }
   provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ec2-user/airflow_user_data.sh",
      "/home/ec2-user/airflow_user_data.sh",
    ]
	    connection {
      user                    = "ec2-user"
      agent                   = "false"
      type                    = "ssh"
      private_key             = "${file("/Users/ej/.ssh/ej_key_pair.pem")}"
      timeout                 = "300s"
     }
   }
   tags {
        Name                  = "airflow"
        Environment           = "Test"
  }
}

#"airflow initdb",
#"nohup airflow webserver &",

resource "aws_iam_instance_profile" "ssm_profile" {
  name                        = "ssm_profile"
  role                        = "${aws_iam_role.ssm_role.name}"
}

resource "aws_iam_role" "ssm_role" {
  name                        = "ssm_role"
  path                        = "/"
  assume_role_policy          = <<EOF
{
  	  "Version": "2012-10-17",
  	  "Statement": [
      {	      "Action": "sts:AssumeRole",
        "Principal": {
         "Service": "ec2.amazonaws.com"
       },
       "Effect": "Allow",
      "Sid": ""
      }
    ]
  }
EOF
}

data "aws_iam_policy" "ReadOnlyAccess"
{
arn                           =  "arn:aws:iam::aws:policy/AdministratorAccess"
}
