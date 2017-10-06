function select(vector,indices) = [ for (index = indices) vector[index] ];

function head(l) = l[0];
function last(l) = l[len(l)-1];
function tail(l) = [ for (i = [1 : 1 : len(l)-1]) l[i] ];

function sum(v) = len(v) == 0 ? 0 : v[0] + sum(tail(v));
