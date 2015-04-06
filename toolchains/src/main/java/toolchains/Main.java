package toolchains;

import java.util.concurrent.ConcurrentHashMap;

public class Main
{
    public static String esc( String esc )
    {
        return "\u001B[" + esc + "m";
    }

    public static void main( String[] args )
    {
        System.out.println( esc( "96" ) + "toolchains.Main running on " + esc( "1" ) + "JVM "
            + String.class.getPackage().getSpecificationVersion() + esc( "0" ) );

        callMap();
    }

    // classe ajoutée au JDK 5
    private static final ConcurrentHashMap<?, ?> MAP = new ConcurrentHashMap<Object, Object>();

    public static void callMap()
    {
        MAP.keySet(); // Java 8 coerce: optimisation aggressive faite par le compilateur...
    }
}
