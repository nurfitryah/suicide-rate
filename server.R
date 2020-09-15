function(input, output) {
    
    # Introduction - Bar
    output$h_bar <- renderHighchart({
        gender_2 <- age_suicide %>% 
            group_by(Sex) %>% 
            summarise("2016" = round(sum(X2016)),
                      "2015" = round(sum(X2015)),
                      "2010" = round(sum(X2010)),
                      "2000" = round(sum(X2000))) %>%
            pivot_longer(cols = c("2016", 
                                  "2015", 
                                  "2010", 
                                  "2000"),
                         names_to = "year") %>% 
            dplyr::arrange(year)
        
        gender_2 %>% 
            hchart("column", 
                   hcaes(year, value, group = Sex),
                   stacking = "normal") %>% 
            hc_title(text = "Suicide Rate by Gender from 183 Countries",
                     style = 
                         list(fontWeight = "bold")) %>% 
            hc_subtitle(text = "per 100.000 Population") %>% 
            hc_xAxis(title = list(text = "Year")) %>% 
            hc_yAxis(title = list(text = ""),
                     labels = list(format = "{value}")) %>% 
            hc_colors(c("#b1c2fc",
                        "#ff9e9d",
                        "#c4de91")) %>% 
            hc_tooltip(crosshairs = TRUE)
    })
    
    # Map
    output$h_map <- renderHighchart({
        suicide_country <- age_suicide %>% 
            dplyr::rename("2016" = X2016,
                          "2015" = X2015,
                          "2010" = X2010,
                          "2000" = X2000) %>% 
            pivot_longer(c("2000",
                           "2010",
                           "2015",
                           "2016"),
                         names_to = "Year")
        
        suicide_2000 <- suicide_country %>% 
            dplyr::filter(Year == input$Year) %>% 
            dplyr::group_by(Country) %>%  
            dplyr::mutate_if(is.numeric, round) %>% 
            dplyr::summarise(value = sum(value))
        
        data(worldgeojson, package = "highcharter")
        
        highchart() %>% 
            hc_add_series_map(worldgeojson,
                              suicide_2000,
                              value = "value",
                              joinBy = c("name", "Country")) %>% 
            hc_colorAxis(stops = color_stops()) %>% 
            hc_title(text = "Suicide Rate World Map",
                     align = "center",
                     style = list(fontWeight = "bold",
                                  fontSize = "25px")) %>% 
            hc_subtitle(text = "in 2000, 2010, 2015, 2016 - per 100.000 Population") %>% 
            hc_tooltip(crosshairs = TRUE,
                       borderWidth = 5,
                       sort = TRUE,
                       shared = TRUE,
                       table = TRUE,
                       pointFormat = paste('<br>Total Suicide Rate :{point.value}<br>')
            )
    })
    
   # 5 Country 
    output$h_pie1 <- renderHighchart({
        
        top5 <- age_suicide %>% 
            group_by(Country) %>% 
            dplyr::summarise(Total = round(sum(X2016))) %>% 
            dplyr::arrange(-Total) %>% 
            top_n(5)
        
        top5 %>% 
            hchart("pie",
                   hcaes(x = Country,
                         y = Total),
                   name = "Total Rate per Country") %>% 
            hc_plotOptions(series = 
                               list(showInLegend = TRUE)) %>% 
            hc_title(text = "5 Country with Highest Suicide Rate in 2016",
                     style = list(fontWeight = "bold")) %>% 
            hc_colors(c("#000066",
                        "#0000cc",
                        "#0099ff", 
                        "#07e2f4", 
                        "#8dfff4")) %>% 
            hc_tooltip(crosshairs = TRUE, 
                       borderWidth = 5,
                       sort = TRUE,
                       shared = TRUE, 
                       table = TRUE,
                       pointFormat=paste('<br><b>Percentage: {point.percentage:.1f}%</b><br>Total: {point.y}')) %>% 
            hc_subtitle(text = "per 100.000 Population")
    })
    
    output$h_pie2 <- renderHighchart({
        
        low5<- age_suicide %>% 
            group_by(Country) %>% 
            dplyr::summarise(Total = round(sum(X2016))) %>%  
            dplyr::arrange(-Total) %>% 
            tail(5)
        
        low5 %>% 
            hchart("pie",
                   hcaes(x = Country,
                         y = Total),
                   name = "Total Rate") %>% 
            hc_plotOptions(series = 
                               list(showInLegend = TRUE)) %>% 
            hc_title(text = "5 Country with Lowest Suicide Rate in 2016",
                     style = list(fontWeight = "bold")) %>% 
            hc_subtitle(text = "per 100.000 Population") %>% 
            hc_tooltip(crosshairs = TRUE, 
                       borderWidth = 5,
                       sort = TRUE,
                       shared = TRUE, 
                       table = TRUE,
                       pointFormat=paste('<br><b>Percentage: {point.percentage:.1f}%</b><br>Total: {point.y}')) %>% 
            hc_colors(c("#455901",
                        "#1bc301",
                        "#99cc00",
                        "#c4de91",
                        "#d9eab8"))
        
    })
    
    # Age
    output$h_heat <- renderHighchart({
        guyana <- suicide_2016 %>% 
            dplyr::filter(Country == input$Country) %>% 
            dplyr::select(-Country) %>% 
            dplyr::group_by(Sex)
        
        guyana %>% 
            hchart("heatmap",
                   hcaes(Age,
                         Sex,
                         value = value),
                   name = "Rate") %>% 
            hc_title(text = "Suicide Rate in 2016 Based on Age & Sex/Gender",
                     align = "center",
                     style = list(fontWeight = "bold",
                                  fontSize = "25px")) %>% 
            hc_subtitle(text = "per 100.000 Population") %>% 
            hc_add_theme(hc_theme_google()) %>% 
            hc_tooltip(crosshairs = TRUE,
                       borderWidth = 5,
                       sort = TRUE,
                       shared = TRUE, 
                       table = TRUE,
                       pointFormat = paste('Sex :{point.Sex}<br>Age :{point.Age}<br>Suicide Rate :{point.value}'))
    })
    
    # Source
    
}

