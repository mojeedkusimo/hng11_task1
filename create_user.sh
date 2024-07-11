echo "Reading file..." >>  /var/log/user_management.log

echo "Storing the first argument to be passed to the shell" >> /var/log/user_management.log
file=$1

echo "Creating a line counter to track progress.." >> /var/log/user_management.log
line_counter=1
username="";
groupnames_list="";

while read each_line

	do
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
               echo "Completed splitting line: $line_counter into user: $username and groups: $groupnames_list.";

		sudo useradd $username;
		echo "Completed creating user: $username in line: $line_counter"

		IFS=","
		for groupname in $groupnames_list
		do
			sudo groupadd $groupname;
                        echo "Completed creating group: $groupname in line: $line_counter";

			sudo groupmod -a -U $username $groupname;
                        echo "Completed adding user: $username to group: $groupname in line: $line_counter";

		done
                echo "Completed processing line: $line_counter"
		line_counter=$((line_counter+1));
	done < $file
echo "task completed!.."
