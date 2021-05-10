# Instructions

The instructions for terraform-infra should be the
following:

```tfvars
gcp_service_account_key = "praqma-training.json"
gcp_project_id = "praqma-training"
name_prefix = "academyjenkins-"
source_ip_cidr = [ "0.0.0.0/0" ]
bastion_count = 1
instance_count = 1
instance_ports = ["80-40000"]
instance_machine_type= "n1-standard-2"
extra_bootstrap_cmds = "sudo -u ubuntu bash -c 'cd /home/ubuntu && git clone -b wip/fix-agent  https://github.com/eficode-academy/jenkins-katas.git && ./jenkins-katas/setup/insertip.sh && docker-compose -f jenkins-katas/setup/docker-compose.yml up -d && ./jenkins-katas/setup/setup_swarm_on_host.sh'"
instance_disk_size=50
```

## changing the password

If you change the password in
`setup/secret/admin.txt` then please also reflect
it in `setup/docker-compose.yml` in order for the
swarm agent to be able to log in.
