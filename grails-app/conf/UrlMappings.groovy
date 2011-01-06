class UrlMappings {
    
    static mappings = {
        
      "/"(controller:'home',action:'index')
      "/raum"(controller:'home',action:'raum')
      "/coworking"(controller:'home',action:'coworking')
      "/preise"(controller:'home',action:'preise')
      "/faq"(controller:'home',action:'faq')
      "/veranstaltungen"(controller:'home',action:'veranstaltungen')
      "/user"(controller:'home',action:'user')
      "/kontakt"(controller:'home',action:'kontakt')
      "/impressum"(controller:'home',action:'impressum')
      "/agb"(controller:'home',action:'agb')
      "/login"(controller:'home',action:'login')
      "/anmeldung"(controller:'public')
      "/$controller/$action?/$id?"{
            constraints {
                // apply constraints here
            }
        }
      //"/"(view:"/index")
        "500"(view:'/error')
    }

}
