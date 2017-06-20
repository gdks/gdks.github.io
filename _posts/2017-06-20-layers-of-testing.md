---
title: Layers of Testing
description: Layers of Testing
header: Layers of Testing
---

## Unit Testing

Developer tool for testing a single method. Multiple tests per method.

Easy to write, not fragile. Change the test, change the implementation. Take little effort.

## Functional Testing

Test multiple methods or classes. Testing what the application does rather than how it does it. Few implementation details. Higher level, more black box.

More fragile as they're testing business functionality. As you change functionality they tend to break. Don't write too early.

## Integration Testing

Tests interaction between different layers of the application. This could be testing from a controller thought to a repository while still mocking away the data access layer or testing how a repository interacts with the data source.

## System Testing

Tests everything can see and talk to each other. Quality of Service type tests can also be included here.

Even more fragile, more effort to write. Testing everything is up and running.

## Automated Acceptance Testing

Tests walking through application as a user. Everything has to be working, DBs, endpoints.

Longest to write, most fragile.

Verifying that everything works the way the user wants.

## A/B Testing

## Smoke / Sanity Testing

A smoke test is a simple check to see if the software functions on the most basic level.

Often used as an initial step in a build and deployment pipeline as if this fails there's no point spending more time running other tests.

## Static Analysis

## Internationalisation / Localisation testing

&nbsp;
