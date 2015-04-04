package toolchains;

import java.util.concurrent.ConcurrentHashMap;

public class Main
{
    public static void main( String[] args )
    {
        System.out.println( "toolchains.Main running on JVM with implementation version = "
            + String.class.getPackage().getImplementationVersion() );

        callMap();
    }

    // classe ajoutée au JDK 5
    private static final ConcurrentHashMap<?, ?> MAP = new ConcurrentHashMap<Object, Object>();

    public static void callMap()
    {
        MAP.keySet(); // Java 8 coerce
    }
}
