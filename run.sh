#!/bin/sh

SECOR_JAR_GUESS=$(ls secor-*-SNAPSHOT.jar)

SECOR_JAR=${SECOR_JAR:-$SECOR_JAR_GUESS}
SECOR_BASE_CONFIG=${SECOR_BASE_CONFIG:-secor.prod.backup.properties}
SECOR_MESSAGE_PARSER=${SECOR_MESSAGE_PARSER:-com.pinterest.secor.parser.OffsetMessageParser}
SECOR_GROUP=${SECOR_GROUP:-secor_backup}

exec java -ea -Dsecor.kafka.group=${SECOR_GROUP} \
    -Daws.access.key=${SECOR_AWS_ACCESS_KEY} \
    -Daws.secret.key=${SECOR_AWS_SECRET_KEY} \
    -Dzookeeper.quorum=${SECOR_ZK_CLUSTER} \
    -Dkafka.seed.broker.host=${SECOR_KAFKA_HOST} \
    -Dsecor.s3.bucket=${SECOR_S3_BUCKET} \
    -Dsecor.s3.path=${SECOR_S3_PATH} \
    -Dsecor.message.parser.class=${SECOR_MESSAGE_PARSER} \
    -Dlog4j.configuration=log4j.prod.properties \
    -Dconfig=${SECOR_BASE_CONFIG} \
    -cp ${SECOR_JAR}:lib/* \
    "$@" \
    com.pinterest.secor.main.ConsumerMain
