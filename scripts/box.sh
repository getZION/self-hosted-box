#!/bin/bash
# Bash Menu Script Example

function_menu_logs () {
  PS3='Please enter your choice: '
    options=("logs_relay" "logs_proxy" "logs_thunderhub" "quit")
    select opt in "${options[@]}"
    do
        case $opt in
            "logs_relay")
                cmd="docker logs --follow relay"
                echo $cmd
                $cmd            
                ;;

            "logs_proxy")
                cmd="docker logs --follow proxy"
                echo $cmd
                $cmd            
                ;;

            "logs_thunderhub")
                cmd="docker logs --follow thunderhub"
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

function_menu_bash () {
  PS3='Please enter your choice: '
    options=("bash_relay" "bash_thunderhub" "bash_proxy" "quit")
    select opt in "${options[@]}"
    do
        case $opt in
            "bash_relay")
                cmd="docker exec -it relay bash"
                echo $cmd
                $cmd          
                ;;

            "bash_thunderhub")
                cmd="docker exec -it thunderhub sh"
                echo $cmd
                $cmd          
                ;;

            "bash_proxy")
                cmd="docker exec -it proxy sh"
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

function_menu_backup () {
  PS3='Please enter your choice: '
    options=("tar_lnd" "pull_backup" "push_backup" "apply_backup" "quit")
    select opt in "${options[@]}"
    do
        case $opt in
            "tar_lnd")
                cmd="tar -cvzf export.tar.gz .lnd"
                echo $cmd
                $cmd    
                ;;

            "pull_backup")
                cmd="export CTR_ID=$(docker ps -q -f name=relay)"
                echo $cmd
                $cmd  
                cmd="docker cp $CTR_ID:/relay/export.tar.gz /box/export.tar.gz"
                echo $cmd
                $cmd            
                ;;

            "push_backup")
                cmd="export CTR_ID=$(docker ps -q -f name=relay)"
                echo $cmd
                $cmd   
                cmd="docker cp /box/import.tar.gz $CTR_ID:/relay/import.tar.gz"
                echo $cmd
                $cmd            
                ;;
                
            "apply_backup")
                cmd="mv .lnd/thubConfig.yaml ./thubConfig.yaml"
                echo $cmd
                $cmd
                cmd="mv .lnd/.cookie ./.cookie"
                echo $cmd
                $cmd
                cmd="mv .lnd/v3_onion_private_key ./v3_onion_private_key"
                echo $cmd
                $cmd
                cmd="mv .lnd/tls.cert ./tls.cert"
                echo $cmd
                $cmd
                cmd="mv .lnd/tls.key ./tls.key"
                echo $cmd
                $cmd
                cmd="rm -rf .lnd"
                echo $cmd
                $cmd
                cmd="tar -xzvf import.tar.gz"
                echo $cmd
                $cmd
                cmd="mv thubConfig.yaml .lnd/thubConfig.yaml"
                echo $cmd
                $cmd
                cmd="mv .cookie .lnd/.cookie"
                echo $cmd
                $cmd
                cmd="mv tls.key .lnd/tls.key"
                echo $cmd
                $cmd
                cmd="mv tls.cert .lnd/tls.cert"
                echo $cmd
                $cmd
                cmd="mv v3_onion_private_key .lnd/v3_onion_private_key"
                echo $cmd
                $cmd 
                cmd="rm -rf import.tar.gz"
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

function_menu_docker () {
  PS3='Please enter your choice: '
    options=("compose_relay" "compose_proxy" "compose_thunderhub" "kill_relay" "kill_proxy" "kill_thundehub" "ps" "prune" "quit")
    select opt in "${options[@]}"
    do
        case $opt in
            "compose_relay")
                cmd="docker-compose up -d"
                echo $cmd
                $cmd          
                ;;

            "compose_proxy")
                cmd="docker-compose -f docker-compose.proxy.yml up -d"
                echo $cmd
                $cmd          
                ;;

            "compose_thunderhub")
                cmd="docker-compose -f docker-compose.thunderhub.yml up -d"
                echo $cmd
                $cmd          
                ;;

            "kill_relay")
                cmd="docker kill relay"
                echo $cmd
                $cmd          
                ;;

            "kill_proxy")
                cmd="docker kill proxy"
                echo $cmd
                $cmd             
                ;;

            "kill_thunderhub")
                cmd="docker kill thunderhub"
                echo $cmd
                $cmd             
                ;;

            "ps")
                cmd="docker ps"
                echo $cmd
                $cmd             
                ;;

            "prune")
                cmd="docker system prune -a"
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
options=("bash" "docker" "backup" "logs" "git_pull" "copy_conf" "quit")
select opt in "${options[@]}"
do
    case $opt in
        "bash")            
            function_menu_bash 
            ;;

        "docker")
            function_menu_docker
            ;;

        "backup")            
            function_menu_backup
            ;;

        "logs")
            function_menu_logs          
            ;;

        "copy_conf")
            cmd="cp docker/lnd.sample.conf .lnd/lnd.conf"
            echo $cmd
            $cmd            
            ;;

        "git_pull")
            cmd="git pull"
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