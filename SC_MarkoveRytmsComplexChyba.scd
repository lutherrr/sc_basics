/*
 *                            COPYRIGHT
 *
 *  markovgen.c
 *  Copyright (C) 2014 Exstrom Laboratories LLC
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  A copy of the GNU General Public License is available on the internet at:
 *  http://www.gnu.org/copyleft/gpl.html
 *
 *  or you can write to:
 *
 *  The Free Software Foundation, Inc.
 *  675 Mass Ave
 *  Cambridge, MA 02139, USA
 *
 *  Exstrom Laboratories LLC contact:
 *  stefan(AT)exstrom.com
 *
 *  Exstrom Laboratories LLC
 *  Longmont, CO 80503, USA
 *
 */

//ported to supercollider oct2017


//------------------------------------------------------------------------
// comp
// generates all compositions of n
//------------------------------------------------------------------------
(
~comp= {|n|
	var res= List.new;
	var parts= Array.newClear(n-1);
	var compose= {|n, p, m|
		if(n==0, {
			res.add(parts.copyRange(0, m-1)++p);
		}, {
			parts[m]= p;
			compose.(n-1, 1, m+1);
			compose.(n-1, p+1, m);
		});
	};
	compose.(n-1, 1, 0);
	res;
};
)

~comp.(4).do{|x| x.postln};
~comp.(5).do{|x| x.postln};
~comp.(6).do{|x| x.postln};
~comp.(7).do{|x| x.postln};


//------------------------------------------------------------------------
// compm
// generates all compositions of n into m parts
//------------------------------------------------------------------------
(
~compm= {|n, m|
	var res= List.new;
	var parts= Array.newClear(n-1);
	var mp= m-1;
	var compose= {|n, p, m|
		if(n==0, {
			if(m==mp, {
				res.add(parts.copyRange(0, m-1)++p);
			});
		}, {
			if(m<mp, {
				parts[m]= p;
				compose.(n-1, 1, m+1);
			});
			compose.(n-1, p+1, m);
		});
	};
	compose.(n-1, 1, 0);
	res;
};
)

~compm.(4, 3).do{|x| x.postln};
~compm.(5, 3).do{|x| x.postln};
~compm.(6, 3).do{|x| x.postln};
~compm.(7, 3).do{|x| x.postln};


//------------------------------------------------------------------------
// compa
// generates compositions of n with allowed parts pi
//------------------------------------------------------------------------
(
~compa= {|n ...p|
	var res= List.new;
	var parts= Array.newClear(n-1);
	var aparts= p;
	var allowed= {|p| aparts.includes(p)};
	var compose= {|n, p, m|
		if(n==0, {
			if(allowed.(p), {
				res.add(parts.copyRange(0, m-1)++p);
			});
		}, {
			if(allowed.(p), {
				parts[m]= p;
				compose.(n-1, 1, m+1);
			});
			compose.(n-1, p+1, m);
		});
	};
	compose.(n-1, 1, 0);
	res;
};
)

~compa.(8, 3, 4, 5, 6).do{|x| x.postln};
~compa.(8, 2, 4, 5, 6).do{|x| x.postln};
~compa.(8, 1, 4, 5, 6).do{|x| x.postln};


//------------------------------------------------------------------------
// compam
// generates compositions of n with m parts from the set (p1 p2 ...)
//------------------------------------------------------------------------
(
~compam= {|n, m ...p|
	var res= List.new;
	var parts= Array.newClear(n-1);
	var mp= m-1;
	var aparts= p;
	var allowed= {|p| aparts.includes(p)};
	var compose= {|n, p, m|
		if(n==0, {
			if(m==mp and:{allowed.(p)}, {
				res.add(parts.copyRange(0, m-1)++p);
			});
		}, {
			if(m<mp and:{allowed.(p)}, {
				parts[m]= p;
				compose.(n-1, 1, m+1);
			});
			compose.(n-1, p+1, m);
		});
	};
	compose.(n-1, 1, 0);
	res;
};
)

~compam.(16, 5, 2, 3, 4).do{|x| x.postln};
~compam.(16, 5, 1, 2, 3, 4).do{|x| x.postln};
~compam.(16, 5, 1, 2, 3, 4, 5).do{|x| x.postln};


