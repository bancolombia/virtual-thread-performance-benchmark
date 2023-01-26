#######################################
# ARGUMENTS: (instance_ip, user, key)
# OUTPUTS:
# RETURN: 0, Non-zero on error.
#######################################
wait_initialized() {
  local instance_ip=$1
  local user=$2
  local key=$3

  while [[ $(execute_remote_command "echo 'OK'" "$instance_ip" "$user" "$key") != *"OK"* ]]; do
	  echo "... Waiting ssh $instance_ip" > /dev/tty
	done

  echo "Waiting for initialization $instance_id ..." > /dev/tty
  local cmd="until [ -f /var/lib/cloud/instance/boot-finished ]; do echo 'Waiting...'; sleep 2; done"

  execute_remote_command "$cmd" "$instance_ip" "$user" "$key" > /dev/tty

  echo "Instance $instance_ip OK!" > /dev/tty
  return 0;
}

#######################################
# ARGUMENTS: (folder, url_reposity, instance_ip, user, key)
# OUTPUTS:
# RETURN: 0, Non-zero on error.
#######################################
start_docker_image() {
  local instance_ip=$1
	local folder=$2
	local user=$3
	local key=$4

  execute_remote_command "cd app; git checkout . && git pull;" "$instance_ip" "$user" "$key"
	execute_remote_command "bash app/sh/start_docker_image.sh $folder" "$instance_ip" "$user" "$key" > /dev/tty 
  return 0;
}

#######################################
# ARGUMENTS: (command, instance_ip, user, key)
# OUTPUTS: command output
# RETURN: 0, Non-zero on error.
#######################################
execute_remote_command() {
  local command=$1
  local ip=$2
  local user=$3
  local key=$4

  echo "Executing command $command on $ip" > /dev/tty
  ssh -o "StrictHostKeyChecking no" -i "$key" "$user@$ip" "$command"

  return 0
}

#######################################
# ARGUMENTS: (url)
# OUTPUTS:
# RETURN: 0, Non-zero on error.
#######################################
wait_http() {
  local url=$1

  echo "Waiting for http $url ..." > /dev/tty

	while [[ $(curl -is $url | head -n 1) == "" ]]; do
	  echo "Waiting for $url, state: $(curl -is $url | head -n 1)" > /dev/tty
	done
	sleep 3

  echo "OK! $url" > /dev/tty
  return 0;
}

#######################################
# ARGUMENTS: (instance_ip, origin, destination, user, key)
# OUTPUTS:
# RETURN: 0, Non-zero on error.
#######################################
upload_file() {
  local intance_ip=$1
  local origin=$2
  local destination=$3
  local user=$4
  local key=$5

  echo "Uploading $destination from $origin on $intance_ip" > /dev/tty;
  local out=$(scp -o "StrictHostKeyChecking no" -i "$key" "$origin" "$user@$intance_ip:$destination")
  echo "$out" > /dev/tty
  return 0
}

#######################################
# ARGUMENTS: (instance_ip, origin, destination, user, key)
# OUTPUTS:
# RETURN: 0, Non-zero on error.
#######################################
download_file() {
  local intance_ip=$1
  local origin=$2
  local destination=$3
  local user=$4
  local key=$5

  echo "Downloading $origin to $destination on $intance_ip" > /dev/tty;
  local out=$(scp -o "StrictHostKeyChecking no" -i "$key" "$user@$intance_ip:$origin" "$destination")
  echo "$out" > /dev/tty
  return 0
}