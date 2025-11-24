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

mod Time.Format {

    use Time.Format.DateTimeFormatter
    use Time.Format.DateTimeFormatter.{DateTimeFormatter}

    import java.time.format.{DateTimeFormatter => JDateTimeFormatter}

    ///
    /// A wrapper around a Java DateTimeFormatter for date-time formats.
    ///
    /// This uses a phantom type parameter to restrict the application of
    /// specific format types (date, time, date-time).
    ///
    pub enum DateTimeFormatter[_ftype: Type](JDateTimeFormatter)

    instance ToString[DateTimeFormatter[t]] {
        pub def toString(x: DateTimeFormatter[t]): String =
            let DateTimeFormatter(x1) = x;
            unsafe IO { x1.toString() }
    }

    instance FromString[DateTimeFormatter[t]] {
        pub def fromString(s: String): Option[DateTimeFormatter[t]] =
            Result.tryCatch(_ -> {
                let s1 = String.trim(s);
                DateTimeFormatter(unsafe IO { JDateTimeFormatter.ofPattern(s1) })
            }) |> Result.toOption
    }

    /// Phantom arguments to restrict the type of DateTimeFormatter
    pub enum DateFormat {}
    pub enum TimeFormat {}
    pub enum DateTimeFormat {}

}

mod Time.Format.DateTimeFormatter {

    
    use Locale.{Locale}

    use Time.Format.DateTimeFormatter
    use Time.Format.DateTimeFormatter.{DateTimeFormatter}
    use Time.Format.DateFormat
    use Time.Format.TimeFormat
    use Time.Format.DateTimeFormat
    use Time.Format.DecimalStyle
    use Time.Format.DecimalStyle.{DecimalStyle}
    use Time.Format.FormatStyle
    use Time.Format.ResolverStyle
    use Time.ZoneId
    use Time.ZoneId.{ZoneId}

    import java.time.format.{DateTimeFormatter => JDateTimeFormatter}
    import java.time.{ZoneId => JZoneId}

    /// ## Unwrap

    pub def getDateTimeFormatter(x: DateTimeFormatter[t]): JDateTimeFormatter = 
        let DateTimeFormatter(x1) = x;
        x1

    /// ## "abstract constructors"

    /// Builtin DateTime Formatters

    pub def iso_local_date_time(): DateTimeFormatter[DateTimeFormat] =
        DateTimeFormatter(unsafe IO { JDateTimeFormatter.ISO_LOCAL_DATE_TIME })

    pub def iso_offset_date_time(): DateTimeFormatter[DateTimeFormat] =
        DateTimeFormatter(unsafe IO { JDateTimeFormatter.ISO_OFFSET_DATE_TIME })

    pub def iso_zoned_date_time(): DateTimeFormatter[DateTimeFormat] =
        DateTimeFormatter(unsafe IO { JDateTimeFormatter.ISO_ZONED_DATE_TIME })

    pub def iso_date_time(): DateTimeFormatter[DateTimeFormat] =
        DateTimeFormatter(unsafe IO { JDateTimeFormatter.ISO_DATE_TIME })

    pub def rfc_1123_date_time(): DateTimeFormatter[DateTimeFormat] =
        DateTimeFormatter(unsafe IO { JDateTimeFormatter.RFC_1123_DATE_TIME })

    /// Builtin Date Formatters

    pub def basic_iso_date(): DateTimeFormatter[DateFormat] =
        DateTimeFormatter(unsafe IO { JDateTimeFormatter.BASIC_ISO_DATE })

    pub def iso_local_date(): DateTimeFormatter[DateFormat] =
        DateTimeFormatter(unsafe IO { JDateTimeFormatter.ISO_LOCAL_DATE })

    pub def iso_offset_date(): DateTimeFormatter[DateFormat] =
        DateTimeFormatter(unsafe IO { JDateTimeFormatter.ISO_OFFSET_DATE })

    pub def iso_date(): DateTimeFormatter[DateFormat] =
        DateTimeFormatter(unsafe IO { JDateTimeFormatter.ISO_DATE })

    pub def iso_oridinal_date(): DateTimeFormatter[DateFormat] =
        DateTimeFormatter(unsafe IO { JDateTimeFormatter.ISO_ORDINAL_DATE })

    pub def iso_week_date(): DateTimeFormatter[DateFormat] =
        DateTimeFormatter(unsafe IO { JDateTimeFormatter.ISO_WEEK_DATE })

