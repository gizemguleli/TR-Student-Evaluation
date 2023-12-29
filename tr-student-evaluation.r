{
 "cells": [
  {
   "cell_type": "markdown",
   "id": "bbc64c69",
   "metadata": {
    "_cell_guid": "0afbd355-85ec-48c9-9df0-2b4b35875a75",
    "_uuid": "e32e5b20-c950-4412-ae5a-715306055af0",
    "jupyter": {
     "outputs_hidden": false
    },
    "papermill": {
     "duration": 0.00227,
     "end_time": "2023-12-29T18:15:41.217739",
     "exception": false,
     "start_time": "2023-12-29T18:15:41.215469",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "\r\n",
    "####preliminary #############\r\n",
    "##loading  and reading packages  if its required \r\n",
    "\r\n",
    "if(!require(ClusterR)){install.packages(\"rstatix\")}\r\n",
    "if(!require(cluster)){install.packages(\"cluster\")}\r\n",
    "if(!require(factoextra)){install.packages(\"factoextra\")}\r\n",
    "if(!require(flexclust)){install.packages(\"flexclust\")}\r\n",
    "if(!require(fpc)){install.packages(\"fpc\")}\r\n",
    "if(!require(ClusterR)){install.packages(\"ClusterR\")}\r\n",
    "if(!require(ClusterR)){install.packages(\"ggpubr\")}\r\n",
    "install.packages(\"ggpubr\", repos = \"http://cran.us.r-project.org\")\r\n",
    "\r\n",
    "library(cluster)\r\n",
    "library(factoextra)\r\n",
    "library(flexclust)\r\n",
    "library(fpc)\r\n",
    "library(ClusterR)\r\n",
    "library(rstatix)\r\n",
    "library(ggpubr)\r\n",
    "\r\n",
    "install.packages(\"reshape\")\r\n",
    "library(dplyr)\r\n",
    "library(ggplot2)\r\n",
    "library(tidyr)\r\n",
    "library(reshape)\r\n",
    "\r\n",
    "##Data Loading \r\n",
    "library(readr)\r\n",
    "trstudent <- read_csv(\"turkiye-student-evaluation_R_Specific.csv\")\r\n",
    "\r\n",
    "#view and Check first and last 6 obs of dataset to be sure that it readed Clearly \r\n",
    "head(trstudent)\r\n",
    "tail(trstudent)\r\n",
    "\r\n",
    "##Empty value controls\r\n",
    "trstudent[!complete.cases(trstudent),]\r\n",
    "\r\n",
    "attach(trstudent)\r\n",
    "#####EDA Analysis #############\r\n",
    "\r\n",
    "##summarize statistics and structure of dataset \r\n",
    "str(trstudent)\r\n",
    "summary(trstudent)\r\n",
    "\r\n",
    "#instance and attribute components in dataset\r\n",
    "dim(trstudent)\r\n",
    "\r\n",
    "att_hist <- ggplot(trstudent, aes(x = attendance)) + geom_histogram(color = \"black\", fill = \"blue\", bins = 20) +labs(x = \"attendance\", y = \"Frequency\", title = \"Distribution of Attendance\")\r\n",
    "easiness_hist <- ggplot(df, aes(x = Easiness)) +\r\n",
    "  geom_histogram(color = \"black\", fill = \"green\", bins = 20) +\r\n",
    "  stat_bin(aes(label = paste0(round((..count../nrow(df))*100), \"%\")), geom = \"text\", vjust = -0.5, color = \"white\", size = 3, bins = 20) +\r\n",
    "  labs(x = \"Easiness\", y = \"Frequency\", title = \"Distribution of Easiness Ratings\")\r\n",
    "\r\n",
    "\r\n",
    "# Plot a histogram of the scores for each question\r\n",
    "trstudent %>%\r\n",
    "  select(starts_with(\"Q\")) %>%\r\n",
    "  gather() %>%\r\n",
    "  ggplot(aes(value)) +\r\n",
    "  geom_histogram(bins = 5) +\r\n",
    "  facet_wrap(~key, nrow = 5)\r\n",
    "\r\n",
    "# Plot a boxplot of the scores for each question by course\r\n",
    "trstudent %>%\r\n",
    "  select(starts_with(\"Q\"), course) %>%\r\n",
    "  gather(key = \"question\", value = \"score\", starts_with(\"Q\")) %>%\r\n",
    "  ggplot(aes(course, score)) +  # Add the `group` aesthetic\r\n",
    "  geom_boxplot() +\r\n",
    "  facet_wrap(~question, nrow = 5)\r\n",
    "\r\n",
    "\r\n",
    "#### Plot a heatmap of the correlation matrix\r\n",
    "# Calculate the correlation matrix\r\n",
    "cor_matrix <- cor(trstudent %>% select(starts_with(\"Q\")))\r\n",
    "\r\n",
    "# Melt the correlation matrix\r\n",
    "cor_melted <- as.data.frame(as.table(cor_matrix))\r\n",
    "names(cor_melted) <- c(\"Q1\", \"Q2\", \"Correlation\")\r\n",
    "\r\n",
    "# Create the heatmap\r\n",
    "ggplot(cor_melted, aes(Q1, Q2, fill = Correlation)) +\r\n",
    "  geom_tile() +\r\n",
    "  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +\r\n",
    "  labs(title = \"Correlation Matrix of Survey Questions\")\r\n",
    "\r\n",
    "# Boxplots for variables of interest\r\n",
    "trstudent %>%\r\n",
    "  gather(key = \"variable\", value = \"value\", 'repeat', attendance, difficulty) %>%\r\n",
    "  ggplot(aes(x = variable, y = value)) +\r\n",
    "  geom_boxplot() +\r\n",
    "  labs(x = \"Variable\", y = \"Value\")\r\n",
    "\r\n",
    "\r\n",
    "\r\n",
    "## Subset the dataset to include only the evaluation questions\r\n",
    "subset_data <- trstudent[, 7:34]\r\n",
    "\r\n",
    "# Scale the data to normalize the variables\r\n",
    "scaled_data <- scale(subset_data)\r\n",
    "\r\n",
    "# Determine the optimal number of clusters \r\n",
    "##using the elbow method using wcsse\r\n",
    "\r\n",
    "fviz_nbclust(scaled_data, FUNcluster=kmeans, method = \"wss\", k.max = 10) + theme_minimal() + ggtitle(\"The Elbow Method\")\r\n",
    "\r\n",
    "###using silhouette and kmeans\r\n",
    "fviz_nbclust(scaled_data, kmeans, method=\"silhouette\")+ theme_minimal()+ ggtitle(\"The Silhouette\") # factoextra::\r\n",
    "\r\n",
    "###using gap statistic (*too long to calculate)\r\n",
    "\r\n",
    "fviz_gap_stat(clusGap(scaled_data, FUNcluster = kmeans, K.max = 24))\r\n",
    "\r\n",
    "\r\n",
    "# From the elbow plot, we can see that the optimal number of clusters is 4\r\n",
    "# Apply K-means clustering with 4 clusters\r\n",
    "set.seed(123)\r\n",
    "kmeans_clusters <- kmeans(scaled_data, centers=4)\r\n",
    "\r\n",
    "#plot(scaled_data, col = kmeans_clusters$cluster, pch=\".\", cex=3) # figure has only 2D\r\n",
    "#points(kmeans_clusters$centers, col = 1:5, pch = 8, cex=2, lwd=2)\r\n",
    "#fviz_cluster(list(data=scaled_data, cluster=kmeans_clusters$cluster), ellipse.type=\"norm\", geom=\"point\", stand=FALSE, palette=\"jco\", ggtheme=theme_classic()) \r\n",
    "#factoextra::\r\n",
    "\r\n",
    "# View the cluster assignments for each feedback\r\n",
    "cluster_ass <- kmeans_clusters$cluster\r\n",
    "\r\n",
    "centers <- kmeans_clusters$centers\r\n",
    "# Add the cluster assignments to the original dataset\r\n",
    "trstudent$cluster <- cluster_ass\r\n",
    "trstudent$cluster <- cluster_ass\r\n",
    "# Analyze the clusters by comparing the means of each variable for each cluster\r\n",
    "cluster_means <- aggregate(subset_data, by=list(trstudent$cluster), mean)\r\n",
    "\r\n",
    "# View the cluster means for each variable\r\n",
    "print(cluster_means)\r\n",
    "\r\n",
    "\r\n",
    "# Compute the principal components\r\n",
    "pca <- prcomp(eval_data, scale=TRUE)\r\n",
    "\r\n",
    "# Extract the first two principal components\r\n",
    "PC1 <- pca$x[,1]\r\n",
    "PC2 <- pca$x[,2]\r\n",
    "help(plot)\r\n",
    "###In this code, we first subset the dataset to only include the evaluation questions and scale the data to\r\n",
    "#normalize the variables. We then use the prcomp() function to compute the principal components, \r\n",
    "#with the scale=TRUE parameter indicating that the variables should be scaled. \r\n",
    "#Finally, we extract the first two principal components (PC1 and PC2) from the result of the prcomp() function.\r\n",
    "#Note that the principal components are linear combinations of the original variables and represent the directions\r\n",
    "#of maximal variation in the data. The first principal component (PC1) captures the most variance in the data, \r\n",
    "#while the second principal component (PC2) captures the second most variance. \r\n",
    "#You can compute additional principal components by including more columns in the x[, ] indexing expression.\r\n",
    "\r\n",
    "\r\n",
    "# Load the ggplot2 package\r\n",
    "library(ggplot2)\r\n",
    "\r\n",
    "# Create a scatterplot of the first two principal components, colored by cluster\r\n",
    "ggplot(trstudent, aes(x=PC1, y=PC2, color=as.factor(cluster))) +\r\n",
    "  geom_point(size=3) +\r\n",
    "  xlab(\"PC1\") +\r\n",
    "  ylab(\"PC2\") +\r\n",
    "  ggtitle(\"Clustering Results\") +\r\n",
    "  theme_bw()\r\n",
    "help(ggplot)\r\n",
    "\r\n",
    "\r\n",
    "\r\n",
    "# Perform hierarchical clustering\r\n",
    "hc <- hclust(dist(survey_data), method = \"ward.D2\")\r\n",
    "\r\n",
    "# Plot the dendrogram\r\n",
    "plot(hc, hang = -1, main = \"Dendrogram of Survey Data\")\r\n",
    "\r\n",
    "# Identify the optimal number of clusters\r\n",
    "rect.hclust(hc, k = 5, border = \"red\")"
   ]
  }
 ],
 "metadata": {
  "kaggle": {
   "accelerator": "none",
   "dataSources": [
    {
     "datasetId": 3330,
     "sourceId": 5431,
     "sourceType": "datasetVersion"
    }
   ],
   "dockerImageVersionId": 30618,
   "isGpuEnabled": false,
   "isInternetEnabled": true,
   "language": "r",
   "sourceType": "notebook"
  },
  "kernelspec": {
   "display_name": "R",
   "language": "R",
   "name": "ir"
  },
  "language_info": {
   "codemirror_mode": "r",
   "file_extension": ".r",
   "mimetype": "text/x-r-source",
   "name": "R",
   "pygments_lexer": "r",
   "version": "4.0.5"
  },
  "papermill": {
   "default_parameters": {},
   "duration": 3.674542,
   "end_time": "2023-12-29T18:15:41.343383",
   "environment_variables": {},
   "exception": null,
   "input_path": "__notebook__.ipynb",
   "output_path": "__notebook__.ipynb",
   "parameters": {},
   "start_time": "2023-12-29T18:15:37.668841",
   "version": "2.5.0"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
