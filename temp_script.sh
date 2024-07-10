echo "Reading file..."

counter=1;
username="";
groupnames="";
while IFS= read -r each_line

	do
		IFS=";";
		i=1
		for x in $each_line
		do 
			
			if [ $i -eq 1 ]
			then
				username=$x;
			else
				groupnames=$x;
			fi
			i=$((i+1));
		done
		echo "$counter. $username $groupnames"
		counter=$((counter+1));
		IFS=
	done < $1
