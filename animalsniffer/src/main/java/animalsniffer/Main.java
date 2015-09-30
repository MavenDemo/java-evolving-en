package animalsniffer;

import bytecode.Display;

/**
 * Launch Display then runs code depending on JDK 7 API.
 */
public class Main extends Display
{
    public static void main( String... args )
        throws Exception
    {
        new Main().run();

        callJava7API( args );
    }

    private static void callJava7API( String... args )
        throws Exception
    {
        // String.join is added in J8
        System.out.println( esc( "96" ) + String.join( "_", args ) + esc( "0" ) );
    }
}
