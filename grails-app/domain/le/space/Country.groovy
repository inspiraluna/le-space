package le.space

class Country {
    
    String name
    boolean isEU = false
           
    static constraints = {
        isEU(nullable:true,blank:true)
    }
   String toString(){
        "${name}"
    }
}
