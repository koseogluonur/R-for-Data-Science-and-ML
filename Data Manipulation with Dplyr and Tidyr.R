install.packages("dplyr")

library(dplyr)

mtcars

library(DT)

datatable(mtcars, options = list(scrollX=T))

library(magrittr)
library(dplyr)


arrange(
  summarize(
    group_by(
      filter(mtcars, carb > 1),
      cyl
    ),
    Avg_mpg = mean(mpg)
  ),
  desc(Avg_mpg)
)

a <- filter(mtcars, carb > 1)
b <- group_by(a, cyl)
c <- summarise(b, Avg_mpg = mean(mpg))
c

mtcars %>%
  filter(carb > 1) %>%
  group_by(cyl) %>%
  summarise(Avg_mpg = mean(mpg)) %>%
  arrange(desc(Avg_mpg))

head(mtcars)

select(mtcars,mpg,cyl)
mtcars %>% select(mpg:qsec)
mtcars %>% select(-mpg:-qsec)

mtcars2 <- mtcars %>% select(-mpg:-qsec)
mtcars2

mtcars2 <- mtcars
mtcars2 %<>% select(-mpg:-qsec)

mtcars %>% select(starts_with("c"))
mtcars %>% select(ends_with("t"))
mtcars %>% select(contains("a"))
mtcars %>% select(matches("^m"))
mtcars %>% select(matches("^(c|m)"))
mtcars %>% select(matches("^d..t$"))

mtcars %>% select(starts_with(c("c","m")))
mtcars %>% select(MilesPerGallon = mpg)
mtcars %>% rename(MilesPerGallon = mpg)

#< Less than
#> Greater than
#== Equal to
#<= Less than or equal to
#>= Greater than or equal to
#!= Not equal to
#%in% Group membership
#is.na is NA
#!is.na is not NA
#&,|,! Boolean operators




mtcars %>% filter(cyl == 4)

mtcars %>% filter(cyl == 4 & hp >90)
mtcars %>% filter((cyl == 4 | cyl == 6) & hp >110)
mtcars %>% filter(cyl %in% c(4,6) & hp >110)

# remove duplicate rows
mtcars[2] %>% distinct()
mtcars[2] %>% unique()

# random sample, 50% sample size without replacement
mtcars %>% sample_frac(size = 0.5, replace = FALSE)

# random sample of 10 rows with replacement
mtcars %>% sample_n(size = 10, replace = TRUE)

# select rows 3-5
mtcars %>% slice(3:5)

# select top n entries - in this case ranks variable mpg and selects
# the rows with the top 5 values
mtcars %>% top_n(n = 5, wt = mpg)

# similarly you can use slice_max and slice_min
mtcars %>% slice_max(mpg,n=5)
mtcars %>% slice_min(mpg,n=5)


mtcars %>% group_by(cyl)
mtcars %>% summarise(mean_Hp = mean(hp))
mtcars %>% 
  group_by(cyl) %>% 
  summarise(mean_Hp = mean(hp))

mtcars2 <- mtcars %>% group_by(cyl)

mtcars2 %>% 
  summarise(mean = mean(hp))

mtcars2 %<>% ungroup

mtcars2 %>% 
  summarise(mean = mean(hp))

mtcars %>% 
  group_by(cyl) %>% 
  summarise(count=n(),
    mean_Hp = mean(hp),
    sd_Hp=sd(hp)
            )

mtcars %>% 
  group_by(cyl) %>% 
  summarise(count=n(),
            mean_Hp = mean(hp),
            sd_Hp=sd(hp)
  ) %>% ungroup()
  
absolute <- function(x){
  mean(abs(x - mean(x, na.rm = T)))
}

mtcars %>% 
  select(cyl, mpg, hp) %>%
  filter(cyl %in% c(4,6)) %>% 
  group_by(cyl) %>% 
  summarise(
    count = n(),
    mean_mpg = mean(mpg, na.rm = T),
    sd_mpg = sd(mpg, na.rm = T),
    abs_mpg = absolute(mpg),
    mean_hp = mean(hp, na.rm = T),
    sd_hp = sd(hp, na.rm = T),
    abs_hp = absolute(hp)
  )

mtcars %>% arrange(cyl)
mtcars %>% arrange(desc(mpg))
mtcars %>% arrange(cyl, desc(mpg))

mtcars %>% 
  mutate(g100m = 1/mpg*100) %>% 
  round(3) %>% 
  arrange(g100m)

mtcars %>% 
  filter(cyl %in% c(4,6)) %>% 
  group_by(cyl) %>% 
  summarise_all(mean)

mtcars %>% 
  filter(cyl %in% c(4,6)) %>% 
  group_by(cyl) %>% 
  summarise_if(is.numeric, mean)

mtcars %>% 
  filter(cyl %in% c(4,6)) %>% 
  group_by(cyl) %>% 
  summarise_at(vars(starts_with("m")), mean)

mtcars %>% 
  filter(cyl %in% c(4,6)) %>% 
  mutate_if(~mean(.x) > 100,log)

mtcars %>% 
  filter(cyl %in% c(4,6)) %>% 
  mutate_all(.,log)

mtcars %>%
  group_by(cyl) %>% 
  summarise(across(contains("a"), mean, na.rm=TRUE))

mtcars %>%
  group_by(cyl) %>% 
  summarise(across(contains("a"), mean, na.rm=TRUE, .names="mean_{col}"))

mtcars %>%
  group_by(cyl) %>% 
  summarise(across(contains("a"), ~mean(.x, na.rm=T)))

mtcars %>%
  group_by(cyl) %>% 
  summarise(across(contains("a"), ~mean(.x, na.rm=T)))

mtcars %>%
  group_by(cyl) %>% 
  summarise(across(contains("a"), list(mean=mean, sd=sd), 
                   .names = "{fn}.{col}"))

mtcars %>%
  group_by(cyl) %>% 
  summarise(across(contains("a"), list(mean, sd), 
                   .names = "{fn}.{col}"))

mtcars %>%
  group_by(cyl) %>% 
  mutate(across(contains("a"), log))

mtcars %>%
  group_by(cyl) %>% 
  mutate(across(contains("a"), ~log(.x+1)))