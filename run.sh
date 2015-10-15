#!/bin/sh

SECOR_JAR=$(ls secor-*-SNAPSHOT.jar)

exec java -ea -Dsecor.kafka.group=${SECOR_GROUP} \
    -Daws.access.key=${AWS_ACCESS_KEY} \
    -Daws.secret.key=${AWS_SECRET_KEY} \
    -Dzookeeper.quorum=${ZK_QUORUM} \
    -Dkafka.seed.broker.host=${SEED_BROKER_HOST} \
    -Dsecor.s3.bucket=${S3_BUCKET} \
    -Dsecor.s3.path=${S3_PATH} \
    -Dlog4j.configuration=log4j.prod.properties \
    -Dconfig=secor.prod.backup.properties \
    -cp ${SECOR_JAR}:lib/* \
    com.pinterest.secor.main.ConsumerMain
