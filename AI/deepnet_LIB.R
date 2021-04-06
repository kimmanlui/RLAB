
rbm.train=function (x, hidden, numepochs = 3, batchsize = 100, learningrate = 0.8, 
                    learningrate_scale = 1, momentum = 0.5, visible_type = "bin", 
                    hidden_type = "bin", cd = 1) 
{
  if (!is.matrix(x)) 
    stop("x must be a matrix!")
  input_dim <- ncol(x)
  rbm <- list(size = c(input_dim, hidden), W = matrix(runif(hidden * 
                                                              input_dim, min = -0.1, max = 0.1), c(hidden, input_dim)), 
              vW = matrix(rep(0, hidden * input_dim), c(hidden, input_dim)), 
              B = runif(input_dim, min = -0.1, max = 0.1), vB = rep(0, 
                                                                    input_dim), C = runif(hidden, min = -0.1, max = 0.1), 
              vC = rep(0, hidden), learningrate = learningrate, learningrate_scale = learningrate_scale, 
              momentum = momentum, hidden_type = hidden_type, visible_type = visible_type, 
              cd = cd)
  m <- nrow(x)
  numbatches <- m/batchsize
  s <- 0
  for (i in 1:numepochs) { 
    if (i%%10 ==1) print(paste("epochs:", i))
    randperm <- sample(1:m, m)
    if (numbatches >= 1) {
      for (l in 1:numbatches) {
        s <- s + 1
        batch_x <- x[randperm[((l - 1) * batchsize + 
                                 1):(l * batchsize)], ]
        rbm <- do.rbm.train(rbm, batch_x, s)
      }
    }
    if (numbatches > as.integer(numbatches)) {
      batch_x <- x[randperm[(as.integer(numbatches) * batchsize):m], 
                   ]
      s <- s + 1
      rbm <- do.rbm.train(rbm, batch_x, s)
    }
    rbm$learningrate <- rbm$learningrate * rbm$learningrate_scale
  }
  rbm
}

rbm.up=function (rbm, v) 
{
  if (rbm$hidden_type != "bin") stop("only support binary state for rbm hidden layer!")
  #m <- nrow(v)
  sum <- t(t(v %*% t(rbm$W)) + rbm$C) 
  h <- sigm(sum)
  h
}


rbm.down=function (rbm, h) 
{
  if (rbm$visible_type != "bin") stop("only support binary state for rbm hidden layer!")
  #m <- nrow(h)
  sum <- t(t(h %*% rbm$W) + rbm$B) 
  v <- sigm(sum)
  v
}


do.rbm.train=function (rbm, batch_x, s) 
{
  m <- nrow(batch_x)
  v1 <- batch_x
  h1 <- binary.state(rbm.up(rbm, v1))
  vn <- v1
  hn <- h1
  for (i in 1:rbm$cd) {
    vn <- rbm.down(rbm, hn)  #could it be: hn <- rbm.up(rbm, binary.state(vn))
    hn <- rbm.up(rbm, vn)
    if (i < rbm$cd) {
      hn <- binary.state(hn)
    }
  }
  dW <- (t(h1) %*% v1 - t(hn) %*% vn)/m  #????
  dW <- rbm$learningrate * dW
  rbm$vW <- rbm$vW * rbm$momentum + dW
  dw <- rbm$vW
  rbm$W <- rbm$W + dW
  
  dB <- colMeans(v1 - vn)  #???????
  dB <- rbm$learningrate * dB
  rbm$vB <- rbm$vB * rbm$momentum + dB
  dB <- rbm$vB
  rbm$B <- rbm$B + dB
  
  dC <- colMeans(h1 - hn)  #???????
  dC <- rbm$learningrate * dC
  rbm$vC <- rbm$vC * rbm$momentum + dC
  dC <- rbm$vC
  rbm$C <- rbm$C + dC
  rbm$e[s] <- sum((v1 - vn)^2)/m
  rbm
}

sigm=function (x)   1/(1 + exp(-x))

binary.state=function (h) 
{
  p <- matrix(runif(length(h), min = 0, max = 1), nrow = nrow(h), 
              ncol = ncol(h))
  h[h > p] <- 1
  h[h <= p] <- 0
  h
}



