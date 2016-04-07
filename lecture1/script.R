mtcars_subs <- mtcars[mtcars$am == 1, ]
split(mtcars_subs$mpg, mtcars_subs$cyl)
sapply(split(mtcars_subs$mpg, mtcars_subs$cyl), mean)

download.file("http://api.worldbank.org/v2/en/country/ukr?downloadformat=csv",
              destfile="ua.zip")
unzip("ua.zip", exdir="data_dir")
csv_files <- list.files("data_dir", ".*.csv", recursive=T, full.names=T)
data <- read.csv(csv_files[1], skip = 3)
str(data)

library(jsonlite)
data1 <- fromJSON("https://api.github.com/users/nikolaypavlov/repos")
install.packages('curl')

names(data1)

order(data1$watchers)
which.max(data1$watchers)
data1$name[data1$watchers == max(data1$watchers)]


colSums(is.na(data))

getOption("na.action")

data[complete.cases(data), ]

mean(data$X1992)
mean(data$X1992, na.rm=TRUE)

library(tidyr)
new_data <- data[,-c(3, ncol(data))]

data_long <- gather(new_data, key=year, value=measurement,
                    -Country.Name, 
                    -Country.Code, 
                    -Indicator.Code, na.rm=T)
data_long$year <- extract_numeric(data_long$year)
names(data_long) <- tolower(names(data_long))
head(data_long)

plot(data_long$year, data_long$measurement)


data_wide <- spread(data_long, key=indicator.code, value=measurement)
names(data_wide) <- gsub("\\.", "_", names(data_wide))
names(data_wide) <- toupper(names(data_wide))
plot(data_wide$year, data_wide$TX_VAL_FOOD_ZS_UN, type="l")

data_wide$TX_VAL_FOOD_ZS_UN

library(dplyr)

dim(data)
head(select(data, 1:3))

data_sub <- select(data_long, indicator.code, year, measurement)
data_200X <- filter(data_sub, year >= 2000 & year <= 2010)
data_by_code <- group_by(data_200X, indicator.code)
mean_stats <- summarise(data_by_code, 
                        avg=mean(measurement), 
                        max=max(measurement),
                        min=min(measurement))
head(as.data.frame(mean_stats))


data_long <- data %>% 
  select(-Indicator.Name, -X) %>%
  gather(key=year, value=measurement, 
         -Country.Name, 
         -Country.Code, 
         -Indicator.Code, na.rm=T) %>%
  mutate(year=extract_numeric(year))

names(data_long) <- tolower(names(data_long))
head(data_long)

mutate_each(data_wide, )
select(starts_with("TX"))

data2 <- data_wide %>%
  select(country_name, country_code, year, starts_with("TX"))
head(data2)
data3 <- filter(data2, year >= 1995 & year <= 2005)
head(data3)

data3 %>%
  mutate_each(profit= ifelse(is.na(profit), mean(profit, na.rm=TRUE), profit))

data4 <- data3 %>% summarise_each(funs(mean))
