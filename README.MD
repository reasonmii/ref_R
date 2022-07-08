<b>sites</b>
- https://rpubs.com/chidungkt/449576

<b>shortcut</b>
- \# : Ctrl + Shift + C

<b>Difference between library and require</b>
- https://www.r-bloggers.com/2016/12/difference-between-library-and-require-in-r/
- require() : used inside functions
  - it gives a warning message and returns a logical value
    - FALSE if the requested package is not found
    - TRUE if the package is loaded
- It is better to use the library() as it gives the error message if the package is not found during the package loading time
  - This will indeed avoid unnecessary headaches of tracking down the errors caused while attempting to use the library routines which are not installed.
- library(xyz)
  - result : Error in library(xyz) : there is no package called ‘xyz’
- require(xyz)
  - result : Loading required package: xyz
  - Warning message:
    - In library(package, lib.loc = lib.loc, character.only = TRUE, logical.return = TRUE, :there is no package called ‘xyz’

