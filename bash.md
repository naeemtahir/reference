# Bash

- [Get Script Path](#get-script-path)
- [Process file line by line](#process-file-line-by-line)
- [POSIX Style Command Line](#posix-style-command-line)

## Get Script Path

```bash
#!/bin/sh

script_name=`basename "$0"`
script_dir="$( cd "$( dirname "$0" )" && pwd )"

echo "script_name=$script_name"
echo "script_dir=$script_dir"
```

## Process file line by line

```bash
#!/bin/sh

process() {
    local arg=$*

    # anything you want to do with line goes here
    echo $arg 
}

if [ "$#" -eq 1 ]; then
    while IFS= read -r line; 
    do
        process $line
    done < $1	
else
    script_name=`basename "$0"`
    echo "Usage: $script_name <file>"
    exit 1
fi
```

## POSIX Style Command Line

```bash
#!/bin/sh

usage() {
  cat <<HERE
Usage:
  build.sh --job-jar <path-to-job-jar> --from-local-dist [--image-name <image>]
  build.sh --job-jar <path-to-job-jar> --from-archive <path-to-dist-archive> [--image-name <image>]
  build.sh --job-jar <path-to-job-jar> --from-release --flink-version <x.x.x> --scala-version <x.xx> [--hadoop-version <x.x>] [--image-name <image>]
  build.sh --help

  If the --image-name flag is not used the built image name will be 'flink-job'.
  Before Flink-1.8, the hadoop-version is required. And from Flink-1.8, the hadoop-version is optional and would download pre-bundled shaded Hadoop jar package if provided.
HERE
  exit 1
}

while [[ $# -ge 1 ]]
do
key="$1"
  case $key in
    --job-jar)
    JOB_JAR_PATH="$2"
    shift
    ;;
    --from-local-dist)
    FROM_LOCAL="true"
    ;;
    --from-archive)
    FROM_ARCHIVE="$2"
    shift
    ;;
    --from-release)
    FROM_RELEASE="true"
    ;;
    --image-name)
    IMAGE_NAME="$2"
    shift
    ;;
    --flink-version)
    FLINK_VERSION="$2"
    shift
    ;;
    --hadoop-version)
    HADOOP_VERSION="$2"
    HADOOP_MAJOR_VERSION="$(echo ${HADOOP_VERSION} | sed 's/\.//')"
    shift
    ;;
    --scala-version)
    SCALA_VERSION="$2"
    shift
    ;;
    --kubernetes-certificates)
    CERTIFICATES_DIR="$2"
    shift
    ;;
    --help)
    usage
    ;;
    *)
    # unknown option
    ;;
  esac
  shift
done
```