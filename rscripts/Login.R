#### Log in module ###
USER <- reactiveValues(Logged = Logged,
                       Admin = Admin)

passwdInput <- function(inputId, label) {
        tagList(
                tags$label(label),
                tags$input(id = inputId, type="password", value="")
        )
}

output$uiLogin <- renderUI({
        if (USER$Logged == FALSE) {
                wellPanel(
                        textInput("userName", "Username:"),
                        passwdInput("passwd", "Password:"),
                        br(),
                        actionButton("Login", "Log in")
                )
        }
})

output$pass <- renderText({  
        if (USER$Logged == FALSE) {
                if (!is.null(input$Login)) {
                        if (input$Login > 0) {
                                Username <- isolate(input$userName)
                                Password <- isolate(input$passwd)
                                Id.username <- which(PASSWORD$Name == Username)
                                Id.password <- which(PASSWORD$Password    == Password)
                                
                                # adding admin check
                                
                                USER$Admin = PASSWORD[Id.username, 'Admin']
                                
                                if (length(Id.username) > 0 & length(Id.password) > 0) {
                                        if (Id.username == Id.password) {
                                                USER$Logged <- TRUE
                                        } 
                                } else  {
                                        "User name or password failed!"
                                }
                        } 
                }
        }
})

