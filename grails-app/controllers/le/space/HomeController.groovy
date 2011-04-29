package le.space

class HomeController {
    def index = {[bodyId:"startseite",slogan: "Büro war gestern.!"]}
    def raum = {[bodyId:"raeume",slogan: "Coworking funktioniert weltweit und ist die Zukunft der Büroarbeit."]}
    def coworking = {[bodyId:"coworking",slogan: "Coworking ist produktives Arbeiten in kreativer Umgebung."] }
    def preise = {[bodyId:"preise",slogan: "Coworking = flexibles Arbeiten = flexible Tarife"] }
    def faq = { [bodyId:"faq",slogan: "Coworking ist die logische Konsequenz des Internets auf die Arbeitswelt."]}
    
    def user = {

        def hql = ""
        hql+="from le.space.Customer c where c.allowPublishNameOnWebsite=true order by c.dateCreated desc "

        def hparams = [:]
        hparams.put("max","15")
        def customerList = le.space.Customer.findAll(hql,hparams)
        
        [customerList: customerList,  bodyId:"user",slogan: "... where change goes to work"]
    }
    def veranstaltungen = {[bodyId:"veranstaltungen",slogan: ""] }
    def kontakt = {[bodyId:"kontakt",slogan: "join the coworking revolution..."] }
    def impressum = {[bodyId:"impressum",slogan: "Vernetzung im realen Raum - virtuell reicht nicht."] }
    def anmeldung = {[bodyId:"anmeldung",slogan: "Jetzt anmelden und Fensterplätze sichern! :-)"] }
    def agb = {[bodyId:"agb", slogan: "Allgemeine Geschäftsbedingungen der Le Space UG (haftungsbeschränkt)"] }
    def login = {

        session.loginParams = params
        log.debug params
        [bodyId:"login", slogan: "Herzlich Willkommen!"]
    }

}
