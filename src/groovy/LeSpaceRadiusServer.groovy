import java.net.InetSocketAddress
import org.apache.shiro.crypto.hash.Sha512Hash
import org.tinyradius.packet.AccessRequest
import org.tinyradius.packet.RadiusPacket
import org.tinyradius.util.RadiusException
import org.codehaus.groovy.grails.commons.ConfigurationHolder
/**
 *
 * @author nico
 */
class LeSpaceRadiusServer extends org.tinyradius.util.RadiusServer {

    def loginService = new le.space.LoginService()
    def persistenceInterceptor

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
        int type = RadiusPacket.ACCESS_REJECT;
        //Accept auf true setzen, wenn das übermittelte passwort (aus dem accessRequest mit dem aus der Datenbank übereinstimmt

        def shiroUser = le.space.ShiroUser.findByUsername(accessRequest.getUserName())
        //accessRequest.setAuthProtocol(AccessRequest.AUTH_PAP); //
        System.out.println("try radius login of:"+accessRequest.getUserName())
        // if(!shiroUser)
        //     throw RadiusException
        // System.out.println("accessRequest.getUserPassword()"+accessRequest.getUserPassword())
        // System.out.println("new Sha1Hash(accessRequest.getUserPassword()).toHex()"+new Sha512Hash(accessRequest.getUserPassword()).toHex())
        //System.out.println("shiroUser.findByUsername(username).passwordHash"+shiroUser.passwordHash)

        //http://www.dd-wrt.com/wiki/index.php/How_to_configure_DD-WRT,_Chillispot,_Apache2,_FreeRadius,_freeradius-dialupadmin,_and_MySQL_on_Debian_4.0

        if (shiroUser && new Sha512Hash(accessRequest.getUserPassword()).toHex() == shiroUser.passwordHash){
            type = RadiusPacket.ACCESS_ACCEPT;
            System.out.println(accessRequest.getUserName()+" logged in.")
            try {
                if (persistenceInterceptor) {
                    //log.debug("opening persistence context")
                    persistenceInterceptor.init()
                } else {
                    //log.debug("no persistence interceptor")
                }
                loginService.login(shiroUser.id.toString(),client,null)
            } finally {
                if (persistenceInterceptor) {
                    //log.debug("destroying persistence context for listener" )
                    persistenceInterceptor.flush()
                    persistenceInterceptor.destroy()
                }
            }
            
        }//if

        RadiusPacket answer = new RadiusPacket(type, accessRequest.getPacketIdentifier());
        copyProxyState(accessRequest, answer);
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

