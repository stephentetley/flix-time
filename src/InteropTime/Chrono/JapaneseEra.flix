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

    
    use InteropTime.Internal.AdaptorExtras
    use InteropTime.Format.TextStyle.TextStyle

    use InteropLocale.Locale.Locale

    import java.time.chrono.{JapaneseEra => JJapaneseEra}
    import java.time.chrono.{Era => JEra}
    import java.lang.{Object }
    import java.lang.{Exception => JException}

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
            let JapaneseEra.JapaneseEra(x1) = x;
            unsafe IO { x1.toString()  }
    }

    instance Eq[JapaneseEra] {
        pub def eq(x: JapaneseEra, y: JapaneseEra): Bool = 
            let JapaneseEra.JapaneseEra(x1) = x;
            let JapaneseEra.JapaneseEra(y1) = y;
            unsafe IO { x1.equals(y1) }
    }

    instance Hash[JapaneseEra] {
        pub def hash(x: JapaneseEra): Int32 = 
            let JapaneseEra.JapaneseEra(x1) = x;
            unsafe IO { x1.hashCode() }
    }

    instance ToJava[JapaneseEra] {
        type Out = JJapaneseEra
        pub def toJava(x: JapaneseEra): JJapaneseEra = 
            let JapaneseEra.JapaneseEra(x1) = x;
            x1
    }

    instance ToFlix[JapaneseEra] {
        type In = JJapaneseEra
        pub def toFlix(x: JJapaneseEra): JapaneseEra = JapaneseEra.JapaneseEra(x)
    }

    pub def japaneseEra(japaneseEra: {japaneseEra = Int32 }): Result[String, JapaneseEra] =
        AdaptorExtras.ofWithResult(() -> unsafe IO { JJapaneseEra.of(japaneseEra#japaneseEra)}) 

    pub def heisei(): JapaneseEra = 
        AdaptorExtras.of(() -> unsafe IO { JJapaneseEra.HEISEI}) 

    pub def meiji(): JapaneseEra = 
        AdaptorExtras.of(() -> unsafe IO { JJapaneseEra.MEIJI}) 

    // Java 13

    pub def reiwa(): JapaneseEra = 
        AdaptorExtras.of(() -> unsafe IO { JJapaneseEra.REIWA })

    pub def showa(): JapaneseEra = 
        AdaptorExtras.of(() -> unsafe IO { JJapaneseEra.SHOWA })

    pub def taisho(): JapaneseEra = 
        AdaptorExtras.of(() -> unsafe IO { JJapaneseEra.TAISHO })

    pub def getValue(x: JapaneseEra): Int32 = 
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.getValue() })


    pub def getDisplayName(style: TextStyle, locale: Locale, x: JapaneseEra): String = 
        AdaptorExtras.extract3(style, locale, x, (style1, locale1, x1) ->
            unsafe IO { x1.getDisplayName(style1, locale1) }
        )



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
