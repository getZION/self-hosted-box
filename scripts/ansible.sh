#!/bin/bash
# Bash Menu Script Example

KEYPAIR="n2n2"
URL_1=ubuntu@box-1.n2n2.chat
URL_6=ubuntu@box-6.n2n2.chat

function_menu_backup () {
  PS3='Please enter your choice: '
    options=("pull_lnd" "quit")
    select opt in "${options[@]}"
    do
        case $opt in
            "pull_lnd")
                # cmd="scp -i ~/.ssh/box -r $URL:/box/export.tar.gz ."
                cmd="NOT_IMPLEMENTED"
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
    options=("box-1" "box-6" "quit")
    select opt in "${options[@]}"
    do
        case $opt in
            "box-1")
                cmd="ssh -i ~/.ssh/$KEYPAIR $URL_1"
                echo $cmd
                $cmd      
                ;;
            
            "box-6")
                cmd="ssh -i ~/.ssh/$KEYPAIR $URL_6"
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