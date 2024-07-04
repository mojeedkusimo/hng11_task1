echo "DevOps Grandmaster";

#sudo useradd $1;
#sudo groupadd $2;
#sudo groupmod -a -U $1 $2;

echo "creating an iterator i..."
i=1;

echo "making ; a delimeter in a string..."
old_ifs="$IFS"
IFS=";"

echo "declaring variables to store split string..."
username=""
groupnames=""

echo "spliting string in a loop and updating respective container variables"
for x in $@
do 
	echo "$i - is i"
	echo "$x is x"
	if [ $i -eq 1 ]
	then
		username=$x;
	else
		groupnames=$x;
	fi
	i=$((i+1));
done
echo "loop ended.."

echo "creating user from input provided"
sudo useradd $username

echo "creating groups in a loop and assinging new user to each group inputted"
IFS=","
for y in $groupnames
do
	sudo groupadd $y;
	sudo groupmod -a -U $username $y; 
done

echo "task completed!..."
