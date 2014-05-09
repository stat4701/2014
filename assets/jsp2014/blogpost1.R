    library(ggplot2)
    library(plyr)
    library(scales)
  
  ################################################
  # 1.                                           #
  ################################################
    
        inflation <- read.csv("C:/users/JP/Desktop/Baseball Data/baseballinflation.csv")
        inflation <- inflation[1:22,]
        inflation2 <- ggplot(inflation, aes(x=factor(Year), y=Cost....  , colour = Measure, group=Measure)) + 
        geom_line(size=2.5) + 
        geom_point(size=8)  + 
        scale_colour_brewer(palette="Set2") +      
        xlab("Year") +
        ylab("Current cost for $1 in 2003") +
        labs(title="MLB Payroll vs. US Dollar Inflation, 2003-2013\n") +
        theme(
        axis.ticks.x=element_blank(),
        axis.title.x=element_text(face="bold"),
        axis.title.y=element_text(face="bold"),
        axis.text.x=element_text(face="bold", size=rel(1.2)),
        axis.text.y=element_text(face="bold",size=rel(1.2)),
        plot.title=element_text(face="bold", size=rel(1.5))
        )
        ## Name: 01. Inflation
        inflation2
      
      
    inflation <- read.csv("C:/users/JP/Desktop/Baseball Data/baseballinflation.csv")
    inflation <- inflation[23:33,]
    inflation2 <- ggplot(inflation, aes(x=factor(Year), y=Cost....  , colour = Measure, group=Measure)) + 
      geom_line(size=2.5) + 
      geom_point(size=8)  + 
      scale_colour_brewer(palette="Set2") +      
      xlab("Year") +
      ylab("Ratio of Inflation Rates") +
      labs(title="MLB Payroll Increase, Normalized for Inflation, 2003-2013\n") +
      theme(
        axis.ticks.x=element_blank(),
        axis.title.x=element_text(face="bold"),
        axis.title.y=element_text(face="bold"),
        axis.text.x=element_text(face="bold", size=rel(1.2)),
        axis.text.y=element_text(face="bold",size=rel(1.2)),
        plot.title=element_text(face="bold", size=rel(1.5))
      )
    ## Name: 02. Inflation Normalized
    inflation2
    
    
    
    
    
    ### Payroll vs Wins for all years
    ### Observation: with the exception of 2010, the shallower slopes occur in later years, possibly indicating that wins are harder to purchase now.
  # TODO: find a bar chart or something else that shows this. r^2, correlation, etc?
  # 
  #   payrollvsw <- read.csv("C:/users/JP/Desktop/Baseball Data/payrollvsw.csv")
  #   payrollvsw <-payrollvsw[141:403,]
  #   payroll_vs_w_all <- ggplot(payrollvsw, aes(x=PAYROLL...Z, y=WINS, 'colour=factor(YEAR)')) + 
  #     geom_point(size = 4, colour="#999999") + 
  #     stat_smooth(method=lm, se=FALSE, size =1.5, colour="Black") + 
  #     xlab("Payroll (Standard Deviations Above/Below Mean for that Season)") +
  #       ylab("Wins") +
  #       labs(title="Payroll (Z-Scores) vs. Wins, 2005-2013\n") +
  #       theme(
  #         axis.ticks.x=element_blank(),
  #         axis.title.x=element_text(face="bold"),
  #         axis.title.y=element_text(face="bold"),
  #         axis.text.x=element_text(face="bold", size=rel(1.2)),INS
  #         axis.text.y=element_text(face="bold",size=rel(1.2)),
  #         plot.title=element_text(face="bold", size=rel(1.5))
  #       )
  #   
  #   ##ANNOTATED #   payroll_vs_w_all <- ggplot(payrollvsw, aes(x=PAYROLL...Z, y=WINS)) + geom_text(aes(label=Team.Year))
  #   # NAME: Payroll Z vs. Wins
  #   payroll_vs_w_all  
    
  #   lm.r=lm(formula=payrollvsw$WINS~payrollvsw$PAYROLL...Z)
  #   summary(lm.r)
    
   # TODO: find a bar chart or something else that shows this. r^2, correlation, etc?
  #   
  #   payrollvsw <- read.csv("C:/users/JP/Desktop/Baseball Data/payrollvsw.csv")
  #   payrollvsw <-payrollvsw[141:403,]
  #   payroll_vs_w_all <- ggplot(payrollvsw, aes(x=PAYROLL...Z, y=WINS.OVER.50  , 'colour=factor(YEAR)')) + 
  #     geom_point(size = 4, colour="#999999") + 
  #     stat_smooth(method=lm, se=FALSE, size =1.5, colour="Black") + 
  #     xlab("Payroll (Standard Deviations Above/Below Mean for that Season)") +
  #     ylab("Wins Over 50") +
  #     labs(title="Payroll (Z-Scores) vs. Wins Over 50, 2005-2013\n") +
  #     theme(
  #       axis.ticks.x=element_blank(),
  #       axis.title.x=element_text(face="bold"),
  #       axis.title.y=element_text(face="bold"),
  #       axis.text.x=element_text(face="bold", size=rel(1.2)),
  #       axis.text.y=element_text(face="bold",size=rel(1.2)),
  #       plot.title=element_text(face="bold", size=rel(1.5))
  #     )
  #   
  #   ##ANNOTATED #   payroll_vs_w_all <- ggplot(payrollvsw, aes(x=PAYROLL...Z, y=WINS)) + geom_text(aes(label=Team.Year))
  #   # NAME: 03. Payroll Z vs. Wins
  #   payroll_vs_w_all    
  #   
  # payrollvsw <- read.csv("C:/users/JP/Desktop/Baseball Data/payrollvsw.csv")
  # lm.r=lm(formula=payrollvsw$WINS~payrollvsw$PAYROLL...Z)
  # summary(lm.r)
  #   
    
  #   
  #   payrollvsw <- read.csv("C:/users/JP/Desktop/Baseball Data/payrollvswhighpayroll.csv")
  #     payroll_vs_w_all <- ggplot(payrollvsw, aes(x=PAYROLL...Z, y=WINS, colour=TEAM)) + 
  #     geom_point(size = 4, colour="#999999") + 
  #     #stat_smooth(method=lm, se=FALSE, size =1.5, colour="Black") + 
  #     xlab("Payroll (Standard Deviations Above/Below Mean for that Season)") +
  #     ylab("Wins") +
  #     scale_colour_brewer(palette="Set1")+
  #     geom_text(aes(label=Team.Year), vjust=-1, hjust=.5)+ #annotation 
  #     labs(title="Payroll (Z-Scores) vs. Wins, 2005-2013\n") +
  #     xlim(1.98,4.02) + 
  #     ylim(84,104) + 
  #     theme(
  #       axis.ticks.x=element_blank(),
  #       axis.title.x=element_text(face="bold"),
  #       axis.title.y=element_text(face="bold"),
  #       axis.text.x=element_text(face="bold", size=rel(1.2)),
  #       axis.text.y=element_text(face="bold",size=rel(1.2)),
  #       plot.title=element_text(face="bold", size=rel(1.5))
  #     )
  #   
  #   # NAME: 04. Big spenders
  #   payroll_vs_w_all    
  #   
  #   
  #   
  #     
  # stackedbar <- read.csv("C:/users/JP/Desktop/Baseball Data/stackedbar.csv")
  # stackedbar2 <- ggplot(stackedbar, aes(x=Payroll.Size  , y=X..Chance  , fill=TYPE, group = Payroll.Size)) +
  #     geom_bar(stat="identity") +
  #     coord_flip()+
  #     scale_x_discrete(limits=c("Tiny","Small","Medium-Small","Medium-Large","Large","Huge"))+
  #     guides(fill=guide_legend(title="Season Success Type"))+
  #     scale_fill_brewer(palette = "BrBG",labels=c("Guaranteed Playoffs (>95 W)","Good Shot (91-95 W)","Competitive (86-90 W)","Outside Chance (81-85 W)","Maybe Next Year (76-80 W)","Time to Rebuild (<76 W)"))+
  #     ylab("Cumulative % of Having Season Type (or Better)")+
  #     xlab("Payroll")+
  #     scale_y_continuous(labels=percent)+
  #     labs(title="Season Success Types By Payroll Size, 2000-2013\n") +
  #     theme(
  #             axis.ticks.x=element_blank(),
  #             axis.title.x=element_text(face="bold"),
  #             axis.title.y=element_blank(),
  #             axis.text.x=element_text(face="bold", size=rel(1.2)),
  #             axis.text.y=element_text(face="bold",size=rel(1.2)),
  #             plot.title=element_text(face="bold", size=rel(1.5))
  #           )
  #   ## NAME: 05. Season Success Type
  # stackedbar2
  #     
  
  #   
  #   stackedbar <- read.csv("C:/users/JP/Desktop/Baseball Data/stackedbarsince05.csv")
  #   stackedbar2 <- ggplot(stackedbar, aes(x=Payroll.Size  , y=X..Chance  , fill=TYPE, group = Payroll.Size)) +
  #     geom_bar(stat="identity") +
  #     coord_flip()+
  #     scale_x_discrete(limits=c("Tiny","Small","Medium-Small","Medium-Large","Large","Huge"))+
  #     guides(fill=guide_legend(title="Season Success Type"))+
  #     scale_fill_brewer(palette = "BrBG",labels=c("Guaranteed Playoffs (>95 W)","Good Shot (91-95 W)","Competitive (86-90 W)","Outside Chance (81-85 W)","Maybe Next Year (76-80 W)","Time to Rebuild (<76 W)"))+
  #     ylab("Cumulative % of Having Season Type (or Better)")+
  #     xlab("Payroll")+
  #     scale_y_continuous(labels=percent)+
  #     facet_grid(Years ~.)+
  #     labs(title="Season Success Types By Payroll Size\n") +
  #     theme(
  #       axis.ticks.x=element_blank(),
  #       axis.title.x=element_text(face="bold"),
  #       axis.title.y=element_blank(),
  #       axis.text.x=element_text(face="bold", size=rel(1.2)),
  #       axis.text.y=element_text(face="bold",size=rel(1.2)),
  #       plot.title=element_text(face="bold", size=rel(1.5)),
  #       strip.text = element_text(face="bold",size=rel(1.5)),
  #       strip.background = element_rect(fill="lightblue", size=1, colour="black")
  #     )
  #   ## NAME: 06. Season Success Type Facets
  #   stackedbar2
  
    
    
    ### Payroll vs Wins for all years - SMALL MARKETS
    ### 
    # 
      payrollvswsm <- read.csv("C:/users/JP/Desktop/Baseball Data/payrollvswsmallbudget.csv")
      payrollvswsm <-payrollvswsm[1:46,]
      payrollvswsm <- ggplot(payrollvswsm, aes(x=PAYROLL...Z, y=WINS, 'colour=factor(YEAR)')) + 
        geom_point(size = 4, colour="#15527e") + 
        xlab("Payroll (Standard Deviations Above/Below Mean for that Season)") +
          ylab("Wins") +
          labs(title="Payroll (Z-Scores) vs. Wins, 2006-2013\n Low-Budget Teams\n") +
          theme(
            axis.ticks.x=element_blank(),
            axis.title.x=element_text(face="bold"),
            axis.title.y=element_text(face="bold"),
            axis.text.x=element_text(face="bold", size=rel(1.2)),
            axis.text.y=element_text(face="bold",size=rel(1.2)),
            plot.title=element_text(face="bold", size=rel(1.5))
          )
      
    #   ##ANNOTATED #   payrollvswsm <- ggplot(payrollvswsm, aes(x=PAYROLL...Z, y=WINS)) + geom_text(aes(label=Team.Year))
    #   # NAME: 07. Payroll Z vs. Wins - Small Budget
      payrollvswsm  
  
    
    ### Payroll vs Wins for all years - SMALL MARKETS and HIGH WINS
    ### 
  #   # 
  #   payrollvswsm <- read.csv("C:/users/JP/Desktop/Baseball Data/payrollvswsmallbudget.csv")
  #   payrollvswsm <-payrollvswsm[1:7,]
  #   payrollvswsm <- ggplot(payrollvswsm, aes(x=PAYROLL...Z, y=WINS, colour=TEAM)) + 
  #     geom_point(size = 4, colour="#15527e") + 
  #     xlab("Payroll (Standard Deviations Above/Below Mean for that Season)") +
  #     ylab("Wins") +
  #     geom_text(aes(label=Team.Year),vjust=-1, stat="identity") + 
  #     scale_colour_brewer (palette="Set1") +
  #     xlim(-1.4,-0.9) +
  #     ylim(90,98) +
  #     labs(title="Payroll (Z-Scores) vs. Wins, 2006-2013\n Low-Budget Teams with >90 Wins\n") +
  #     theme(
  #       axis.ticks.x=element_blank(),
  #       axis.title.x=element_text(face="bold"),
  #       axis.title.y=element_text(face="bold"),
  #       axis.text.x=element_text(face="bold", size=rel(1.2)),
  #       axis.text.y=element_text(face="bold",size=rel(1.2)),
  #       plot.title=element_text(face="bold", size=rel(1.5))
  #     )
  #   # NAME: 08. Payroll Z vs. Wins - Small Budget High Wins
  #   payrollvswsm  
  #   
  #   
    
    
    
  
    
    ### Broken down by top and bottom teams, bubbles market size
    
    payrollvswtopbot2010 <- read.csv("C:/users/JP/Desktop/Baseball Data/payrollvswtopbot2010.csv")
    payrollvswtopbot2010 <- ggplot(payrollvswtopbot2010, aes(x= PAYROLL...Z, y= WINS, colour=MARKET.SIZE, size=Wins.over.43.per.Normalized..m  )) + 
      scale_size_area(max_size=5) + 
      geom_text(aes(label=Team.Year), vjust=1, size = 5) +
      geom_point() + 
      xlab("Payroll (Z-scores)") +
      ylab("Wins") +
      scale_colour_brewer (palette="Set1") +
      labs(title="Payroll (Z-scores) vs. Wins since 2010 \n Top and Bottom by Wins per Normalized Dollar") +
      theme(
          axis.ticks.x=element_blank(),
          axis.title.x=element_text(face="bold"),
          axis.title.y=element_text(face="bold"),
          axis.text.x=element_text(face="bold", size=rel(1.2)),
          axis.text.y=element_text(face="bold",size=rel(1.2)),
          plot.title=element_text(face="bold", size=rel(1.5))
        )
    # NAME: 09. Payroll vs. Wins -- Extreme cases
    payrollvswtopbot2010  
    
    
    
    
    #### same thing, last 5 years (payrolltopbot2010.csv)
  #   payrollvswtopbot2010 <- read.csv("C:/users/JP/Desktop/Baseball Data/payrollvswtopbot2010.csv")
  #   payrollvswtopbot2010 <- ggplot(payrollvswtopbot2010, aes(x= PAYROLL...Z, y= WINS, colour=MARKET.SIZE)) + geom_point(size = 4) + scale_fill_brewer("Spectral") + geom_text(aes(label=Team.Year  ), vjust=1.5) 
  #   #   ANNOTATED #   payrolltopbot2000 <- ggplot(payrolltopbot2000, aes(x=PAYROLL...Z, y=WINS)) + geom_text(aes(label=Team.Year))
  #   #   # NAME: Payroll vs. Wins -- Extreme cases since 2010
  #   payrollvswtopbot2010  
  #   
  #   
  #   ### NOT USING THIS FOR BLOG POST
  #   ### Broken down by year
  #   ### Observation: 2013 looks flat
  #     payrollvsw2 <- read.csv("C:/users/JP/Desktop/Baseball Data/payrollvsw.csv")
  #     payrollvsw2 <-payrollvsw2[229:403,]
  #     # NAME: Payroll Z vs. Wins by Year
  #     ANNOTATED #   payroll_vs_w_by_year <- ggplot(payrollvsw2, aes(x=PAYROLL...Z, y=WINS)) + geom_text(aes(label=TEAM)) + facet_grid(YEAR ~ .)
  #     payroll_vs_w_by_year <- ggplot(payrollvsw2, aes(x=PAYROLL...Z, y=WINS, colour=factor(YEAR))) + geom_point(size = 2) + facet_grid(YEAR ~ .)
  #     payroll_vs_w_by_year
  #      
  #     
    
    ### Same thing, but TB, OAK, NYY, BOS
    ### !!! annotate with average wins on top
      payrollvsw2teams <- read.csv("C:/users/JP/Desktop/Baseball Data/payrollvswteamswithmetscubs.csv")
      payrollvsw2teams <- payrollvsw2teams[1:24,]
      payroll_vs_w_by_yearteams <- ggplot(payrollvsw2teams, aes(x=PAYROLL...Z, y=WINS, colour=TEAM,size=REVENUE, shape=Group)) + 
      geom_point() + 
      scale_size_area(max_size=15) +
      xlab("Payroll (Z-scores)") +
      ylab("Wins") +
      scale_colour_brewer (palette="Set2") +
      labs(title="The Haves vs. The Have-Nots \n Payroll (z-scores) vs. Wins, Last 5 Years\n") +
      guides(colour = guide_legend(override.aes = list(size=8)))+
      annotate("text", x=2.2, y=92, label="Haves: Average 92 Wins\n                58% Make Playoffs", colour="#000066", size=5, fontface="bold")+
      annotate("text", x=-0.5, y=87, label="Have-Nots: Average 87 Wins\n                       50% Make Playoffs", colour="#996600", size=5, fontface="bold")+
      theme(
        axis.ticks.x=element_blank(),
        axis.ticks.y=element_blank(),
        axis.title.x=element_text(face="bold"),
        axis.title.y=element_text(face="bold"),
        axis.text.x=element_text(face="bold", size=rel(1.2)),
        axis.text.y=element_text(face="bold",size=rel(1.2)),
        plot.title=element_text(face="bold", size=rel(1.5))
      )
    # NAME: 10. Haves vs Have Nots  
    payroll_vs_w_by_yearteams
      
  # 
  #   
  #   #### Same thing, but NYM and CHC
  #   #   ### !!! annotate with average wins on top
  #         payrollvswteamswithmetscubs <- read.csv("C:/users/JP/Desktop/Baseball Data/payrollvswteamswithmetscubs.csv")
  #         # NAME: Money Doesn't Buy Happiness
  #         # ANNOTATED #   payroll_vs_w_by_yearteams <- ggplot(payrollvsw2teams, aes(x=PAYROLL...Z, y=WINS)) + geom_text(aes(label=TEAM)) + facet_grid(YEAR ~ .)
  #         payrollvswteamswithmetscubs <- ggplot(payrollvswteamswithmetscubs, aes(x=PAYROLL...Z, y=WINS, colour=TEAM,size=REVENUE)) + geom_point() + scale_size_area(max_size=15)
  #         payrollvswteamswithmetscubs
  #       
  #   
    
    
    
    ### Same thing, but TB, OAK, NYY, BOS
    payrollvsw2teams <- read.csv("C:/users/JP/Desktop/Baseball Data/payrollvswteamswithmetscubs.csv")
    payroll_vs_w_by_yearteams <- ggplot(payrollvsw2teams, aes(x=PAYROLL...Z, y=WINS, colour=TEAM,size=REVENUE, shape=Group)) + 
      geom_point() + 
      scale_size_area(max_size=15) +
      xlab("Payroll (Z-scores)") +
      ylab("Wins") +
      scale_colour_brewer (palette="Set2") +
      labs(title="Money Doesn't Buy Happiness \n Payroll (z-scores) vs. Wins, Last 5 Years\n") +
      annotate("text", x=2.2, y=92, label="Haves: Average 92 Wins\n                58% Make Playoffs", colour="#006633", size=5, fontface="bold")+
      annotate("text", x=-0.5, y=87, label="Have-Nots: Average 87 Wins\n                       50% Make Playoffs", colour="#000066", size=5, fontface="bold")+
      annotate("text", x=0.4, y=76, label="Sad Sacks: Average 76 Wins\n                     8% Make Playoffs", colour="#996600", size=5, fontface="bold")+
      guides(colour = guide_legend(override.aes = list(size=8)))+
      theme(
        axis.ticks.x=element_blank(),
        axis.ticks.y=element_blank(),
        axis.title.x=element_text(face="bold"),
        axis.title.y=element_text(face="bold"),
        axis.text.x=element_text(face="bold", size=rel(1.2)),
        axis.text.y=element_text(face="bold",size=rel(1.2)),
        plot.title=element_text(face="bold", size=rel(1.5))
      )
    # NAME: 10. Haves vs Have Nots  
    payroll_vs_w_by_yearteams
    
  
  
  #   
  # winsbydivision <- read.csv("C:/Users/JP/Desktop/Baseball data/winsbydivision.csv")
  # winsbydivision <- ggplot(winsbydivision, aes(x=factor(Year), y=Wins, colour=Division, group=Division))+
  #     geom_point(size=8)+
  #     geom_line(size=2.5)+
  #     labs(title="Year vs. Average Wins, By Division\n") +
  #     scale_color_brewer(palette="Set3")+
  #     xlab("Year")+
  #     ylab("Wins")+
  #     annotate("text", x=4.9, y=82, label="*HOU moved NL C\n to AL W in 2013.\n Wins: 65 ('09-'12)\n    51('13)", colour="#000066", size=4, fontface="italic")+
  #     theme(
  #       axis.ticks.x=element_blank(),
  #       axis.ticks.y=element_blank(),
  #       axis.title.x=element_text(face="bold"),
  #       axis.title.y=element_text(face="bold"),
  #       axis.text.x=element_text(face="bold", size=rel(1.2)),
  #       axis.text.y=element_text(face="bold",size=rel(1.2)),
  #       plot.title=element_text(face="bold", size=rel(1.5))
  #     )
  # # NAME: 11. Year vs. Average Wins  
  # winsbydivision
  # 
  #   
  
    
    # custom annotation: ann_text <- data.frame(Name="Yankees",  Team="NYY",  Z.Scores=4.15,  Metric="Revenue",X="AL",	X.1="East",	X.2="AL East",	Total=10.9636068)
    baseballdata <- read.csv("C:/users/JP/Desktop/Baseball Data/BASEBALLDATA_marketvsrevenue.csv")
    baseballdata = ggplot(baseballdata, aes(x=reorder(factor(Team),Total),y=Z.Scores , fill=Metric)) + 
      geom_bar(position="dodge", stat="identity")+ 
      facet_wrap(~  X.2, scales="free_x") + 
      scale_fill_brewer(palette="BrBG")+
      ylab("z-scores")+
      xlab("Teams By Division (Total z-score ascending left to right)")+
      # custom annotation: geom_text(data = ann_text,label = "4.2", colour="#018571",fontface="bold", vjust=5, hjust=0.5,size=4)+
      labs(title="Varying Metrics by Team, By Division\n")+
      theme(
        axis.ticks.x=element_blank(),
        axis.ticks.y=element_blank(),
        axis.title.x=element_text(face="bold"),
        axis.title.y=element_text(face="bold"),
        axis.text.x=element_text(face="bold", size=rel(1.2)),
        axis.text.y=element_text(face="bold",size=rel(1.2)),
        plot.title=element_text(face="bold", size=rel(1.5)),
        strip.text = element_text(face="bold",size=rel(1)),
        strip.background = element_rect(fill="#80cdc1", size=1, color="#018571")
      )  
    ### Name: 12. Metrics by division
    baseballdata
    
    
    
    
    
    
    
    ## Bar chart - market size and revenue
    ## PICK SOME BUT NOT ALL METRICS?
    
    
  
    
    
    baseballdata <- read.csv("C:/users/JP/Desktop/Baseball Data/BASEBALLDATA_marketvsrevenuebydiv.csv")
    baseballdata = ggplot(baseballdata, aes(x=reorder(factor(Team),Total),y=Z.Scores , fill=Metric)) + 
      geom_bar(position="dodge", stat="identity")+ 
      facet_wrap(~  X.2, scales="free_x") + 
      scale_fill_brewer(palette="BrBG")+
      ylab("z-scores")+
      xlab("Teams By Division (Total z-score ascending left to right)")+
      #geom_text(data = ann_text,label = "4.2", colour="#018571",fontface="bold", vjust=5, hjust=0.5,size=4)+
      labs(title="Different Resources by Team, By Division\n")+
      theme(
        axis.ticks.x=element_blank(),
        axis.ticks.y=element_blank(),
        axis.title.x=element_text(face="bold"),
        axis.title.y=element_text(face="bold"),
        axis.text.x=element_text(face="bold", size=rel(1.2)),
        axis.text.y=element_text(face="bold",size=rel(1.2)),
        plot.title=element_text(face="bold", size=rel(1.5)),
        strip.text = element_text(face="bold",size=rel(1)),
        strip.background = element_rect(fill="#80cdc1", size=1, color="#018571")
      )  
    ### Name: 12. Metrics by division
    baseballdata
    
    
    metricbydivision <- read.csv("C:/users/JP/Desktop/Baseball Data/metricbydivision.csv")
    metricbydivision = ggplot(metricbydivision, aes(x=Division,y=z.scores , fill=Metric)) + 
      geom_bar(position="dodge", stat="identity")+ 
      facet_wrap(~  Division, scales="free_x") + 
      scale_fill_brewer(palette="BrBG")+
      ylab("z-scores")+
      xlab("Teams By Division (Total z-score ascending left to right)")+
      #geom_text(data = ann_text,label = "4.2", colour="#018571",fontface="bold", vjust=5, hjust=0.5,size=4)+
      labs(title="Different Resources by By Division, Aggregated\n")+
      theme(
        axis.ticks.x=element_blank(),
        axis.ticks.y=element_blank(),
        axis.title.x=element_text(face="bold"),
        axis.title.y=element_text(face="bold"),
        axis.text.x=element_text(face="bold", size=rel(1.2)),
        axis.text.y=element_text(face="bold",size=rel(1.2)),
        plot.title=element_text(face="bold", size=rel(1.5)),
        strip.text = element_text(face="bold",size=rel(1)),
        strip.background = element_rect(fill="#80cdc1", size=1, color="#018571")
      )  
    ### Name: 13. Metrics by total division
      metricbydivision
    
    
    
    #### Increases in attendance and payroll
    
    attpayroll <- read.csv("C:/users/JP/Desktop/Baseball Data/averagepayrollchanges.csv")
    attpayroll2 <- ggplot(attpayroll, aes(x=factor(YEAR), y=X..CHANGE,fill=CHANGE)) + 
      geom_bar(position="dodge", stat="identity")+ 
      scale_fill_brewer(palette="Set2")+
      ylab("Percentage Change")+
      xlab("Year")+
      labs(title="Percentage Change in Attendance and Revenue By Year")+
      scale_y_continuous(labels=percent)+
      coord_flip()+
      theme(
      axis.ticks.x=element_blank(),
      axis.ticks.y=element_blank(),
      axis.title.x=element_text(face="bold"),
      axis.title.y=element_text(face="bold"),
      axis.text.x=element_text(face="bold", size=rel(1.2)),
      axis.text.y=element_text(face="bold",size=rel(1.2)),
      plot.title=element_text(face="bold", size=rel(1.5)),
      strip.text = element_text(face="bold",size=rel(1))
      )
    )   
    # NAME: 14. Change in Attendance and Revenue
    attpayroll2  
    
    
    
    
    
    
    
    
    
    
  
  
  
  
