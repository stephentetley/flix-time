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
    pub opaque type DateTimeFormatter = ##java.time.format.DateTimeFormatter

    instance ToString[DateTimeFormatter] {
        pub def toString(x: DateTimeFormatter): String =
            import java.time.format.DateTimeFormatter.toString();
            let DateTimeFormatter(x1) = x;
            toString(x1) as & Pure
    }

    instance FromString[DateTimeFormatter] {
        pub def fromString(x: String): Option[DateTimeFormatter] = Time/Format/DateTimeFormatter.ofPattern(x)
    }

}

namespace Time/Format/DateTimeFormatter {

    use I18n.Locale;

    use Time/Format.DateTimeFormatter;
    use Time/Format.DateTimeFormatter.{DateTimeFormatter};
    use Time/Format.DecimalStyle;
    use Time/Format.DecimalStyle.{DecimalStyle};
    use Time/Format.FormatStyle;
    use Time/Format.ResolverStyle;
    use Time.ZoneId;
    use Time.ZoneId.{ZoneId};

    /// Formatters

    pub def iso_local_date_time(): DateTimeFormatter =
        import get java.time.format.DateTimeFormatter:ISO_LOCAL_DATE_TIME as getISO_LOCAL_DATE_TIME;
        DateTimeFormatter(getISO_LOCAL_DATE_TIME()) as & Pure

    pub def iso_offset_date_time(): DateTimeFormatter =
        import get java.time.format.DateTimeFormatter:ISO_OFFSET_DATE_TIME as getISO_OFFSET_DATE_TIME;
        DateTimeFormatter(getISO_OFFSET_DATE_TIME()) as & Pure

    pub def iso_zoned_date_time(): DateTimeFormatter =
        import get java.time.format.DateTimeFormatter:ISO_ZONED_DATE_TIME as getISO_ZONED_DATE_TIME;
        DateTimeFormatter(getISO_ZONED_DATE_TIME()) as & Pure

    pub def iso_date_time(): DateTimeFormatter =
        import get java.time.format.DateTimeFormatter:ISO_DATE_TIME as getISO_DATE_TIME;
        DateTimeFormatter(getISO_DATE_TIME()) as & Pure

    pub def rfc_1123_date_time(): DateTimeFormatter =
        import get java.time.format.DateTimeFormatter:RFC_1123_DATE_TIME as getRFC_1123_DATE_TIME;
        DateTimeFormatter(getRFC_1123_DATE_TIME()) as & Pure


    pub def ofPattern(pattern: String): Option[DateTimeFormatter] =
        Option.map(DateTimeFormatter, Time/Format/Internal/Prim.ofPattern(pattern))

    
    pub def ofLocalizedDateTime(style: FormatStyle): DateTimeFormatter =
        import java.time.format.DateTimeFormatter:ofLocalizedDateTime(##java.time.format.FormatStyle);
        let style1 = Time/Format/FormatStyle.toNative(style);
        DateTimeFormatter(ofLocalizedDateTime(style1)) as & Pure

    pub def ofLocalizedDateTime2(dateStyle: FormatStyle, timeStyle: FormatStyle): DateTimeFormatter =
        import java.time.format.DateTimeFormatter:ofLocalizedDateTime(##java.time.format.FormatStyle, ##java.time.format.FormatStyle);
        let d1 = Time/Format/FormatStyle.toNative(dateStyle);
        let t1 = Time/Format/FormatStyle.toNative(timeStyle);
        DateTimeFormatter(ofLocalizedDateTime(d1, t1)) as & Pure


    pub def getZone(x: DateTimeFormatter): ZoneId =
        import java.time.format.DateTimeFormatter.getZone();
        let DateTimeFormatter(x1) = x;
        ZoneId(getZone(x1)) as & Pure

    pub def putZone(x: DateTimeFormatter, zone: ZoneId): DateTimeFormatter =
        import java.time.format.DateTimeFormatter.withZone(##java.time.ZoneId);
        let DateTimeFormatter(x1) = x;
        let ZoneId(z1) = zone;
        DateTimeFormatter(withZone(x1, z1)) as & Pure

    
    pub def getLocale(x: DateTimeFormatter): Locale =
        let DateTimeFormatter(x1) = x;
        Time/Format/Internal/Prim.getLocale(x1)

    pub def putLocale(x: DateTimeFormatter, locale: Locale): DateTimeFormatter =
        let DateTimeFormatter(x1) = x;
        DateTimeFormatter(Time/Format/Internal/Prim.putLocale(x1, locale))

    pub def getDecimalStyle(x: DateTimeFormatter): DecimalStyle =
        let DateTimeFormatter(x1) = x;
        Time/Format/Internal/Prim.getDecimalStyle(x1)

    pub def putDecimalStyle(x: DateTimeFormatter, style: DecimalStyle): DateTimeFormatter =
        let DateTimeFormatter(x1) = x;
        DateTimeFormatter(Time/Format/Internal/Prim.putDecimalStyle(x1, style))

    pub def getResolverStyle(x: DateTimeFormatter): ResolverStyle =
        let DateTimeFormatter(x1) = x;
        Time/Format/Internal/Prim.getResolverStyle(x1)

    pub def putResolverStyle(x: DateTimeFormatter, style: ResolverStyle): DateTimeFormatter =
        import java.time.format.DateTimeFormatter.withResolverStyle(##java.time.format.ResolverStyle);
        let DateTimeFormatter(x1) = x;
        let style1 = Time/Format/ResolverStyle.toNative(style);
        DateTimeFormatter(withResolverStyle(x1, style1)) as & Pure  

}
