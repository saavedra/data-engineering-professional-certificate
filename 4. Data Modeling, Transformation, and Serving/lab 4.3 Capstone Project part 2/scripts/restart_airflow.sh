export airflow_instance_id=$(aws ec2 describe-instances --filters 'Name=tag:Name,Values=de-c4w4a2-da-instance' --query "Reservations[].Instances[].InstanceId" --output text)
export restart_command_id=$(aws ssm send-command --instance-ids $airflow_instance_id --document-name "AWS-RunShellScript" --comment "Restart airflow service" --parameters commands=["sudo bash /opt/airflow/restart_airflow.sh"] --query "Command.CommandId" --output text)

# Checking the availability of the services
while true; do
    echo "Checking the status of the services..."
    export command_status=$(aws ssm list-command-invocations --command-id $restart_command_id --details --query "CommandInvocations[].StatusDetails" --output text)
    
    if [[ $command_status == "Success" ]]; then
        echo "Service is healthy!"
        sleep 30
        echo "Refresh your Airflow UI several times until it is ready."
        break
    else
        echo "Service is not healthy yet. Waiting 30 seconds..."
        sleep 30        
    fi
done