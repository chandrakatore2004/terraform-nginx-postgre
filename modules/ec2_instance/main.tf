resource "aws_instance" "app_server" {
  ami                    = "ami-0f1dcc636b69a6438"
  instance_type          = "t2.micro"
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.ec2_sg_id]
  key_name               = var.key_name

  user_data = <<-EOF
              #!/bin/bash
              sudo dnf update -y
              sudo dnf install -y nginx postgresql15
              sudo systemctl start nginx
              sudo systemctl enable nginx
              sudo curl -fsSL https://rpm.nodesource.com/setup_20.x | bash -
              sudo dnf install -y nodejs
              sudo cat > /home/ec2-user/app.js <<'APP'
              const express = require('express');
              const { Pool } = require('pg');
              const app = express();
              const pool = new Pool({
                host: '${var.db_endpoint}',
                user: 'dbadmin',
                password: '${var.db_password}',
                database: 'app_db',
                port: 5432
              });
              app.get('/', async (req, res) => {
                const { rows } = await pool.query('SELECT NOW()');
                res.send('Database time: ' + rows[0].now);
              });
              app.listen(3000, () => console.log('App running on port 3000'));
              APP
              cd /home/ec2-user
              sudo npm install express pg
              nohup node app.js > app.log 2>&1 &
              EOF

  tags = {
    Name = "nginx-app-server"
  }
}

output "public_ip" {
  value = aws_instance.app_server.public_ip
}