    /// Builtin Time Formatters

    pub def iso_local_time(): DateTimeFormatter[TimeFormat] =
        DateTimeFormatter(unsafe IO { JDateTimeFormatter.ISO_LOCAL_TIME })

    pub def iso_offset_time(): DateTimeFormatter[TimeFormat] =
        DateTimeFormatter(unsafe IO { JDateTimeFormatter.ISO_OFFSET_TIME })

    pub def basic_iso_time(): DateTimeFormatter[TimeFormat] =
        DateTimeFormatter(unsafe IO { JDateTimeFormatter.ISO_TIME })

    /// ## `from` functions

    pub def fromPattern(pattern: String): Result[String, DateTimeFormatter[t]] =
        Result.tryCatch(_ -> {
            let s1 = String.trim(pattern);
            DateTimeFormatter(unsafe IO { JDateTimeFormatter.ofPattern(s1) })
        })


    pub def fromLocalizedTime(style: FormatStyle): DateTimeFormatter[TimeFormat] =
        let style1 = Time.Format.FormatStyle.marshalFormatStyle(style);
        DateTimeFormatter(unsafe IO { JDateTimeFormatter.ofLocalizedTime(style1) })

    pub def fromLocalizedDateTime(style: FormatStyle): DateTimeFormatter[DateTimeFormat] =
        let style1 = Time.Format.FormatStyle.marshalFormatStyle(style);
        DateTimeFormatter(unsafe IO { JDateTimeFormatter.ofLocalizedDateTime(style1) })

    pub def fromLocalizedDateTime2(dateStyle: FormatStyle, timeStyle: FormatStyle): DateTimeFormatter[DateTimeFormat] =
        let d1 = Time.Format.FormatStyle.marshalFormatStyle(dateStyle);
        let t1 = Time.Format.FormatStyle.marshalFormatStyle(timeStyle);
        DateTimeFormatter(unsafe IO { JDateTimeFormatter.ofLocalizedDateTime(d1, t1) })

    pub def fromLocalizedDate(style: FormatStyle): DateTimeFormatter[DateFormat] =
        let style1 = Time.Format.FormatStyle.marshalFormatStyle(style);
        DateTimeFormatter(unsafe IO { JDateTimeFormatter.ofLocalizedDate(style1) })

    /// ## Getters and Setters

    pub def getZone(x: DateTimeFormatter[t]): ZoneId =
        let DateTimeFormatter(x1) = x;
        let ans = unsafe IO { x1.getZone() };
        ZoneId(ans)

    pub def withZone(zone: ZoneId, x: DateTimeFormatter[t]): DateTimeFormatter[t] =
        let DateTimeFormatter(x1) = x;
        let ZoneId(z1) = zone;
        DateTimeFormatter(unsafe IO { x1.$withZone(z1) })


    pub def getLocale(x: DateTimeFormatter[t]): Locale =
        let DateTimeFormatter(x1) = x;
        Locale(unsafe IO { x1.getLocale() })

    pub def withLocale(locale: Locale, x: DateTimeFormatter[t]): DateTimeFormatter[t] =
        let Locale(locale1) = locale;
        let DateTimeFormatter(x1) = x;
        DateTimeFormatter(unsafe IO { x1.$withLocale(locale1) })

    pub def getDecimalStyle(x: DateTimeFormatter[t]): DecimalStyle =
        let DateTimeFormatter(x1) = x;
        DecimalStyle(unsafe IO { x1.getDecimalStyle() })

    pub def withDecimalStyle(style: DecimalStyle, x: DateTimeFormatter[t]): DateTimeFormatter[t] =
        let DecimalStyle(style1) = style;
        let DateTimeFormatter(x1) = x;
        DateTimeFormatter(unsafe IO { x1.$withDecimalStyle(style1) })

    pub def getResolverStyle(x: DateTimeFormatter[t]): ResolverStyle =
        let DateTimeFormatter(x1) = x;
        Time.Format.ResolverStyle.unmarshalResolverStyle(unsafe IO { x1.getResolverStyle() })

    pub def withResolverStyle(style: ResolverStyle, x: DateTimeFormatter[t]): DateTimeFormatter[t] =
        let DateTimeFormatter(x1) = x;
        let style1 = Time.Format.ResolverStyle.marshalResolverStyle(style);
        DateTimeFormatter(unsafe IO { x1.$withResolverStyle(style1) })

}
