echo
echo " ____    _____      _      ____    _____ "
echo "/ ___|  |_   _|    / \    |  _ \  |_   _|"
echo "\___ \    | |     / _ \   | |_) |   | |  "
echo " ___) |   | |    / ___ \  |  _ <    | |  "
echo "|____/    |_|   /_/   \_\ |_| \_\   |_|  "
echo
echo

DELAY="$2"

: ${DELAY:="50"}

echo "Import Kafka image"
set -x
docker load < bitnami_kafka_3.tar.gz
set +x
sleep $DELAY

echo "Import zoo keeper image"
set -x
docker load < bitnami_zookeeper_3.7.tar.gz
set +x
sleep $DELAY

echo "Deploy K8s Kafka/zookeeper services"
set -x
kubectl apply -f kafka-deployment.yaml,kafka-service.yaml,zookeeper-deployment.yaml,zookeeper-service.yaml,pgkafka-kafka-data-persistentvolumeclaim.yaml,pgkafka-zookeeper-data-persistentvolumeclaim.yaml,k8-dashboard.yaml
set +x