//------------------------------------------------------------------------
// comprnd
// generate random composition of n
//------------------------------------------------------------------------
(
~comprnd= {|n|
	var res= List.new;
	var p= 1;
	(n-1).do{
		if(0.5.coin, {
			p= p+1;
		}, {
			res.add(p);
			p= 1;
		});
	};
	res.add(p);
	res;
};
)

~comprnd.(3).do{|x| x.postln};
~comprnd.(4).do{|x| x.postln};
~comprnd.(8).do{|x| x.postln};


//------------------------------------------------------------------------
// compmrnd
// generate random composition of n into m parts
//------------------------------------------------------------------------
(
~compmrnd= {|n, m|
	var res= List.new;
	var mp= m-1;
	var np= n-1;
	var p;
	var j= 1;
	while({mp>0}, {
		p= mp*(1/np);
		if(1.0.rand<p, {
			res.add(j);
			mp= mp-1;
			j= 1;
		}, {
			j= j+1;
		});
		np= np-1;
	});
	res.add(j+np);
	res;
};
)

~compmrnd.(3, 2).do{|x| x.postln};
~compmrnd.(4, 2).do{|x| x.postln};
~compmrnd.(8, 2).do{|x| x.postln};
~compmrnd.(8, 4).do{|x| x.postln};


//------------------------------------------------------------------------
// neck
// generates all binary necklaces of length n
//------------------------------------------------------------------------
(
~neck= {|n|
	var res= List.new;
	var b= Array.newClear(n+1);
	var neckbin= {|k, l|
		if(k>n, {
			if((n%l)==0, {
				res.add(b.copyRange(1, n));
			});
		}, {
			b[k]= b[k-l];
			if(b[k]==1, {
				neckbin.(k+1, l);
				b[k]= 0;
				neckbin.(k+1, k);
			}, {
				neckbin.(k+1, l);
			});
		});
	};
	b[0]= 1;
	neckbin.(1, 1);
	res;
};
)

~neck.(4).do{|x| x.postln};
~neck.(5).do{|x| x.postln};
~neck.(6).do{|x| x.postln};


//------------------------------------------------------------------------
// neckm
// generates all binary necklaces of length n with m ones
//------------------------------------------------------------------------
(
~neckm= {|n, n1|
	var res= List.new;
	var b= Array.newClear(n+1);
	var neckbin= {|k, l, m|
		if(k>n, {
			if((n%l)==0 and:{m==n1}, {
				res.add(b.copyRange(1, n));
			});
		}, {
			b[k]= b[k-l];
			if(b[k]==1, {
				neckbin.(k+1, l, m+1);
				b[k]= 0;
				neckbin.(k+1, k, m);
			}, {
				neckbin.(k+1, l, m);
			});
		});
	};
	b[0]= 1;
	neckbin.(1, 1, 0);
	res;
};
)

~neckm.(4, 2).do{|x| x.postln};
~neckm.(8, 2).do{|x| x.postln};
~neckm.(8, 4).do{|x| x.postln};


//------------------------------------------------------------------------
// necka
// generates binary necklaces of length n with allowed parts pi
//------------------------------------------------------------------------
(
~necka= {|n ...p|
	var res= List.new;
	var b= Array.newClear(n+1);
	var aparts= p;
	var allowed= {|p| aparts.includes(p)};
	var neckbin= {|k, l, p|
		if(k>n, {
			if((n%l)==0 and:{allowed.(p) and:{p<=n}}, {
				res.add(b.copyRange(1, n));
			});
		}, {
			b[k]= b[k-l];
			if(b[k]==1, {
				if(allowed.(p) or:{k==1}, {neckbin.(k+1, l, 1)});
				b[k]= 0;
				neckbin.(k+1, k, p+1);
			}, {
				neckbin.(k+1, l, p+1);
			});
		});
	};
	b[0]= 1;
	neckbin.(1, 1, 1);
	res;
};
)

~necka.(4, 2, 3, 4).do{|x| x.postln};
~necka.(8, 2, 3, 4).do{|x| x.postln};
~necka.(8, 4, 1).do{|x| x.postln};


