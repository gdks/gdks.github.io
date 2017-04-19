---
title: 10 Software Project Quality Factors
description: Overview of factors that make for a clean software project
header: 10 Software Project Quality Factors
---

### Code review
Code review for every change that is introduced into the codebase should be a core principle followed by us all.

### Version control
It doesn't matter which VCS you use but every project should be under version control.

### Development Environment
Every repository should contain a readme with one command that will provision a development instance of the application. It should be easy for a developer to checkout the project and start changing code; we want as little friction here as possible.

### Configuration Management
This can be managed in many ways but it should be possible to inject configuration into the application at runtime. Configuration should not contain any sensitive data such as passwords or keys. Options for this can include using environment variables or running a dedicated configuration server.

### Dependency Management
Every application should use a dependency/package management tool. Examples of these include Maven, Composer or NPM.

### Dependency Injection
Every application should be using dependency injection.

### Logging
Every application should log messages locally and upload logs to a central system. The logs can either be uploaded by the application itself or by an agent. <a href="https://www.elastic.co/">elastic</a> is a good option for storing and aggregating your logs.

### Metrics
Every application should expose metrics that can be used to measure and monitor the state of the application in realtime. These are useful as part of the deployment process to monitor whether a newly released version of our application has introduced any problems.

### Build
Every application should use a build tool such as Ant or Gradle to create a single artifact containing all dependencies. This is what will be deployed.

### Deployment
The output of the build step is a single artifact. This should then be followed by a deployment stage which will deploy the artifact to the desired environments.
