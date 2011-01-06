package le.space
import org.joda.time.*
import org.joda.time.format.*
import java.net.InetAddress
import java.net.InetSocketAddress
import java.net.NetworkInterface
import java.net.SocketException
import java.net.UnknownHostException

class LoginService {

    static transactional = true

    def login(String id, InetSocketAddress client) {

        ShiroUser.withTransaction{
            def shiroUser = le.space.ShiroUser.get(id)
            log.debug "shiroUser:${shiroUser} userId:${id} "
            if (shiroUser) {
                String macAddr = ""

                def login = new Login(user:shiroUser,ipAddress:client?client.getAddress().toString():null,macAddress:macAddr,loginStart:new Date()).save(flush:true)
                log.debug "saved new login ${login}"

                shiroUser.addToLogins(login)
                shiroUser.save(flush:true)
            
           
                //letzten aktiven vertrag eines users heraussuchen
                //  hql = "select sum(amountGross) as amount, customer.id "
                def hql="select co from le.space.Contract  co "
                hql+="inner join co.customer cu "
                hql+="inner join cu.shiroUsers u "
                hql+="WHERE u.username=:username "
                hql+="ORDER BY co.contractStart desc"
            
                def hparams = [username:shiroUser.username]

                def contractList = Contract.executeQuery(hql,hparams)
                // log.debug "contractList: ${contractList}"
                def contractInstance = contractList[0]

                log.debug "Product ${contractInstance} has durationType: contractInstance.products[0].durationType"

                //wenn heute schon ein login war diesen login nicht noch einmal zählen!
                MutableDateTime today = new DateTime(new Date()).toMutableDateTime()
                today.setHourOfDay(0)
                today.setMinuteOfHour(0)
                today.setSecondOfMinute(0)
                log.debug "todays login ${today}"
                if(contractInstance.lastLogin < today.toDateTime().toDate() && contractInstance.getProducts().toArray()[0].allowedLoginDays>0){
                    contractInstance.allowedLoginDaysLeft--
                    contractInstance.loginDays++

                    log.debug "login was counted. allowedLoginDayLeft now:${contractInstance.allowedLoginDaysLeft} and loginDays now: ${contractInstance.loginDays}"
                }
                contractInstance.lastLogin = new Date()
                contractInstance.save(flush:true)
            }
        }
    }
}
