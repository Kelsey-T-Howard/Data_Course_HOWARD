?read.table() #This brings up the help file
df <-  read.csv("../../Data/landdata-states.csv") # why did I change to read.csv ???
class(df) # what type of object is df?
## [1] "data.frame"
head(df)
"data.frame"
## [1] "data.frame"
?read.csv
?read.csv2
class(df$State)
class(df$Date)
State_updated <- as.factor
class(df$State)
df$State <- as.factor
df$State <- as.factor
df$State <- as.factor(df$State)


dim(df)
str(df)
summary(df)
summary(df$Home.Value)
names(df)[4]

hist(df$Land.Value)
plot(x=df$region,y=df$Land.Value)
plot(x=df$Year,y=df$Land.Value)
??ggplot
ggplot(df, aes(x=Year, y=Land.Value,color=region)) + geom_point()
ggsave("./colored.png")
ITS <- read.csv("../../Data/ITS_mapping.csv")
summary(ITS)
summary(ITS$SampleID.BarcodeSequence.LinkerPrimerSequence.Run.Ecosystem.Island.Lat.Lon.Collection_Date.F_Primer.R_Primer.Ecosys_Type.Host_Type.Host.InputFileName.Description)
dim(ITS)
str(ITS)
head(ITS)
dat(ITS)
dim(ITS)
plot(x=ITS$Ecosystem, y=ITS$Lat, col= ITS$SampleID.BarcodeSequence.LinkerPrimerSequence.Run.Ecosystem.Island.Lat.Lon.Collection_Date.F_Primer.R_Primer.Ecosys_Type.Host_Type.Host.InputFileName.Description)
#I answered the questions. However, the plot function doesn't work as the columns aren't individually separated. I'm not sure what to do.

class(ITS)
dat <- read.csv("../../Data/ITS_mapping.csv")
