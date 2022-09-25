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
            equals(x1, y1 as ##java.lang.Object)
    }

    instance Hash[DecimalStyle] {
        pub def hash(x: DecimalStyle): Int32 = 
            import java.time.format.DecimalStyle.hashCode(): Int32 \ {};
            let DecimalStyle(x1) = x;
            hashCode(x1)
    } 
    
}

namespace Time/Format/DecimalStyle {

    use Basis/I18n.Locale;
    use Basis/I18n.Locale.{Locale};

    use Time/Format.DecimalStyle;
    use Time/Format.DecimalStyle.{DecimalStyle};

    /// ## Unwrap

    pub def getDecimalStyle(x: DecimalStyle): ##java.time.format.DecimalStyle = 
        let DecimalStyle(x1) = x;
        x1


    /// ## "abstract constructors" (e.g. `standard`)

    pub def standard(): DecimalStyle =
        import static get java.time.format.DecimalStyle.STANDARD: ##java.time.format.DecimalStyle \ {} as get_STANDARD;
        DecimalStyle(get_STANDARD())

    pub def decimalStyle(loc: Locale): DecimalStyle \ IO = 
        import static java.time.format.DecimalStyle.of(##java.util.Locale): ##java.time.format.DecimalStyle \ IO;
        let loc1 = Interop/Util/Locale.getHH(loc);
        DecimalStyle(of(loc1))

    pub def decimalStyleWithDefaultLocale(): DecimalStyle \ IO = 
        import static java.time.format.DecimalStyle.ofDefaultLocale(): ##java.time.format.DecimalStyle \ IO;
        DecimalStyle(ofDefaultLocale())


    /// ## DecimalStyle functions

    pub def getAvailableLocales(): List[Locale] = region r {
        import static java.time.format.DecimalStyle.getAvailableLocales(): ##java.util.Set \ {};
        getAvailableLocales() 
            |> Interop/Util/SetZ.wrapHH(r)
            |> Interop/Util/SetZ.toFlixList
    }

    // Note - should the Locale module provide a function marshal and unmarshal functions
    // so a client doesn't have to use: `o -> Locale(o as ##java.util.Locale)` ?

    /// ## Getters and Setters

    pub def getDecimalSeparator(x: DecimalStyle): Char = 
        import java.time.format.DecimalStyle.getDecimalSeparator(): Char \ {};
        getDecimalStyle(x) |> getDecimalSeparator


    pub def setDecimalSeparator(sep: Char, x: DecimalStyle): DecimalStyle = 
        import java.time.format.DecimalStyle.withDecimalSeparator(Char): ##java.time.format.DecimalStyle \ {};
        let DecimalStyle(x1) = x;
        withDecimalSeparator(x1, sep) |> DecimalStyle

    pub def getNegativeSign(x: DecimalStyle): Char = 
        import java.time.format.DecimalStyle.getNegativeSign(): Char \ {};
        getDecimalStyle(x) |> getNegativeSign

    pub def setNegativeSign(sign: Char, x: DecimalStyle): DecimalStyle = 
        import java.time.format.DecimalStyle.withNegativeSign(Char): ##java.time.format.DecimalStyle \ {};
        let DecimalStyle(x1) = x;
        withNegativeSign(x1, sign) |> DecimalStyle

    pub def getPositiveSign(x: DecimalStyle): Char = 
        import java.time.format.DecimalStyle.getPositiveSign(): Char \ {};
        getDecimalStyle(x) |> getPositiveSign

    pub def setPositiveSign(sign: Char, x: DecimalStyle): DecimalStyle = 
        import java.time.format.DecimalStyle.withPositiveSign(Char): ##java.time.format.DecimalStyle \ {};
        let DecimalStyle(x1) = x;
        withPositiveSign(x1, sign) |> DecimalStyle

    pub def getZeroDigit(x: DecimalStyle): Char = 
        import java.time.format.DecimalStyle.getZeroDigit(): Char \ {};
        getDecimalStyle(x) |> getZeroDigit

    pub def setZeroDigit(digit: Char, x: DecimalStyle): DecimalStyle = 
        import java.time.format.DecimalStyle.withZeroDigit(Char): ##java.time.format.DecimalStyle \ {};
        let DecimalStyle(x1) = x;
        withZeroDigit(x1, digit) |> DecimalStyle

}
