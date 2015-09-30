package toolchains;

import java.util.concurrent.ConcurrentHashMap;

import bytecode.Display;

public class Main extends Display
{
    public static void main( String... args )
        throws Exception
    {
        new Main().run();

        callMap();
    }

    // class added to JDK 5
    private static final ConcurrentHashMap<?, ?> MAP = new ConcurrentHashMap<Object, Object>();

    public static void callMap()
    {
        MAP.keySet(); // Java 8 coerce: aggressive optimization done by compiler...
    }
}
