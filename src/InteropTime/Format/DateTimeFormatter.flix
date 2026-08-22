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


pub mod InteropTime.Format.DateTimeFormatter {

    use InteropLocale.Locale
        
    use JavaInterop.AdaptorExtras

    use InteropTime.Format.DecimalStyle.DecimalStyle
    use InteropTime.Format.DecimalStyle.DecimalStyle.{DecimalStyle}
    use InteropTime.Format.FormatStyle.FormatStyle
    use InteropTime.Format.ResolverStyle.ResolverStyle
    use InteropTime.ZoneId.ZoneId
    

    import java.time.format.{DateTimeFormatter => JDateTimeFormatter}
    import java.time.{ZoneId => JZoneId}
    import java.lang.{Exception => JException}

    ///
    /// A wrapper around a Java DateTimeFormatter spcifically for 
    /// date-time formats.
    ///
    pub enum DateTimeFormatter(JDateTimeFormatter)

    instance ToString[DateTimeFormatter] {
        pub def toString(x: DateTimeFormatter): String =
            let DateTimeFormatter.DateTimeFormatter(x1) = x;
            unsafe IO { x1.toString() }
    }

    instance FromString[DateTimeFormatter] {
        pub def fromString(s: String): Option[DateTimeFormatter] =
            try {
                let s1 = String.trim(s);
                DateTimeFormatter.DateTimeFormatter(unsafe IO { JDateTimeFormatter.ofPattern(s1) }) |> Some
            } catch {
                case _: JException => None
            }
    }

    instance ToJava[DateTimeFormatter] {
        type Out = JDateTimeFormatter
        pub def toJava(x: DateTimeFormatter): JDateTimeFormatter = 
            let DateTimeFormatter.DateTimeFormatter(x1) = x;
            x1
    }

    instance ToFlix[DateTimeFormatter] {
        type In = JDateTimeFormatter
        pub def toFlix(x: JDateTimeFormatter): DateTimeFormatter = DateTimeFormatter.DateTimeFormatter(x)
    }


    /// ## "abstract constructors"

    /// Builtin DateTime Formatters

    pub def iso_local_date_time(): DateTimeFormatter =
        DateTimeFormatter(unsafe IO { JDateTimeFormatter.ISO_LOCAL_DATE_TIME })

    pub def iso_offset_date_time(): DateTimeFormatter =
        DateTimeFormatter(unsafe IO { JDateTimeFormatter.ISO_OFFSET_DATE_TIME })

    pub def iso_zoned_date_time(): DateTimeFormatter =
        DateTimeFormatter(unsafe IO { JDateTimeFormatter.ISO_ZONED_DATE_TIME })

    pub def iso_date_time(): DateTimeFormatter =
        DateTimeFormatter(unsafe IO { JDateTimeFormatter.ISO_DATE_TIME })

    pub def rfc_1123_date_time(): DateTimeFormatter =
        DateTimeFormatter(unsafe IO { JDateTimeFormatter.RFC_1123_DATE_TIME })

    /// ## `from` functions

    pub def fromPattern(pattern: String): Result[String, DateTimeFormatter] =
        AdaptorExtras.ofWithResult(() -> {
            let s1 = String.trim(pattern);
            unsafe IO { JDateTimeFormatter.ofPattern(s1) }
        })


    // Varies according to system locale
    pub def fromLocalizedDateTime(style: FormatStyle): DateTimeFormatter \ IO =
        AdaptorExtras.op(style, style1 -> { JDateTimeFormatter.ofLocalizedDateTime(style1) })

    pub def fromLocalizedDateTime2(dateStyle: FormatStyle, timeStyle: FormatStyle): DateTimeFormatter \ IO =
        AdaptorExtras.op2(dateStyle, timeStyle, (d1, t1) -> { JDateTimeFormatter.ofLocalizedDateTime(d1, t1) })


    /// ## Getters and Setters

    pub def getZone(x: DateTimeFormatter): ZoneId =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.getZone() })

    
    pub def withZone(zone: ZoneId, x: DateTimeFormatter): DateTimeFormatter =
        AdaptorExtras.op2(zone, x, (zone1, x1) -> unsafe IO { x1.$withZone(zone1) })


    pub def getLocale(x: DateTimeFormatter): Locale \ IO =
        AdaptorExtras.op(x, x1 -> { x1.getLocale() })

    pub def withLocale(locale: Locale, x: DateTimeFormatter): DateTimeFormatter =
        AdaptorExtras.op2(locale, x, (locale1, x1) -> unsafe IO { x1.$withLocale(locale1) })

    pub def getDecimalStyle(x: DateTimeFormatter): DecimalStyle =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.getDecimalStyle() })

    pub def withDecimalStyle(style: DecimalStyle, x: DateTimeFormatter): DateTimeFormatter =
        AdaptorExtras.op2(style, x, (style1, x1) -> unsafe IO { x1.$withDecimalStyle(style1) })

    pub def getResolverStyle(x: DateTimeFormatter): ResolverStyle =
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.getResolverStyle() })

    pub def withResolverStyle(style: ResolverStyle, x: DateTimeFormatter): DateTimeFormatter =
        AdaptorExtras.op2(style, x, (style1, x1) -> unsafe IO { x1.$withResolverStyle(style1) })

}

