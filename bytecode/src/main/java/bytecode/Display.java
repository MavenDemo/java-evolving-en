package bytecode;

/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

import java.io.IOException;
import java.io.InputStream;

/**
 * Affiche la version du bytecode de la classe compilée qui tourne.
 */
public class Display
{

    private static void display( Class<?> clazz )
       throws IOException
    {
        System.out.print( clazz.getName() + " -> " );
        InputStream in = clazz.getResourceAsStream( "/" + clazz.getName().replace( '.', '/' ) + ".class" );

        int version = 0;
        for ( int i = 0; i < 4; i++ )
        {
            System.out.print( String.format( "%02x%02x ", in.read(), version = in.read() ) );
        }

        System.out.println( String.format( " : 0x%02x = %d = Java %d", version, version, version - 44 ) );

        in.close();
    }

    public static void main( String[] args )
       throws IOException
    {
        display( Display.class );
        display( Object.class );
    }
}
