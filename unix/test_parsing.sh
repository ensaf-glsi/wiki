#!/bin/bash

# Initialize our own variables
output_file=""
verbose=0

function help() {
    echo "Usage: $0 [-h] [-v] [-o <output_file>]"
    echo "  -h: Display this help message."
    echo "  -v: Verbose mode."
    echo "  -o <output_file>: Write output to output_file."
}

# Parse the options
while getopts "hvo:" opt; do
    case ${opt} in
        h )
            help
            exit 0
            ;;
        v )
            verbose=1
            ;;
        o )
            output_file=$OPTARG
            ;;
        \? )
            echo "Invalid Option: -$OPTARG" 1>&2
            help
            exit 1
            ;;
    esac
done
shift $((OPTIND -1))

# Rest of the script
if [ "$verbose" -eq 1 ]; then
    echo "Verbose mode is on."
fi
if [ ! -z "$output_file" ]; then
    echo "Output will be written to $output_file"
fi


echo "arg 1 : $1"
echo "arg 2 : $2"
shift
echo "arg 1 : $1"
echo "arg 2 : $2"
shift
echo "arg 1 : $1"
echo "arg 2 : $2"
echo "arg 3 : $3"
echo "arg 4 : $4"
echo "arg 5 : $5"

