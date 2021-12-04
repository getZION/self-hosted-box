#!/bin/bash
# Bash Menu Script Example

function_menu_backup () {
  PS3='Please enter your choice: '
    options=("pull_lnd" "hex_macaroon" "quit")
    select opt in "${options[@]}"
    do
        case $opt in
            "pull_lnd")
                cmd="scp -i ~/.ssh/box -r ubuntu@box-6.n2n2.chat:/box/export.tar.gz ."
                echo $cmd
                $cmd      
                ;;
                
            "hex_macaroon")
                cmd="xxd -plain -c 1000  /box/.lnd/data/chain/bitcoin/mainnet/admin.macaroon"
                echo $cmd
                $cmd      
                ;;

            "quit")
                break
                ;;
            *) 
                PS3="" # this hides the prompt
                echo asdf | select foo in "${options[@]}"; do break; done # dummy select 
                PS3="Please enter your choice: " # this displays the common prompt
                ;;
        esac
    done
}

function_menu_ssh () {
  PS3='Please enter your choice: '
    options=("box" "quit")
    select opt in "${options[@]}"
    do
        case $opt in
            "box")
                cmd="ssh -i ~/.ssh/box ubuntu@box-6.n2n2.chat"
                echo $cmd
                $cmd      
                ;;
                
            "quit")
                break
                ;;
            *) 
                PS3="" # this hides the prompt
                echo asdf | select foo in "${options[@]}"; do break; done # dummy select 
                PS3="Please enter your choice: " # this displays the common prompt
                ;;
        esac
    done
}

PS3='Please enter your choice: '
options=("start_cluster" "terminate_cluster" "ssh" "backup" "quit")
select opt in "${options[@]}"
do
    case $opt in
        "start_cluster")            
            cmd="ansible-playbook -i ops/ansible/inventory/hosts ops/ansible/playbooks/start-cluster.yml"
            echo $cmd
            $cmd
            ;;
        "terminate_cluster")
            cmd="ansible-playbook -i ops/ansible/inventory/hosts ops/ansible/playbooks/terminate-cluster.yml"
            echo $cmd
            $cmd
            ;;
        "ssh")
            function_menu_ssh
            ;;

        "backup")
            function_menu_backup
            ;;

        "quit")
            break
            ;;
            
        *) 
            PS3="" # this hides the prompt
            echo asdf | select foo in "${options[@]}"; do break; done # dummy select 
            PS3="Please enter your choice: " # this displays the common prompt
            ;;
    esac
done