
# Flink

## Resource Management

### Job Manager

The JobManagers (also called masters) coordinate the distributed execution. They schedule tasks, coordinate checkpoints, coordinate recovery on failures, etc. There is always at least one Job Manager. A high-availability setup will have multiple JobManagers, one of which one is always the leader, and the others are standby.

### Task Manager

The TaskManagers (also called workers) execute the tasks (or more specifically, the subtasks) of a dataflow, and buffer and exchange the data streams. Each TaskManager is a JVM process, and may execute one or more subtasks in separate threads. The managed memory of a Taskmanager is equally split up between the Taskslots. No CPU isolation happens between the slots, just the managed memory is divided. Tasks in the same JVM share TCP connections (via multiplexing) and heartbeat messages. They may also share data sets and data structures, thus reducing the per-task overhead.

### Task Slot

To control how many tasks a worker accepts, a worker has so called task slots (at least one). Each TaskSlot is a Thread within the respective JVM process and represents a fixed subset of resources of the TaskManager. Number of tasks slots is set by property 'taskmanager.numberOfTaskSlots'. We recommend to set the number of slots to the number of processors per machine. As a rule-of-thumb, a good default number of task slots would be the number of CPU cores.  

When starting a Flink application, users can supply the default number of slots to use for that job. The command line value therefore is called -p (for parallelism). In addition, it is possible to set the number of slots in the programming APIs for the whole application (e.g., StreamExecutionEnvironment.setParallelism(6)) and for individual operators (e.g., DataStream.addSink(bucketSink).setParallelism(6)). 

The highest parallelism that can be set in the pipeline code is the total number of slots, which is the product of "TaskManagers" and "slots."

### Yarn Session

Apache Hadoop YARN is a cluster resource management framework. It allows to run various distributed applications on top of a cluster. Flink runs on YARN next to other applications. Users do not have to setup or install anything if there is already a YARN setup.

### Resources:
- https://ci.apache.org/projects/flink/flink-docs-stable/concepts/runtime.-html#task-slots-and-resources
- https://developer.here.com/olp/documentation/pipeline/topics/stream-processing.html
- https://ci.apache.org/projects/flink/flink-docs-stable/ops/deployment/yarn_setup.html


## Save Points and CheckPoints

**Save point** is a point-in-time snapshot of an entire streaming application, it includes information about exactly where you were in the stream and any inflight information being processed (execution state, e.g., session windows) at that moment.
It contains metadata about reading position in input stream as well as inflight application state. Save point is typically stored on a distributed file system.
When you start from a save point it basically rewinds application to point in time the snapshot was taken. You can also use a different version of application to launch from save point (for example you fixed a bug and you like to reprocess all data with new code). Save points are for turning back time. It can also be used for A/B testing where you can run both variants from save save point and compare results.  
By default, savepoints are stored in the JobManager, but you should configure an appropriate state backend for your application.  

**Check points** is Apache Flink’s internal mechanism to recover from failures, consisting of the copy of the application’s state and including the reading positions of the input. In case of a failure, Flink recovers an application by loading the application state from the Checkpoint and continuing from the restored reading positions as if nothing happened. When a checkpoint is triggered, the offsets for each partition are stored in the checkpoint. CheckPoints are owned, created and dropped automatically and periodically by Flink, without any user interaction, to ensure full recovery in case of an unexpected job failure. On the contrary, Savepoints are owned and managed (i.e. they are scheduled, created, and deleted) manually by the user.  

Conceptually, Flink’s Savepoints are different from Checkpoints in a similar way that backups are different from recovery logs in traditional database systems.

### Resources

- https://stackoverflow.com/questions/45603953/apache-flink-difference-between-checkpoints-save-points
- https://data-artisans.com/blog/differences-between-savepoints-and-checkpoints-in-flink
- https://data-artisans.com/blog/how-apache-flink-manages-kafka-consumer-offsets
