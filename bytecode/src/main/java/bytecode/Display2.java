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

import org.apache.lucene.util.IOUtils;

/**
 * Launch Display then runs code from a library compiled with JDK 7.
 */
public class Display2 extends Display
{
    public static void main( String... args )
        throws Exception
    {
        new Display2().run();
    }

    public void run()
       throws Exception
    {
        super.run();

        callJava7Library();
    }

    private static void callJava7Library()
        throws Exception
    {
        IOUtils.reThrow( null );
    }
}
