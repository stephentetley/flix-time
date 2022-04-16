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

namespace Time/Format {

    ///
    /// A wrapper around a Java DateTimeFormatter for date-time formats.
    ///
    /// This uses a phantom type parameter
    ///
    pub opaque type DateTimeFormatter[_ftype] = ##java.time.format.DateTimeFormatter

    instance ToString[DateTimeFormatter[t]] {
        pub def toString(x: DateTimeFormatter[t]): String =
            import java.time.format.DateTimeFormatter.toString(): String & Pure;
            let DateTimeFormatter(x1) = x;
            toString(x1)
    }

    instance FromString[DateTimeFormatter[t]] {
        pub def fromString(x: String): Option[DateTimeFormatter[t]] = Time/Format/DateTimeFormatter.ofPattern(x)
    }

    pub enum DateFormat {}
    pub enum TimeFormat {}
    pub enum DateTimeFormat {}

}

namespace Time/Format/DateTimeFormatter {

    use FlixSandbox/I18n.Locale;

    use Time/Format.DateTimeFormatter;
    use Time/Format.DateTimeFormatter.{DateTimeFormatter};
    use Time/Format.DateFormat;
    use Time/Format.TimeFormat;
    use Time/Format.DateTimeFormat;
    use Time/Format.DecimalStyle;
    use Time/Format.DecimalStyle.{DecimalStyle};
    use Time/Format.FormatStyle;
    use Time/Format.ResolverStyle;
    use Time.ZoneId;
    use Time.ZoneId.{ZoneId};

    /// Builtin DateTime Formatters

    pub def iso_local_date_time(): DateTimeFormatter[DateTimeFormat] =
        import static get java.time.format.DateTimeFormatter.ISO_LOCAL_DATE_TIME: ##java.time.format.DateTimeFormatter & Pure as get_ISO_LOCAL_DATE_TIME;
        DateTimeFormatter(get_ISO_LOCAL_DATE_TIME())

    pub def iso_offset_date_time(): DateTimeFormatter[DateTimeFormat] =
        import static get java.time.format.DateTimeFormatter.ISO_OFFSET_DATE_TIME: ##java.time.format.DateTimeFormatter & Pure as get_ISO_OFFSET_DATE_TIME;
        DateTimeFormatter(get_ISO_OFFSET_DATE_TIME())

    pub def iso_zoned_date_time(): DateTimeFormatter[DateTimeFormat] =
        import static get java.time.format.DateTimeFormatter.ISO_ZONED_DATE_TIME: ##java.time.format.DateTimeFormatter & Pure as get_ISO_ZONED_DATE_TIME;
        DateTimeFormatter(get_ISO_ZONED_DATE_TIME())

    pub def iso_date_time(): DateTimeFormatter[DateTimeFormat] =
        import static get java.time.format.DateTimeFormatter.ISO_DATE_TIME: ##java.time.format.DateTimeFormatter & Pure as get_ISO_DATE_TIME;
        DateTimeFormatter(get_ISO_DATE_TIME())

    pub def rfc_1123_date_time(): DateTimeFormatter[DateTimeFormat] =
        import static get java.time.format.DateTimeFormatter.RFC_1123_DATE_TIME: ##java.time.format.DateTimeFormatter & Pure as get_RFC_1123_DATE_TIME;
        DateTimeFormatter(get_RFC_1123_DATE_TIME())

    /// Builtin Date Formatters

    pub def basic_iso_date(): DateTimeFormatter[DateFormat] =
        import static get java.time.format.DateTimeFormatter.BASIC_ISO_DATE: ##java.time.format.DateTimeFormatter & Pure as get_BASIC_ISO_DATE;
        DateTimeFormatter(get_BASIC_ISO_DATE())

    pub def iso_local_date(): DateTimeFormatter[DateFormat] =
        import static get java.time.format.DateTimeFormatter.ISO_LOCAL_DATE: ##java.time.format.DateTimeFormatter & Pure as get_ISO_LOCAL_DATE;
        DateTimeFormatter(get_ISO_LOCAL_DATE())

    pub def iso_offset_date(): DateTimeFormatter[DateFormat] =
        import static get java.time.format.DateTimeFormatter.ISO_OFFSET_DATE: ##java.time.format.DateTimeFormatter & Pure as get_ISO_OFFSET_DATE;
        DateTimeFormatter(get_ISO_OFFSET_DATE())

    pub def iso_date(): DateTimeFormatter[DateFormat] =
        import static get java.time.format.DateTimeFormatter.ISO_DATE: ##java.time.format.DateTimeFormatter & Pure as get_ISO_DATE;
        DateTimeFormatter(get_ISO_DATE())

    pub def iso_oridinal_date(): DateTimeFormatter[DateFormat] =
        import static get java.time.format.DateTimeFormatter.ISO_ORDINAL_DATE: ##java.time.format.DateTimeFormatter & Pure as get_ISO_ORDINAL_DATE;
        DateTimeFormatter(get_ISO_ORDINAL_DATE())

    pub def iso_week_date(): DateTimeFormatter[DateFormat] =
        import static get java.time.format.DateTimeFormatter.ISO_WEEK_DATE: ##java.time.format.DateTimeFormatter & Pure as get_ISO_WEEK_DATE;
        DateTimeFormatter(get_ISO_WEEK_DATE())

