# self-hosted-box

The following is the manual detailing steps for self-hosting a Zion relay node on AWS.

Here is a video demo -> https://streamable.com/dc5hf3 (Possibly outdated)

## Requirements
1. macOS + ansible [Details](ops/ansible/README.md)
2. Github Account + relevant keys [Details](https://docs.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent) 
   1. Generate github SSH keys [YOUR_GITHUB_ACCESS_KEY] 
   2. Put at

    ```
    ~/.ssh/id_rsa.github
    ~/.ssh/id_rsa.github.pub
    ```
     (EC2 will use this key in order to pull source from this repo.)

3. AWS Account + relevant keys
    1. Generate IAM User with administrator access [YOUR_AWS_KEY] [YOUR_SECRET_KEY] (Use at 2 below)
    2. Generate EC2 keypair in your AWS console [YOUR_EC2_KEYPAIR_NAME] (Use at 2 below)
    3. Put at

    ```
    ~/.ssh
    ```
    4. Find your vpc_id in your AWS console [YOUR_EC2_CLUSTER_ID] (Use at 2 below)

## Initial Setup

1. Create ansible vars file ops/ansible/playbooks/group_vars/all.yml (Ansible will use these values to set up your cluster) inside this project if does not exist.

```bash
aws_access_key: [YOUR_AWS_KEY]
aws_secret_key: [YOUR_AWS_SECRET]
aws_region: [YOUR_AWS_REGION]

key_name: [YOUR_EC2_KEYPAIR_NAME]
# obtainable in your AWS account
vpc_id: [YOUR_EC2_CLUSTER_ID]

# obtain here based on [YOUR_AWS_REGION]
# https://cloud-images.ubuntu.com/locator/ec2/
# bionic 18.04LTS hvm:ebs-ssd
ami_id: [YOUR_AMI_ID]

communities_host: communities.getzion.com
communities_host_staging: null

media_host: memes.getzion.com
media_host_staging: null

media_host_protocol: "https"
```

[Use Reference](ops/ansible/playbooks/group_vars/all.yml)

2. Create ops/ansible/playbooks/roles/zion/vars/.env (Ansible will use these values to setup your EC2 instances, relay docker container and lnd) inside this project if does not exist.
   
```bash
CONNECT_UI=true
```

[Use Reference](ops/ansible/playbooks/roles/zion/tasks/main.yml)

3. Create ops/ansible/playbooks/cluster_configs.yml if does not exist.
   (Modify cluster parameters to reflect the relevant domain/subdomain where you plan accessing your Zion relay )

```yaml
---
cluster_configs:
  - {
      instance_type: "t3.large",
      instance_name: "box-1",
      alias: "zion-box-1",
      testnet: false,
      domain: "n2n2.chat",
      scheme: "https",
    }
```

[cluster_configs](ops/ansible/playbooks/cluster_configs.yml) 

## Deploy Your Cluster
1. Deploy Cluster
```bash 
./scripts/ansible.sh

# Choose Option 1 start_cluster
```

1. Open your favorite browser and go to https://box-1.n2n2.chat/connect to obtain your access key/qr-code. (Use scheme/domain/subdomain combination from above)

2. Check letsencrypt

```
https://crt.sh/?q=box-1.n2n2.chat
```

3. Establish route to Zion.

```bash
./scripts/ansible.sh
# Choose Option 3 ssh
# Choose Option 1 box

# inside box
./scripts/box.sh
# Choose Option 1 bash
# Choose Option 1 bash_relay

# inside relay container
./scripts/relay.sh
# Choose Option 1 lncli
# Choose Option 2 create_wallet

# Send desired balance to generated p2sh address

# Peer node https://1ml.com/node/029f96fe33e4c3db0a7dc4039fb9e2a792bb99ef62589c9932bce2a59a06b650d7
# Open channel

```