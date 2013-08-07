public class Server {
    public static void main(String[] args) {
        while (true){
            try {
                System.out.println("I need to make sure I'm still alive");
                Thread.sleep(1000);
            } catch(InterruptedException ex) {
                Thread.currentThread().interrupt();
            }
        }
    }
}
