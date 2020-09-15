options(shiny.maxRequestSize=200*1024^2)


dashboardPage(title = "Suicide Rate",
              
              dashboardHeader(title = "Suicide Rate"),
              
              dashboardSidebar(
                  sidebarMenu(
                      menuItem(
                          text = "Introduction",
                          tabName = "intro",
                          icon = icon("readme")),
                      
                      
                      menuItem(
                          text = "5 Country",
                          tabName = "pie",
                          icon = icon("chart-pie")),
                      
                      menuItem(
                          text = "Age",
                          tabName = "guyana",
                          icon = icon("theater-masks")),
                      
                      menuItem(
                          text = "Source",
                          tabName = "source",
                          icon = icon("bookmark")))
                  ),
              
              dashboardBody(
                  tabItems(
                      tabItem(tabName = "intro",
                              align = "justify",
                              
                              h1(strong("Introduction : Suicide Rate in 2000, 2010, 2015, and 2016")),
                              
                              p(h4("As we know that Mental Illness is one of serious disease that could lead to suicide. In fact, 95% of people who commit 
                                 suicide have a mental illness [2]. According to the CDC, suicide rates have increased by 30% since 1999. 
                                 Nearly 45,000 lives were lost to suicide in 2016 alone.Comments or thoughts about suicide — also 
                                 known as suicidal ideation — can begin small like, “I wish I wasn’t here” or “Nothing matters.” 
                                 But over time, they can become more explicit and dangerous [3].")),
                             
                              p(h4("This dataset show age-standardized suicides rate on 183 countries in 2000, 2010, 2015, and 2016. Also this dataset 
                                 provide suicide rate by age and gender in 2016. Chart below shows suicide rate in 2000, 2010, 2015, 
                                 and 2016, categorized by sex/gender.")),
                              
                              br(),
                              
                              highchartOutput(outputId = "h_bar", height = "550px"),
                              
                              br(),
                              
                              h4("If you ever wonder how many suicide rate in each 183 country on 2000, 2010, 2015, and 2016, then you could select year 
                                 on your left below and see what's happen to Map below."),
                             
                              br(),
                              
                              fluidRow(
                                column(width = 3,
                                       selectInput(
                                         inputId = "Year",
                                         label = "Select Year",
                                         choices = unique(suicide_country$Year)
                                       )),
                                column(width = 9,
                                       highchartOutput(outputId = "h_map",
                                                       height = "650px"))
                                )),
                      
                       tabItem(tabName = "pie",
                               align = "center",
                               
                               h2(strong("5 Country with Highest and Lowest Suicide Rate in 2016")),
                               
                               br(),
                               
                               fluidRow(
                                 column(width = 6,
                                        highchartOutput(outputId = "h_pie1",
                                                        height = "600px")
                                        ),
                                 column(width = 6,
                                        highchartOutput(outputId = "h_pie2",
                                                        height = "600px")
                                        )),
                               br(),
                               
                               p(h4("Chart above shows on information maximum of total population of a gender and an age.
                                  If you happened to curious which age or sex/gender on each 183 country that has highest or lowest Suicide Rate,
                                  Tab Age will shows numbers of Suicide Rate categorized by Sex/Gender and Age."))
                               ),
                      
                      tabItem(tabName = "guyana",
                              align = "center",
                              
                              h2(strong("Suicide Rate by Age and Sex/Gender in 2016")),
                              
                              br(),
                              
                              selectInput(
                                  inputId = "Country",
                                  label = "Select Country",
                                  choices = unique(suicide_2016$Country)),
                              
                              highchartOutput(outputId = "h_heat", height = "550px"),
                              
                              br(),
                              
                              p(h4("As you can see from heatmap chart above, those 80 years and older have the highest suicide rate 
                                 of any age group. As with most age groups, the majority of elders who kill themselves are male [4]. There are may factors that might
                                 contribute somebody or a person to commit suicide. For elderly, most of them feeling loneliness [4].But in a developing country
                                 such as Guyana, the factor or thoughs about suicide are like dominoes. Mental illness, access to lethal chemicals, alcohol misuse, 
                                 interpersonal violence, family dysfunction and insufficient mental health resources as key factors that could lead someone
                                 have thoughs about or even do suicide[5].")),
                              
                              ),
                      
                      tabItem(tabName = "source",
                              align = "justify",
                              
                              h2(strong("Source :")),
                    
                              h4("[1]", tags$a(href = "https://www.kaggle.com/twinkle0705/mental-health-and-suicide-rates", "Data"),""),
                              
                              br(),
                              
                              h4("[2]", tags$a(href = "https://www.medscape.com/answers/2013085-157663/what-is-the-role-of-mental-illness-in-the-development-of-suicidal-behaviors", "Source 2")," "),
                              
                              br(),
                              
                              h4("[3]", tags$a(href = "https://www.nami.org/About-Mental-Illness/Common-with-Mental-Illness/Risk-of-Suicide", "Source 3")," "),
                              
                              br(),
                              
                              h4("[4]", tags$a(href = "https://www.psychologytoday.com/us/blog/understanding-grief/202001/why-do-the-elderly-commit-suicide", "Source 4")," "),
                              
                              br(),
                              
                              h4("[5]", tags$a(href = "https://www.npr.org/sections/goatsandsoda/2018/06/29/622615518/trying-to-stop-suicide-guyana-aims-to-bring-down-its-high-rate", "Source 5")," ")
                              )
                  ))
)
