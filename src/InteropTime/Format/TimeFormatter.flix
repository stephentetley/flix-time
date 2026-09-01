/*
 * Copyright 2026 Stephen Tetley
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


pub mod InteropTime.Format.TimeFormatter {

    use EffectExtras.Fail.Fail
    use JavaInterop.AdaptorChecked
    use JavaInterop.AdaptorUnchecked
    use InteropLocale.Locale

    use InteropTime.Format.DecimalStyle.DecimalStyle
    use InteropTime.Format.DecimalStyle.DecimalStyle.{DecimalStyle}
    use InteropTime.Format.FormatStyle.FormatStyle
    use InteropTime.Format.ResolverStyle.ResolverStyle
    use InteropTime.ZoneId.ZoneId
    

    import java.time.format.{DateTimeFormatter => JDateTimeFormatter}
    import java.time.{ZoneId => JZoneId}
    import java.lang.{Exception => JException}

    ///
    /// A wrapper around a Java DateTimeFormatter specifically for 
    /// time formats.
    ///
    pub enum TimeFormatter(JDateTimeFormatter)

    instance ToString[TimeFormatter] {
        pub def toString(x: TimeFormatter): String =
            let TimeFormatter.TimeFormatter(x1) = x;
            unsafe IO { x1.toString() }
    }

    instance FromString[TimeFormatter] {
        pub def fromString(s: String): Option[TimeFormatter] =
            try {
                let s1 = String.trim(s);
                TimeFormatter.TimeFormatter(unsafe IO { JDateTimeFormatter.ofPattern(s1) }) |> Some
            } catch {
                case _: JException => None
            }
    }

    instance ToJava[TimeFormatter] {
        type Out = JDateTimeFormatter
        pub def toJava(x: TimeFormatter): JDateTimeFormatter = 
            let TimeFormatter.TimeFormatter(x1) = x;
            x1
    }

    instance ToFlix[TimeFormatter] {
        type In = JDateTimeFormatter
        pub def toFlix(x: JDateTimeFormatter): TimeFormatter = 
            TimeFormatter.TimeFormatter(x)
    }

    /// ## `from` functions

    pub def newTimeFormatter(pattern: String): TimeFormatter \ Fail =
        AdaptorChecked.of(() -> {
            let s1 = String.trim(pattern);
            unsafe IO { JDateTimeFormatter.ofPattern(s1) }
        })

    // Varies according to system locale
    pub def newWithFormatStyle(style: FormatStyle): TimeFormatter \ IO =
        AdaptorUnchecked.op(style, style1 -> { JDateTimeFormatter.ofLocalizedTime(style1) })


    /// ## "abstract constructors"

    /// Builtin DateTime Formatters


    /// Builtin Time Formatters

    pub def iso_local_time(): TimeFormatter =
        AdaptorUnchecked.of(() -> unsafe IO { JDateTimeFormatter.ISO_LOCAL_TIME })

    pub def iso_offset_time(): TimeFormatter =
        AdaptorUnchecked.of(() -> unsafe IO { JDateTimeFormatter.ISO_OFFSET_TIME })

    pub def basic_iso_time(): TimeFormatter =
        AdaptorUnchecked.of(() -> unsafe IO { JDateTimeFormatter.ISO_TIME })



    // /// ## Getters and Setters

    pub def getZone(x: TimeFormatter): ZoneId =
        AdaptorUnchecked.op(x, x1 -> unsafe IO { x1.getZone() })

    
    pub def withZone(zone: ZoneId, x: TimeFormatter): TimeFormatter =
        AdaptorUnchecked.op2(zone, x, (zone1, x1) -> unsafe IO { x1.$withZone(zone1) })


    pub def getLocale(x: TimeFormatter): Locale \ IO =
        AdaptorUnchecked.op(x, x1 -> { x1.getLocale() })

    pub def withLocale(locale: Locale, x: TimeFormatter): TimeFormatter =
        AdaptorUnchecked.op2(locale, x, (locale1, x1) -> unsafe IO { x1.$withLocale(locale1) })

    pub def getDecimalStyle(x: TimeFormatter): DecimalStyle =
        AdaptorUnchecked.op(x, x1 -> unsafe IO { x1.getDecimalStyle() })

    pub def withDecimalStyle(style: DecimalStyle, x: TimeFormatter): TimeFormatter =
        AdaptorUnchecked.op2(style, x, (style1, x1) -> unsafe IO { x1.$withDecimalStyle(style1) })

    pub def getResolverStyle(x: TimeFormatter): ResolverStyle =
        AdaptorUnchecked.op(x, x1 -> unsafe IO { x1.getResolverStyle() })

    pub def withResolverStyle(style: ResolverStyle, x: TimeFormatter): TimeFormatter =
        AdaptorUnchecked.op2(style, x, (style1, x1) -> unsafe IO { x1.$withResolverStyle(style1) })

}

