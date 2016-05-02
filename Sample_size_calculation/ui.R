#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that calculates necessary sample size 
shinyUI(navbarPage("Navbar!", 
                   tabPanel("The sample size calculator",
  
  # Sidebar with input controls 
  sidebarLayout(
    sidebarPanel(
      h3('Input parameters'),
      numericInput('power', 'Power', 0.8, min = 0.8, max = 0.99, step = 0.01),
      numericInput('delta', 'Difference in means', 1, min = 0.5, max = 100000, step = 0.5),
      numericInput('sd', 'Standard deviation', 1, min = 0.5, max = 100000, step = 0.5),
      radioButtons("radioType", label = h3("Type of t test"),
                   choices = c("two.sample" = 1, "one.sample" = 2, "paired" = 3), selected = 1),
      radioButtons("radioAlt", label = h3("Hypothesis testing"),
                   choices = list("two.sided" = 1, "one.sided" = 2),selected = 1)
    ),
    
    
    # Show output 
    mainPanel(
      h3('Required sample size'),
      verbatimTextOutput("oid1"),
      plotOutput("distPlot"),
      h5('Note: A large Effect size (difference in means / standard deviation) can lead to decreased performance')
    )
  
    
    )
),

tabPanel("Instructions",
         h3('About calculation'),
         h4('Power analysis and sample size calculation are important planning stage of the experiment, because without these calculations, the amount of data may be too large or too small to obtain reliable results. If the sample size is too small, you have small probability that you have carried out an experimental research (mass survey, etc.) will give reliable results. On the contrary, if the sample size is too large, the time spent on data collection and large financial costs associated with it, will not bring the expected effect.'),
         h3('Parameters meaning in calculator:'),
         h4('1) Power - power of test (1 minus Type II error probability)'),
         h4('In other words, power - it`s the probability that the null hypothesis will be rejected adequately, when indeed there is evidence of real differences or relationships.'),
         h4('Power is usually fixed at 80%, 90% or 95%. Power must not be less than 80%.'),
         h4('2) The effect size, the difference in the means in standard deviation units (difference in the means / standard deviation).'),
         h4('The sample must has such size, so if such differences exist, the study would have produced statistically significant results. Before determining the sample size its necessary to specify size of the significant effect.'),
         h4('3) Type of t test.'),
         h4('1 sample t-test Tests whether the mean of a single population is equal to a target value.'),
         h4('Example: Is the mean height of female college students greater than 5.5 feet?'),
         h4('2 sample t-test Tests whether the difference between the means of two independent populations is equal to a target value.'),
         h4('Example: Does the mean height of female college students significantly differ from the mean height of male college students?'),
         h4('Paired t-test Tests whether the mean of the differences between dependent or paired observations is equal to a target value.'),
         h4('Example: If you measure the weight of male college students before and after each subject takes a weight-loss pill, is the mean weight loss significant enough to conclude that the pill works?'),
         h4('4) One- or two-sided test.'),
         h4('For two-sided test, the null hypothesis is no difference and the alternative hypothesis is that differences between groups can be in either direction.'),
         h4('With one-sided test, the alternative hypothesis specifies the expected direction of the difference.'),
         h4('If there are no serious reasons to not to do so, you should use two-sided hypothesis.'))
)
)
