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

    ///
    /// A wrapper around a Java DateTimeFormatter for date-time formats.
    ///
    /// This uses a phantom type parameter to restrict the application of
    /// specific format types (date, time, date-time).
    ///
    pub enum DateTimeFormatter[_ftype: Type](##java.time.format.DateTimeFormatter)

    instance ToString[DateTimeFormatter[t]] {
        pub def toString(x: DateTimeFormatter[t]): String =
            import java.time.format.DateTimeFormatter.toString(): String \ {};
            let DateTimeFormatter(x1) = x;
            toString(x1)
    }

    instance FromString[DateTimeFormatter[t]] {
        pub def fromString(s: String): Option[DateTimeFormatter[t]] =
            Result.tryCatch(_ -> {
                import static java.time.format.DateTimeFormatter.ofPattern(String): ##java.time.format.DateTimeFormatter \ {};
                DateTimeFormatter(ofPattern(String.trim(s)))
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

    /// ## Unwrap

    pub def getDateTimeFormatter(x: DateTimeFormatter[t]): ##java.time.format.DateTimeFormatter = 
        let DateTimeFormatter(x1) = x;
        x1

    /// ## "abstract constructors"

    /// Builtin DateTime Formatters

    pub def iso_local_date_time(): DateTimeFormatter[DateTimeFormat] =
        import static java_get_field java.time.format.DateTimeFormatter.ISO_LOCAL_DATE_TIME: ##java.time.format.DateTimeFormatter \ {} as get_ISO_LOCAL_DATE_TIME;
        DateTimeFormatter(get_ISO_LOCAL_DATE_TIME())

    pub def iso_offset_date_time(): DateTimeFormatter[DateTimeFormat] =
        import static java_get_field java.time.format.DateTimeFormatter.ISO_OFFSET_DATE_TIME: ##java.time.format.DateTimeFormatter \ {} as get_ISO_OFFSET_DATE_TIME;
        DateTimeFormatter(get_ISO_OFFSET_DATE_TIME())

    pub def iso_zoned_date_time(): DateTimeFormatter[DateTimeFormat] =
        import static java_get_field java.time.format.DateTimeFormatter.ISO_ZONED_DATE_TIME: ##java.time.format.DateTimeFormatter \ {} as get_ISO_ZONED_DATE_TIME;
        DateTimeFormatter(get_ISO_ZONED_DATE_TIME())

    pub def iso_date_time(): DateTimeFormatter[DateTimeFormat] =
        import static java_get_field java.time.format.DateTimeFormatter.ISO_DATE_TIME: ##java.time.format.DateTimeFormatter \ {} as get_ISO_DATE_TIME;
        DateTimeFormatter(get_ISO_DATE_TIME())

    pub def rfc_1123_date_time(): DateTimeFormatter[DateTimeFormat] =
        import static java_get_field java.time.format.DateTimeFormatter.RFC_1123_DATE_TIME: ##java.time.format.DateTimeFormatter \ {} as get_RFC_1123_DATE_TIME;
        DateTimeFormatter(get_RFC_1123_DATE_TIME())

    /// Builtin Date Formatters

    pub def basic_iso_date(): DateTimeFormatter[DateFormat] =
        import static java_get_field java.time.format.DateTimeFormatter.BASIC_ISO_DATE: ##java.time.format.DateTimeFormatter \ {} as get_BASIC_ISO_DATE;
        DateTimeFormatter(get_BASIC_ISO_DATE())

    pub def iso_local_date(): DateTimeFormatter[DateFormat] =
        import static java_get_field java.time.format.DateTimeFormatter.ISO_LOCAL_DATE: ##java.time.format.DateTimeFormatter \ {} as get_ISO_LOCAL_DATE;
        DateTimeFormatter(get_ISO_LOCAL_DATE())

    pub def iso_offset_date(): DateTimeFormatter[DateFormat] =
        import static java_get_field java.time.format.DateTimeFormatter.ISO_OFFSET_DATE: ##java.time.format.DateTimeFormatter \ {} as get_ISO_OFFSET_DATE;
        DateTimeFormatter(get_ISO_OFFSET_DATE())

    pub def iso_date(): DateTimeFormatter[DateFormat] =
        import static java_get_field java.time.format.DateTimeFormatter.ISO_DATE: ##java.time.format.DateTimeFormatter \ {} as get_ISO_DATE;
        DateTimeFormatter(get_ISO_DATE())

    pub def iso_oridinal_date(): DateTimeFormatter[DateFormat] =
        import static java_get_field java.time.format.DateTimeFormatter.ISO_ORDINAL_DATE: ##java.time.format.DateTimeFormatter \ {} as get_ISO_ORDINAL_DATE;
        DateTimeFormatter(get_ISO_ORDINAL_DATE())

    pub def iso_week_date(): DateTimeFormatter[DateFormat] =
        import static java_get_field java.time.format.DateTimeFormatter.ISO_WEEK_DATE: ##java.time.format.DateTimeFormatter \ {} as get_ISO_WEEK_DATE;
        DateTimeFormatter(get_ISO_WEEK_DATE())

    /// Builtin Time Formatters

    pub def iso_local_time(): DateTimeFormatter[TimeFormat] =
        import static java_get_field java.time.format.DateTimeFormatter.ISO_LOCAL_TIME: ##java.time.format.DateTimeFormatter \ {} as get_ISO_LOCAL_TIME;
        DateTimeFormatter(get_ISO_LOCAL_TIME())

    pub def iso_offset_time(): DateTimeFormatter[TimeFormat] =
        import static java_get_field java.time.format.DateTimeFormatter.ISO_OFFSET_TIME: ##java.time.format.DateTimeFormatter \ {} as get_ISO_OFFSET_TIME;
        DateTimeFormatter(get_ISO_OFFSET_TIME())

    pub def basic_iso_time(): DateTimeFormatter[TimeFormat] =
        import static java_get_field java.time.format.DateTimeFormatter.ISO_TIME: ##java.time.format.DateTimeFormatter \ {} as get_ISO_TIME;
        DateTimeFormatter(get_ISO_TIME())

    /// ## `from` functions

    pub def fromPattern(pattern: String): Result[String, DateTimeFormatter[t]] =
        Result.tryCatch(_ -> {
            import static java.time.format.DateTimeFormatter.ofPattern(String): ##java.time.format.DateTimeFormatter \ {};
            DateTimeFormatter(ofPattern(String.trim(pattern)))
        })


    pub def fromLocalizedTime(style: FormatStyle): DateTimeFormatter[TimeFormat] =
        import static java.time.format.DateTimeFormatter.ofLocalizedTime(##java.time.format.FormatStyle): ##java.time.format.DateTimeFormatter \ {};
        let style1 = Time.Format.FormatStyle.marshalFormatStyle(style);
        DateTimeFormatter(ofLocalizedTime(style1))

    pub def fromLocalizedDateTime(style: FormatStyle): DateTimeFormatter[DateTimeFormat] =
        import static java.time.format.DateTimeFormatter.ofLocalizedDateTime(##java.time.format.FormatStyle): ##java.time.format.DateTimeFormatter \ {};
        let style1 = Time.Format.FormatStyle.marshalFormatStyle(style);
        DateTimeFormatter(ofLocalizedDateTime(style1))

    pub def fromLocalizedDateTime2(dateStyle: FormatStyle, timeStyle: FormatStyle): DateTimeFormatter[DateTimeFormat] =
        import static java.time.format.DateTimeFormatter.ofLocalizedDateTime(##java.time.format.FormatStyle, ##java.time.format.FormatStyle): ##java.time.format.DateTimeFormatter \ {};
        let d1 = Time.Format.FormatStyle.marshalFormatStyle(dateStyle);
        let t1 = Time.Format.FormatStyle.marshalFormatStyle(timeStyle);
        DateTimeFormatter(ofLocalizedDateTime(d1, t1))

    pub def fromLocalizedDate(style: FormatStyle): DateTimeFormatter[DateFormat] =
        import static java.time.format.DateTimeFormatter.ofLocalizedDate(##java.time.format.FormatStyle): ##java.time.format.DateTimeFormatter \ {};
        let style1 = Time.Format.FormatStyle.marshalFormatStyle(style);
        DateTimeFormatter(ofLocalizedDate(style1))

    /// ## Getters and Setters

    pub def getZone(x: DateTimeFormatter[t]): ZoneId =
        import java.time.format.DateTimeFormatter.getZone(): ##java.time.ZoneId \ {};
        let DateTimeFormatter(x1) = x;
        ZoneId(getZone(x1))

    pub def withZone(zone: ZoneId, x: DateTimeFormatter[t]): DateTimeFormatter[t] =
        import java.time.format.DateTimeFormatter.withZone(##java.time.ZoneId): ##java.time.format.DateTimeFormatter \ {};
        let DateTimeFormatter(x1) = x;
        let ZoneId(z1) = zone;
        DateTimeFormatter(withZone(x1, z1))


    pub def getLocale(x: DateTimeFormatter[t]): Locale =
        import java.time.format.DateTimeFormatter.getLocale(): ##java.util.Locale \ {};        
        let DateTimeFormatter(x1) = x;
        Locale(getLocale(x1))

    pub def withLocale(locale: Locale, x: DateTimeFormatter[t]): DateTimeFormatter[t] =
        import java.time.format.DateTimeFormatter.withLocale(##java.util.Locale): ##java.time.format.DateTimeFormatter \ {};
        let Locale(locale1) = locale;
        let DateTimeFormatter(x1) = x;
        DateTimeFormatter(withLocale(x1, locale1))

    pub def getDecimalStyle(x: DateTimeFormatter[t]): DecimalStyle =
        import java.time.format.DateTimeFormatter.getDecimalStyle(): ##java.time.format.DecimalStyle \ {};
        let DateTimeFormatter(x1) = x;
        DecimalStyle(getDecimalStyle(x1))

    pub def withDecimalStyle(style: DecimalStyle, x: DateTimeFormatter[t]): DateTimeFormatter[t] =
        import java.time.format.DateTimeFormatter.withDecimalStyle(##java.time.format.DecimalStyle): ##java.time.format.DateTimeFormatter \ {};
        let DecimalStyle(style1) = style;
        let DateTimeFormatter(x1) = x;
        DateTimeFormatter(withDecimalStyle(x1, style1))

    pub def getResolverStyle(x: DateTimeFormatter[t]): ResolverStyle =
        import java.time.format.DateTimeFormatter.getResolverStyle(): ##java.time.format.ResolverStyle \ {};
        let DateTimeFormatter(x1) = x;
        Time.Format.ResolverStyle.unmarshalResolverStyle(getResolverStyle(x1))

    pub def withResolverStyle(style: ResolverStyle, x: DateTimeFormatter[t]): DateTimeFormatter[t] =
        import java.time.format.DateTimeFormatter.withResolverStyle(##java.time.format.ResolverStyle): ##java.time.format.DateTimeFormatter \ {};
        let DateTimeFormatter(x1) = x;
        let style1 = Time.Format.ResolverStyle.marshalResolverStyle(style);
        DateTimeFormatter(withResolverStyle(x1, style1))

}
