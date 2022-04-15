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
            import java.time.format.DateTimeFormatter.toString(): String & Pure;
            let TimeFormatter(x1) = x;
            toString(x1)
    }

    instance FromString[TimeFormatter] {
        pub def fromString(x: String): Option[TimeFormatter] = Time/Format/TimeFormatter.ofPattern(x)
    }
}

namespace Time/Format/TimeFormatter {

    use FlixSandbox/I18n.Locale;
    use FlixSandbox/I18n.Locale.{Locale};

    use Time/Format.TimeFormatter;
    use Time/Format.TimeFormatter.{TimeFormatter};
    use Time/Format.DecimalStyle;
    use Time/Format.DecimalStyle.{DecimalStyle};
    use Time/Format.FormatStyle;
    use Time/Format.ResolverStyle;
    use Time.ZoneId;
    use Time.ZoneId.{ZoneId};

    pub def iso_local_time(): TimeFormatter =
        import static get java.time.format.DateTimeFormatter.ISO_LOCAL_TIME: ##java.time.format.DateTimeFormatter & Pure as getISO_LOCAL_TIME;
        TimeFormatter(getISO_LOCAL_TIME())

    pub def iso_offset_time(): TimeFormatter =
        import static get java.time.format.DateTimeFormatter.ISO_OFFSET_TIME: ##java.time.format.DateTimeFormatter & Pure as getISO_OFFSET_TIME;
        TimeFormatter(getISO_OFFSET_TIME())

    pub def basic_iso_time(): TimeFormatter =
        import static get java.time.format.DateTimeFormatter.ISO_TIME: ##java.time.format.DateTimeFormatter & Pure as getISO_TIME;
        TimeFormatter(getISO_TIME())

    pub def ofPattern(pattern: String): Option[TimeFormatter] =
        Option.map(TimeFormatter, Time/Format/Internal/Prim.ofPattern(pattern))
    
    pub def ofLocalizedTime(style: FormatStyle): TimeFormatter =
        import static java.time.format.DateTimeFormatter.ofLocalizedTime(##java.time.format.FormatStyle): ##java.time.format.DateTimeFormatter & Pure;
        let style1 = Time/Format/FormatStyle.marshal(style);
        TimeFormatter(ofLocalizedTime(style1))


    pub def getZone(x: TimeFormatter): ZoneId =
        import java.time.format.DateTimeFormatter.getZone(): ##java.time.ZoneId & Pure;
        let TimeFormatter(x1) = x;
        ZoneId(getZone(x1))

    pub def withZone(x: TimeFormatter, zone: ZoneId): TimeFormatter =
        import java.time.format.DateTimeFormatter.withZone(##java.time.ZoneId): ##java.time.format.DateTimeFormatter & Pure;
        let TimeFormatter(x1) = x;
        let ZoneId(z1) = zone;
        TimeFormatter(withZone(x1, z1))

    pub def getDecimalStyle(x: TimeFormatter): DecimalStyle =
        let TimeFormatter(x1) = x;
        Time/Format/Internal/Prim.getDecimalStyle(x1)

    pub def withDecimalStyle(x: TimeFormatter, style: DecimalStyle): TimeFormatter =
        let TimeFormatter(x1) = x;
        TimeFormatter(Time/Format/Internal/Prim.withDecimalStyle(x1, style))

    pub def getResolverStyle(x: TimeFormatter): ResolverStyle =
        let TimeFormatter(x1) = x;
        Time/Format/Internal/Prim.getResolverStyle(x1)

    
    pub def getLocale(x: TimeFormatter): Locale =
        let TimeFormatter(x1) = x;
        Time/Format/Internal/Prim.getLocale(x1)

    pub def withLocale(x: TimeFormatter, locale: Locale): TimeFormatter =
        let TimeFormatter(x1) = x;
        TimeFormatter(Time/Format/Internal/Prim.withLocale(x1, locale))

}