//------------------------------------------------------------------------
// neckam
// generates binary necklaces of length n with m ones and allowed parts pi
//------------------------------------------------------------------------
(
~neckam= {|n, n1 ...p|
	var res= List.new;
	var b= Array.newClear(n+1);
	var aparts= p;
	var allowed= {|p| aparts.includes(p)};
	var neckbin= {|k, l, m, p|
		if(k>n, {
			if((n%l)==0 and:{allowed.(p) and:{p<=n and:{m==n1}}}, {
				res.add(b.copyRange(1, n));
			});
		}, {
			b[k]= b[k-l];
			if(b[k]==1, {
				if(allowed.(p) or:{k==1}, {neckbin.(k+1, l, m+1, 1)});
				b[k]= 0;
				neckbin.(k+1, k, m, p+1);
			}, {
				neckbin.(k+1, l, m, p+1);
			});
		});
	};
	b[0]= 1;
	neckbin.(1, 1, 0, 1);
	res;
};
)

~neckam.(8, 4, 1, 3).do{|x| x.postln};
~neckam.(16, 5, 2, 3, 4).do{|x| x.postln};


//------------------------------------------------------------------------
// part
// generates all partitions of n
//------------------------------------------------------------------------
(
~part= {|n|
	var res= List.new;
	var parts= Array.newClear(n-1);
	var partitions= {|n, p, m|
		if(n==0, {
			res.add(parts.copyRange(0, m-1)++p);
		}, {
			if(n>0, {
				parts[m]= p;
				partitions.(n-p, p, m+1);
				partitions.(n-1, p+1, m);
			});
		});
	};
	partitions.(n-1, 1, 0);
	res;
};
)

~part.(4).do{|x| x.postln};
~part.(5).do{|x| x.postln};
~part.(6).do{|x| x.postln};


//------------------------------------------------------------------------
// partm
// generates all partitions of n into m parts
//------------------------------------------------------------------------
(
~partm= {|n, m|
	var res= List.new;
	var parts= Array.newClear(n-1);
	var mp= m-1;
	var partitions= {|n, p, m|
		if(n==0, {
			if(m==mp, {
				res.add(parts.copyRange(0, m-1)++p);
			});
		}, {
			if(n>0, {
				if(m<mp, {
					parts[m]= p;
					partitions.(n-p, p, m+1);
				});
				partitions.(n-1, p+1, m);
			});
		});
	};
	partitions.(n-1, 1, 0);
	res;
};
)

~partm.(4, 3).do{|x| x.postln};
~partm.(4, 2).do{|x| x.postln};


//------------------------------------------------------------------------
// parta
// generates all partitions of n with allowed parts pi
//------------------------------------------------------------------------
(
~parta= {|n ...p|
	var res= List.new;
	var parts= Array.newClear(n-1);
	var aparts= p;
	var allowed= {|p| aparts.includes(p)};
	var partitions= {|n, p, m|
		if(n==0, {
			if(allowed.(p), {
				res.add(parts.copyRange(0, m-1)++p);
			});
		}, {
			if(n>0, {
				if(allowed.(p), {
					parts[m]= p;
					partitions.(n-p, p, m+1);
				});
				partitions.(n-1, p+1, m);
			});
		});
	};
	partitions.(n-1, 1, 0);
	res;
};
)

~parta.(8, 2, 3).do{|x| x.postln};
~parta.(8, 1, 4).do{|x| x.postln};


//------------------------------------------------------------------------
// partam
// generates all partitions of n with m parts from the set (p1 p2 ...)
//------------------------------------------------------------------------
(
~partam= {|n, m ...p|
	var res= List.new;
	var parts= Array.newClear(n-1);
	var mp= m-1;
	var aparts= p;
	var allowed= {|p| aparts.includes(p)};
	var partitions= {|n, p, m|
		if(n==0, {
			if(m==mp and:{allowed.(p)}, {
				res.add(parts.copyRange(0, m-1)++p);
			});
		}, {
			if(n>0, {
				if(m<mp and:{allowed.(p)}, {
					parts[m]= p;
					partitions.(n-p, p, m+1);
				});
				partitions.(n-1, p+1, m);
			});
		});
	};
	partitions.(n-1, 1, 0);
	res;
};
)

~partam.(16, 5, 1, 2, 3, 4, 5).do{|x| x.postln};


