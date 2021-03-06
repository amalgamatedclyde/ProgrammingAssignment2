## makeCacheMatrix() accepts a matrix as an argument. the function internals cache the inverse of this matrix
## using the companion function, cacheSolve.
## cacheSolve solves for the inverted matrix or, if the solution already exists, returns a cached version 
## saved as an internal variable of the makeCacheMatrix function

makeCacheMatrix <- function(x = matrix()) {

  inv <- NULL
  identical_input <- FALSE
  
    # getter and setter functions for the input matrix 
    # we tell the user when they are passing a matrix identical to the previous one, and if so, do not invalidate cache.
  set <- function(y) {
    if(identical(x, y)){
      set_identical_input(TRUE)
      message("input matrix is identical to cached matrix")
    }
    else{
      set_identical_input(FALSE)
      x <<- y
      inv <<- NULL
    }
  }
  get <- function() x
  setinv <- function(x.inverse) inv <<- x.inverse
  getinv <- function() inv
  
  # setter and getter functions for the identical_input flag. flag is TRUE when the input matrix is 
  # identical to previous one
  set_identical_input <- function(true_false) identical_input <<- true_false
  get_identical_input <- function() identical_input
  
  #return a list of handles to the internal functions
  list(set_matrix = set, get_matrix = get, setinv = setinv, getinv = getinv, identical_input = get_identical_input)
}

cacheSolve <- function(x, ...) {
  #retrieve the inverted matrix from the makeCacheMatrix object passed to cacheSolve()
  #if it exists, otherwise solve for it.
  #tell the user if the cache is being retrieved or when the input matrix is unchanged
  inv <- x$getinv()
  if(x$identical_input() && !is.null(inv)){
    message("input matrix is unchanged: getting cached data")
    return(inv)
  }
  else if(!is.null(inv)) {
    message("getting cached data")
    return(inv)
  }
  data <- x$get_matrix()
  inv <- solve(data, ...)
  x$setinv(inv)
  inv
}