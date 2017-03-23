---
title: SOLID Principles
description:
header: SOLID Principles
---

### Single Responsibility

Methods, classes, modules etc should have only one reason to change. They should have one Responsibility and that should be entirely [encapsulated]({% post_url 2017-03-21-encapsulation-in-oop %}) in the class.

### Open/Closed

Code should be open for extension but closed for modification.

It should be easy to change the functionality of a class without changing the source code of that class. When requirements change in reasonably expected ways, it should be possible to implement the new behaviour by adding new code and changing little or no existing code.

Good examples of this are the strategy and command patterns. The Meyer approach to open/closed should generally be avoided as we want to favour composition over inheritance.

### Liskov Substitution

You should not violate the intent or semantics of the abstraction that you are inheriting from. You have to be able to replace a sub-class for a super-class. We can generally avoid this by favouring composition over inheritance.

### Interface Segregation

Don't force clients to depend on methods they don't use. Use role based interfaces by splitting large interfaces into small specific interfaces.

A classic example of this is changing a method signature in a base class, then having to change a large number of classes as a result even though many of those classes never actually use that argument.

### Dependency Inversion

Implementations should depend on higher level abstractions, not the other way around. As an example I don't want a refactor in my data access layer to force me to make a change to my business logic. Well structured layered architectures and patterns such as bridge can help resolve this problem.

&nbsp;
