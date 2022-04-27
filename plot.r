# type = "p" : for points (default)
# type = "l" : for lines
# type = "b" : for both points and lines
# type = "c" : for the lines part along of “b”
# type = "o" : for both overplotted
# type = "h" : for histogram (vertical lines)
# type = "s" : for stair steps
# type = "S" : for other steps
# type = "n" : for no plotting

# 그래프 여러 개 한 화면에 나타내기
par(mfrow = c(2,2))

hist(x, y, main="Title", xlab="", ylab="")            # histogram
plot(x, y, main="Title", xlab="", ylab="", type="l")  # line
barplot(x, y, main="Title", xlab="", ylab="")         # barplot
