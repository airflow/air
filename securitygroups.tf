

resource "aws_security_group" "FrontEnd" {
  name = "FrontEnd"
  tags {
        Name = "FrontEnd"
  }
  description = "ONLY HTTP CONNECTION IN-BOUND"
  vpc_id = "${aws_vpc.terraformmain.id}"

  ingress {
        from_port    = 80
        to_port      = 80
        protocol     = "TCP"
        cidr_blocks  = ["0.0.0.0/0"]
  }
  ingress {
        from_port    = 8080
        to_port      = 8080
        protocol     = "TCP"
        cidr_blocks  = ["0.0.0.0/0"]
  }
  ingress {
        from_port     = 100
        to_port       = 100
        protocol      = "TCP"
        cidr_blocks   = ["0.0.0.0/0"]
  }
  ingress {
        from_port     = 443
        to_port       = 443
        protocol      = "TCP"
        cidr_blocks   = ["0.0.0.0/0"]
  }
  ingress {
    from_port         = "22"
    to_port           = "22"
    protocol          = "TCP"
    cidr_blocks       = ["0.0.0.0/0"]
  }
  egress {
    from_port         = 0
    to_port           = 0
    protocol          = "-1"
    cidr_blocks       = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "Backend" {
  name = "Backend"
  tags {
        Name          = "Backend"
  }
  description         = "ONLY tcp CONNECTION INBOUND"
  vpc_id              = "${aws_vpc.terraformmain.id}"
  ingress {
      from_port       = 5432
      to_port         = 5432
      protocol        = "TCP"
      security_groups = ["${aws_security_group.FrontEnd.id}"]
  }
  ingress {
      from_port       = "3389"
      to_port         = "3389"
      protocol        = "TCP"
      cidr_blocks     = ["0.0.0.0/0"]
  }
  ingress {
      from_port   = "22"
      to_port     = "22"
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port     = 0
    to_port       = 0
    protocol      = "-1"
    cidr_blocks   = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "my_db_sg" {
  name = "my_db_sg"
  tags {
        Name = "RDSMYSQL"
  }

  description = "RDS  servers (terraform-managed)"
  vpc_id = "${aws_vpc.terraformmain.id}"

  # Only mysql in
  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic.
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
