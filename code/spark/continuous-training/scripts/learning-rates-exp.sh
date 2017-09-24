~/Documents/frameworks/spark/2.2.0/bin/spark-submit --class de.dfki.deployment.ContinuousClassifier --master "spark://MacBook-Pro-5.home:7077" --driver-memory 3g --executor-memory 5G /Users/bede01/Documents/work/phd-papers/continuous-training/code/spark/continuous-training/target/continuous-training-1.0-SNAPSHOT-jar-with-dependencies.jar "batch-duration=1" "slack=10" "incremental=true" "initial-training-path=/Users/bede01/Documents/work/phd-papers/continuous-training/code/spark/continuous-training/data/criteo-full/initial-training/0" "streaming-path=/Users/bede01/Documents/work/phd-papers/continuous-training/code/spark/continuous-training/data/criteo-full/processed/*" "temp-path=/Users/bede01/Documents/work/phd-papers/continuous-training/code/spark/continuous-training/data/criteo-full/temp-data" "result-path=/Users/bede01/Documents/work/phd-papers/continuous-training/experiment-results/criteo-full" "num-iterations=500" "input-format=vector" "step-size=0.001" "model-path=/Users/bede01/Documents/work/phd-papers/continuous-training/code/spark/continuous-training/data/criteo-full/models/learning-rates/adam/day-0/model" "test-path=/Users/bede01/Documents/work/phd-papers/continuous-training/code/spark/continuous-training/data/criteo-full/evaluation-data" "updater=adam"



~/Documents/frameworks/spark/2.2.0/bin/spark-submit --class de.dfki.deployment.ContinuousClassifier --master "spark://MacBook-Pro-5.home:7077" --driver-memory 3g --executor-memory 5G /Users/bede01/Documents/work/phd-papers/continuous-training/code/spark/continuous-training/target/continuous-training-1.0-SNAPSHOT-jar-with-dependencies.jar "batch-duration=1" "slack=10" "incremental=true" "initial-training-path=/Users/bede01/Documents/work/phd-papers/continuous-training/code/spark/continuous-training/data/criteo-full/initial-training/0" "streaming-path=/Users/bede01/Documents/work/phd-papers/continuous-training/code/spark/continuous-training/data/criteo-full/processed/*" "temp-path=/Users/bede01/Documents/work/phd-papers/continuous-training/code/spark/continuous-training/data/criteo-full/temp-data" "result-path=/Users/bede01/Documents/work/phd-papers/continuous-training/experiment-results/criteo-full" "num-iterations=500" "input-format=vector" "step-size=0.001" "model-path=/Users/bede01/Documents/work/phd-papers/continuous-training/code/spark/continuous-training/data/criteo-full/models/learning-rates/momentum/day-0/model" "test-path=/Users/bede01/Documents/work/phd-papers/continuous-training/code/spark/continuous-training/data/criteo-full/evaluation-data" "updater=momentum"

~/Documents/frameworks/spark/2.2.0/bin/spark-submit --class de.dfki.deployment.ContinuousClassifier --master "spark://MacBook-Pro-5.home:7077" --driver-memory 3g --executor-memory 5G /Users/bede01/Documents/work/phd-papers/continuous-training/code/spark/continuous-training/target/continuous-training-1.0-SNAPSHOT-jar-with-dependencies.jar "batch-duration=1" "slack=10" "incremental=true" "initial-training-path=/Users/bede01/Documents/work/phd-papers/continuous-training/code/spark/continuous-training/data/criteo-full/initial-training/0" "streaming-path=/Users/bede01/Documents/work/phd-papers/continuous-training/code/spark/continuous-training/data/criteo-full/processed/*" "temp-path=/Users/bede01/Documents/work/phd-papers/continuous-training/code/spark/continuous-training/data/criteo-full/temp-data" "result-path=/Users/bede01/Documents/work/phd-papers/continuous-training/experiment-results/criteo-full" "num-iterations=500" "input-format=vector" "step-size=0.001" "model-path=/Users/bede01/Documents/work/phd-papers/continuous-training/code/spark/continuous-training/data/criteo-full/models/learning-rates/rmsprop/day-0/model" "test-path=/Users/bede01/Documents/work/phd-papers/continuous-training/code/spark/continuous-training/data/criteo-full/evaluation-data" "updater=rmsprop"

