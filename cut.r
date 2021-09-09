# Convert Numeric to Factor
# https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/cut

# Similar Functions : cut(), ifesle(), within()

# include.lowest = TRUE : Convert even if the value is equal to the minimum
# right = TRUE : a < x <= b
# right = FALSE : a <= x <b

score = cut(score,
            breaks = c(0, 40, 60, 80, 100),
            include.lowest = TRUE,
            right = FALSE,
            abels = c("F", "D", "C", "B", "A")
            )
