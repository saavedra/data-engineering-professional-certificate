#!/bin/bash
set -e
export de_project="de-c4w4lab1"
export docker_image="public.ecr.aws/deeplearning-ai/dlai-de-c4w1a1-jupyter-env:latest"
export de_project_underscore=$(echo $de_project|sed -r 's/[-]+/_/g')
export AWS_DEFAULT_REGION="us-east-1"
REQUIREMENTS_FILE="$(pwd)/scripts/requirements.txt"

sudo apt update && sudo apt upgrade -y
sudo apt-get install libpq-dev -y
sudo apt-get install postgresql -y
sudo apt-get install zip -y

mkdir -p $HOME/.dbt/

## Install Jupyter Lab
python3 -m venv jupyterlab-venv
REQUIREMENTS_FILE="$(pwd)/scripts/requirements.txt"
source jupyterlab-venv/bin/activate
pip install --upgrade pip
pip install -r "$REQUIREMENTS_FILE"

echo "Requirements installed successfully"

## Run Jupyter Lab in the background and redirect output to a file
nohup jupyter lab --ip 0.0.0.0 --port 8888 > jupyter_output.log 2>&1 &

## Wait for a moment to ensure Jupyter Lab starts
sleep 25

## Extract the URL from the output file
jupyter_url_local=$(grep -oP 'http://127.0.0.1:\d+/lab\?token=[a-f0-9]+' jupyter_output.log | head -1)

## Get the EC2 instance's public DNS name
ec2_dns=$(curl https://ipinfo.io/ip)

## Replace the DNS in the URL
jupyter_url=$(echo "$jupyter_url_local" | sed "s/127.0.0.1/${ec2_dns}/")

# Print the updated URL
echo "Jupyter is running at: $jupyter_url" >> jupyter_output.log
echo "Jupyter is running at: $jupyter_url"