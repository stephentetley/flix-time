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

mod Time.Format {

    use Time.Format.DecimalStyle
    use Time.Format.DecimalStyle.{DecimalStyle}

    /// Immutable
    ///
    pub enum DecimalStyle(##java.time.format.DecimalStyle)


    instance ToString[DecimalStyle] {
        pub def toString(x: DecimalStyle): String =
            import java.time.format.DecimalStyle.toString(): String \ {};
            let DecimalStyle(x1) = x;
            toString(x1)
    }
    
    instance Eq[DecimalStyle] {
        pub def eq(x: DecimalStyle, y: DecimalStyle): Bool =
            import java.time.format.DecimalStyle.equals(##java.lang.Object): Bool \ {};
            let DecimalStyle(x1) = x;
            let DecimalStyle(y1) = y;
            equals(x1, checked_cast(y1))
    }

    instance Hash[DecimalStyle] {
        pub def hash(x: DecimalStyle): Int32 = 
            import java.time.format.DecimalStyle.hashCode(): Int32 \ {};
            let DecimalStyle(x1) = x;
            hashCode(x1)
    } 
    
}

mod Time.Format.DecimalStyle {

    use Locale.{Locale}

    use Time.Format.DecimalStyle
    use Time.Format.DecimalStyle.{DecimalStyle}

    /// ## Unwrap

    pub def getDecimalStyle(x: DecimalStyle): ##java.time.format.DecimalStyle = 
        let DecimalStyle(x1) = x;
        x1


    /// ## "abstract constructors" (e.g. `standard`)

    pub def standard(): DecimalStyle =
        import static java_get_field java.time.format.DecimalStyle.STANDARD: ##java.time.format.DecimalStyle \ {} as get_STANDARD;
        DecimalStyle(get_STANDARD())

    pub def decimalStyle(loc: Locale): DecimalStyle \ IO = 
        import static java.time.format.DecimalStyle.of(##java.util.Locale): ##java.time.format.DecimalStyle \ IO;
        let Locale(loc1) = loc;
        DecimalStyle(of(loc1))

    pub def decimalStyleWithDefaultLocale(): DecimalStyle \ IO = 
        import static java.time.format.DecimalStyle.ofDefaultLocale(): ##java.time.format.DecimalStyle \ IO;
        DecimalStyle(ofDefaultLocale())


    /// ## DecimalStyle functions

    pub def getAvailableLocales(): List[Locale] =
        import static java.time.format.DecimalStyle.getAvailableLocales(): ##java.util.Set \ {};
        let locs = getAvailableLocales();
        let locs1: List[##java.util.Locale] = fromSetAsList(locs);
        List.map(l -> Locale(l), locs1)


    /// Candidate for Adaptor...
    def fromSetAsList(l: ##java.util.Set): List[a] = region rc {
        import java.util.Set.iterator(): ##java.util.Iterator \ rc;
        iterator(l) |> Adaptor.fromIterator(rc, Proxy.Proxy: Proxy[a]) |> Iterator.toList
    }


    // Note - should the Locale module provide a function marshal and unmarshal functions
    // so a client doesn't have to use: `o -> Locale(o as ##java.util.Locale)` ?

    /// ## Getters and Setters

    pub def getDecimalSeparator(x: DecimalStyle): Char = 
        import java.time.format.DecimalStyle.getDecimalSeparator(): Char \ {};
        getDecimalStyle(x) |> getDecimalSeparator


    pub def withDecimalSeparator(sep: Char, x: DecimalStyle): DecimalStyle = 
        import java.time.format.DecimalStyle.withDecimalSeparator(Char): ##java.time.format.DecimalStyle \ {};
        let DecimalStyle(x1) = x;
        withDecimalSeparator(x1, sep) |> DecimalStyle

    pub def getNegativeSign(x: DecimalStyle): Char = 
        import java.time.format.DecimalStyle.getNegativeSign(): Char \ {};
        getDecimalStyle(x) |> getNegativeSign

    pub def withNegativeSign(sign: Char, x: DecimalStyle): DecimalStyle = 
        import java.time.format.DecimalStyle.withNegativeSign(Char): ##java.time.format.DecimalStyle \ {};
        let DecimalStyle(x1) = x;
        withNegativeSign(x1, sign) |> DecimalStyle

    pub def getPositiveSign(x: DecimalStyle): Char = 
        import java.time.format.DecimalStyle.getPositiveSign(): Char \ {};
        getDecimalStyle(x) |> getPositiveSign

    pub def withPositiveSign(sign: Char, x: DecimalStyle): DecimalStyle = 
        import java.time.format.DecimalStyle.withPositiveSign(Char): ##java.time.format.DecimalStyle \ {};
        let DecimalStyle(x1) = x;
        withPositiveSign(x1, sign) |> DecimalStyle

    pub def getZeroDigit(x: DecimalStyle): Char = 
        import java.time.format.DecimalStyle.getZeroDigit(): Char \ {};
        getDecimalStyle(x) |> getZeroDigit

    pub def withZeroDigit(digit: Char, x: DecimalStyle): DecimalStyle = 
        import java.time.format.DecimalStyle.withZeroDigit(Char): ##java.time.format.DecimalStyle \ {};
        let DecimalStyle(x1) = x;
        withZeroDigit(x1, digit) |> DecimalStyle

}
