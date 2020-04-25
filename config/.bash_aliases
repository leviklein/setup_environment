alias cdr="cd ~/repo"
alias cdtemp="cd ~/Documents/tmp"
alias ebash="vim ~/.bash_aliases && source ~/.bash_aliases"
alias grep="grep --color"
alias grepwatch1="grepwatch ^[a-g]"
alias grepwatch2="grepwatch ^[h-n]"
alias grepwatch3="grepwatch ^[o-z]"
alias ls="ls -G"
alias ll="ls -al"
alias restart_ggpods="oc get pods | grep 0/ | awk '{print \$1}' | xargs -I{} oc delete pod {}"
alias watch_ggpods="watch 'oc get pods | grep \"0/\"'"
alias watch_me="watch oc whoami -c"
alias watch_nodes="watch oc get nodes"
alias watch_pods="watch oc get pods"

function try_delete() {
        $1 > $2
        if [ $? -ne 0 ]
                then rm $2
        fi
}

function backup_deployments() {
        if [ "$#" -ne 1 ]; then
                echo "Illegal number of parameters"
        fi

        for VARIABLE in ${@}
        do
                try_delete "oc get deploy -o yaml --export $VARIABLE" $VARIABLE-deploy.yaml
                try_delete "oc get svc -o yaml --export $VARIABLE" $VARIABLE-svc.yaml
        done
}
