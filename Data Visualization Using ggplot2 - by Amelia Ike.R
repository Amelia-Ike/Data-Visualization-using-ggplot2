#EX-1---------------Import the ggplot2 data.table libraries and use fread 
#to load the csv file 'Economist_Assignment_Data.csv' into a dataframe called 
#df (Hint: use drop=1 to skip the first column)

library(data.table)
df <- fread(file.choose(), drop = 1)
head(df)

#EX-2--------------Use ggplot() + geom_point() to create a scatter plot
#object called pl. You will need to specify x=CPI and y=HDI and color=Region 
#as aesthetics
library(ggplot2)
library(ggthemes)

pl <- ggplot(data=df, aes(x=CPI, y=HDI))
pl+ geom_point(aes(color=Region))

#EX-3--------------Change the points to be larger empty circles.
#(You'll have to go back and add arguments to geom_point() and reassign 
#it to pl.) You'll need to figure out what shape= and size=
pl+ geom_point(aes(color=Region), shape=1, size=5)

#EX-4--------------Add geom_smooth(aes(group=1)) to add a trend line
pl+ geom_point(aes(color=Region), shape=1, size=5)+ geom_smooth(aes(group=1))

#EX-5-------------We want to further edit this trend line. 
#Add the following arguments to geom_smooth (outside of aes):
pl2 <- pl+ geom_point(aes(color=Region), shape=1, size=5)+
  geom_smooth(aes(group=1),method = 'lm', formula = y ~ log(x), se = FALSE, color = 'red')
pl2
#EX_6-------------It's really starting to look similar! But we still need 
#to add labels, we can use geom_text! Add geom_text(aes(label=Country)) to
#pl2 and see what happens. (Hint: It should be way too many labels)

pl2 + geom_text(aes(label=Country))
#EX-7-------------Labeling a subset is actually pretty tricky! So we're just 
#going to give you the answer since it would require manually selecting the 
#subset of countries we want to label!


#EX-8-------------Labeling a subset is actually pretty tricky! So we're just 
#going to give you the answer since it would require manually selecting the 
#subset of countries we want to label!

pointsToLabel <- c("Russia", "Venezuela", "Iraq", "Myanmar", "Sudan",
                   "Afghanistan", "Congo", "Greece", "Argentina", "Brazil",
                   "India", "Italy", "China", "South Africa", "Spane",
                   "Botswana", "Cape Verde", "Bhutan", "Rwanda", "France",
                   "United States", "Germany", "Britain", "Barbados", "Norway", "Japan",
                   "New Zealand", "Singapore")

pl3 <- pl2 + geom_text(aes(label = Country), color = "gray20", 
                       data = subset(df, Country %in% pointsToLabel),check_overlap = TRUE)

pl3

#EX-9--------------Almost there! Still not perfect, but good enough for this assignment. 
#Later on we'll see why interactive plots are better for labeling. Now let's just add some 
#labels and a theme, set the x and y scales and we're done! Add theme_bw() to your plot and 
#save this to pl4

pl4 <- pl3+theme_bw()
pl4

#EX-10--------------Add scale_x_continuous() and set the following arguments:
#name = Same x axis as the Economist Plot
#limits = Pass a vector of appropriate x limits
#breaks = 1:10

pl4 <- pl4+ scale_x_continuous("Corruption Perceptions Index, 2011 (10=least corrupt)", limits=c(1,10), breaks = 1:10)

#EX-11-------------Now use scale_y_continuous to do similar operations to the y axis!
pl4 <- pl4 + scale_y_continuous("Human Development Index, 2011 (1=BEST)", limits=c(0.2, 1.0))

#EX-12-------------Finally use ggtitle() to add a string as a title.
pl4 + ggtitle("Corruption and Human Development") + theme(plot.title = element_text(hjust = 0.5))
