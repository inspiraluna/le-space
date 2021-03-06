package le.space

import org.joda.time.*
import org.joda.time.format.*

class PaymentService {

    static transactional = true

    def calculatePayments(Contract contract){

        try{
            def sum = Contract.executeQuery("select sum(amount) from le.space.Payment p where p.customer.id=:id",[id:contract.customer.id])
            def amountPaid = (sum==null || sum[0]==null)?0:sum[0]

            log.debug "amountPaid (all payments) of customer with id: ${contract.customer.id} ${contract.customer.amountPaid}"

            //Collect all contracts
            def amountTotal = 0
            log.debug "find contracts of customer ${contract.customer}"
            def l = Contract.findAllByCustomer(contract.customer)
            l.each{
                //if contract entends automatically calculate all months gone sofar and mulitplay with amountGross for amountTotal!
                if(it.autoExtend){
                    int monthsGone = Months.monthsBetween(
                        new DateTime(it.contractStart).withTime(0,0,0,0),
                        it.cancelationDate?new DateTime(it.cancelationDate).withTime(0,0,0,0):new DateTime().withTime(23,59,59,999)).getMonths()
                    amountTotal += it.amountGross*(monthsGone)
                }
                amountTotal += it.amountGross
                log.debug "found contract ${it} - new amountTotal ${amountTotal} "
            }

            def amountDue = amountTotal - amountPaid

            //automatisch verlängernde Verträge heraussuchen und anzahl der noch nicht bezahlten Monate heraussuchen und mit Vertragspreis multiplizieren.
            boolean autoExtendPaid = false

            //log.debug "autoExtend:${autoExtend} amountPaid:${amountPaid} monthsGone:${monthsGone} amountGross*monthsGone:${amountGross*monthsGone}"
            if(contract.autoExtend && amountPaid >=amountTotal)
            autoExtendPaid = true

            def paid

            if((!contract.autoExtend && amountPaid >=amountTotal) || (contract.autoExtend && autoExtendPaid))
            paid = true
            else
            paid = false

            boolean tmpValid = false

            if(contract.autoExtend && autoExtendPaid && new DateTime(contract.cancelationDate).withTime(0,0,0,0).toDate().getTime()>=new Date().getTime()
                && new DateTime(contract.contractStart).withTime(0,0,0,0).toDate().getTime()<=new Date().getTime() && contract.allowedLoginDaysLeft>-1)
            tmpValid = true


            if(!contract.autoExtend && contract.paid && new DateTime(contract.contractStart).withTime(0,0,0,0).toDate().getTime()<=new Date().getTime()
                && new DateTime(contract.contractEnd).withTime(23,59,59,999).toDate().getTime()>=new Date().getTime() && contract.allowedLoginDaysLeft>-1)
            tmpValid  = true

            if(tmpValid!=contract.valid || paid!=contract.paid ||
                contract.customer.amountDue != amountDue || contract.customer.amountPaid!=amountPaid ||
                contract.customer.amountTotal != amountTotal){
                
                log.debug "saving contract ${contract.id} because payment calculation changed... amountDue:${amountDue} amountPaid:${amountPaid} amountTotal:${amountTotal}"
                // def contract2 = Contract.get(contract.id)
                def customer = contract.customer
                customer.amountDue = amountDue
                customer.amountPaid = amountPaid
                customer.amountTotal = amountTotal

                contract.valid = tmpValid
                contract.paid = paid
                contract.calculateAmounts()

                def contractNew = contract.save(flush:true)
                def customerNew = customer.save(flush:true)

                contractNew.errors.each{
                    log.debug "${it}"
                }
                log.debug "${contractNew} saved.."
            }
        }
        catch(Exception ex){
            log.debug "problem with calculation of contract id ${contract.id} ${ex}"
            ex.printStackTrace()
        }
    }
}