nn.train=function (x, y, initW = NULL, initB = NULL, hidden = c(10), activationfun = "sigm", 
          learningrate = 0.8, momentum = 0.5, learningrate_scale = 1, 
          output = "sigm", numepochs = 3, batchsize = 100, hidden_dropout = 0, 
          visible_dropout = 0) 
{
  if (!is.matrix(x)) 
    stop("x must be a matrix!")
  input_dim <- ncol(x)
  output_dim <- 0
  if (is.vector(y)) {
    output_dim <- 1
  }
  else if (is.matrix(y)) {
    output_dim <- ncol(y)
  }
  if (output_dim == 0) 
    stop("y must be a vector or matrix!")
  size <- c(input_dim, hidden, output_dim)
  vW <- list()
  vB <- list()
  if (is.null(initW) || is.null(initB)) {
    W <- list()
    B <- list()
    for (i in 2:length(size)) {
      W[[i - 1]] <- matrix(runif(size[i] * size[i - 1], 
                                 min = -0.1, max = 0.1), c(size[i], size[i - 1]))
      B[[i - 1]] <- runif(size[i], min = --0.1, max = 0.1)
      vW[[i - 1]] <- matrix(rep(0, size[i] * size[i - 1]), 
                            c(size[i], size[i - 1]))
      vB[[i - 1]] <- rep(0, size[i])
    }
  }
  else {
    W <- initW
    B <- initB
    for (i in 2:length(size)) {
      vW[[i - 1]] <- matrix(rep(0, size[i] * size[i - 1]), 
                            c(size[i], size[i - 1]))
      vB[[i - 1]] <- rep(0, size[i])
      if (nrow(W[[i - 1]]) != size[i] || ncol(W[[i - 1]]) != 
          size[i - 1]) {
        stop("init W size is not eq to network size!")
      }
      if (length(B[[i - 1]]) != size[i]) {
        stop("init B size is not eq to network size!")
      }
    }
  }
  nn <- list(input_dim = input_dim, output_dim = output_dim, 
             hidden = hidden, size = size, activationfun = activationfun, 
             learningrate = learningrate, momentum = momentum, learningrate_scale = learningrate_scale, 
             hidden_dropout = hidden_dropout, visible_dropout = visible_dropout, 
             output = output, W = W, vW = vW, B = B, vB = vB)
  m <- nrow(x)
  numbatches <- m/batchsize
  s <- 0
  for (i in 1:numepochs) {
    randperm <- sample(1:m, m)
    if (numbatches >= 1) {
      for (l in 1:numbatches) {
        s <- s + 1
        batch_x <- x[randperm[((l - 1) * batchsize + 
                                 1):(l * batchsize)], ]
        if (is.vector(y)) {
          batch_y <- y[randperm[((l - 1) * batchsize + 
                                   1):(l * batchsize)]]
        }
        else if (is.matrix(y)) {
          batch_y <- y[randperm[((l - 1) * batchsize + 
                                   1):(l * batchsize)], ]
        }
        nn <- nn.ff(nn, batch_x, batch_y, s)
        nn <- nn.bp(nn)
      }
    }
    if (numbatches > as.integer(numbatches)) {
      batch_x <- x[randperm[(as.integer(numbatches) * batchsize):m], 
                   ]
      if (is.vector(y)) {
        batch_y <- y[randperm[(as.integer(numbatches) * 
                                 batchsize):m]]
      }
      else if (is.matrix(y)) {
        batch_y <- y[randperm[(as.integer(numbatches) * 
                                 batchsize):m], ]
      }
      s <- s + 1
      nn <- nn.ff(nn, batch_x, batch_y, s)
      nn <- nn.bp(nn)
    }
    nn$learningrate <- nn$learningrate * nn$learningrate_scale
  }
  nn
}


