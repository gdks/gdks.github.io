---
title: Getting started with Kinesalite
description: Getting started with Kinesalite
header: Getting started with Kinesalite
---

Kinesalite is an implementation of Amazon's Kinesis, built on LevelDB, that can be used for local development of Kinesis consumers and producers.

To get started, install Kinesalite using npm by running the following command

> npm install -g kinesalite

Install AWS CLI using pip by running the following command

> pip install --upgrade --user awscli

Once both have been installed, the first thing to do is configure the credentials for AWS by running the following command. Since this is a mock instance of Kinesis you can use fake credientials. Just type anything in the fields when requested but keep a note of these for use as your credentials when using the Kinesis libraries to create a consumer or producer.

> aws configure

To start Kinesalite, open a command line and run the following

> kinesalite --port 7000

This will run Kinesalite on the port 7000, so the endpoint for Kinesalite will be http://localhost:7000


Once Kinesalite is running we can create streams and shards with the AWS CLI. Open another Terminal and run the following command.

> aws kinesis create-stream --stream-name testStream --shard-count 1 --endpoint-url http://localhost:7000 --no-verify-ssl

This will create a stream with a single shard on our fake Kinesis. We have a Kinesis instance accessible on http://localhost:7000.

&nbsp;
