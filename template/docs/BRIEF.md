# Brief: <Project name>

One page. Written on Day 0, before ARCHITECTURE.md and SPEC.md. No appetite, no build.

## Problem
What hurts today, for whom, and what they do instead.

## User and job
- Main user:
- Job they hire this product to do:

## Use cases (3 to 7)
In the order a user meets them.
1. As a <user> I can <do> so that <outcome>.
2. ...
3. ...

## Success number
One number that tells us it worked in 3 months:

## Appetite
How much time v1 gets (1 to 2 weeks, 6 weeks, or more). The scope fits the time, not the other way round.

## Out of scope
- <Things v1 will not do>

## Future direction
- Likely (1 to 2 years, earns a design option now):
- Dream (nice if it happens, no design work now):

## The 8 must-ask questions
Answer these before writing ARCHITECTURE.md. Short answers are fine.

1. Who is the main user, and what job are they hiring this product to do?
2. What are the top 3 to 5 things a user must be able to do in v1?
3. How much time are we willing to spend on v1: 1 to 2 weeks, 6 weeks, or more?
4. Where could this be in 1 to 2 years? Which parts are likely and which are dreams? (Only likely ones earn a design option now.)
5. How many users at launch and in a year? Peak requests per second? Mostly reads or writes?
6. What sensitive data do we hold (money, personal data, minors), and what laws or policies apply?
7. Which outside systems must we connect to (payments, SSO, SMS, email, an existing database)?
8. Who builds and maintains this (people and agents), and which stack do they know best?

The agent also answers one question itself: which choices here are one-way doors? Each one gets an entry in `docs/DECISIONS.md`.
