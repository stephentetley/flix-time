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
        pub def toString(x: DecimalStyle): String =
            import java.time.format.DecimalStyle.toString(): String & Pure;
            let DecimalStyle(x1) = x;
            toString(x1)
    }
    
    instance Eq[DecimalStyle] {
        pub def eq(x: DecimalStyle, y: DecimalStyle): Bool = Time/Format/DecimalStyle.equals(x, y)
    }

    instance Hash[DecimalStyle] {
        pub def hash(x: DecimalStyle): Int32 = Time/Format/DecimalStyle.hashCode(x)
    } 
    

}

namespace Time/Format/DecimalStyle {

    use FlixSandbox/I18n.Locale;
    use FlixSandbox/I18n.Locale.{Locale};

    use Time/Format.DecimalStyle;
    use Time/Format.DecimalStyle.{DecimalStyle};

    pub def getDecimalStyle(x: DecimalStyle): ##java.time.format.DecimalStyle = 
        let DecimalStyle(x1) = x;
        x1

    pub def equals(x: DecimalStyle, y: DecimalStyle): Bool =
        import java.time.format.DecimalStyle.equals(##java.lang.Object): Bool & Pure;
        let DecimalStyle(x1) = x;
        let DecimalStyle(y1) = y;
        equals(x1, y1 as ##java.lang.Object)

    pub def standard(): DecimalStyle =
        import static get java.time.format.DecimalStyle.STANDARD: ##java.time.format.DecimalStyle & Pure as get_STANDARD;
        DecimalStyle(get_STANDARD())

    pub def of(loc: Locale): DecimalStyle & Impure = 
        import static java.time.format.DecimalStyle.of(##java.util.Locale): ##java.time.format.DecimalStyle & Impure;
        let Locale(loc1) = loc;
        DecimalStyle(of(loc1))

    pub def ofDefaultLocale(): DecimalStyle & Impure = 
        import static java.time.format.DecimalStyle.ofDefaultLocale(): ##java.time.format.DecimalStyle & Impure;
        DecimalStyle(ofDefaultLocale())

    pub def hashCode(x: DecimalStyle): Int32 = 
        import java.time.format.DecimalStyle.hashCode(): Int32 & Pure;
        let DecimalStyle(x1) = x;
        hashCode(x1)

    pub def getAvailableLocales(): List[Locale] =
        import static java.time.format.DecimalStyle.getAvailableLocales(): ##java.util.Set & Pure;
        let js = getAvailableLocales();
        FlixSandbox/Marshal.unmarshalSetToList(o -> Locale(o as ##java.util.Locale), js)

    // Note - should the Locale module provide a function marshal and unmarshal functions
    // so a cleint doesn't have to use: `o -> Locale(o as ##java.util.Locale)` ?



    pub def getDecimalSeparator(x: DecimalStyle): Char = 
        import java.time.format.DecimalStyle.getDecimalSeparator(): Char & Pure;
        getDecimalStyle(x) |> getDecimalSeparator


    pub def withDecimalSeparator(sep: Char, x: DecimalStyle): Char = 
        import java.time.format.DecimalStyle.withDecimalSeparator(Char): Char & Pure;
        let DecimalStyle(x1) = x;
        withDecimalSeparator(x1, sep)

    pub def getNegativeSign(x: DecimalStyle): Char = 
        import java.time.format.DecimalStyle.getNegativeSign(): Char & Pure;
        getDecimalStyle(x) |> getNegativeSign

    pub def withNegativeSign(sign: Char, x: DecimalStyle): Char = 
        import java.time.format.DecimalStyle.withNegativeSign(Char): Char & Pure;
        let DecimalStyle(x1) = x;
        withNegativeSign(x1, sign)

    pub def getPositiveSign(x: DecimalStyle): Char = 
        import java.time.format.DecimalStyle.getPositiveSign(): Char & Pure;
        getDecimalStyle(x) |> getPositiveSign

    pub def withPositiveSign(sign: Char, x: DecimalStyle): Char = 
        import java.time.format.DecimalStyle.withPositiveSign(Char): Char & Pure;
        let DecimalStyle(x1) = x;
        withPositiveSign(x1, sign)

    pub def getZeroDigit(x: DecimalStyle): Char = 
        import java.time.format.DecimalStyle.getZeroDigit(): Char & Pure;
        getDecimalStyle(x) |> getZeroDigit

    pub def withZeroDigit(digit: Char, x: DecimalStyle): Char = 
        import java.time.format.DecimalStyle.withZeroDigit(Char): Char & Pure;
        let DecimalStyle(x1) = x;
        withZeroDigit(x1, digit)

}
