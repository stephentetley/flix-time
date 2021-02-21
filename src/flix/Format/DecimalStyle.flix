/*
 * Copyright 2021 Stephen Tetley
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

namespace Time/Format {

    pub opaque type DecimalStyle = ##java.time.format.DecimalStyle
    
    instance ToString[DecimalStyle] {
        def toString(x: DecimalStyle): String =
            import java.time.format.DecimalStyle.toString();
            let DecimalStyle(x1) = x;
            toString(x1) as & Pure
    }
    
    instance Hash[DecimalStyle] {
        def hash(x: DecimalStyle): Int32 = Time/Format/DecimalStyle.hashCode(x)
    } 
    

}

namespace Time/Format/DecimalStyle {

    use Time/Format.DecimalStyle;
    use Time/Format.DecimalStyle.{DecimalStyle};

    pub def standard(): DecimalStyle =
        import get java.time.format.DecimalStyle:STANDARD as getSTANDARD;
        DecimalStyle(getSTANDARD()) as & Pure

    pub def new(): DecimalStyle = 
        import java.time.format.DecimalStyle:ofDefaultLocale();
        DecimalStyle(ofDefaultLocale()) as & Pure

    pub def hashCode(x: DecimalStyle): Int32 = 
        import java.time.format.DecimalStyle.hashCode();
        let DecimalStyle(x1) = x;
        hashCode(x1) as & Pure
}