nn.train=function (x, y, initW = NULL, initB = NULL, hidden = c(10), activationfun = "sigm", 
                   learningrate = 0.8, momentum = 0.5, learningrate_scale = 1, 
                   output = "sigm", numepochs = 3, batchsize = 100, hidden_dropout = 0, 
                   visible_dropout = 0) 
{
  if (!is.matrix(x)) 
    stop("x must be a matrix!")
  input_dim <- ncol(x)
  output_dim <- 0
  if (is.vector(y)) {
    output_dim <- 1
  }
  else if (is.matrix(y)) {
    output_dim <- ncol(y)
  }
  if (output_dim == 0) 
    stop("y must be a vector or matrix!")
  size <- c(input_dim, hidden, output_dim)
  vW <- list()
  vB <- list()
  if (is.null(initW) || is.null(initB)) {
    W <- list()
    B <- list()
    for (i in 2:length(size)) {
      W[[i - 1]] <- matrix(runif(size[i] * size[i - 1], 
                                 min = -0.1, max = 0.1), c(size[i], size[i - 1]))
      B[[i - 1]] <- runif(size[i], min = --0.1, max = 0.1)
      vW[[i - 1]] <- matrix(rep(0, size[i] * size[i - 1]), 
                            c(size[i], size[i - 1]))
      vB[[i - 1]] <- rep(0, size[i])
    }
  }
  else {
    W <- initW
    B <- initB
    for (i in 2:length(size)) {
      vW[[i - 1]] <- matrix(rep(0, size[i] * size[i - 1]), 
                            c(size[i], size[i - 1]))
      vB[[i - 1]] <- rep(0, size[i])
      if (nrow(W[[i - 1]]) != size[i] || ncol(W[[i - 1]]) != 
          size[i - 1]) {
        stop("init W size is not eq to network size!")
      }
      if (length(B[[i - 1]]) != size[i]) {
        stop("init B size is not eq to network size!")
      }
    }
  }
  nn <- list(input_dim = input_dim, output_dim = output_dim, 
             hidden = hidden, size = size, activationfun = activationfun, 
             learningrate = learningrate, momentum = momentum, learningrate_scale = learningrate_scale, 
             hidden_dropout = hidden_dropout, visible_dropout = visible_dropout, 
             output = output, W = W, vW = vW, B = B, vB = vB)
  m <- nrow(x)
  numbatches <- m/batchsize
  s <- 0
  for (i in 1:numepochs) {
    randperm <- sample(1:m, m)
    if (numbatches >= 1) {
      for (l in 1:numbatches) {
        s <- s + 1
        batch_x <- x[randperm[((l - 1) * batchsize + 
                                 1):(l * batchsize)], ]
        if (is.vector(y)) {
          batch_y <- y[randperm[((l - 1) * batchsize + 
                                   1):(l * batchsize)]]
        }
        else if (is.matrix(y)) {
          batch_y <- y[randperm[((l - 1) * batchsize + 
                                   1):(l * batchsize)], ]
        }
        nn <- nn.ff(nn, batch_x, batch_y, s)
        nn <- nn.bp(nn)
      }
    }
    if (numbatches > as.integer(numbatches)) {
      batch_x <- x[randperm[(as.integer(numbatches) * batchsize):m], 
                   ]
      if (is.vector(y)) {
        batch_y <- y[randperm[(as.integer(numbatches) * 
                                 batchsize):m]]
      }
      else if (is.matrix(y)) {
        batch_y <- y[randperm[(as.integer(numbatches) * 
                                 batchsize):m], ]
      }
      s <- s + 1
      nn <- nn.ff(nn, batch_x, batch_y, s)
      nn <- nn.bp(nn)
    }
    nn$learningrate <- nn$learningrate * nn$learningrate_scale
  }
  nn
}



nn.predict=function (nn, x) 
{
  m <- nrow(x)
  post <- x
  for (i in 2:(length(nn$size) - 1)) {
    pre <- t(nn$W[[i - 1]] %*% t(post) + nn$B[[i - 1]])
    if (nn$activationfun == "sigm") {
      post <- sigm(pre)
    }
    else if (nn$activationfun == "tanh") {
      post <- tanh(pre)
    }
    else {
      stop("unsupport activation function 'nn$activationfun'")
    }
    post <- post * (1 - nn$hidden_dropout)
  }
  i <- length(nn$size)
  pre <- t(nn$W[[i - 1]] %*% t(post) + nn$B[[i - 1]])
  if (nn$output == "sigm") {
    post <- sigm(pre)
  }
  else if (nn$output == "linear") {
    post <- pre
  }
  else if (nn$output == "softmax") {
    post <- exp(pre)
    post <- post/rowSums(post)
  }
  else {
    stop("unsupport output function!")
  }
  post
}



