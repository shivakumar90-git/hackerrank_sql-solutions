with numbers as (
  select level as n 
  from dual connect by level <=1000
  ),
primes as (
  select n 
  from numbers 
  where n>=2 
  and not exists (
  select 1 from numbers n2 
  where n2.n>1
and n2.n<numbers.n 
  and mod(numbers.n,n2.n) = 0
 )
)
select listagg(n,'&') within group (order by n) as prime_numbers 
from primes;
