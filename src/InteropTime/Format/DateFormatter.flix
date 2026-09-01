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


pub mod InteropTime.Format.DateFormatter {

    use EffectExtras.Fail.Fail
    use JavaInterop.AdaptorUnchecked
    use JavaInterop.AdaptorChecked
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
    /// date formats.
    ///
    pub enum DateFormatter(JDateTimeFormatter)

    instance ToString[DateFormatter] {
        pub def toString(x: DateFormatter): String =
            let DateFormatter.DateFormatter(x1) = x;
            unsafe IO { x1.toString() }
    }

    instance FromString[DateFormatter] {
        pub def fromString(s: String): Option[DateFormatter] =
            try {
                let s1 = String.trim(s);
                DateFormatter.DateFormatter(unsafe IO { JDateTimeFormatter.ofPattern(s1) }) |> Some
            } catch {
                case _: JException => None
            }
    }

    instance ToJava[DateFormatter] {
        type Out = JDateTimeFormatter
        pub def toJava(x: DateFormatter): JDateTimeFormatter = 
            let DateFormatter.DateFormatter(x1) = x;
            x1
    }

    instance ToFlix[DateFormatter] {
        type In = JDateTimeFormatter
        pub def toFlix(x: JDateTimeFormatter): DateFormatter = 
            DateFormatter.DateFormatter(x)
    }


    pub def newDateFormatter(pattern: String): DateFormatter \ Fail =
        AdaptorChecked.of(() -> {
            let s1 = String.trim(pattern);
            unsafe IO { JDateTimeFormatter.ofPattern(s1) }
        })

    pub def newWithFormatStyle(style: FormatStyle): DateFormatter \ IO =
        AdaptorUnchecked.op(style, style1 -> { JDateTimeFormatter.ofLocalizedDate(style1) })



    /// ## "abstract constructors"

    /// Builtin DateTime Formatters


    /// Builtin Date Formatters

    pub def basic_iso_date(): DateFormatter =
        AdaptorUnchecked.of(() -> unsafe IO { JDateTimeFormatter.BASIC_ISO_DATE })

    pub def iso_local_date(): DateFormatter =
        AdaptorUnchecked.of(() -> unsafe IO { JDateTimeFormatter.ISO_LOCAL_DATE })

    pub def iso_offset_date(): DateFormatter =
        AdaptorUnchecked.of(() -> unsafe IO { JDateTimeFormatter.ISO_OFFSET_DATE })

    pub def iso_date(): DateFormatter =
        AdaptorUnchecked.of(() -> unsafe IO { JDateTimeFormatter.ISO_DATE })

    pub def iso_oridinal_date(): DateFormatter =
        AdaptorUnchecked.of(() -> unsafe IO { JDateTimeFormatter.ISO_ORDINAL_DATE })

    pub def iso_week_date(): DateFormatter =
        AdaptorUnchecked.of(() -> unsafe IO { JDateTimeFormatter.ISO_WEEK_DATE })


    /// ## Getters and Setters

    pub def getZone(x: DateFormatter): ZoneId =
        AdaptorUnchecked.op(x, x1 -> unsafe IO { x1.getZone() })

    
    pub def withZone(zone: ZoneId, x: DateFormatter): DateFormatter =
        AdaptorUnchecked.op2(zone, x, (zone1, x1) -> unsafe IO { x1.$withZone(zone1) })


    pub def getLocale(x: DateFormatter): Locale \ IO =
        AdaptorUnchecked.op(x, x1 -> { x1.getLocale() })

    pub def withLocale(locale: Locale, x: DateFormatter): DateFormatter =
        AdaptorUnchecked.op2(locale, x, (locale1, x1) -> unsafe IO { x1.$withLocale(locale1) })

    pub def getDecimalStyle(x: DateFormatter): DecimalStyle =
        AdaptorUnchecked.op(x, x1 -> unsafe IO { x1.getDecimalStyle() })

    pub def withDecimalStyle(style: DecimalStyle, x: DateFormatter): DateFormatter =
        AdaptorUnchecked.op2(style, x, (style1, x1) -> unsafe IO { x1.$withDecimalStyle(style1) })

    pub def getResolverStyle(x: DateFormatter): ResolverStyle =
        AdaptorUnchecked.op(x, x1 -> unsafe IO { x1.getResolverStyle() })

    pub def withResolverStyle(style: ResolverStyle, x: DateFormatter): DateFormatter =
        AdaptorUnchecked.op2(style, x, (style1, x1) -> unsafe IO { x1.$withResolverStyle(style1) })

}