###################
#  END OF PART 1  #
###################  
  
  
  

  
################
#  OLD/UNUSED  #
################  

  
#   
#   ### Wins/$m normalized by average payroll
#   #### Observation: fewer true outliers due to more efficient market
#   winsperdollarplot <- read.csv("C:/users/JP/Desktop/Baseball Data/payrollvsw.csv")
#   winsperdollarplot <- ggplot(winsperdollarplot, aes(x=factor(YEAR), y=Wins.over.60.per.Normalized..m , colour=LEAGUE)) + geom_point(size = 4) #+ scale_colour_brewer(palette="Blues")
#   # ANNOTATED  winsperdollarplot <- ggplot(winsperdollarplot, aes(x=factor(YEAR), y=Wins.over.60.per.Normalized..m, colour=LEAGUE)) + geom_text(aes(label=Team.Year))
#   # NAME: Year vs. W$m (Normalized)
#   winsperdollarplot

#   
#   ### Wins/$m normalized by average payroll
#     #### Observation: fewer true outliers due to more efficient market
# winsperdollarplot2 <- read.csv("C:/users/JP/Desktop/Baseball Data/payrollvsw.csv")
# winsperdollarplot2 <- ggplot(winsperdollarplot2, aes(x=Normalized..m, y=Wins.over.60, colour=factor(YEAR))) + geom_point(size = 4) #+ scale_colour_brewer(palette="Set3")
# ANNOTATED # winsperdollarplot2 <- ggplot(winsperdollarplot2, aes(x=Normalized..m, y=Wins.over.60, colour=factor(YEAR))) + scale_colour_brewer(palette="Greens")+ geom_text(aes(label=Team.Year))
# ## NAME: Year vs. W$m (Normalized) all years
# winsperdollarplot2
#   
#   
#   
#   
#   #### Rising payroll and cost/win over time
#   ### ???? $/Win scale on right, payroll on left
#   payrolls <- read.csv("C:/users/JP/Desktop/Baseball Data/averagepayroll.csv")
#   payrolls <- ggplot(payrolls, aes(x=YEAR, y=AVERAGE.PAYROLL...m.)) + geom_line(size=2)
#   payrolls


  
  #### Increases in attendance and revenue?
