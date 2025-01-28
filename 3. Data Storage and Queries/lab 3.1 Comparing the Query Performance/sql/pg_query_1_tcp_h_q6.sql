select /* TPC-H Q6 */
	sum(l_extendedprice * l_discount) as revenue
from
	lineitem
where
	l_shipdate >= date '1994-01-01'
	and l_shipdate < cast('1994-01-01' as date) + interval '1 year' 
	and l_discount between .06 - 0.01 and .06 + 0.01
	and l_quantity < 24;
