**Generate a fake dataset that we can use in the demonstration**
</br>A matrix of data with 10 samples where we measured 100 genes in each sample

```{r}
data.matrix <- matrix(nrow=100, ncol=10)
```

</br>**name the samples**
</br>The first 5 samples will be "wt" or "wild type" samples
</br>"wt" samples are the normal, every day samples
</br>The last 5 samples will be "ko" or "knock-out" samples
</br>These are samples that are missing a gene because we knocked it out

```{r}
colnames(data.matrix) <- c(
  paste("wt", 1:5, sep=""),
  paste("ko", 1:5, sep="")
)
```

</br>**name the genes**
</br>Usually you'd have things like "Sox9" AND "Utx"
</br>but since this is a fake dataset, we have gene1, gene2, ..., gene100

```{r}
rownames(data.matrix) <- paste("gene", 1:100, sep="")
```

</br>This is where we give the fake genes fake read counts
</br>rpois : used poisson distribution

```{r}
for (i in 1:100) {
  wt.values <- rpois(5, lambda=sample(x=10:1000, size=1))
  ko.values <- rpois(5, lambda=sample(x=10:1000, size=1))
  
  data.matrix[i, ] <- c(wt.values, ko.values)
}
```

</br>**First 6 rows in our data matrix**
</br>NOTE : The samples are columns, and the genes are rows

```{r}
head(data.matrix)
```

</br>**Call prcomp() to do PCA on our data**
</br>The goal is to draw a graph that shows how the samples are related (or not related) to each other
</br>NOTE : By default, prcomp() expects the samples to be rows and the genes to be columns
</br>Since the samples in our data matrix are columns, and the genes(variables) are rows
</br>**★ we have to transpose the matrix using the t() function**
</br>If we don't transpose the matrix,
</br>we will ultimately get a graph that shows how the genes are related to each other

```{r}
pca <- prcomp(t(data.matrix), scale=TRUE)
```

</br>**★ prcomp() returns three things: x, sdev, rotation**
</br>x contains the principal components (PCs) for drawing a graph
</br>Here we are using the first two columns in x to draw a 2-D gaph that uses the first two PCs
</br>Remember! Since there are 10 samples, there are 10 PCs
</br>The first PC accounts for the most variation in the original data
</br>(the gene expression across all 10 samples),
</br>the 2nd PC accounts for the second most variation and so on
</br>To plot a 2-D PCA graph, we usually use the first 2 PCs
</br>However, sometimes we use PC2 and PC3

```{r}
plot(pca$x[,1], pca$x[,2])
```

</br>**Graph interpretation**
</br>5 of the samples are on one side of the graph
</br>and the other 5 samples are on the other side of the graph
</br>To get a sense of how meaningful these clusters are,
</br>let's see how much variation in the original data PC1 accounts for

</br>To do this, we use the square of "sdev"
</br>which stands for "standard deviation",
</br>to calculate how much variation in the original data each principal component accounts for

```{r}
pca.var <- pca$sdev^2
```

</br>Since the percentage of variation that each PC accounts for is way more interesting
</br>than the actual value, we calculate the percentages

```{r}
pca.var.per <- round(pca.var/sum(pca.var)*100, 1)
```

</br>**Plot the percentages is easy with barplot()**

```{r}
barplot(pca.var.per, main="Scree Plot", xlab="Principal Component", ylab="Percent Variation")
```

</br>**Graph interpretation**
</br>PC1 accounts for almost all of the variation in the data!
</br>This means that there is a big difference between two clusters
</br>(5 on the left and 5 on the right)

</br>We can use ggplot2 to make a fancy PCA plot that looks nice
</br>and also provides us with tons of information

```{r}
install.packages("ggplot2")
library(ggplot2)
```

</br>**First, format the data the way ggplot2 likes it**
</br>We made a data frame with one column with the sample ids,
</br>two columns for the X and Y coordinates for each sample

```{r}
pca.data <- data.frame(Sample=rownames(pca$x),
                       X=pca$x[,1],
                       Y=pca$x[,2])
```

</br>**Here's what the dataframe looks like**
</br>We have one row per sample
</br>Each row has a sample ID and X/Y coordinates for that sample

```{r}
pca.data
```

</br>The X-axis tells us what percentage of the variation in the original data that PC1 accounts for
</br>The Y-axis tells us what percentage of the variation in the original data that PC2 accounts for
</br>Now the samples are labeled, so we know which ones are on the left and the right
</br>**★ geom_text : plot the labels, rather than dots or some other shape**
</br>**★ theme_bw : makes the graph's background white**

```{r}
ggplot(data=pca.data, aes(x=X, y=Y, label=Sample)) +
  geom_text() +
  xlab(paste("PC1 - ", pca.var.per[1], "%", sep=""))+
  ylab(paste("PC2 - ", pca.var.per[2], "%", sep=""))+
  theme_bw() +
  ggtitle("My PCA Graph")
```

</br>Lastly, let's look at how to use loading scores to determine
</br>which genes have the largest effect on where samples are plotted in the PCA plot
</br>**★ The prcomp() function calls the loading scores rotation**
</br>There are loading scores for each PC
</br>Here we're just going to look at the loading scores for PC1
</br>since it accounts for 92% of the variation in the data

```{r}
loading_scores <- pca$rotation[,1]
```

</br>Genes that push samples to the left side of the graph will have large negative values
</br>and genes that push samples to the right will have large positive values
</br>Since we're interested in both sets of genes,
</br>we'll use the abs() function to sort based on the number's magnitude rather than from high to low

```{r}
gene_scores <- abs(loading_scores)
```

</br>Now we sort the magnitude of the loading scores, from high to row

```{r}
gene_score_ranked <- sort(gene_scores, decreasing=TRUE)
```

</br>Now we get the names of top 10 genes with the largest loading score magnitudes

```{r}
top_10_genes <- names(gene_score_ranked[1:10])
top_10_genes
```

</br>**Show the scores (and +/- sign)**
</br>Lastly, we can see which of these genes have positive loading scores, these push the "ko" samples to the right side of the graph
</br>then we see which genes have negative loading scores, these push the "wt" samples to the left side of the graph

```{r}
pca$rotation[top_10_genes,1]
```