~/Documents/frameworks/spark/2.2.0/bin/spark-submit --class de.dfki.deployment.ContinuousClassifier --master "spark://MacBook-Pro-5.home:7077" --driver-memory 3g --executor-memory 5G /Users/bede01/Documents/work/phd-papers/continuous-training/code/spark/continuous-training/target/continuous-training-1.0-SNAPSHOT-jar-with-dependencies.jar "batch-duration=1" "slack=10" "incremental=true" "initial-training-path=/Users/bede01/Documents/work/phd-papers/continuous-training/code/spark/continuous-training/data/criteo-full/initial-training/0" "streaming-path=/Users/bede01/Documents/work/phd-papers/continuous-training/code/spark/continuous-training/data/criteo-full/processed/*" "temp-path=/Users/bede01/Documents/work/phd-papers/continuous-training/code/spark/continuous-training/data/criteo-full/temp-data" "result-path=/Users/bede01/Documents/work/phd-papers/continuous-training/experiment-results/criteo-full" "num-iterations=500" "input-format=vector" "step-size=0.001" "model-path=/Users/bede01/Documents/work/phd-papers/continuous-training/code/spark/continuous-training/data/criteo-full/models/learning-rates/adadelta/day-0/model" "test-path=/Users/bede01/Documents/work/phd-papers/continuous-training/code/spark/continuous-training/data/criteo-full/evaluation-data" "updater=adadelta"

~/Documents/frameworks/spark/2.2.0/bin/spark-submit --class de.dfki.deployment.ContinuousClassifier --master "spark://MacBook-Pro-5.home:7077" --driver-memory 3g --executor-memory 5G /Users/bede01/Documents/work/phd-papers/continuous-training/code/spark/continuous-training/target/continuous-training-1.0-SNAPSHOT-jar-with-dependencies.jar "batch-duration=1" "slack=10" "incremental=true" "initial-training-path=/Users/bede01/Documents/work/phd-papers/continuous-training/code/spark/continuous-training/data/criteo-full/initial-training/0" "streaming-path=/Users/bede01/Documents/work/phd-papers/continuous-training/code/spark/continuous-training/data/criteo-full/processed/*" "temp-path=/Users/bede01/Documents/work/phd-papers/continuous-training/code/spark/continuous-training/data/criteo-full/temp-data" "result-path=/Users/bede01/Documents/work/phd-papers/continuous-training/experiment-results/criteo-full" "num-iterations=500" "input-format=vector" "step-size=0.001" "model-path=/Users/bede01/Documents/work/phd-papers/continuous-training/code/spark/continuous-training/data/criteo-full/models/learning-rates/l2/day-0/model" "test-path=/Users/bede01/Documents/work/phd-papers/continuous-training/code/spark/continuous-training/data/criteo-full/evaluation-data" "updater=l2"

~/Documents/frameworks/spark/2.2.0/bin/spark-submit --class de.dfki.deployment.ContinuousClassifier --master "spark://MacBook-Pro-5.home:7077" --driver-memory 3g --executor-memory 5G /Users/bede01/Documents/work/phd-papers/continuous-training/code/spark/continuous-training/target/continuous-training-1.0-SNAPSHOT-jar-with-dependencies.jar "batch-duration=1" "slack=10" "incremental=true" "initial-training-path=/Users/bede01/Documents/work/phd-papers/continuous-training/code/spark/continuous-training/data/criteo-full/initial-training/0" "streaming-path=/Users/bede01/Documents/work/phd-papers/continuous-training/code/spark/continuous-training/data/criteo-full/processed/*" "temp-path=/Users/bede01/Documents/work/phd-papers/continuous-training/code/spark/continuous-training/data/criteo-full/temp-data" "result-path=/Users/bede01/Documents/work/phd-papers/continuous-training/experiment-results/criteo-full" "num-iterations=500" "input-format=vector" "step-size=0.001" "model-path=/Users/bede01/Documents/work/phd-papers/continuous-training/code/spark/continuous-training/data/criteo-full/models/learning-rates/constant/day-0/model" "test-path=/Users/bede01/Documents/work/phd-papers/continuous-training/code/spark/continuous-training/data/criteo-full/evaluation-data" "updater=constant"

~/Documents/frameworks/spark/2.2.0/bin/spark-submit --class de.dfki.deployment.ContinuousClassifier --master "spark://MacBook-Pro-5.home:7077" --driver-memory 3g --executor-memory 5G /Users/bede01/Documents/work/phd-papers/continuous-training/code/spark/continuous-training/target/continuous-training-1.0-SNAPSHOT-jar-with-dependencies.jar "batch-duration=1" "slack=10" "incremental=true" "initial-training-path=/Users/bede01/Documents/work/phd-papers/continuous-training/code/spark/continuous-training/data/criteo-full/initial-training/0" "streaming-path=/Users/bede01/Documents/work/phd-papers/continuous-training/code/spark/continuous-training/data/criteo-full/processed/*" "temp-path=/Users/bede01/Documents/work/phd-papers/continuous-training/code/spark/continuous-training/data/criteo-full/temp-data" "result-path=/Users/bede01/Documents/work/phd-papers/continuous-training/experiment-results/criteo-full" "num-iterations=500" "input-format=vector" "step-size=0.001" "model-path=/Users/bede01/Documents/work/phd-papers/continuous-training/code/spark/continuous-training/data/criteo-full/models/learning-rates/step-decay/day-0/model" "test-path=/Users/bede01/Documents/work/phd-papers/continuous-training/code/spark/continuous-training/data/criteo-full/evaluation-data" "updater=step-decay"
