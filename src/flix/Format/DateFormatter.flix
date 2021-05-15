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
    /// A wrapper around a Java DateTimeFormatter for date formats.
    ///
    pub opaque type DateFormatter = ##java.time.format.DateTimeFormatter

    instance ToString[DateFormatter] {
        pub def toString(x: DateFormatter): String =
            import java.time.format.DateTimeFormatter.toString();
            let DateFormatter(x1) = x;
            toString(x1) as & Pure
    }

    instance FromString[DateFormatter] {
        pub def fromString(x: String): Option[DateFormatter] = Time/Format/DateFormatter.ofPattern(x)
    }

}

namespace Time/Format/DateFormatter {
    
    use I18n.Locale;

    use Time/Format.DateFormatter;
    use Time/Format.DateFormatter.{DateFormatter};
    use Time/Format.DecimalStyle;
    use Time/Format.DecimalStyle.{DecimalStyle};
    use Time/Format.FormatStyle;
    use Time/Format.ResolverStyle;

    pub def basic_iso_date(): DateFormatter =
        import get java.time.format.DateTimeFormatter:BASIC_ISO_DATE as getBASIC_ISO_DATE;
        DateFormatter(getBASIC_ISO_DATE()) as & Pure

    pub def iso_local_date(): DateFormatter =
        import get java.time.format.DateTimeFormatter:ISO_LOCAL_DATE as getISO_LOCAL_DATE;
        DateFormatter(getISO_LOCAL_DATE()) as & Pure

    pub def iso_offset_date(): DateFormatter =
        import get java.time.format.DateTimeFormatter:ISO_OFFSET_DATE as getISO_OFFSET_DATE;
        DateFormatter(getISO_OFFSET_DATE()) as & Pure

    pub def iso_date(): DateFormatter =
        import get java.time.format.DateTimeFormatter:ISO_DATE as getISO_DATE;
        DateFormatter(getISO_DATE()) as & Pure

    pub def iso_oridinal_date(): DateFormatter =
        import get java.time.format.DateTimeFormatter:ISO_ORDINAL_DATE as getISO_ORDINAL_DATE;
        DateFormatter(getISO_ORDINAL_DATE()) as & Pure

    pub def iso_week_date(): DateFormatter =
        import get java.time.format.DateTimeFormatter:ISO_WEEK_DATE as getISO_WEEK_DATE;
        DateFormatter(getISO_WEEK_DATE()) as & Pure

    /// Should this be called `new`?
    pub def ofPattern(pattern: String): Option[DateFormatter] =
        Option.map(DateFormatter, Time/Format/Internal/Prim.ofPattern(pattern))

    pub def ofLocalizedDate(style: FormatStyle): DateFormatter =
        import java.time.format.DateTimeFormatter:ofLocalizedDate(##java.time.format.FormatStyle);
        let style1 = Time/Format/FormatStyle.toNative(style);
        DateFormatter(ofLocalizedDate(style1)) as & Pure

    
    pub def getLocale(x: DateFormatter): Locale =
        let DateFormatter(x1) = x;
        Time/Format/Internal/Prim.getLocale(x1)

    pub def putLocale(x: DateFormatter, locale: Locale): DateFormatter =
        let DateFormatter(x1) = x;
        DateFormatter(Time/Format/Internal/Prim.putLocale(x1, locale))

    pub def getDecimalStyle(x: DateFormatter): DecimalStyle =
        let DateFormatter(x1) = x;
        Time/Format/Internal/Prim.getDecimalStyle(x1)

    pub def putDecimalStyle(x: DateFormatter, style: DecimalStyle): DateFormatter =
        let DateFormatter(x1) = x;
        DateFormatter(Time/Format/Internal/Prim.putDecimalStyle(x1, style))


    pub def getResolverStyle(x: DateFormatter): ResolverStyle =
        let DateFormatter(x1) = x;
        Time/Format/Internal/Prim.getResolverStyle(x1)

}
