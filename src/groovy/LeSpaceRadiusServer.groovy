import java.net.InetSocketAddress
import org.apache.shiro.crypto.hash.Sha512Hash
import org.tinyradius.packet.AccessRequest
import org.tinyradius.packet.RadiusPacket
import org.tinyradius.util.RadiusException
import org.codehaus.groovy.grails.commons.ConfigurationHolder
import org.codehaus.groovy.grails.commons.ApplicationHolder;
import org.springframework.context.ApplicationContext;
/**
 * LeSpaceRadiusServer
 */
class LeSpaceRadiusServer extends org.tinyradius.util.RadiusServer {

    // This method should check whether the passed client is allowed to communicate with the Radius server. If this is the case, it should return the shared secret that secures the communication to the client.
    public String getUserPassword(String username) {
        return null;
    }

    /**
     * Constructs an answer for an Access-Request packet. Either this
     * method or isUserAuthenticated should be overriden.
     * @param accessRequest Radius request packet
     * @param client address of Radius client
     * @return response packet or null if no packet shall be sent
     * @exception RadiusException malformed request packet; if this
     * exception is thrown, no answer will be sent
     */
    public RadiusPacket accessRequestReceived(AccessRequest accessRequest, InetSocketAddress client)
    throws RadiusException {

        //String plaintext = getUserPassword(accessRequest.getUserName());
        int type = RadiusPacket.ACCESS_REJECT
        
        accessRequest.getAttributes().each{
            System.out.println("attribute:"+it.getAttributeTypeObject().getName()+":"+it.getAttributeValue())
        }

        boolean macAuth = false
        def shiroUser

        System.out.println("try radius login of:"+accessRequest.getUserName())
        // System.out.println(accessRequest.getUserName().tokenize(':').size())

        if(accessRequest.getUserName().tokenize(':').size()==6){
            macAuth = true
            System.out.println("mac address wants to authenticate searching for user.")
            shiroUser = le.space.ShiroUser.findByMac(accessRequest.getUserName())
            if(!shiroUser){
                //create new anonymous user
                System.out.println("mac address not known creating a new user!")
                //le.space.ShiroUser.withTransaction(){
                shiroUser = new le.space.ShiroUser(username:accessRequest.getUserName(),
                    passwordHash:new Sha512Hash(accessRequest.getUserName()).toHex(),salutation:null,
                    firstname:"Anonym",
                    lastname:"Anonymous",
                    email:accessRequest.getUserName().replace(':','.')+"@le-space.de",
                    birthday:null,
                    telMobile:null,
                    occupation:null,
                    twitterName:null,
                    facebookName:null,
                    mac:accessRequest.getUserName(),optOutIamHereFunction:true)

                ApplicationContext ctx = (ApplicationContext)ApplicationHolder.getApplication().getMainContext()
                le.space.java.LoginServiceIf loginService = (le.space.java.LoginServiceIf) ctx.getBean("loginService")

                shiroUser = loginService.createUser(shiroUser)
               
                System.out.println("User: "+shiroUser+" created!")
            }
        }
        else
        shiroUser = le.space.ShiroUser.findByUsername(accessRequest.getUserName())

        //accessRequest.setAuthProtocol(AccessRequest.AUTH_PAP); //
        

        //http://www.dd-wrt.com/wiki/index.php/How_to_configure_DD-WRT,_Chillispot,_Apache2,_FreeRadius,_freeradius-dialupadmin,_and_MySQL_on_Debian_4.0

        //Accept auf true setzen, wenn das übermittelte passwort (aus dem accessRequest mit dem aus der Datenbank übereinstimmt
        if ((shiroUser && new Sha512Hash(accessRequest.getUserPassword()).toHex() == shiroUser.passwordHash) || macAuth){
            type = RadiusPacket.ACCESS_ACCEPT

            ApplicationContext ctx = (ApplicationContext)ApplicationHolder.getApplication().getMainContext()
            le.space.java.LoginServiceIf loginService = (le.space.java.LoginServiceIf) ctx.getBean("loginService")

            loginService.login(shiroUser.id.toString(),
                accessRequest?.getAttribute("Framed-IP-Address")?.getAttributeValue()
                ,accessRequest?.getAttribute("Calling-Station-Id")?.getAttributeValue())
                       
        }//if

        RadiusPacket answer = new RadiusPacket(type, accessRequest.getPacketIdentifier())
        copyProxyState(accessRequest, answer)
        return answer;
    }


    public String getSharedSecret(InetSocketAddress arg0) {
        ConfigurationHolder.config.lespace.radiusServerSharedSecret
        //"testing123"
    }

    org.tinyradius.packet.RadiusPacket accountingRequestReceived(org.tinyradius.packet.AccountingRequest request, InetAddress client){
        System.out.println("access Request Received")
    }

}

