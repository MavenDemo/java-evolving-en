package animalsniffer;

public class Main
{

    public static void main( String[] args )
    {
        // String.join is added in J8
        System.out.println( "\u001B[96m" + String.join( "_", args ) + "\u001B[0m" );
    }
}
