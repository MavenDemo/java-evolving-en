package toolchains;

import java.util.concurrent.ConcurrentHashMap;

public class Main
{
    public static void main( String[] args )
    {
        System.out.println( "\u001B[96mtoolchains.Main running on JVM version \u001B[1m"
            + String.class.getPackage().getSpecificationVersion() + "\u001B[0m" );

        callMap();
    }

    // classe ajoutée au JDK 5
    private static final ConcurrentHashMap<?, ?> MAP = new ConcurrentHashMap<Object, Object>();

    public static void callMap()
    {
        MAP.keySet(); // Java 8 coerce: optimisation aggressive faite par le compilateur...
    }
}
