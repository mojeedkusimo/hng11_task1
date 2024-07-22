file=$1
echo "Reading file: $file..." >>  /var/log/user_management.log

echo "Creating a line counter to track progress.." >> /var/log/user_management.log
line_counter=1
username="";
groupnames_list="";

while read each_line

	do
		echo "Setting ';' as a text separator for splitting each line into user and group(s).." >> /var/log/user_management.log
		IFS=";";
		i=1
		for each_word in $each_line

		do
			if [ $i -eq 1 ]
			then
				username=$each_word;
			else
				groupnames_list=$each_word;
			fi

			i=$((i+1));
		done
               echo "Completed splitting line: $line_counter into user: $username and groups: $groupnames_list." >> /var/log/user_management.log;

		sudo useradd $username 2>> /var/log/user_management.log;
		echo "Completed processing user: $username in line: $line_counter" >> /var/log/user_management.log;

		echo "Setting ',' as a text separator for splitting each line for splitting each group.." >> /var/log/user_management.log
		IFS=","
		for groupname in $groupnames_list
		do
			sudo groupadd $groupname 2>> /var/log/user_management.log;
                        echo "Completed processing group: $groupname in line: $line_counter" >> /var/log/user_management.log;

			sudo groupmod -a -U $username $groupname 2>> /var/log/user_management.log;
                        echo "Completed adding user: $username to group: $groupname in line: $line_counter" >> /var/log/user_management.log;

		done
                echo "Completed processing line: $line_counter" >> /var/log/user_management.log;
		line_counter=$((line_counter+1));
	done < $file
echo "Completed processing user details in $file!.." >> /var/log/user_management.log;
