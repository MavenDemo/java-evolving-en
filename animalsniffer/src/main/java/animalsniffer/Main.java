package animalsniffer;

import bytecode.Display;

/**
 * Lance Display puis exécute du code dépendant d'une API du JDK 7.
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
