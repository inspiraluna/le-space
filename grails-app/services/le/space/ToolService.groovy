package le.space
import org.springframework.context.i18n.LocaleContextHolder as LCH
import java.text.DecimalFormatSymbols
import java.text.DecimalFormat

class ToolService {

    static transactional = false

    def messageSource
    def persistContractAgain(Long id){
        log.debug "loading contract with id ${id}"
        if(id){
            def contract = Contract.get(id)
            contract.save()
        }
    }

    def formatNumber(Double number){
        def numberFormat = new DecimalFormat("#,##0.00", new DecimalFormatSymbols(LCH.getLocale()))
        numberFormat.format(number)
        //"${g.formatNumber(number: number, format: '€ #,##0.00')}"
        //number
    }
    
    def getMessage(String message) {
        try{
            "${messageSource.getMessage(message, [this] as Object[], LCH.getLocale())}"}
        catch(Exception ex){
            return message
        }
    }
}
