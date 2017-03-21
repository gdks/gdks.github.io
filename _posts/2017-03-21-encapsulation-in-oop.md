---
title: Encapsulation in Object Oriented Programming
description: Encapsulation in Object Oriented Programming
header: Encapsulation in Object Oriented Programming
---


&nbsp;

Encapsulation is an Object Oriented Programming concept that binds together data and functions that manipulate that data to keep it safe from outside interference from client code.

### Information Hiding
Information or data hiding is an important concept in Encapsulation. It's often interpreted as being about hiding fields and using getters and setters but this isn't really the case. It should really be called implementation hiding as we want to hide the implementation details, not necessarily all the information. We want to avoid asking objects for their internal information; we should ask the objects that know the information to do the work.

### Protection of Invariants
We want to make it as difficult as possible to put objects into invalid state. We shouldn't have public fields or setters and the constructor should ensure the object is fully initialised in a valid state on construction.

### Command Query Separation (CQS)
Operations should be either commands or queries, not both. Commands have side effects, they effect the state of the application in some way, for example, changing a data structure or updating a database. Queries simply return data, they should not have any side effects. Queries are naturally idempotent; they can be run any number of times without changing the answer.

Following CQS throughout a whole codebase means you can tell from a method signature whether a method has side effects wthout having to look at the implementation.

&nbsp;
