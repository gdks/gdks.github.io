---
title: OWASP Security Top 10
description:
header: OWASP Security Top 10
---

### 10. Unvalidated Redirects and Forwards

The result of accepting untrusted input.

An example could be a phishing scam using an unvalidated url to redirect to a malicious website example.com/login.php?redirect=malicious.example.com.

### 9. Insufficient Transport Layer Security

Use up to date TLS.

### 8. Cross Site Request Forgery (CSRF)

You're logged into PayPal. Another site you visit makes a request to a PayPal URL and your logged in session is used.

Can be avoided by using POST, CSRF tokens or require user interaction.

### 7. Missing Functional Level Access Control

Ability to edit URLs/requests to view data you shouldn't. Use consistent access control layer.

### 6. Sensitive Data Exposure

Don't store card details, un-hashed passwords, unnecessary sensitive docs. Do use security experts.

### 5. Security Misconfiguration

Hide error messages/inner workings. Leave configuration to exports.

### 4. Insecure Direct Object References

Ability to edit URLs/requests to view data you shouldn't. Use consistent access control layer.

### 3. Cross Site Scripting (XSS)

Using unescaped user input to submit request to another URL. For example, exposing session ID from cookie. Escape all user input.

### 2. Broken Authentication and Session Management

Don't put session ID in URL. Track IP to session. Use HTTPS sessions. Use session framework.

### 1. Injection

Filter/escape all input, all the time and use frameworks and libraries.

&nbsp;
