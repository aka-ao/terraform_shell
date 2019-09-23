resource "null_resource" "shell_deploy" {
  provisioner "file" {
    content     = "${data.template_file.shell.rendered}"
    destination = "/tmp/sample.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /tmp/sample.sh",
    ]
  }

  connection {
    host        = "${aws_instance.sandbox.0.public_ip}"
    user        = "ec2-user"
    private_key = "${file("${var.ssh_private_key_path}")}"
  }
}

data "template_file" "shell" {
  vars = {
    var = "$${var}"
  }

  template = <<EOF
    #!/bin/bash

    var=12345

    echo $${var}
  EOF
}
