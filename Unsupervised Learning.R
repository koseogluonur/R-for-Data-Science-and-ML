#Unsupervised Learning Clustering

#K means Clustering
kmeans(x, centers = 5, nstart = 20) #General Formula 

pokemon <- read.csv("Pokemon.csv")
str(pokemon)

head(pokemon)

summary(pokemon[,6:11])

#K means Algorithm

km.pokemon <- kmeans(pokemon[,6:11], centers=3, nstart = 20)
km.pokemon

km.pokemon$cluster
km.pokemon$centers
km.pokemon$tot.withinss

# Initialize total within sum of squares error: wss
wss <- 0

# Look over 1 to 15 possible clusters
for (i in 1:15) {
  # Fit the model: km.out
  km.out <- kmeans(pokemon[,6:11], centers = i, nstart = 20, iter.max = 50)
  # Save the within cluster sum of squares
  wss[i] <- km.out$tot.withinss
}

# Produce a scree plot
plot(1:15, wss, type = "b", 
     xlab = "Number of Clusters", 
     ylab = "Within groups sum of squares")

#Scaling our selected data
pokemon_scaled <- scale(pokemon[,6:11])
pokemon_scaled
summary(pokemon_scaled)


# Initialize total within sum of squares error: wss
wss <- 0

# Look over 1 to 15 possible clusters
for (i in 1:15) {
  # Fit the model: km.out
  km.out <- kmeans(pokemon_scaled, centers = i, nstart = 20, iter.max = 50)
  # Save the within cluster sum of squares
  wss[i] <- km.out$tot.withinss
}

# Produce a scree plot
plot(1:15, wss, type = "b", 
     xlab = "Number of Clusters", 
     ylab = "Within groups sum of squares")

km.pokemon_3 <- kmeans(pokemon_scaled, centers = 3, nstart = 20) 
km.pokemon_3

#Yorumlarken ortalamasi 0 standar sapmasi 1 olucak sekilde düsünürsün.
#Normal dagilim 

library(DT)
datatable(data.frame(km.pokemon_3$cluster, pokemon$Name))

#Hierarchical clustering

dist_matrix <- dist(x)
hclust(d = dist_matrix) #General Formula

plot(hclust)

#Assignment can be determined either with a height argument h or with a number of cluster argument k

cutree(hclust, h = 6)
cutree(hclust, k = 3)
#There are four methods that determines the links between clusters.
#Single,Average,Centroid,Complete
#Complete and average methods give more balanced results.

hclust.complete <- hclust(d, method = "complete")
hclust.average <- hclust(d, method = "average")
hclust.single <- hclust(d, method = "single")

#Scale data into 0-1 range

scaled_data <- scale(x) or

range01 <- function(x){
  (x-min(x))/(max(x)-min(x))
}


pokemon <- read.csv("Pokemon.csv")

pokemon_scaled <- scale(pokemon[,6:11])

dist_matrix <- dist(pokemon_scaled)
hc.pokemon <- hclust(dist_matrix, method = "complete")
plot(hc.pokemon)

scaled_data <- range01(x)

hc.pok.cluster <- cutree(hc.pokemon, k=3)

#Compare with K means 
table("kmeans result" = km.pokemon_3$cluster, "Hierarchical Result" = hc.pok.cluster)

#Principled Component Analysis

pr.iris <- prcomp(x=iris[-5], scale = FALSE, center = FALSE)  #General Formula

pr.iris

biplot(pr.iris)

pr.var <- pr.iris$sdev^2
pve <- pr.var / sum(pr.var)
# Plot variance explained for each principal component

plot(pve, xlab = "Principal Component",
     ylab = "Proportion of Variance Explained",
     ylim = c(0, 1), type = "b")

#Scale
#If measurement levels are different scaling the data is a MUST.
#Missing Values
#Imput missing values with a suitable number.
#Categorical data
#Do not use categorical data.
#If you have to convert them to numerical values.

#Scaling can be made with:
  prcomp(x, center = TRUE, scale = TRUE)

  
#Example  
  
  pokemon <- read.csv("Pokemon.csv")
  
  rownames(pokemon) <- pokemon$Name
  pr.pokemon <- prcomp(pokemon[,6:11], scale = TRUE)
  summary(pr.pokemon)

  biplot(pr.pokemon)
  
  pr.var <- pr.pokemon$sdev^2
  pve <- pr.var / sum(pr.var)
  # Plot variance explained for each principal component
  
  plot(pve, xlab = "Principal Component",
       ylab = "Proportion of Variance Explained",
       ylim = c(0, 1), type = "b")
  
  plot(cumsum(pve), xlab = "Principal Component",
       ylab = "Cumulative Proportion of Variance Explained",
       ylim = c(0, 1), type = "b")