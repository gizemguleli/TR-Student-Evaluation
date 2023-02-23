TR STUDENT EVALUATION
Gizem Guleli
2022-11-28

```{r,include=FALSE,warning=FALSE, results=FALSE, message=FALSE}
##Loading and reading packages if its required
if(!require(ClusterR)){install.packages("rstatix")}
if(!require(cluster)){install.packages("cluster")}
if(!require(factoextra)){install.packages("factoextra")}
if(!require(flexclust)){install.packages("flexclust")}
if(!require(fpc)){install.packages("fpc")}
if(!require(ClusterR)){install.packages("ClusterR")}
if(!require(ClusterR)){install.packages("ggpubr")}
if(!require(ClusterR)){install.packages("reshape")}
install.packages("ggpubr", repos = "http://cran.us.r-project.org")
```


```{r, echo=T,warning=FALSE,results=FALSE, message=FALSE}
library(cluster)
library(factoextra)
library(flexclust)
library(fpc)
library(ClusterR)
library(rstatix)
library(ggpubr)
library(dplyr)
library(ggplot2)
library(tidyr)
library(reshape)
library(gridExtra)
library(readr)
library(ggplot2)

```

##Data Loading

trstudent <- read_csv("turkiye-student-evaluation_R_Specific.csv")

head(trstudent)
tail(trstudent)

colnames(trstudent)[colnames(trstudent)=="instr"] <- "instructor"
colnames(trstudent)[colnames(trstudent)=="class"] <- "course"
colnames(trstudent)[colnames(trstudent)=="nb.repeat"] <- "repeat"

##Empty value controls

trstudent[!complete.cases(trstudent),]
colSums(is.na(trstudent))
attach(trstudent)

###Check changes and last version
head(trstudent)

# Create histograms of the Instructor, Class, Repeat, Attendance and Difficulty  variables

ins_hist <- ggplot(trstudent, aes(x = `instructor`)) +
  geom_histogram(color = "black", fill = "red", bins = 10) +
  stat_bin(aes(label = paste0(round((..count../nrow(trstudent))*100), "%")), geom = "text", vjust = -0.5, color = "black", size = 3, bins = 3) +
  labs(x = "Instructor", y = "Frequency", title = "Distribution of Instructors")

course_hist <- ggplot(trstudent, aes(x = `course`)) +
  geom_histogram(color = "black", fill = "blue", bins = 13) +
  stat_bin(aes(label = paste0(round((..count../nrow(trstudent))*100), "%")), geom = "text", vjust = -0.5, color = "black", size = 3, bins = 13) +
  labs(x = "Course", y = "Frequency", title = "Distribution of Courses")
 
rep_hist <- ggplot(trstudent, aes(x = `repeat`)) +
  geom_histogram(color = "black", fill = "yellow", bins = 10) +
  stat_bin(aes(label = paste0(round((..count../nrow(trstudent))*100), "%")), geom = "text", vjust = -0.5, color = "black", size = 3, bins = 3) +
  labs(x = "Repeat", y = "Frequency", title = "Distribution of Repeating")

att_hist <- ggplot(trstudent, aes(x = attendance)) +
  geom_histogram(color = "black", fill = "green", bins = 10) +
  stat_bin(aes(label = paste0(round((..count../nrow(trstudent))*100), "%")), geom = "text", vjust = -0.5, color = "black", size = 3, bins = 5) +
  labs(x = "Attendance", y = "Frequency", title = "Distribution of Attendance")

dif_hist <- ggplot(trstudent, aes(x = difficulty)) +
  geom_histogram(color = "black", fill = "orange", bins = 20) +
  stat_bin(aes(label = paste0(round((..count../nrow(trstudent))*100), "%")), geom = "text", vjust = -0.5, color = "black", size = 3, bins = 5) +
  labs(x = "Difficulty", y = "Frequency", title = "Distribution of Difficulty")

grid.arrange(ins_hist, course_hist, rep_hist, att_hist,dif_hist)


# Plot a histogram of the scores for each question
trstudent %>%
  select(starts_with("Q")) %>%
  gather() %>%
  ggplot(aes(value)) +
  geom_histogram(bins = 5) +
  facet_wrap(~key, nrow = 5)
 
# Plot a boxplot of the scores for each question by course
trstudent %>%
  select(starts_with("Q"), course) %>%
  gather(key = "question", value = "score", starts_with("Q")) %>%
  ggplot(aes(course, score)) +
  geom_boxplot() +
  facet_wrap(~question, nrow = 5)
## Warning: Continuous x aesthetic
## i did you forget `aes(group = ...)`?
 

## Subset the dataset to include only the evaluation questions
subset_data <- trstudent[, 7:34]

# Scale the data to normalize the variables
scaled_subset <- scale(subset_data)

# Perform PCA analysis
pca1<-prcomp(scaled_subset, center=FALSE, scale.=FALSE) # stats::
pca1$rotation

plot(pca1)
 
#visulation of PCA results
fviz_pca_var(pca1, col.var="steelblue")
 
# visusalisation of quality
fviz_eig(pca1, choice='eigenvalue')
 
fviz_eig(pca1)
 
# table of eigenvalues
eig.val<-get_eigenvalue(pca1)
eig.val

x<-summary(pca1)
plot(x$importance[3,],type="l") 
 
# displaying the most significant questions that constitute PC1 
loading_scores_PC_1<-pca1$rotation[,1]
fac_scores_PC_1<-abs(loading_scores_PC_1)
fac_scores_PC_1_ranked<-names(sort(fac_scores_PC_1, decreasing=T))
pca1$rotation[fac_scores_PC_1_ranked, 1]

# individual results with factoextra::
ind<-get_pca_ind(pca1)  
print(ind)

head(ind$coord) 
head(ind$contrib)
var<-get_pca_var(pca1)
a<-fviz_contrib(pca1, "var", axes=1, xtickslab.rt=90) # default angle=45°
b<-fviz_contrib(pca1, "var", axes=2, xtickslab.rt=90)
grid.arrange(a,b,top='Contribution to the first two Principal Components')
 

#Determinin optimal number of cluster

##using the elbow method using wcsse
fviz_nbclust(scaled_subset, FUNcluster=kmeans, method = "wss", k.max = 10) + theme_minimal() + ggtitle("The Elbow Method")
 
###using silhouette and kmeans
fviz_nbclust(scaled_subset, kmeans, method="silhouette")+ theme_minimal()+ ggtitle("The Silhouette") # factoextra::
 
# 3=8 clusters for observations
km<-eclust(scaled_subset, k=3) 
 
km2<-eclust(scaled_subset, k=8) 
 
# k-means clustering  with PCA result
set.seed(123) # for reproducibility
ss.cs<-center_scale(scaled_subset) 
ss.pca<-princomp(ss.cs)$scores[, 1:2] 
pcakm3<-KMeans_rcpp(ss.pca, clusters=3, num_init=3, max_iters = 100) 
pcakm3
c3<-plot_2d(ss.pca, pcakm3$clusters, pcakm3$centroids)
c3

pcakm8<-KMeans_rcpp(ss.pca, clusters=8, num_init=3, max_iters = 100) 
pcakm8
c8<-plot_2d(ss.pca, pcakm8$clusters, pcakm8$centroids)
c8


 
 
