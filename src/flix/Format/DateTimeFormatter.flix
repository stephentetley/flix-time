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
            x1.toString() as & Pure
    }

}

namespace Time/Format/DateTimeFormatter {

    use Time/Format.DateTimeFormatter;
    use Time/Format.DateTimeFormatter.{DateTimeFormatter};
    use Time/Format.DecimalStyle;
    use Time/Format.DecimalStyle.{DecimalStyle};
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


    pub def fromPattern(pattern: String): Option[DateTimeFormatter] =
        import java.lang.String.strip();
        import java.time.format.DateTimeFormatter:ofPattern(String) as ofPattern;
        try {
            Some(DateTimeFormatter(pattern.strip().ofPattern())) as & Pure
        } catch {
            case _: ##java.lang.IllegalArgumentException => None
        }


    pub def getZone(x: DateTimeFormatter): ZoneId =
        import java.time.format.DateTimeFormatter.getZone();
        let DateTimeFormatter(x1) = x;
        ZoneId(x1.getZone()) as & Pure

    pub def putZone(x: DateTimeFormatter, zone: ZoneId): DateTimeFormatter =
        import java.time.format.DateTimeFormatter.withZone(##java.time.ZoneId);
        let DateTimeFormatter(x1) = x;
        let ZoneId(z1) = zone;
        DateTimeFormatter(x1.withZone(z1)) as & Pure

    pub def getDecimalStyle(x: DateTimeFormatter): DecimalStyle =
        import java.time.format.DateTimeFormatter.getDecimalStyle();
        let DateTimeFormatter(x1) = x;
        DecimalStyle(getDecimalStyle(x1)) as & Pure

    pub def putDecimalStyle(x: DateTimeFormatter, style: DecimalStyle): DateTimeFormatter =
        import java.time.format.DateTimeFormatter.withDecimalStyle(##java.time.format.DecimalStyle);
        let DateTimeFormatter(x1) = x;
        let DecimalStyle(style1) = style;
        DateTimeFormatter(withDecimalStyle(x1, style1)) as & Pure   


    pub def getResolverStyle(x: DateTimeFormatter): ResolverStyle =
        import java.time.format.DateTimeFormatter.getResolverStyle();
        let DateTimeFormatter(x1) = x;
        Time/Format/ResolverStyle.unmarshal(getResolverStyle(x1)) as & Pure

    pub def putResolverStyle(x: DateTimeFormatter, style: ResolverStyle): DateTimeFormatter =
        import java.time.format.DateTimeFormatter.withResolverStyle(##java.time.format.ResolverStyle);
        let DateTimeFormatter(x1) = x;
        let style1 = Time/Format/ResolverStyle.marshal(style);
        DateTimeFormatter(withResolverStyle(x1, style1)) as & Pure  

}
