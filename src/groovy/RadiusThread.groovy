import org.tinyradius.util.RadiusServer


/**
 * Radius Thread
 * @author nico
 */
class RadiusThread implements Runnable{


    RadiusThread() {

    }

    /**
     * Start the Radius Server ....
     */
    public void run() {
        
        while(true){

            try{
                def LeSpaceRadiusServer server = new LeSpaceRadiusServer()
                System.out.println("le space radius server started")
                server.start(true, true)

            }catch(Exception ex){
                System.out.println("radius server threw an excpetion - restarting");
            }
        }
        server.stop()
    }

    public static void main(String[] args) {

        RadiusThread bt = new RadiusThread();
        new Thread(bt).start();
    
    }

	
}

