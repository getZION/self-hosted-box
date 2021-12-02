# Deploy Zion Cluster

## Prerequisites
```
brew install ansible
pip install boto boto3 botocore
```

### Configs
```
code ops/ansible/playbooks/group_vars/all.yml 
```

### Commands
```
cd ops/ansible
ansible-playbook -i inventory/hosts playbooks/start-cluster.yml
# OR
ansible-playbook -i inventory/hosts playbooks/terminate-cluster.yml
```

```
docker kill $(docker ps -q)
```

### Logs
```
docker ps -q | xargs -L 1 docker logs -f
```

### Bash
```
ssh -i ~/.ssh/box ubuntu@box-1.getzion.com
```