#! /bin/bash
echo "========================================================================="
echo "===                executing ansible provisioning script              ==="
echo "========================================================================="

# check if Ansible already installed
ans=$(ansible --version | grep executable)

if [ "$ans" == "" ]; then
   echo "Ansible not installed, starting installation"
   echo "installing EPEL repositories"
   sudo rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm

   echo "installing Ansible"
   sudo yum -y install ansible

   echo "installing certificates fix"
   sudo yum install python-urllib3 pyOpenSSL python2-ndg_httpsclient python-pyasn1 -y
else
   echo "Ansible already installed"
fi

# check if Ansible-galaxy roles needs to be installed
echo "Installing Ansible Galaxy modules if needed"

if ! sudo ansible-galaxy list | grep "geerlingguy.apache";
then
  echo "Installing ansible-galaxy role geerlingguy.apache"
  sudo ansible-galaxy -f install geerlingguy.apache
else
  echo "ansible-galaxy role: geerlingguy.apache already installed"
fi  

if ! sudo ansible-galaxy list | grep "geerlingguy.mysql";
then
  echo "Installing ansible-galaxy role geerlingguy.mysql"
  sudo ansible-galaxy -f install geerlingguy.mysql
else
  echo "ansible-galaxy role: geerlingguy.mysql already installed"
fi  

# executing Ansible Playbook
echo ">>>>>> Executing Ansible playbook"
ansible-playbook /ansible/playbook.yml -i /ansible/inventories/hosts --connection=local
