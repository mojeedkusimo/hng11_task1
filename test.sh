packageChecker="true"

if [ -z "$packageChecker"] 
	then
		echo "$1 package is not installed.. $packageChecker"
		exit 1
fi

echo "$1 package exists..."
