library(shiny)

shinyUI(navbarPage("Portfolio Optimization",
             
  tabPanel("App Description",
    sidebarLayout(
      sidebarPanel(
          p("This application constructs efficient portfolios containing 8 asset classes based on two
          models - a simple mean-variance optimization model and a Black-Litterman (BL) model which factors
          in investor beliefs about returns in the asset classes. The final outputs are percentages 
          of each asset you should allocate in the portfolios to obtain the minimum level of risk for a 
          desired return. Efficient frontiers for both models are plotted for comparison."),
          br(),
          p("Historical returns for each asset class is specified in the assumptions tab, and included as well is a 
          covariance matrix used to compute the optimal weights of the portfolio."),
          br(),
          helpText("You may choose to adjust historical returns. Values are in percentages."),
          numericInput("usBonds", label = strong("US Bonds"), min=0, max=100, value = .08),
          numericInput("intlBonds", label = strong("Intl Bonds"), min=0, max=100, value = .067),
          numericInput("usLargeG", label = strong("US Large Growth"), min=0, max=100, value = 6.41),
          numericInput("usLargeV", label = strong("US Large Value"), min=0, max=100, value = 4.08),
          numericInput("usSmallG", label = strong("US Small Growth"), min=0, max=100, value = 7.43),
          numericInput("usSmallV", label = strong("US Small Value"), min=0, max=100, value = 3.70),
          numericInput("intlDevEq", label = strong("Intl Dev Equity"), min=0, max=100, value = 4.80),
          numericInput("intlEmergEq", label = strong("Intl Emerg Equity"), min=0, max=100, value = 6.60)
          
      ),
      mainPanel(
        tabsetPanel(type="tabs",
          tabPanel("Input Assumptions",        
            h4("Covariance Matrix of Excess Returns"),
              tableOutput("cMat"),
            
            h4("Historical Returns of Asset Classes"),
            tableOutput("histReturns")
          
          ),
          tabPanel("Black-Litterman Model"))
        )
  )
  ),  
                                
  tabPanel("Mean-Variance Model",
    sidebarLayout(
      sidebarPanel(
        
      ),
             
      mainPanel(
        numericInput("numRVals", label = strong("Specify number of R Values"), min=0, max=500, value = 5),
        selectInput("selectRVals", label = "Specify R Value", c("label 1" = "option1")),
        plotOutput("meanVarAlloc"),
        plotOutput("meanVarFrontier")
        )
          )),
  
  tabPanel("Black-Litterman Model",
    sidebarLayout(
      sidebarPanel(
        
        ),
      mainPanel(
         numericInput("tau", label ="Specify τ", min=0, max=500, value = 2.5),
         selectInput("selectType", label ="Is your view absolute or relative?", choices=list("absolute","relative")),
         selectInput("assetClass", label ="Choose an asset class to specify a view for", 
                     choices=c("US Bonds", "Int'l Bonds", "US Large Growth","US Large Value",  
                               "US Small Growth", "US Small Value", "Intl Dev Equity", "Intl Emerg Equity")),
         numericInput("viewInput", label="Your view on this asset class", min=0, max=100, value=4.1),
         uiOutput("ui"),
         
        plotOutput("blAlloc")
        )
      )                 
  )
  )
)