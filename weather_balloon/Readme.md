Weather Balloon: Spark Application for predicting weather.

•	Setting Up Spark Cluster: Running Spark on EC2
1.	Install Spark on your local.
2.	For Spark, pre-install Java. 

•	Next steps:
1.	Create an Amazon EC2 keypair.
2.	Before using spark-ec2 script, set the environment variables: AWS_ACCESS_KEY_ID  and AWS_SECRET_ACCESS_KEY  to Amazon EC2 access key ID and secret access key.
<<<<<<< HEAD
3.	Then run the below commands :
	cd to the spark folder, inside spark folder go to ec2 directory and then run below command.
	./spark-ec2 --key-pair=[keypair] --identity-file=[key-file] -t m1.small --copy-aws-credentials --region=[ec2-region] --zone=[ec2-zone] launch [cluster-name]
	** Please note above command should not be run again , this is one time activity.
4.	Our spark cluster can be found at :
5.	http://ec2-52-25-140-32.us-west-2.compute.amazonaws.com:8080/

•	Other operations possible on Spark Cluster:
1.	Logging in to the existing cluster:
	./spark-ec2 --key-pair=[keypair] --identity-file=[key-file] -t m1.small --copy-aws-credentials --region=[ec2-region] --zone=[ec2-zone] login [cluster-name]
2.	Destroying the existing cluster:
	./spark-ec2 --key-pair=[keypair] --identity-file=[key-file] -t m1.small --copy-aws-credentials --region=[ec2-region] --zone=[ec2-zone] destroy [cluster-name]

•	Post Cluster Setup:
(i)	Login to the cluster
(ii)	Sudo to Deploy user by below command :
	su deploy
(iii)	Since our Spark cluster is already set up and running. We have two folders named : basic_spark and predict_weather which we will be using in future to run the storm detecting algorithm and will be reading the input data from amazon s3 bucket.
•	Commands to execute:
1.	cd basic_spark
2.	../spark/bin/spark-submit --class src.main.scala.com.sga.sparkhello.SparkHello --master local target/sparkhello-0.0.1-SNAPSHOT.jar TestString 
	// This is the program which accepts the string and prints it 10 times.
	//This is dummy program for now, to test that Spark is running and that we are able to read from a file system as an(file is passed as an argument to the code).
	**Later, this code will be modified to read and write to S3 buckets.**	

3.	cd predict_weather
4.	../spark/bin/spark-submit --class src.main.scala.com.sga.sparkwordcount.SparkWordCount --master local target/sparkwordcount-0.0.1-SNAPSHOT.jar inputfile.txt 2
	//This is simple word count example to test whether we are able to read/write from local/hdfs and write to local/hdfs.
	**Later, this code will be modified to do the storm prediction.

***Please note that below are one time activity, we don’t need to launch the cluster every time, just use login to existing cluster.

=======
3.	Then run the command :
4.	./spark-ec2 -k <keypair> -i <key-file> -s <num-slaves> launch <cluster-name>
5.	Once the cluster is launched it can be found at :
6.	http://<master-hostname>:8080

•	Cluster configurations:
1.	Using the existing cluster:
./spark-ec2 -k <keypair> -i <key-file> -s <num-slaves> login <cluster-name>
2.	Destroying the cluster:
./spark-ec2 -k <keypair> -i <key-file> -s <num-slaves> destroy <cluster-name>

•	Post Cluster Setup:
(i)	Login to the cluster
(ii)	Sudo to Deploy user : command – 
su deploy
(iii)	Spark cluster is already set up and two folders are present which have the code for storm detecting algorithms in Spark.
•	  Commands to execute:
1.	cd basic_spark
2.	../spark/bin/spark-submit --class src.main.scala.com.cloudera.sparkhello.SparkHello --master local target/sparkhello-0.0.1-SNAPSHOT.jar TestString 
// This is the program which accepts the string and prints it 10 times.
**Later, this code will be modified to read and write to S3 buckets.**	

3.	Cd predict_weather
4.	../spark/bin/spark-submit --class src.main.scala.com.cloudera.sparkwordcount.SparkWordCount --master local target/sparkwordcount-0.0.1-SNAPSHOT.jar inputfile.txt 2
This is simple word count example to test whether we are able to read/write from local/hdfs and write to local/hdfs.
Please note that below are one time activity, we don’t need to launch the cluster every time, just use login to existing cluster.
