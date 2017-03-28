hadoop fs -rm -r s3://<bucket name>/<output path>
hadoop jar /usr/lib/hadoop-mapreduce/hadoop-streaming.jar \
           -input s3://<bucket name>/<input path> -output /<bucket name>/<output path>  \
           -file /<local path>/mapper.py -mapper /<local path>/mapper.py \
           -file /<local path>/reducer.py -reducer /<local path>/reducer.py
