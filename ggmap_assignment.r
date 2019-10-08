"
Once you have downloaded the file, copy and paste the information that you need in a new Excel file
Save it as a .csv and import it to R Studio
If necessary,install the packages ggmap and ggplot2
Load the packages: ggplot2 and ggmap
Have a look at the distribution of your data: which map scale suits your needs? 
"
install.packages("ggmap")
install.packages("ggplot2")

library(ggmap)
library(ggplot2)

# The code for displaying the map we need is (change the zoom if you need):
ggmap(get_map(location = 'Europe',  
              zoom = 3))
 
# If you want satellite imagery, just add maptype = 'satellite':
ggmap(get_map(location = 'Europe',  
              maptype = 'satellite',  
              zoom = 3))

 
#  There are faster ways to get the maps, such as (this one doesn't show the latitude and longitude axis):
qmap('Europe',  
     zoom=3)

# After this, you need to save those:
europe <-  
  ggmap(get_map(location = 'Europe',  
                        zoom = 3))

europeSat <-  
  ggmap(get_map(location = 'Europe',  
                maptype = 'satellite',  
                zoom = 3))

# Once you have the maps, you need to match them with your data. For example, plotting the points of ancient ports and harbours:
europe + 
  geom_point(aes(x=longitude, y=latitude),  
             data=ancient,  
             show.legend = FALSE,  
             col='darkred',  
             alpha=0.2,  
             size=2) + 
  ggtitle("Ancient Ports and Harbours") + 
  theme(title = element_text(size=12))
 

# From now on, you choose how to use ggplot2 and the combinations that you want to do with ggmap.
# According to the variables in my data, the most appropriate were the following:
# Density: shows where most of the points are concentrated
 
europe +  
  geom_density_2d(aes(x=longitude, y=latitude),  
                  data=romanports,  
                  show.legend = FALSE,  
                  col='red') + 
  ggtitle("2D Density estimate") + 
  theme(title = element_text(size=12))

# Heatmap: the colour scale maps the number of observations.
europe + 
  geom_bin2d(aes(x=longitude, y=latitude),  
             data=romanports,  
             show.legend = TRUE,  
             alpha=0.6) + 
  ggtitle("Heatmap of 2D bin counts") +  
  theme(title = element_text(size=12)) +  
  theme(legend.background = element_rect(fill="gray90")) +  
  theme(legend.title = element_text(colour="black", size=10, face="italic"))


# As we can see, there is a concentration of ports and harbours in the Aegean Sea and the Italian Peninsula. 
# Thus, I considered that it could be very useful to zoom in that particular area:
greeceItaly <-  
  ggmap(get_map(location = 'Greece',  
                zoom = 5))

greeceItalySat <-  
ggmap(get_map(location = 'Greece',  
              maptype = 'satellite',  
              zoom = 5))


# Since ggplot2 has an enormous range of data graphs, you can combine the ones that suit your data with the maps:
# Mentions by ancient/modern authors

europe +
  geom_point(aes(x=longitude, y=latitude, color=AM),  
             data=romanports,  
             show.legend = TRUE, alpha=0.5, size=1.5) + 
  ggtitle("Mentions by Ancient and Modern authors") + 
  theme(title = element_text(size=12))

# Ports and harbours per country

europe + 
  geom_point(aes(x=longitude, y=latitude, color=country),  
             data=romanports, show.legend = FALSE, alpha=0.3, size=1.5) + 
  ggtitle("Ancient Ports and Harbours per country") + 
  theme(title = element_text(size=12))

"
If we had other observations on the ports, it would be possible to improve the visualisation (e. g. the size of each port to depict different point sizes).
Moreover, if you wanted to publish the maps you could use packages such as GISTools or prettymapr to add a scale and a north arrow.
"