//------------------------------------------------------------------------
// permi
// generates permutations of the integers ai>=0
// to generate all permutations they must be ordered a1<a2<...<an
// any other order will only generate permutations that are larger
// in lexicographic order
//------------------------------------------------------------------------
(
~permi= {|...a|
	var res= List.new;
	var n= a.size, i, j, m;
	var running= true;
	a= [-1]++a;
	while({running}, {
		res.add(a.copyRange(1, n));
		i= n-1;
		while({i>0 and:{a[i]>=a[i+1]}}, {
			i= i-1;
		});
		if(i==0, {
			running= false;
		}, {
			j= n;
			while({a[i]>=a[j]}, {
				j= j-1;
			});
			m= a[j];
			a[j]= a[i];
			a[i]= m;
			j= i+1;
			k= n;
			while({j<k}, {
				m= a[j];
				a[j]= a[k];
				a[k]= m;
				j= j+1;
				k= k-1;
			});
		});
	});
	res;
};
)

~permi.(1, 2, 3).do{|x| x.postln};


//------------------------------------------------------------------------
// debruijn
// generates the largest de Bruijn sequence of order n
//------------------------------------------------------------------------
(
~debruijn= {|n|
	var ndbs= 1<<n;
	var idbs= 0;
	var dbs;
	var b= Array.newClear(n+1);
	var neckbin= {|k, l|
		if(k>n, {
			if((n%l)==0, {
				l.do{|k|
					dbs[idbs+k]= if(b[k+1]==0, {0}, {1});
				};
				idbs= idbs+l;
			});
		}, {
			b[k]= b[k-l];
			if(b[k]==1, {
				neckbin.(k+1, l);
				b[k]= 0;
				neckbin.(k+1, k);
			}, {
				neckbin.(k+1, l);
			});
		});
	};
	b[0]= 1;
	dbs= Array.newClear(ndbs);
	neckbin.(1, 1);
	dbs;
};
)

~debruijn.(3).do{|x| x.postln};
~debruijn.(4).do{|x| x.postln};


//------------------------------------------------------------------------
// b2int
// reads binary strings and converts them to interval notation
//------------------------------------------------------------------------
(
~b2int= {|line|
	var res= List.new;
	var nbit= line.size;
	var k, j= 0;
	while({j<nbit}, {
		k= 1;
		while({line[j= j+1]!=$1 and:{j<nbit}}, {
			k= k+1;
		});
		res.add(k);
	});
	res;
};
)

~b2int.("1010010001001000");


//------------------------------------------------------------------------
// int2b
// reads intervals and converts them to a binary string
//------------------------------------------------------------------------
(
~int2b= {|line|
	var res= "";
	line.do{|k|
		res= res++$1;
		(k-1).do{res= res++$0};
	};
	res;
};
)

~int2b.([2, 3, 4, 3, 4]);


//------------------------------------------------------------------------
// chsequl
// generates the upper or lower Christoffel word for p/q
//   t= type of word (\upper or \lower)
//   p= numerator
//   q= denominator
//   n= number of terms to generate, default= p+q
//------------------------------------------------------------------------
(
~chsequl= {|t, p, q, n|
	var res= List.new;
	var i= 0, a, b;
	n= n??{p+q};
	while({
		res.add(if(t==\upper, 1, 0));
		i= i+1;
		a= p;
		b= q;
		while({a!=b and:{i<n}}, {
			if(a>b, {
				res.add(1);
				b= b+q;
			}, {
				res.add(0);
				a= a+p;
			});
			if(a==b and:{i<n}, {
				res.add(if(t==\upper, 0, 1));
				i= i+1;
			});
			i= i+1;
		});
		i<n;
	}, {});
	res;
};
)

~chsequl.(\upper, 8, 7, 6).do{|x| x.postln};
~chsequl.(\upper, 8, 7, 5).do{|x| x.postln};
~chsequl.(\upper, 8, 3).do{|x| x.postln};
~chsequl.(\lower, 8, 3).do{|x| x.postln};
~chsequl.(\lower, 3, 8).do{|x| x.postln};
~chsequl.(\upper, 3, 8).do{|x| x.postln};


