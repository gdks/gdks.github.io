---
title: The Law Of Demeter
description: The Law Of Demeter and the Train Wreck
header: The Law Of Demeter
---

The law of demeter states a module should not know about the innards of the objects it manipulates. More precisely, the LoD states that a method m of class C should only call methods of:

* C
* An object created by m
* An object passed as a argument to m
* An object held in an instance variable of C

m should not invoke methods on objects returned by any of the calls in m.

This law is also more informally known as "talk to friends, not to strangers".

### Train Wreck Example
The classic example of a violation of the LoD is the construct known as a train wreck. For example,

```
request.getParams().getPageNumber();
```

If request is an object then we should be asking it to do something. Not asking about its internals.

It should be noted that this principle only applies in the case of request being an object. If it was a data structure then it wouldn't be a violation of LoD.

&nbsp;
