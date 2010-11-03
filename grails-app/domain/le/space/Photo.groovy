package le.space

class Photo {

    String filename
    String directory
    String title
    String pageId
    
        //static transients = [ "filename","directory",]

    static constraints = {
        filename(nullable:false,blank:false);
        directory(nullable:false,blank:false)
        title(nullable:false,blank:false)
        pageId(nullable:false,blank:false)
    }
}
