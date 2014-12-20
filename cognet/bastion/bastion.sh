#!/bin/bash


#Create array of bastion hosts
declare -a bastions=(base1b.cognet.tv base1c.cognet.tv base1d.cognet.tv)

#A function to display when the command-line arguments are incorrect
usage() { echo "Usage: $0 [-u <username>] [-k <pubkey filename>]" 1>&2; exit 1; }

#Parse command-line arguments
while getopts ":u:k:" opt; do
    case "${opt}" in
        u)
            USERNAME=${OPTARG} || usage 
            echo "Username is set to: $USERNAME"
            ;;
        k)
            PUBKEY=${OPTARG}
            echo "Public Key file is set to: $PUBKEY"
            ;;
        *|\?)
            usage
            ;;
    esac
done
shift $((OPTIND-1))

#Create user and push keys for each host
for host in $(echo ${bastions[@]})
  do
    echo "Will configure a user named $USERNAME on $host and push the key: $PUBKEY"
    ssh -t $host 'sudo useradd -m -G admin $USERNAME; sudo mkdir /home/$USERNAME/.ssh; sudo touch /home/$USERNAME/.ssh/authorized_keys; cat $PUBKEY | sudo tee /home/$USERNAME/.ssh/authorized_keys; sudo cp -R /home/shared/* /home/$USERNAME/.ssh/; sudo chown -R $USERNAME:$USERNAME /home/$USERNAME'
  done