nn.ff=function (nn, batch_x, batch_y, s) 
{
  m <- nrow(batch_x)
  if (nn$visible_dropout > 0) {
    nn$dropout_mask[[1]] <- dropout.mask(ncol(batch_x), nn$visible_dropout)
    batch_x <- t(t(batch_x) * nn$dropout_mask[[1]])
  }
  nn$post[[1]] <- batch_x
  for (i in 2:(length(nn$size) - 1)) {
    nn$pre[[i]] <- t(nn$W[[i - 1]] %*% t(nn$post[[(i - 1)]]) + 
                       nn$B[[i - 1]])
    if (nn$activationfun == "sigm") {
      nn$post[[i]] <- sigm(nn$pre[[i]])
    }
    else if (nn$activationfun == "tanh") {
      nn$post[[i]] <- tanh(nn$pre[[i]])
    }
    else {
      stop("unsupport activation function!")
    }
    if (nn$hidden_dropout > 0) {
      nn$dropout_mask[[i]] <- dropout.mask(ncol(nn$post[[i]]), 
                                           nn$hidden_dropout)
      nn$post[[i]] <- t(t(nn$post[[i]]) * nn$dropout_mask[[i]])
    }
  }
  i <- length(nn$size)
  nn$pre[[i]] <- t(nn$W[[i - 1]] %*% t(nn$post[[(i - 1)]]) + 
                     nn$B[[i - 1]])
  if (nn$output == "sigm") {
    nn$post[[i]] <- sigm(nn$pre[[i]])
    nn$e <- batch_y - nn$post[[i]]
    nn$L[s] <- 0.5 * sum(nn$e^2)/m
  }
  else if (nn$output == "linear") {
    nn$post[[i]] <- nn$pre[[i]]
    nn$e <- batch_y - nn$post[[i]]
    nn$L[s] <- 0.5 * sum(nn$e^2)/m
  }
  else if (nn$output == "softmax") {
    nn$post[[i]] <- exp(nn$pre[[i]])
    nn$post[[i]] <- nn$post[[i]]/rowSums(nn$post[[i]])
    nn$e <- batch_y - nn$post[[i]]
    nn$L[s] <- -sum(batch_y * log(nn$post[[i]]))/m
  }
  else {
    stop("unsupport output function!")
  }
  if (s%%10000 == 0) {
    message(sprintf("####loss on step %d is : %f", s, nn$L[s]))
  }
  nn
}

nn.bp=function (nn) 
{
  n <- length(nn$size)
  d <- list()
  if (nn$output == "sigm") {
    d[[n]] <- -nn$e * (nn$post[[n]] * (1 - nn$post[[n]]))
  }
  else if (nn$output == "linear" || nn$output == "softmax") {
    d[[n]] <- -nn$e
  }
  for (i in (n - 1):2) {
    if (nn$activationfun == "sigm") {
      d_act <- nn$post[[i]] * (1 - nn$post[[i]])
    }
    else if (nn$activationfun == "tanh") {
      d_act <- 1.7159 * 2/3 * (1 - 1/(1.7159)^2 * nn$post[[i]]^2)
    }
    d[[i]] <- (d[[i + 1]] %*% nn$W[[i]]) * d_act
    if (nn$hidden_dropout > 0) {
      d[[i]] <- t(t(d[[i]]) * nn$dropout_mask[[i]])
    }
  }
  for (i in 1:(n - 1)) {
    dw <- t(d[[i + 1]]) %*% nn$post[[i]]/nrow(d[[i + 1]])
    dw <- dw * nn$learningrate
    if (nn$momentum > 0) {
      nn$vW[[i]] <- nn$momentum * nn$vW[[i]] + dw
      dw <- nn$vW[[i]]
    }
    nn$W[[i]] <- nn$W[[i]] - dw
    db <- colMeans(d[[i + 1]])
    db <- db * nn$learningrate
    if (nn$momentum > 0) {
      nn$vB[[i]] <- nn$momentum * nn$vB[[i]] + db
      db <- nn$vB[[i]]
    }
    nn$B[[i]] <- nn$B[[i]] - db
  }
  nn
}

nn.test=function (nn, x, y, t = 0.5) 
{
  y_p <- nn.predict(nn, x)
  m <- nrow(x)
  y_p[y_p >= t] <- 1
  y_p[y_p < t] <- 0
  error_count <- sum(abs(y_p - y))/2
  error_count/m
}

