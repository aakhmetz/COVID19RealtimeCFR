libraries = c("dplyr","magrittr","tidyr","readxl")
for(x in libraries) { library(x,character.only=TRUE,warn.conflicts=FALSE,quietly=TRUE) }

require(zoo)
require(lubridate)

'%&%' = function(x,y) paste0(x,y)

args <- commandArgs(trailingOnly = TRUE)
t0 = as.Date(args[2])
day(t0) = day(t0) + 1

#### Cut-off time for our analysis
CUTOFF_DATE = as.Date(args[3])

datafilename = "../../../Hokkaido_Wuhan Data 2020/wuhan_data_master.xlsx"
read_excel(datafilename, sheet="export") -> Df

#### setting the estimated window time
detection_window = 12.5
#### setting the population size of Wuhan
popWuhan = 11081000
#### setting the volume of inbound passengers from China per year
total_travellers = 55568293
#### fraction of Wuhan travellers in the total flow of travellers from China
fraction_travellers_Wuhan = 0.020763
#### probability of travel outside of Mainland China
prob_travel = (total_travellers*fraction_travellers_Wuhan*detection_window)/(365*popWuhan)


### day zero
df = data.frame(date = as.Date(t0:CUTOFF_DATE), 
                prob_travel = prob_travel) %>% mutate(time = 1:n())
df_exports = read_excel(datafilename, sheet="export") %>% 
    filter(DiagnosisCountry!='China') %>% 
    select(DiagnosisCountry,Onset,DateReportedConfirmed) %>%
    rename(`Confirmed`=`DateReportedConfirmed`, `Country`=`DiagnosisCountry`) %>%
    arrange(Confirmed,Onset) %>%
    filter(as.Date(Confirmed) <= CUTOFF_DATE)
    
df_exports %>% 
    select(Confirmed) %>% 
    group_by(Confirmed) %>% 
    summarize(exports=n()) %>%
    rename(`date`=`Confirmed`) %>%
    mutate(date = as.Date(date)) %>%
    mutate(exports=cumsum(exports)) %>%
    right_join(df, by='date') -> df
    
df$exports[1] = 0
df$exports = zoo::na.locf(df$exports, fromLast=FALSE)
        
read_excel(datafilename, sheet="deaths") %>% 
    select(DateOfDeath) %>% 
    group_by(DateOfDeath) %>% 
    summarize(deaths=n()) %>%
    na.omit() -> df_deaths
    
df_deaths %>%
    rename(date=DateOfDeath) %>%
    mutate(date=as.Date(date)) %>%
    arrange(date) %>% 
    mutate(deaths = cumsum(deaths)) %>%
    right_join(df, by="date") -> df
    
df$deaths[1] = 0
df$deaths = zoo::na.locf(df$deaths, fromLast=FALSE)
        
read_excel(datafilename, sheet="cases_CHN") %>% 
    select(Date,Cases) %>%
    rename(`date`=`Date`, `reported`=`Cases`) %>%
    mutate(date=as.Date(date)) %>%
    arrange(date) %>%
    right_join(df) -> df
    
df$reported[1] = 0
df$reported = zoo::na.locf(df$reported, fromLast=FALSE)
        
## re-arranging the column order
df %<>% select(date, time, everything())

df %>% write.table(args[1]%&%'/data.csv', row.names=FALSE, sep=",", quote = FALSE)

read_excel(datafilename, sheet="deaths") %>% 
    select(Onset, DateOfDeath) %>%
    mutate(dist = as.numeric(as.Date(DateOfDeath) - as.Date(Onset)),
           distUpper = as.numeric(CUTOFF_DATE - as.Date(Onset)), 
           distUpper = distUpper + 1) %>% #we assume that no new cases reported at tstar on the last day
    na.omit() %>% 
    filter(as.Date(DateOfDeath) <= CUTOFF_DATE) %>%
    select(Onset,distUpper,dist) -> df_onset2death

df_onset2death %>% write.table(args[1]%&%'/data_onset2death.csv', row.names=FALSE, sep=",", quote = FALSE)

read_excel(datafilename, sheet="export") %>%
    filter(DiagnosisCountry!='China') %>%
    select(Onset, `DateReportedConfirmed`) %>%
    mutate(dist = as.numeric(as.Date(DateReportedConfirmed) - as.Date(Onset)),
           distUpper = as.numeric(CUTOFF_DATE - as.Date(Onset)), 
           distUpper = distUpper + 1) %>%
    na.omit() %>% 
    filter(as.Date(`Onset`) <= CUTOFF_DATE) %>%
    select(Onset,distUpper,dist) -> df_onset2report

df_onset2report %>% write.table(args[1]%&%'/data_onset2report.csv', row.names=FALSE, sep=",", quote = FALSE)