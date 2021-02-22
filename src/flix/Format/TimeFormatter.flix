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
    /// A wrapper around a Java DateTimeFormatter for time formats.
    ///
    pub opaque type TimeFormatter = ##java.time.format.DateTimeFormatter

    instance ToString[TimeFormatter] {
        pub def toString(x: TimeFormatter): String =
            import java.time.format.DateTimeFormatter.toString();
            let TimeFormatter(x1) = x;
            x1.toString() as & Pure
    }

}

namespace Time/Format/TimeFormatter {

    use I18n.Locale;
    use I18n.Locale.{Locale};

    use Time/Format.TimeFormatter;
    use Time/Format.TimeFormatter.{TimeFormatter};
    use Time/Format.DecimalStyle;
    use Time/Format.ResolverStyle;
    use Time/Format.DecimalStyle.{DecimalStyle};
    use Time.ZoneId;
    use Time.ZoneId.{ZoneId};

    pub def iso_local_time(): TimeFormatter =
        import get java.time.format.DateTimeFormatter:ISO_LOCAL_TIME as getISO_LOCAL_TIME;
        TimeFormatter(getISO_LOCAL_TIME()) as & Pure

    pub def iso_offset_time(): TimeFormatter =
        import get java.time.format.DateTimeFormatter:ISO_OFFSET_TIME as getISO_OFFSET_TIME;
        TimeFormatter(getISO_OFFSET_TIME()) as & Pure

    pub def basic_iso_time(): TimeFormatter =
        import get java.time.format.DateTimeFormatter:ISO_TIME as getISO_TIME;
        TimeFormatter(getISO_TIME()) as & Pure

    pub def fromPattern(pattern: String): Option[TimeFormatter] =
        try {
            import java.lang.String.strip();
            import java.time.format.DateTimeFormatter:ofPattern(String) as ofPattern;
            Some(TimeFormatter(pattern.strip().ofPattern())) as & Pure
        } catch {
            case _: ##java.lang.IllegalArgumentException => None
        }

    pub def getZone(x: TimeFormatter): ZoneId =
        import java.time.format.DateTimeFormatter.getZone();
        let TimeFormatter(x1) = x;
        ZoneId(x1.getZone()) as & Pure

    pub def putZone(x: TimeFormatter, zone: ZoneId): TimeFormatter =
        import java.time.format.DateTimeFormatter.withZone(##java.time.ZoneId);
        let TimeFormatter(x1) = x;
        let ZoneId(z1) = zone;
        TimeFormatter(x1.withZone(z1)) as & Pure

    pub def getDecimalStyle(x: TimeFormatter): DecimalStyle =
        import java.time.format.DateTimeFormatter.getDecimalStyle();
        let TimeFormatter(x1) = x;
        DecimalStyle(getDecimalStyle(x1)) as & Pure
    
    pub def getLocale(x: TimeFormatter): Locale =
        import java.time.format.DateTimeFormatter.getLocale();
        let TimeFormatter(x1) = x;
        Locale(getLocale(x1)) as & Pure

    pub def getResolverStyle(x: TimeFormatter): ResolverStyle =
        import java.time.format.DateTimeFormatter.getResolverStyle();
        let TimeFormatter(x1) = x;
        Time/Format/ResolverStyle.unmarshal(getResolverStyle(x1)) as & Pure


    pub def putLocale(x: TimeFormatter, locale: Locale): TimeFormatter =
        import java.time.format.DateTimeFormatter.withLocale(##java.util.Locale);
        let TimeFormatter(x1) = x;
        let Locale(locale1) = locale;
        TimeFormatter(withLocale(x1, locale1)) as & Pure

}