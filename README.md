# Automated Outline Server Setup

## What is Outline

Secure, "Underground Railroad" to free internet:

https://getoutline.org

## Why build this

Currently the desktop Outline Manager app only supports automated DigitalOcean server setup.

This playbook enables you to configure a Ubuntu/Debian server to become Outline server.

## How to use

1. Create a new virtual Ubuntu/Debian server in cloud of your choice. Recommended [Linode](https://www.linode.com) 1GB plan with Ubuntu 17.10. After server is created, take a note of its SSH username/password and server IP address.

2. Install Ansible 2.4 or above, instructions here: http://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html
   
   For Windows 10 users, follow the instructions here: https://www.jeffgeerling.com/blog/2017/using-ansible-through-windows-10s-subsystem-linux

3. Clone this repo to your computer:
   
   ```
   git clone https://github.com/richardzone/automated-outline-server-setup.git
   ```

4. Go to the repo directory, modify `hosts` file, change the IP to your own server's IP address.

5. In your terminal, run:
   
   ```
   SSH_USERNAME=root SSH_PASSWORD=your_password ./go-playbook.sh outline_server_setup.yml
   ```

   Modify `root` and `your_password` to match your server's SSH username and password

6. If successful, there should be a `outline-server-info.log` file created in the repo directory. Copy the contents of this file.
7. Download and install Outline Manager app from https://getoutline.org/
8. Run Outline Manager app, when asked to "Choose a server", select "Get Started" under "Already have a server?" option.
9. In the next page, ignore the first step of command as you already have Outline server running, paste the contents of aforementioned `outline-server-info.log` file in the second text box, and click "DONE".
10. Outline Manager is all set! Click "Get connected" and follow instructions to use your VPN.

## Notes 

For optimum VPN performance, please use Ubuntu 17.10 or above (with kernel >= 4.9) as the playbook will enable [TCP BBR](https://github.com/google/bbr) for lightening fast data throughput.

Playbook is tested with [Linode](https://www.linode.com/) Ubuntu 17.10 server.