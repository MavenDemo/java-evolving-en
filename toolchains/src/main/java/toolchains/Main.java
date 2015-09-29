package toolchains;

import java.io.IOException;
import java.io.InputStream;
import java.util.concurrent.ConcurrentHashMap;

public class Main
{
    public static String esc( String esc )
    {
        return "\u001B[" + esc + "m";
    }

    public static void main( String[] args )
        throws Exception
    {
        int version = display( Main.class );
        Package p = Object.class.getPackage();
        System.out.println( esc( "1" ) + "Bytecode Java " + version + " exécuté sur une JVM " + p.getSpecificationVersion()
            + esc( "0" ) );

        callMap();
    }

    // classe ajoutée au JDK 5
    private static final ConcurrentHashMap<?, ?> MAP = new ConcurrentHashMap<Object, Object>();

    public static void callMap()
    {
        MAP.keySet(); // Java 8 coerce: optimisation aggressive faite par le compilateur...
    }

    public static int display( Class<?> clazz )
        throws IOException
    {
        System.out.print( esc( "96" ) + clazz.getName() + ".class -> " );

        InputStream in = clazz.getResourceAsStream( "/" + clazz.getName().replace( '.', '/' ) + ".class" );
        int version = 0;
        for ( int i = 0; i < 4; i++ )
        {
            System.out.print( String.format( "%02x%02x ", in.read(), version = in.read() ) );
        }
        in.close();
        System.out.println( "..." );

        System.out.println( String.format( "             version majeure = 0x%02x = %d = Java %d", version, version,
                                           version - 44 ) );

        return version - 44;
    }
}
