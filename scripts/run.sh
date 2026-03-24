#!/bin/bash
set -e

STREAMING_JAR=/opt/hadoop/share/hadoop/tools/lib/hadoop-streaming-3.4.3.jar
cd /scripts

echo "Cleaning old output..."
hdfs dfs -rm -r /user/root/output 2>/dev/null || true

echo "Creating input directory..."
hdfs dfs -mkdir -p /user/root/input

echo "Uploading data..."
for file in /input/*.txt; do
    if [ -f "$file" ]; then
        echo "  Uploading $(basename $file)..."
        hdfs dfs -put -f "$file" /user/root/input/
    fi
done

echo "Running MapReduce..."
hadoop jar "$STREAMING_JAR" \
  -files mapper.py,reducer.py \
  -mapper "python3 mapper.py" \
  -reducer "python3 reducer.py" \
  -input /user/root/input/*.txt \
  -output /user/root/output

echo "Result:"
hdfs dfs -cat /user/root/output/part-00000

echo "Downloading result to /output..."
hdfs dfs -get -f /user/root/output/part-00000 /output/result.txt

echo "Done. Result saved to /output/result.txt"