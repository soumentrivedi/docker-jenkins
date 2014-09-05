#!/bin/bash
# Setting up SSH Host Key Authentication for Git
mkdir -p /root/.ssh
cp /scripts/id_rsa /root/.ssh/id_rsa
chmod 700 /root/.ssh/id_rsa
echo -e "Host gerritforge.lmera.ericsson.se\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config