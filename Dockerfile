FROM apache/hadoop:3.4.3

USER root

RUN apt-get update && apt-get install -y python3

RUN mkdir -p /hadoop/dfs/name /hadoop/dfs/data

ENV HADOOP_HOME=/opt/hadoop
ENV PATH=$PATH:/opt/hadoop/bin:/opt/hadoop/sbin