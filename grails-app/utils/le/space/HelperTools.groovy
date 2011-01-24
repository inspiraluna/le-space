package le.space
import org.apache.commons.lang.StringUtils

/**

HelperTools (initilizes data in database with base data and test data)
getLocale() returns the current locale.
getByteArrayFromUrl - returns a byte array from a file.

$Rev: 113 $:     Revision of last commit
$Author: inspiraluna $:  Author of last commit
$Date: 2009-10-07 10:23:58 +0200 (Mi, 07. Okt 2009) $:    Date of last commit

This program is free software; you can redistribute it and/or modify it
under the terms of the GNU General Public License as published by the Free
Software Foundation; either version 3 of the License, or (at your option)
any later version.

This program is distributed in the hope that it will be useful, but WITHOUT
ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
more details.

You should have received a copy of the GNU General Public License along
with this program; if not, see <http://www.gnu.org/licenses/>.
 */
import org.codehaus.groovy.grails.commons.*
class HelperTools {

    def static isNumeric = {

        def formatter = java.text.NumberFormat.instance
        def pos = [0] as java.text.ParsePosition
        formatter.parse(it, pos)

        // if parse position index has moved to end of string
        // them the whole string was numeric
        pos.index == it.size()
    }

    def static getJasperFilePath = { request ->

        def config = ConfigurationHolder.config

        String jasperFilePath = config.jasper.dir.reports ?: request.getSession().getServletContext().getRealPath("./")+"/reports"

        //String jasperFilePath = config.jasper.dir.reports ?: request.servletContext.getRealPath("./")+"/reports"

        //String jasperFilePath = ConfigurationHolder.config.jasper.dir.reports ?: servletContext.getRealPath("./")+"/"+"reports"
        //e.g. /var/webanizer/nico.site/webanizer_tb
        //e.g. /var/webanizer/nico.site/cse_webanizer
        //e.g. /var/webanizer/stegbth.site/webanizer
        println config.jasper.dir.reportsFromServerName
        println config.jasper.dir.reportsFromContextName
        
        if(config.jasper.dir.reportsFromServerName==true){
            jasperFilePath += File.separator+HelperTools.getServerName(request)
            if(!new File(jasperFilePath).exists())
            new File(jasperFilePath).mkdir()
        }
        if(config.jasper.dir.reportsFromContextName==true){
            jasperFilePath += File.separator+HelperTools.getContext(request)
            if(!new File(jasperFilePath).exists())
            new File(jasperFilePath).mkdir()
        }
        println jasperFilePath

        jasperFilePath
    }


    /*
     * Clones a domain object and recursively clones children, clearing ids and
     * attaching children to their new parents. Ownership relationships (indicated
     * by GORM belongsTo keyword) cause "copy as new" (a recursive deep clone),
     * but associations without ownership are shallow copied by reference.
     */
    def static deepClone(domainInstanceToClone){

        //Our target instance for the instance we want to clone
        def newDomainInstance = domainInstanceToClone.getClass().newInstance()

        //Returns a DefaultGrailsDomainClass (as interface GrailsDomainClass) for inspecting properties
        def domainClass = ApplicationHolder.application.getDomainClass(newDomainInstance.getClass().name)

        domainClass?.persistentProperties.each{prop ->
            if(prop.association){
                if(prop.owningSide){
                    //we have to deep clone owned associations
                    if(prop.oneToOne){
                        def newAssociationInstance = deepClone(domainInstanceToClone."${prop.name}")
                        newDomainInstance."${prop.name}" = newAssociationInstance
                    }
                    else{
                        domainInstanceToClone."${prop.name}".each{ associationInstance ->
                            def newAssociationInstance = deepClone(associationInstance)
                            newDomainInstance."addTo${StringUtils.capitalize(prop.name)}"(newAssociationInstance)
                        }
                    }
                }
                else{
                    if(!prop.bidirectional){
                        //If the association isn't owned or the owner, then we can just do a  shallow copy of the reference.
                        newDomainInstance."${prop.name}" = domainInstanceToClone."${prop.name}"
                    }
                }
            }
            else{
                //If the property isn't an association then simply copy the value
                newDomainInstance."${prop.name}" = domainInstanceToClone."${prop.name}"
            }
        }

        return newDomainInstance
    }

    def static makeSSL(urlToMakeSSL){

        def config = ConfigurationHolder.config
        def serverURL = config.grails.serverURL
        def secureServerURL = config.grails.secureServerURL

        urlToMakeSSL.replace("${serverURL}","${secureServerURL}")
    }

    def static getServerName = {request ->
        def config = ConfigurationHolder.config
        def s = request.requestURL.substring(0, request.requestURL.length()-request.servletPath.length())      
        def c = s.substring(s.lastIndexOf("/"))
        def u = new URL(s)
        u.getHost()
    }


    def static getContext = {request ->     
        def config = ConfigurationHolder.config
        def s = request.requestURL.substring(0, request.requestURL.length()-request.servletPath.length())
        def cs = config.grails.serverURL
        
        s.substring(s.lastIndexOf("/")) //return only context
    }

    def static getServerAndContext = {request ->
        def config = ConfigurationHolder.config
        def s = request.requestURL.substring(0, request.requestURL.length()-request.servletPath.length())
        def cs = config.grails.serverURL
        def c = s.substring(s.lastIndexOf("/"))

        println "Server And Context from config file: set ${cs}"
        println "Request servlet path: ${request.servletPath}"
        println "Request with context: ${s}"
        println "context only: ${c}"

        if(cs)
        cs.endsWith("/")?cs.substring(0,cs.length()-1)+c:cs+c
        else
        s
    }

    def static getLocale = {request ->
        //  println "${org.springframework.web.servlet.support.RequestContextUtils.getLocaleResolver(request).resolveLocale(request).getDisplayName()} ${org.springframework.web.servlet.support.RequestContextUtils.getLocaleResolver(request).resolveLocale(request).getLanguage()}"
        org.springframework.web.servlet.support.RequestContextUtils.getLocaleResolver(request).resolveLocale(request).getLanguage()
    }
    
    public static byte[] readUrlBytes(String address) {

        /// log.debug "loading pdf... "+address

        byte[] byteReturn = null;
        URL theURL = null
        InputStream is = null
        try {

            def out = new ByteArrayOutputStream()
            out << new URL(address).openStream()
            byteReturn = out.toByteArray()
            /**
            theURL = new URL(address);
            is = theURL.openStream();

            byteReturn = [].with{bytes-> is.eachByte{bytes <<  it}; bytes }
             */
            //log.debug "----------------------->byteReturn.length"+byteReturn.length

            /**def fos= new FileOutputStream('/tmp/output.pdf')
            fos.write(byteReturn);
            fos.close()*/

        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if (is != null) {
                    is.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        byteReturn;
    }


    def byteArrayFromUrl= { URL url ->

        //def len = request.getContentLength()
        def inputStream = url.openConnection().getInputStream()

        try {
            def byte[] data = new byte[len]
            def offset = 0
            while (offset < len) {
                def read = inputStream.read(data, offset, data.length - offset);
                if (read < 0) {
                    break;
                }
                offset += read;
            }
            if (offset < len) {
                throw new IOException("Read ${offset} bytes; expected ${len}")
            }

            return data;
        } finally {
            inputStream.close();
        }
    }

    def static download(address)
    {
        def out = new ByteArrayOutputStream()
        out << new URL(address).openStream()
        out.toByteArray()

    }
	
}

