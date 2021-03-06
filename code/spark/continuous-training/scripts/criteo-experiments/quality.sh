
# Copy jar files
scp target/continuous-training-1.0-SNAPSHOT-jar-with-dependencies.jar behrouz@cloud-11.dima.tu-berlin.de:/home/behrouz/jar
cp /home/behrouz/jar/continuous-training-1.0-SNAPSHOT-jar-with-dependencies.jar /share/hadoop/behrouz/jars/


#local
~/Documents/frameworks/spark/2.2.0/bin/spark-submit --class de.dfki.experiments.Quality --master "spark://dhcp-214-87.vpn.tu-berlin.de:7077" --driver-memory 3g --executor-memory 5G /Users/bede01/Documents/work/phd-papers/continuous-training/code/spark/continuous-training/target/continuous-training-1.0-SNAPSHOT-jar-with-dependencies.jar "input=/Users/bede01/Documents/work/phd-papers/continuous-training/code/spark/continuous-training/data/criteo-full/experiments/initial-training/day_0" "stream=/Users/bede01/Documents/work/phd-papers/continuous-training/code/spark/continuous-training/data/criteo-full/experiments/stream" "result=/Users/bede01/Documents/work/phd-papers/continuous-training/experiment-results/criteo-full/quality/local" "slack=5" "features=3000" "iterations=500" "sample=0.1" "pipeline=/Users/bede01/Documents/work/phd-papers/continuous-training/code/spark/continuous-training/data/criteo-full/pipelines/quality/init_500" "days=1,2" "day_duration=100" "evaluation=/Users/bede01/Documents/work/phd-papers/continuous-training/code/spark/continuous-training/data/criteo-full/experiments/evaluation/6"



#Cluster
/share/hadoop/behrouz/spark/stable/bin/spark-submit --class de.dfki.experiments.DeploymentModesQualityAndTime --master "spark://cloud-11.dima.tu-berlin.de:7077" /share/hadoop/behrouz/jars/continuous-training-1.0-SNAPSHOT-jar-with-dependencies.jar "result=/share/hadoop/behrouz/experiments/criteo/results/deployment-modes" "profile=criteo-cluster"
