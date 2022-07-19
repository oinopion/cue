# Cue: Architecture

## General user flow

1. A user arrives to Cue
2. Cue assigns a sequential number to the user (or retrieves their old number)
3. Time passes and Cue "calls out" numbers sequentially
4. A user with "called out" number gets redirected to the target URL

Following diagram ties to illustrate this flow:

```mermaid
flowchart TD
  Start([User arrives to Cue]) --> IsNew{Is this new visitor?}
  IsNew --Yes--> Assign[Cue assigns a new sequential number to the user]
  IsNew --No--> Retrieve[Cue retrieves user's number]
  Assign --> Wait[User waits for the next number to be called]
  Retrieve --> Wait
  Wait -. Time passes .-> Next
  Next[Cue calls out next number] --> IsMatch{Is this user's number?}
  IsMatch --No--> Wait
  IsMatch --Yes--> Redirect([User is redirected to the target website])
```
