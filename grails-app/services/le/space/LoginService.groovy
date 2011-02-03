package le.space
import org.joda.time.*
import org.joda.time.format.*
import java.net.InetAddress
import java.net.InetSocketAddress
import java.net.NetworkInterface
import java.net.SocketException
import java.net.UnknownHostException
import org.springframework.beans.factory.InitializingBean

class LoginService implements InitializingBean {
    
    def grailsApplication
    def setting

    static transactional = true
    
    void afterPropertiesSet()
    {
        this.setting = grailsApplication.config.setting
    }

    def login(String id, String ipAddress, String macAddress) {

        def shiroUser

        ShiroUser.withTransaction{
        shiroUser = le.space.ShiroUser.get(id)
        shiroUser.getLogins()
        log.debug "shiroUser:${shiroUser} userId:${id}"
        //}

        if (shiroUser) {
            
            //Login.withTransaction{
            def login = new Login(user:shiroUser,ipAddress:ipAddress?ipAddress:null,macAddress:macAddress?macAddress:null,loginStart:new Date()).save()
            shiroUser.addToLogins(login)
            shiroUser.save()
            //  }

            //Contract.withTransaction{
                
            //letzten aktiven vertrag eines users heraussuchen
            //  hql = "select sum(amountGross) as amount, customer.id "
                
            def hql="select co from le.space.Contract  co "
            hql+="left join co.customer cu "
            hql+="left join cu.shiroUsers u "
            hql+="WHERE u.username=:username "
            hql+="ORDER BY co.contractStart desc"
            
            def hparams = [username:shiroUser.username]

            def contractList = Contract.executeQuery(hql,hparams)
            log.debug "contractList: ${contractList.size()}"

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
                
            contractInstance.save()
   
        }
        }
    }
}

