
####preliminary #############
##loading  and reading packages  if its required 
if(!require(cluster)){install.packages("cluster")}
if(!require(factoextra)){install.packages("factoextra")}
if(!require(flexclust)){install.packages("flexclust")}
if(!require(fpc)){install.packages("fpc")}
if(!require(ClusterR)){install.packages("ClusterR")}
if(!require(ClusterR)){install.packages("ggpubr")}
install.packages("ggpubr", repos = "http://cran.us.r-project.org")

library(cluster)
library(factoextra)
library(flexclust)
library(fpc)
library(ClusterR)
library(rstatix)
library(ggpubr)

##Data Loading 
library(readr)
trstudent <- read_csv("NEW/turkiye-student-evaluation_R_Specific.csv")

#view and Check first and last 6 obs of dataset to be sure that it readed Clearly 
head(trstudent)
tail(trstudent)
##summarize and stracture of dataset 
str(trstudent)
summary(trstudent)

#instance and attribute components in dataset
dim(trstudent)

##Empty value controls


## Subset the dataset to include only the evaluation questions
eval_data <- trstudent[, 7:34]

# Scale the data to normalize the variables
scaled_data <- scale(eval_data)

# Determine the optimal number of clusters using the elbow method
wcsse <- c()
for(i in 1:10) wcsse[i] <- sum(kmeans(scaled_data, centers=i)$withinss)
plot(1:10, wcsse, type="b", xlab="Number of Clusters", ylab="Within groups sum of squares")

# From the elbow plot, we can see that the optimal number of clusters is 4
# Apply K-means clustering with 4 clusters
set.seed(123)
kmeans_clusters <- kmeans(scaled_data, centers=4)

#plot(scaled_data, col = kmeans_clusters$cluster, pch=".", cex=3) # figure has only 2D
#points(kmeans_clusters$centers, col = 1:5, pch = 8, cex=2, lwd=2)
#fviz_cluster(list(data=scaled_data, cluster=kmeans_clusters$cluster), ellipse.type="norm", geom="point", stand=FALSE, palette="jco", ggtheme=theme_classic()) 
#factoextra::

# View the cluster assignments for each feedback
cluster_ass <- kmeans_clusters$cluster

centers <- kmeans_clusters$centers
# Add the cluster assignments to the original dataset
trstudent$cluster <- cluster_ass
trstudent$cluster <- cluster_ass
# Analyze the clusters by comparing the means of each variable for each cluster
cluster_means <- aggregate(eval_data, by=list(trstudent$cluster), mean)

# View the cluster means for each variable
print(cluster_means)



# Compute the principal components
pca <- prcomp(eval_data, scale=TRUE)

# Extract the first two principal components
PC1 <- pca$x[,1]
PC2 <- pca$x[,2]

###In this code, we first subset the dataset to only include the evaluation questions and scale the data to
#normalize the variables. We then use the prcomp() function to compute the principal components, 
#with the scale=TRUE parameter indicating that the variables should be scaled. 
#Finally, we extract the first two principal components (PC1 and PC2) from the result of the prcomp() function.
#Note that the principal components are linear combinations of the original variables and represent the directions
#of maximal variation in the data. The first principal component (PC1) captures the most variance in the data, 
#while the second principal component (PC2) captures the second most variance. 
#You can compute additional principal components by including more columns in the x[, ] indexing expression.


# Load the ggplot2 package
library(ggplot2)

# Create a scatterplot of the first two principal components, colored by cluster
ggplot(trstudent, aes(x=PC1, y=PC2, color=as.factor(cluster))) +
  geom_point(size=3) +
  xlab("PC1") +
  ylab("PC2") +
  ggtitle("Clustering Results") +
  theme_bw()
help(ggplot)
