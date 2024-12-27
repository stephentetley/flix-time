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

    import java.time.format.{DecimalStyle => JDecimalStyle}
    import java.lang.{Object}

    /// Immutable
    ///
    pub enum DecimalStyle(JDecimalStyle)


    instance ToString[DecimalStyle] {
        pub def toString(x: DecimalStyle): String =
            let DecimalStyle(x1) = x;
            unsafe x1.toString()
    }
    
    instance Eq[DecimalStyle] {
        pub def eq(x: DecimalStyle, y: DecimalStyle): Bool =
            let DecimalStyle(x1) = x;
            let DecimalStyle(y1) = y;
            unsafe x1.equals(y1)
    }

    instance Hash[DecimalStyle] {
        pub def hash(x: DecimalStyle): Int32 = 
            let DecimalStyle(x1) = x;
            unsafe x1.hashCode()
    } 
    
}

mod Time.Format.DecimalStyle {

    use Locale.{Locale}

    use Time.Format.DecimalStyle
    use Time.Format.DecimalStyle.{DecimalStyle}
    
    import java.time.format.{DecimalStyle => JDecimalStyle}
    import java.util.{Locale => JLocale, Set => JSet}

    /// ## Unwrap

    pub def getDecimalStyle(x: DecimalStyle): JDecimalStyle = 
        let DecimalStyle(x1) = x;
        x1


    /// ## "abstract constructors" (e.g. `standard`)

    pub def standard(): DecimalStyle = DecimalStyle(unsafe JDecimalStyle.STANDARD)

    pub def decimalStyle(loc: Locale): DecimalStyle \ IO = 
        let Locale(loc1) = loc;
        let ans = JDecimalStyle.of(loc1);
        DecimalStyle(ans)

    pub def decimalStyleWithDefaultLocale(): DecimalStyle \ IO = 
        let ans = JDecimalStyle.ofDefaultLocale();
        DecimalStyle(ans)


    /// ## DecimalStyle functions

    pub def getAvailableLocales(): List[Locale] \ IO =
        let locs = JDecimalStyle.getAvailableLocales();
        let locs1: List[JLocale] = fromSetAsList(locs);
        List.map(l -> Locale(l), locs1)


    /// Candidate for Adaptor...
    def fromSetAsList(l: JSet): List[a] = region rc {
        let proxy: Proxy[a] = Proxy.Proxy;
        let jiter = unsafe l.iterator();
        let iter = Adaptor.fromIterator(rc, proxy, jiter);
        Iterator.toList(iter)
    }


    // Note - should the Locale module provide a function marshal and unmarshal functions
    // so a client doesn't have to use: `o -> Locale(o as ##java.util.Locale)` ?

    /// Getters and Setters

    pub def getDecimalSeparator(x: DecimalStyle): Char = 
        let DecimalStyle(x1) = x;
        unsafe x1.getDecimalSeparator()


    pub def withDecimalSeparator(sep: Char, x: DecimalStyle): DecimalStyle = 
        let DecimalStyle(x1) = x;
        let ans = unsafe x1.withDecimalSeparator(sep);
        DecimalStyle(ans)

    pub def getNegativeSign(x: DecimalStyle): Char = 
        let DecimalStyle(x1) = x;
        unsafe x1.getNegativeSign()

    pub def withNegativeSign(sign: Char, x: DecimalStyle): DecimalStyle = 
        let DecimalStyle(x1) = x;
        let ans = unsafe x1.withNegativeSign(sign);
        DecimalStyle(ans)

    pub def getPositiveSign(x: DecimalStyle): Char = 
        let DecimalStyle(x1) = x;
        unsafe x1.getPositiveSign()

    pub def withPositiveSign(sign: Char, x: DecimalStyle): DecimalStyle = 
        let DecimalStyle(x1) = x;
        let ans = unsafe x1.withPositiveSign(sign);
        DecimalStyle(ans)

    pub def getZeroDigit(x: DecimalStyle): Char = 
        let DecimalStyle(x1) = x;
        unsafe x1.getZeroDigit()

    pub def withZeroDigit(digit: Char, x: DecimalStyle): DecimalStyle = 
        let DecimalStyle(x1) = x;
        let ans = unsafe x1.withZeroDigit(digit);
        DecimalStyle(ans)

}
