# Cue: Architecture

## Terminology

* *Room*: a virtual waiting room, a place where visitors wait for being admitted to the target website.
* *Visitor*: a person trying to access target website, usually represented with UUID.
* *Target website*: a website that visitors are trying to reach, this is what Cue is protecting.
* *Visitor number*: a sequential number that visitors get when they join the room.

## General user flow

1. A visitor arrives on a room page
2. The visitor joins the room and is assigned a number (or their old number is retrieved)
3. As the time passes visitors are admitted sequentially according to their numbers
4. When a visitor is admitted, they get redirected to the target website

Following diagram ties to illustrate this flow:

```mermaid
flowchart TD
  Start([A visitor arrives to a room]) --> IsNew{Is this a new visitor?}
  IsNew --Yes--> Assign[Cue assigns a new sequential number to the visitor]
  IsNew --No--> Retrieve[Cue retrieves visitor's number]
  Assign --> Wait[Visitor waits for the next number to be admitted]
  Retrieve --> Wait
  Wait -. Time passes .-> Next
  Next[Cue admits next number] --> IsMatch{Is this the visitors's number?}
  IsMatch --No--> Wait
  IsMatch --Yes--> Redirect([The visitor is redirected to the target website])
```
