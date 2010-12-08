import java.net.InetSocketAddress;
import org.apache.shiro.crypto.hash.Sha512Hash
import org.tinyradius.packet.AccessRequest;
import org.tinyradius.packet.RadiusPacket;
import org.tinyradius.util.RadiusException
/**
 *
 * @author nico
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
        int type = RadiusPacket.ACCESS_REJECT;
        //Accept auf true setzen, wenn das übermittelte passwort (aus dem accessRequest mit dem aus der Datenbank übereinstimmt


        def shiroUser = ShiroUser.findByUsername(accessRequest.getUserName())
        System.out.println("accessRequest.getUserPassword()"+accessRequest.getUserPassword())
        System.out.println("new Sha1Hash(accessRequest.getUserPassword()).toHex()"+new Sha512Hash(accessRequest.getUserPassword()).toHex())
        System.out.println("shiroUser.findByUsername(username).passwordHash"+shiroUser.passwordHash)
        
        if (new Sha512Hash(accessRequest.getUserPassword()).toHex() == shiroUser.passwordHash){
            
            //does this user has valid custerorders? (time & if )
/**            def hql = "from CustomerOrder co where co.customerr=:customer "
            hql+= "and co.validFrom>=current_date() and co.validTo<=current_date() "
            hql+= "and co.quantityOrdered<quantityDelivered"
            def results = LoginLog.findAll(hql,[customer:shiroUser.customer])
            if(results.length>0){
                results[0].deliverOne()
            }

   */
            type = RadiusPacket.ACCESS_ACCEPT;
         //   new LoginLog(loginDate:new Date(),shiroUser:shiroUser,ipAddress:"",hostname:"",success:true).save()
            // def loggedIn = loginService.login(shiroUser.username)
        }

        RadiusPacket answer = new RadiusPacket(type, accessRequest.getPacketIdentifier());
        copyProxyState(accessRequest, answer);
        return answer;
    }


    public String getSharedSecret(InetSocketAddress arg0) {
       "secret"
    }


    org.tinyradius.packet.RadiusPacket accountingRequestReceived(org.tinyradius.packet.AccountingRequest request, InetAddress client){
        log.debug "access Request Received"
    }
}