#   
#   
#     #### year by year increase in average payroll
#       payrollincrease <- read.csv("C:/users/JP/Desktop/Baseball Data/averagepayroll.csv")
#       payrollincrease <-payrollincrease[6:12,]
#       payrollincrease <- ggplot(payrollincrease, aes(x=YEAR, y=Absolute.Increase, fill=ATTENDANCE)) + geom_bar(stat="identity")  + scale_fill_brewer(palette="PRGn") #+ geom_line(size=1.5) 
#       payrollincrease



  #### Market size facets -- attendance, revenue, wins over time
  
  #### specific team trends
  
  
  

# 
#   # wins vs. payroll 2013
#   ce <- arrange(data, PAYROLL...2013)
#   ggplot(data, aes(x=WINS...2013, y=PAYROLL...2013))+geom_point()
#   
#   (for loop?) stack z-scores of wins and payrolls for all years
#   
#   last 5 years average Z-scores W vs. payroll
#   ggplot(data, aes(x=LAST.5.AVG.PAYROLL..Z.,y=LAST.5.AVG.W..Z.))+geom_point()+stat_smooth(method=lm)
#   
#   market size vs. attendance
#   
#   ggplot(data, aes(x=Metro.size,y=ATTENDANCE))+geom_point()+stat_smooth(method=lm)
#   
#   market size vs. revenue
#   
#     ggplot(data, aes(x=Metro.size,y=REVENUE.2013,color=SHARE.))+geom_point(shape=3)+facet_grid(~SHARE. )+stat_smooth(method=lm)
#   
#   team normalized by payroll by year
#   
#   payrollvsyear <- read.csv("C:/Users/JP/Desktop/payrollvsyear.csv")
#   
#   
#   ggplot(payrollvsyear, aes(x=Year, y=Payroll, color=Team)) + geom_line()
# 
#   ggplot(payrollvsyear, aes(x=Payroll  ,y=Wins, color=Year))+geom_point()+stat_smooth(method=lm)+facet_grid(~Pre.2008.)
#   
#   
#  ggplot(payrollvsyear, aes(x=Payroll  ,y=Wins, color=Pre.2008.))+geom_point()+stat_smooth(method=lm)
#   
#   payrollvsyeartopbot5 <- read.csv("C:/Users/JP/Desktop/payrollvsyeartopbot5.csv")
#   
#  ggplot(payrollvsyeartopbot5, aes(x=Year, y=Payroll, colour=Team))+geom_line(size=1)+facet_grid(Top.Bottom. ~ .)  +xlim(2008,2013)  
# 
# 2013, 2012, 2011 attendance vs. wins
#   
#   
#   
#  att2012wins <- read.csv("C:/Users/JP/Desktop/2013att2012wins.csv")
#   
#  ggplot(att2012wins, aes(x=X2012.Wins, y=X2013.Attendance))+geom_point(size=5)+stat_smooth(method=lm)
#   
# ggplot(data, aes(x=ATTENDANCE,y=WINS...2013))+geom_point()+stat_smooth(method=lm)
#   


  
####################
# wins vs. attendance (maybe try to find a 3 year weighted average)
#  attendancewins <- read.csv("C:/Users/JP/Desktop/attendancewins.csv", as.is=T)
#  p = ggplot(attendancewins, aes(x=Wins,y=X2013.Attendance..thousands., colour = Year))  + geom_text(aes(label=Team)) + facet_grid(Year ~ .) + stat_smooth(method=lm)

