---
title: Java Collections Overview
description:
header: Java Collections Overview
---

The Java collections framework is a set of implementations of common data structures. A collection is an object that can hold references to other objects.

| Set | List | Map |
| --- | ---- | --- |
| HashSet | ArrayList | HashMap |
| LinkedHashSet | LinkedList | LinkedHashMap |
| TreeSet | Vector | HashTable |
|  |  | TreeMap |

### ArrayList

Allows duplicates ordered by index.

Offers consistent time for size, isEmpty, get, iterator. Therefore can be considered for fast random access.

### LinkedList

Allows duplicates ordered by index.

Offers constant time for adding + removing elements at the end of the list.

### HashSet

Best performing implementation of Set.

No duplication and unordered.

### LinkedHashSet

No duplication. Ordered by insertion order.

### TreeSet

No duplication. Orders by value based on natural ordering or provided comparator.

### HashMap

Unordered and allows nulls.

### LinkedHasMap

Use when you want a Map with key-value pairs sorted by insertion order. Allows nulls.

### TreeMap

Sorted by natural ordering of keys or by comparator. Does not allow nulls.


&nbsp;
