nawk -F '\t' -v pat=':p\\.[A-z0-9]+:' -v OFS='\t' '
{
	printf $1 OFS $4 OFS $5 OFS $6 OFS $7 OFS
    while (match($8, pat)) {
       printf substr($8, RSTART, RLENGTH)","
       $8=substr($8, RSTART+RLENGTH)
    }
	printf OFS $46 OFS $50 OFS $52
	print ""
	
}' HOCM2.flt.filtered.txt > HOCM2.flt.filtered.mutationsextracted.txt
