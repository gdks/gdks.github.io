---
title: What makes a clean software architecture?
description: Overview of main features that make for a clean software architecture
header: What makes a clean software architecture?
---

&nbsp;

### Code review

Every code should be reviewed and only then merged into the integration branch.

&nbsp;

### Version control

Every project should be versioned in git

&nbsp;

### Development environment

Every application repository should contain a readme with one command which will allow a development environment to be brought up automatically.

&nbsp;

### Dependency management

Every application should use a dependency management tool. Examples:


<a href="https://getcomposer.org">https://getcomposer.org</a>

<a href="https://maven.apache.org">https://maven.apache.org</a>

<a href="http://bower.io">http://bower.io</a>		

&nbsp;

### Dependency Injection

Every application should be using dependency injection


<a href="http://symfony.com/doc/current/components/dependency_injection/introduction.html">Symfony DI container</a>

<a href="https://github.com/google/guice">Google Guice</a>

&nbsp;

### Build tools

Every application that requires deployment should contain an <a href="http://ant.apache.org/">ant</a> file with the following targets:


resolve - resolve dependencies and tools

prepare

build - build the source / minify code

test-unit

test-integration

package

&nbsp;

### Configuration management

Each project should contain a configuration file containing all the needed configuration options that makes the application work with minimal effort.

An alternative configuration <b>data souce</b> (local or remote) can be defined using an environment variable.

Both configurations are merged in order to get the final configuration

The alternative configuration source should contain only the configurations that need to be overriden. Example: secrets,production endpoints,debug options

&nbsp;

### Application architecture

Every application should be structured in layers

The application should scale horizontally without manual intervention

If the application can't scale then a second instance should be ready in case the first one has a malfunction

&nbsp;

### Application architecture - Micro Services

Each system should have 1 well defined responsibility

Each application inside the system have 1 responsibility

The application should fail gracefully if any of the internal or external systems fails

Arsenal deals with checks, results and outages

It's not Arsenal's responsibility to deal with alert policies, alert routing, sending emails or notifiy agents

Arsenal delegates these responsibilities to other systems using different consumers

The consumers communicate using events

&nbsp;

### Application architecture - Integration

Use HTTP to integrate with other services

Use a message queue to integrate with other services

&nbsp;

### Application architecture - Event driven

You should decouple the applications within a system using an event driven approach

You extend your system functionality by adding new consumers with well defined responsibilities

&nbsp;

### Logging

Every application should log messages locally using a standard logging framework and upload logs to a central system. The logs can either be uploaded by the application it self or by an agent.

Example: <a href="https://github.com/elastic/logstash">ELK</a>

&nbsp;

### Metrics

Every application should use framework to collect metrics and upload those metrics to a central system.

&nbsp;

### Deployment

Every application should be deployed using docker containers or rpm packages when containers are not available. The application installation folder should be read only.

&nbsp;

### Application state

Every deployed application should be stateless. If shared state is required a solution like <a href="http://redis.io/">redis</a> should be used.

&nbsp;
