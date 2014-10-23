sieve (p : lis) = p : sieve [n | n <- lis, mod n p /= 0]
primes = sieve [2..]



