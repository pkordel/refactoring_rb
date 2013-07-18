# Martin Fowler Refactoring

## Step one: Extract Method

Extract amount due calculation to own method.

## Step two: Move Method to new home

Extracted calculation only uses data from Rental object, so that is
a better home.

## Step three: Replace Temp With Query

Remove redundant local variable amount with new method call on rental object.
The performance penalty of calculating amount due will be addressed in a
later refactoring.
