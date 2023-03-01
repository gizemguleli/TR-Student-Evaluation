# TR Student Evaluation

## Table of contents
* [Problem](#Problem)
* [About Dataset](#About-Dataset)
* [Analyze](#Analyze)
* [EDA](#EDA)


## Problem
The problem statement is a typical unsupervised learning problem, where with a given dataset we need to find patterns or groupings in the data without any labeled output variable.

## About Dataset
In this case, the dataset consists of feedback from students who attended multiple courses. Each feedback consists of evaluation questions and various other attributes, such as attendance, difficulty, and overall score. The series of questions answered by the students. There are 28 questions, each answered from 1 (very bad) to 5 (very good).


### Attribute Information: 
* **instr:** Instructor's identifier; values taken from {1,2,3} 
* **class:** Course code (descriptor); values taken from {1-13} 
* **repeat:** Number of times the student is taking this course; values taken from {0,1,2,3} 
* **attendance:** Code of the level of attendance; values from {0, 1, 2, 3, 4} 
* **difficulty:** Level of difficulty of the course as perceived by the student; values taken from {1,2,3,4,5}
* Q1: The semester course content, teaching method and evaluation system were provided at the start. 
* Q2: The course aims and objectives were clearly stated at the beginning of the period.
* Q3: The course was worth the amount of credit assigned to it. 
* Q4: The course was taught according to the syllabus announced on the first day of class. 
* Q5: The class discussions, homework assignments, applications and studies were satisfactory. 
* Q6: The textbook and other courses resources were sufficient and up to date. 
* Q7: The course allowed field work, applications, laboratory, discussion and other studies. 
* Q8: The quizzes, assignments, projects and exams contributed to helping the learning. 
* Q9: I greatly enjoyed the class and was eager to actively participate during the lectures. 
* Q10: My initial expectations about the course were met at the end of the period or year. 
* Q11: The course was relevant and beneficial to my professional development. 
* Q12: The course helped me look at life and the world with a new perspective. 
* Q13: The Instructor's knowledge was relevant and up to date. 
* Q14: The Instructor came prepared for classes.
* Q15: The Instructor taught in accordance with the announced lesson plan. 
* Q16: The Instructor was committed to the course and was understandable. 
* Q17: The Instructor arrived on time for classes. 
* Q18: The Instructor has a smooth and easy to follow delivery/speech. 
* Q19: The Instructor made effective use of class hours. 
* Q20: The Instructor explained the course and was eager to be helpful to students. 
* Q21: The Instructor demonstrated a positive approach to students. 
* Q22: The Instructor was open and respectful of the views of students about the course. 
* Q23: The Instructor encouraged participation in the course. 
* Q24: The Instructor gave relevant homework assignments/projects, and helped/guided students. Q25: The Instructor responded to questions about the course inside and outside of the course. 
* Q26: The Instructor's evaluation system (midterm and final questions, projects, assignments, etc.) effectively measured the course objectives. 
* Q27: The Instructor provided solutions to exams and discussed them with students. 
* Q28: The Instructor treated all students in a right and objective manner. 
* **Q1-Q28 are all Likert-type, meaning that the values are taken from {1,2,3,4,5}**

TR STUDENT EVALUATION
Gizem Guleli
2022-11-28
Turkey Student Evaluation
Problem
The problem statement is a typical unsupervised learning problem, where with a given dataset we need to find patterns or groupings in the data without any labeled output variable.
About Dataset
In this case, the dataset consists of feedback from students who attended multiple courses at Gazi University, Ankara. Each feedback consists of evaluation questions and various other attributes, such as attendance, difficulty. The series of questions which includes course structure, level and quality of delivery, clarity of course objectives, course difficulty, course impact on student’s overall college experience and goals, course relevance, and aspects such as willingness and ability, and preferences are answered by the students. There are 28 questions, each answered from 1 (very bad) to 5 (very good).
Attribute Information:
instr: Instructor’s identifier; values taken from {1,2,3}
class: Course code (descriptor); values taken from {1-13}
repeat: Number of times the student is taking this course; values taken from {0,1,2,3}
attendance: Code of the level of attendance; values from {0, 1, 2, 3, 4}
difficulty: Level of difficulty of the course as perceived by the student; values taken from {1,2,3,4,5}
Q1: The semester course content, teaching method and evaluation system were provided at the start.
Q2: The course aims and objectives were clearly stated at the beginning of the period.
Q3: The course was worth the amount of credit assigned to it.
Q4: The course was taught according to the syllabus announced on the first day of class.
Q5: The class discussions, homework assignments, applications and studies were satisfactory.
Q6: The textbook and other courses resources were sufficient and up to date.
Q7: The course allowed field work, applications, laboratory, discussion and other studies.
Q8: The quizzes, assignments, projects and exams contributed to helping the learning.
Q9: I greatly enjoyed the class and was eager to actively participate during the lectures.
Q10: My initial expectations about the course were met at the end of the period or year.
Q11: The course was relevant and beneficial to my professional development.
Q12: The course helped me look at life and the world with a new perspective.
Q13: The Instructor’s knowledge was relevant and up to date.
Q14: The Instructor came prepared for classes.
Q15: The Instructor taught in accordance with the announced lesson plan.
Q16: The Instructor was committed to the course and was understandable.
Q17: The Instructor arrived on time for classes.
Q18: The Instructor has a smooth and easy to follow delivery/speech.
Q19: The Instructor made effective use of class hours.
Q20: The Instructor explained the course and was eager to be helpful to students.
Q21: The Instructor demonstrated a positive approach to students.
Q22: The Instructor was open and respectful of the views of students about the course.
Q23: The Instructor encouraged participation in the course.
Q24: The Instructor gave relevant homework assignments/projects, and helped/guided students.
Q25: The Instructor responded to questions about the course inside and outside of the course.
Q26: The Instructor’s evaluation system (midterm and final questions, projects, assignments, etc.) effectively measured the course objectives.
Q27: The Instructor provided solutions to exams and discussed them with students.
Q28: The Instructor treated all students in a right and objective manner.

Q1-Q28 are all Likert-type, meaning that the values are taken from {1,2,3,4,5}

## Analyze

### Preliminary

First, we downloaded and read the required libraries to analyse and visualise the data-set. Then we read the data-set and checked missing values.It appears that the data set contains no missing values and all attributes are numeric. This is a good indication that the data is relatively clean and does not require any preprocessing.
Therefore, it is always a good idea to examine the data carefully and perform exploratory data analysis (EDA) to gain a better understanding of the data, identify potential problems and make informed decisions about pre-processing, modelling and analysing the data.

### Exploratory Data Analysis

The Distribution of Instructors graph shows that most of the courses are given by Instructor 3 and distribution is too skewed left .

The Distribution of Courses shows that course 3 and course 13 is the most taken courses out of 13 courses.

The Distribution of Repeating histogram shows that the majority of students (%84) is repeated the course only once while minority (%16) repeat the classes for the second or third time. However, this may somewhat complicate our plan to create an interpretable, acceptable classifier because the distribution is too skewed right.

The Distribution of Attendance histogram shows that the majority of students’ the attendance level of the course is weak, with a peak at 0 level and 65% of student attendant lesson less then 3 level. This suggests that most students didn’t attended class regularly.

The difficulty_hist histogram shows that the difficulty level of the course was more evenly distributed, with peaks at 3 on the scale. This suggests that some students found the course relatively easy, while others found it more challenging.

When we check the distribution of evaluation question, most of them seems similar and kind of hard to read histogram graphs and need to look detailiy. From boxplot its more clear to see that some questions ( #14,15,17,19,20,21,21,25,28) are higly rated even there is a some outliers which means few students gave less rate while other questions seems more normally distributed.


### Dimension Reduction

#### PCA
Here we also used to PCA analysis to identify the key features that differentiate the groups of students. By computing the principal components of the survey data, we can identify the survey questions that have the highest impact on the clustering results.
We are not able to imagine 28 Dimension and thanks to PCA, we can reduce the columns from 28D to 2D. Therefore, we would able to plot the clustering results based on the first two principal components and visually inspect how well the clusters are separated in this 2D space. We also analyse the loadings of each survey question on the principal components to see which questions are most important in differentiating the clusters.
There are many ways to compute the principal components, but I used here the prcomp() function, which uses single value decomposition. We are standardizing datasets with scale() function and subset data which includes only evaluation questions to be able to focus clustering the question. As it can be seen below (summary of pca1) we started to get the ability to explain %82 of the variance in the first component and being able to catch 86% with second components out of 28.

### Clustering

#### K-means Clustering

K-means clustering is a popular unsupervised learning algorithm used to identify patterns in the data by grouping similar observations into clusters. After performing PCA analysis, we can use the resulting principal components as the input to the k-means clustering algorithm. By using PCA results as input we can effectively identify the most important features that separate the data into different clusters. This approach can be particularly useful when dealing with high-dimensional data, as it can help to reduce the “curse of dimensionality” and improve the efficiency and interpretability of the clustering results.

#### Calculating Optimal Number of Clusters

Determining the optimal number of clusters is a crucial step in clustering analysis. There are several methods to determine the optimal number of clusters, and the appropriate method to use may depend on the specific characteristics of your dataset and the clustering algorithm you are using. It is important to note that there is no one “correct” method to determine the optimal number of clusters, and it may be helpful to try multiple methods and compare the results. Additionally, the optimal number of clusters may not always be clear-cut, and it’s important to interpret the results with caution and domain knowledge. To determine the optimal number of clusters for k-means clustering, we can use both the elbow method and the silhouette method.Because of different results, I tried to cluster with both way. General idea is the elbow method tends to be more appropriate when the clusters are well separated, while the silhouette method is better when the clusters are overlapping or irregularly shaped. As we see in graphs there is a overlapping points among clusters but or me still 3 cluster can be enough.


### Conclusion
The dataset contains evaluation questions for courses and instructors by Turkish university students.The dataset was relatively clean, with no missing data or obvious errors.Principal Component Analysis (PCA) was performed to reduce the dimensionality of the evaluation questions, and two principal components were chosen for further analysis. K-means clustering was performed on the PCA results to group evaluations into clusters based on similarities in responses to the evaluation questions. The optimal number of clusters was found to be 3, based on the elbow method and 8 base on the silhouette method.The PCA and clustering results suggest that there are some underlying patterns in the responses to the evaluation questions, but more detailed analysis would be needed to fully understand the nature of these patterns and their implications.

### References

Gunduz, N., & Fokoue, E. (2015). Pattern Discovery in Students’ Evaluations of Professors: A Statistical Data Mining Approach. arXiv preprint arXiv:1501.02263.
Dataset: https://archive.ics.uci.edu/ml/datasets/turkiye+student+evaluation
https://www.r-project.org/
https://www.r-project.org/
https://scikit-learn.org/stable/modules/clustering.html