# TODO: add in labels for regression lines

# attendance changes 

    
#   attendancebyyear <- read.csv("C:/Users/JP/Desktop/attendancebyyear.csv")
#   
#   ggplot(attendancebyyear, aes(x=YEAR,y=AVG,colour=TEAM))+geom_point()
  
####################
# payroll vs. wins
#   - 
# 
#   data <- read.csv("C:/Users/JP/Desktop/BASEBALLDATA.csv")
#   data <- data[1:31,] # get rid of mean, median, stdev rows
# 
#   last 5 years average Z-scores W vs. payroll
#  ggplot(data, aes(x=LAST.5.AVG.PAYROLL..Z.,y=LAST.5.AVG.W..Z., size=Metro.size))+geom_text(aes(label=TEAM), size = 4, vjust = -0.5) + geom_point(size=2, shape=21) + stat_smooth(method=lm) + scale_Size_area(max_size=15)
# 
#   
#   ggplot(data, aes(x=LAST.5.AVG.PAYROLL..Z.,y=LAST.5.AVG.W..Z., size=Metro.size, colour=Metro.size)) + geom_point() + scale_size_area(max_size=15)+stat_smooth(method=lm)
#   str(data)  
####################
  
  

#p = p + annotate("text",x=48,y=75, label="Rays")
#p
  
#ticketspercapita <- read.csv("C:/Users/JP/Desktop/ticketspercapita.csv") 
# bubbles as market size
#ggplot(ticketspercapita, aes(x=Metro.size..millions.  , y=Attendance.., colour=SHARE.)) + geom_point() + facet_grid(Market ~ .)

