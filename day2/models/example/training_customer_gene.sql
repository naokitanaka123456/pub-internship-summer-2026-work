WITH
final AS (
	SELECT
		t1.customer_gender,
		t2.gene,
		COUNT(*) AS count,
		ROUND(COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS ratio
	FROM {{ source('training', 'customers') }} AS t1
	LEFT OUTER JOIN {{ ref('gene_definition') }} AS t2
		ON t1.customer_age BETWEEN t2.age_lower_limit AND t2.age_upper_limit
	GROUP BY
		t1.customer_gender,
		t2.gene
)

SELECT *
FROM final