    /// Builtin Time Formatters

    pub def iso_local_time(): DateTimeFormatter[TimeFormat] =
        import static get java.time.format.DateTimeFormatter.ISO_LOCAL_TIME: ##java.time.format.DateTimeFormatter & Pure as get_ISO_LOCAL_TIME;
        DateTimeFormatter(get_ISO_LOCAL_TIME())

    pub def iso_offset_time(): DateTimeFormatter[TimeFormat] =
        import static get java.time.format.DateTimeFormatter.ISO_OFFSET_TIME: ##java.time.format.DateTimeFormatter & Pure as get_ISO_OFFSET_TIME;
        DateTimeFormatter(get_ISO_OFFSET_TIME())

    pub def basic_iso_time(): DateTimeFormatter[TimeFormat] =
        import static get java.time.format.DateTimeFormatter.ISO_TIME: ##java.time.format.DateTimeFormatter & Pure as get_ISO_TIME;
        DateTimeFormatter(get_ISO_TIME())



    pub def ofPattern(pattern: String): Option[DateTimeFormatter[t]] =
        Option.map(DateTimeFormatter, Time/Format/Internal/Prim.ofPattern(pattern))


    pub def ofLocalizedTime(style: FormatStyle): DateTimeFormatter[TimeFormat] =
        import static java.time.format.DateTimeFormatter.ofLocalizedTime(##java.time.format.FormatStyle): ##java.time.format.DateTimeFormatter & Pure;
        let style1 = Time/Format/FormatStyle.marshal(style);
        DateTimeFormatter(ofLocalizedTime(style1))

    pub def ofLocalizedDateTime(style: FormatStyle): DateTimeFormatter[DateTimeFormat] =
        import static java.time.format.DateTimeFormatter.ofLocalizedDateTime(##java.time.format.FormatStyle): ##java.time.format.DateTimeFormatter & Pure;
        let style1 = Time/Format/FormatStyle.marshal(style);
        DateTimeFormatter(ofLocalizedDateTime(style1))

    pub def ofLocalizedDateTime2(dateStyle: FormatStyle, timeStyle: FormatStyle): DateTimeFormatter[DateTimeFormat] =
        import static java.time.format.DateTimeFormatter.ofLocalizedDateTime(##java.time.format.FormatStyle, ##java.time.format.FormatStyle): ##java.time.format.DateTimeFormatter & Pure;
        let d1 = Time/Format/FormatStyle.marshal(dateStyle);
        let t1 = Time/Format/FormatStyle.marshal(timeStyle);
        DateTimeFormatter(ofLocalizedDateTime(d1, t1))

    pub def ofLocalizedDate(style: FormatStyle): DateTimeFormatter[DateFormat] =
        import static java.time.format.DateTimeFormatter.ofLocalizedDate(##java.time.format.FormatStyle): ##java.time.format.DateTimeFormatter & Pure;
        let style1 = Time/Format/FormatStyle.marshal(style);
        DateTimeFormatter(ofLocalizedDate(style1))

    pub def getZone(x: DateTimeFormatter[t]): ZoneId =
        import java.time.format.DateTimeFormatter.getZone(): ##java.time.ZoneId & Pure;
        let DateTimeFormatter(x1) = x;
        ZoneId(getZone(x1))

    pub def withZone(zone: ZoneId, x: DateTimeFormatter[t]): DateTimeFormatter[t] =
        import java.time.format.DateTimeFormatter.withZone(##java.time.ZoneId): ##java.time.format.DateTimeFormatter & Pure;
        let DateTimeFormatter(x1) = x;
        let ZoneId(z1) = zone;
        DateTimeFormatter(withZone(x1, z1))


    pub def getLocale(x: DateTimeFormatter[t]): Locale =
        let DateTimeFormatter(x1) = x;
        Time/Format/Internal/Prim.getLocale(x1)

    pub def withLocale(loc: Locale, x: DateTimeFormatter[t]): DateTimeFormatter[t] =
        let DateTimeFormatter(x1) = x;
        DateTimeFormatter(Time/Format/Internal/Prim.withLocale(x1, loc))

    pub def getDecimalStyle(x: DateTimeFormatter[t]): DecimalStyle =
        let DateTimeFormatter(x1) = x;
        Time/Format/Internal/Prim.getDecimalStyle(x1)

    pub def withDecimalStyle(style: DecimalStyle, x: DateTimeFormatter[t]): DateTimeFormatter[t] =
        let DateTimeFormatter(x1) = x;
        DateTimeFormatter(Time/Format/Internal/Prim.withDecimalStyle(x1, style))

    pub def getResolverStyle(x: DateTimeFormatter[t]): ResolverStyle =
        let DateTimeFormatter(x1) = x;
        Time/Format/Internal/Prim.getResolverStyle(x1)

    pub def withResolverStyle(style: ResolverStyle, x: DateTimeFormatter[t]): DateTimeFormatter[t] =
        import java.time.format.DateTimeFormatter.withResolverStyle(##java.time.format.ResolverStyle): ##java.time.format.DateTimeFormatter & Pure;
        let DateTimeFormatter(x1) = x;
        let style1 = Time/Format/ResolverStyle.marshal(style);
        DateTimeFormatter(withResolverStyle(x1, style1))

}
