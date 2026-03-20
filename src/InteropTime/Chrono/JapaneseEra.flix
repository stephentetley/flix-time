/*
 * Copyright 2020 Stephen Tetley
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



pub mod InteropTime.Chrono.JapaneseEra {

    use InteropTime.Chrono.JapaneseEra.JapaneseEra
    use InteropTime.Chrono.JapaneseEra.JapaneseEra.{JapaneseEra}

    use InteropTime.Format.TextStyle.TextStyle

    use InteropLocale.Locale.Locale

    import java.time.chrono.{JapaneseEra => JJapaneseEra}
    import java.time.chrono.{Era => JEra}
    import java.lang.{Object }

    ///
    /// A wrapper around java.time.chrono.JapaneseEra.
    ///
    /// In Java, JapaneseEra is a class not an enum unlike HijrahEra
    ///
    pub enum JapaneseEra(JJapaneseEra)

    ///
    /// Returns the given JapaneseEra `x` as a String.
    ///
    instance ToString[JapaneseEra] {
        pub def toString(x: JapaneseEra): String =
            let JapaneseEra(x1) = x;
            unsafe IO { x1.toString()  }
    }

    instance Eq[JapaneseEra] {
        pub def eq(x: JapaneseEra, y: JapaneseEra): Bool = InteropTime.Chrono.JapaneseEra.equals(x, y)
    }

    instance Hash[JapaneseEra] {
        pub def hash(x: JapaneseEra): Int32 = InteropTime.Chrono.JapaneseEra.hashCode(x)
    }



    pub def japaneseEra(japaneseEra: {japaneseEra = Int32 }): Option[JapaneseEra] =
        Result.tryCatch(_ -> {
            JapaneseEra(unsafe IO { JJapaneseEra.of(japaneseEra#japaneseEra)}) 
        }) |> Result.toOption

    pub def heisei(): JapaneseEra = JapaneseEra(unsafe IO { JJapaneseEra.HEISEI}) 

    pub def meiji(): JapaneseEra = JapaneseEra(unsafe IO { JJapaneseEra.MEIJI}) 

    // Java 13

    pub def reiwa(): JapaneseEra = JapaneseEra(unsafe IO { JJapaneseEra.REIWA })

    pub def showa(): JapaneseEra = JapaneseEra(unsafe IO { JJapaneseEra.SHOWA })

    pub def taisho(): JapaneseEra = JapaneseEra(unsafe IO { JJapaneseEra.TAISHO })

    pub def getValue(x: JapaneseEra): Int32 = 
        let JapaneseEra(x1) = x;
        unsafe IO { x1.getValue() }

    pub def equals(x: JapaneseEra, y: JapaneseEra): Bool = 
        let JapaneseEra(x1) = x;
        let JapaneseEra(y1) = y;
        unsafe IO { x1.equals(y1) }

    pub def hashCode(x: JapaneseEra): Int32 = 
        let JapaneseEra(x1) = x;
        unsafe IO { x1.hashCode() }


    pub def getDisplayName(style: TextStyle, locale: Locale, x: JapaneseEra): String = 
        let JapaneseEra(x1) = x;
        let style1 = InteropTime.Format.TextStyle.marshalTextStyle(style);
        let Locale.Locale(locale1) = locale;
        unsafe IO { x1.getDisplayName(style1, locale1) }



    // NOTE - maybe this should return Option [/ Result] ?

    // pub def adjustInto(t: a, x: JapaneseEra): a with Temporal[a] = 
    //     import java.time.chrono.Era.adjustInto(##java.time.temporal.Temporal): ##java.time.temporal.Temporal \ {};
    //     let x1 = getJapaneseEra(x) as ##java.time.chrono.Era;
    //     let t1 = InteropTime.Temporal.Temporal.marshalToNativeTemporal(t);
    //     InteropTime.Temporal.Temporal.unmarshalFromNativeTemporal(adjustInto(x1, t1))



    // pub def get(t: a, x: JapaneseEra): Int32 with TemporalField[a] = 
    //     import java.time.chrono.Era.get(##java.time.temporal.TemporalField): Int32 \ {};
    //     let x1 = getJapaneseEra(x) as ##java.time.chrono.Era;
    //     let t1 = InteropTime.Temporal.TemporalField.marshalToNativeTemporalField(t);
    //     get(x1, t1)

    // pub def getLong(t: a, x: JapaneseEra): Int64 with TemporalField[a] = 
    //     import java.time.chrono.Era.getLong(##java.time.temporal.TemporalField): Int64 \ {};
    //     let x1 = getJapaneseEra(x) as ##java.time.chrono.Era;
    //     let t1 = InteropTime.Temporal.TemporalField.marshalToNativeTemporalField(t);
    //     getLong(x1, t1)

}
