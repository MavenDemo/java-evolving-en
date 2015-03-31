package toolchains;

public class Main
{

    public static void main( String[] args )
    {
        System.out.println( "toolchains.Main running on JVM with implementation version = "
            + String.class.getPackage().getImplementationVersion() );
    }

}
