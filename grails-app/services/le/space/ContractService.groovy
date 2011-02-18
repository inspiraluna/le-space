package le.space

class ContractService {

    static transactional = true

    def getContractsOfUsername(String username) {
        def hql="select co from le.space.Contract  co "
        hql+="inner join co.customer cu "
        hql+="inner join cu.shiroUsers u "
        hql+="WHERE u.username=:username "
        hql+="ORDER BY co.contractStart desc"

        def hparams = [username:username]

        Contract.executeQuery(hql,hparams)
    }

    def getContractsOfCustomer(Customer cu) {
        def hql="select co from le.space.Contract  co "
        hql+="inner join co.customer cu "
        hql+="WHERE cu=:customer "
        hql+="ORDER BY co.contractStart desc"

        def hparams = [customer:cu]

        Contract.executeQuery(hql,hparams)
    }

}
