---
title: Services in a Layered Architecture
description: Services in a Layered Architecture
header: Services in a Layered Architecture
---

In a layered architecture the Services layer is a middle layer designed to encapsulate business and system logic in a stateless manner.

Services orchestrate a series of steps using other services and repositories.

A service is an optional layer; it should not be necessary to go through the Services layer. If you are using a repository layer it's totally acceptable to go straight to the repository from a controller, skipping out the service layer.

### Application Services

Provide non-infrastructure related operations that wouldn't come up when discussion the domain model outside the context of software.

An example of an application service might be exporting transactions as a CSV. CSV has no meaning in the domain of banking.

Improve cohesiveness of domain model by preventing software implementation leaking into it.

### Domain Services

Scripts a use-case involving multiple domain objects.

An example may be funds transfer. That doesn't fit nicely into either the account or customer but does orchestrate a series of steps involving them both.

Help maintain only core responsibilities in domain objects.

CRUD operations are not domain services. Controller should interact directly with the domain model. Should be sort scripts, not simple 1 liners that delegate to an almost identical interface.

### Infrastructure Services

Encapsulates access to an external system. Often used by application and domain services.

An example would be emailing or queueing messages.

Make domain model more re-usable by separating non-domain software concerns.

&nbsp;
