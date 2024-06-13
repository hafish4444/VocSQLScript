
select SUBSTRING(k.Prize_Time, 3, 2) as year, SUBSTRING(k.Prize_Time, 5, 2) as month, group_concat(distinct k.prize_term)
FROM kmsprizeno k
GROUP BY SUBSTRING(k.Prize_Time, 3, 2), SUBSTRING(k.Prize_Time, 5, 2);

select SUBSTRING(k.Prize_Time, 2, 2) from kmsprizeno k; 