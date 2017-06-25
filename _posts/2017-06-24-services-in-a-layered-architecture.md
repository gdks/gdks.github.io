---
title: Services in a Layered Architecture
description: Services in a Layered Architecture
header: Services in a Layered Architecture
---

In a layered architecture the Services layer is a middle layer designed to encapsulate business and system logic in a stateless manner.

Services orchestrate a series of steps using other services and repositories.

A service is an optional layer; it should not be necessary to go through the Services layer. If you are using a repository layer it's totally acceptable to go straight to the repository from a controller, skipping out the service layer. Services should not be 1 liners that delegate to an almost identical interface.

### Domain Services

Domain Services script a scenario involving multiple domain objects.

An example would be a funds transfer; it doesn't fit nicely into either the account or customer but does orchestrate a series of steps involving them both. This helps maintain only core responsibilities in domain objects.

CRUD operations are not domain services. Controllers can interact directly with the domain model or data access layer.

### Application Services

Application Services implement non-infrastructure related operations that wouldn't come up when discussion the domain model outside the context of software.

An example of an application service might be exporting transactions as a CSV. CSV has no meaning in the domain of banking.

Improve cohesiveness of domain model by preventing software implementation leaking into it.

### Infrastructure Services

Infrastructure Services encapsulate access to or integration with an external system or process. Often used by application and domain services. They make the domain model more re-usable by encapsulating non-domain concerns and separating them out.

An example would be sending emails or queueing messages.

&nbsp;
