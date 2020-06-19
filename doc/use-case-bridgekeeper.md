# Bridge Keeper Workflow

A very simple, minimal workflow.

## Questions

1. What is your name?
2. What is your quest?
3. What is your favorite color?
4. What is the airspeed velocity of an unladen swallow?

## Actions

- Create a new BridgeIntake (status => :pending)
- If questions 3 or 4 are answered incorrectly, eject the user into the
  chasm, otherwise allow them to cross. (status => :rejected, :accepted)