//------------------------------------------------------------------------
// cfsqrt
// calculates continued fractions for: sqrt(n)
//------------------------------------------------------------------------
(
~cfsqrt= {|n|
	var res= List.new;
	var frac= List.new;
	var aa= 0, bb= 1, a0= sqrt(n).asInteger;
	var a= a0;
	res.add(a);
	if(a*a<n, {
		while({a!=(2*a0)}, {
			aa= bb*a-aa;
			bb= (n-(aa*aa)).div(bb);
			a= (a0+aa).div(bb);
			frac.add(a);
		});
	});
	res.add(frac);
};
)

~cfsqrt.(3);
~cfsqrt.(12);
~cfsqrt.(32);
~cfsqrt.(128);


//------------------------------------------------------------------------
// cfcv
// calculates a continued fraction convergent
//------------------------------------------------------------------------
(
~cfcv= {|...ai|
	var res= List.new;
	var p0= 0, p1= 1, q0= 1, q1= 0;
	var p2, q2;
	ai.do{|a|
		p2= a*p1+p0;
		q2= a*q1+q0;
		p0= p1;
		p1= p2;
		q0= q1;
		q1= q2;
	};
	res.add(p2).add(q2);
};
)

~cfcv.(1, 1, 2);
~cfcv.(1, 1, 2, 1, 2);
~cfcv.(1, 2, 3, 4);
~cfcv.(1, 2, 3, 4, 5);


//------------------------------------------------------------------------
// pfold
// generates fold sequences
//   n= number of terms, 1,3,7,15,31,63,127,...
//   m= number of bits
//   f= function number 0 -> 2^m-1
//------------------------------------------------------------------------
(
~pfold= {|n, m, f|
	var res= List.new;
	var i= 1, j, k;
	var oddeven= {|n, a, b|  //finds a and b such that n= 2^a*(2*b+1)
		var k= 0, l;
		l= n&(0-n);
		b= (n/l-1).div(2);
		while({l>1}, {
			l= l>>1;
			k= k+1;
		});
		[k, b];
	};
	while({i<=n}, {
		#k, j= oddeven.(i, k, j);
		k= k%m;
		b= if(f&(1<<k)>0, 1, 0);
		if((2*j+1)%4>1, {b= 1-b});
		res.add(b);
		i= i+1;
	});
	res;
};
)

~pfold.(15, 4, 1);
~pfold.(31, 5, 0);
~pfold.(3, 4, 5);
~pfold.(4, 5, 6);


//------------------------------------------------------------------------
// rndint
// generates random numbers with specified correlation
//   m= range of numbers, 0 to m
//   s= starting number, 0 to m
//   c= degree of correlation
//      0= total correlation (all numbers= s)
//      m= no correlation (each number is independent)
//   n= how many random numbers to generate
//------------------------------------------------------------------------
(
~rndint= {|m, s, c, n|
	var res= List.new;
	var i= 0, j;
	while({i<n}, {
		res.add(s);
		if(c>0, {
			j= m;
			while({j>(m-c)}, {
				k= 1/j;
				if(1.0.rand<(s*k), {s= s-1});
				j= j-1;
			});
			k= 1/2;
			j= 0;
			while({j<c}, {
				if(1.0.rand<k, {s= s+1});
				j= j+1;
			});
		});
		i= i+1;
	});
	res;
};
)

~rndint.(3, 2, 1, 4);


//------------------------------------------------------------------------
// markovgen
// generates random numbers using a markov chain
//   mfile= transition matrix file name
//   s= starting state
//   n= how many random numbers to generate
//------------------------------------------------------------------------
(
~table= #[4,
	0, 1, 0, 0,
	0, 0, 1, 0,
	0, 0, 0, 1,
	1, 0, 0, 0
];
~markovgen= {|m, s, n|
	var res= List.new;
	var ns= m[0];  //number of states
	var pM, mm, u;
	n.do{|i|
		res.add(s);
		pM= m.drop(1).clump(ns)[s];
		u= 1.0.rand;
		j= 0;
		x= 0.0;
		while({j<ns}, {
			x= x+pM[j];
			if(u<x, {s= j; j= ns});
			j= j+1;
		});
	};
	res;
};
)

~markovgen.(~table, 0, 8);
~markovgen.(~table, 1, 8);
~markovgen.([2, 0.75, 0.25, 0.25, 0.75], 0, 8);