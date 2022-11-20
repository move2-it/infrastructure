#!/bin/bash
[ $# -eq 0 ] && { echo "Usage: $0 okteto_token"; exit 1; }
okteto_token=$1
okteto context use https://cloud.okteto.com --token $okteto_token
okteto kubeconfig