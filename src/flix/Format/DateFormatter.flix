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
            x1.toString() as & Pure
    }

    instance FromString[DateFormatter] {
        pub def fromString(x: String): Option[DateFormatter] = Time/Format/DateFormatter.fromPattern(x)
    }

}

namespace Time/Format/DateFormatter {
    
    use Time/Format.DateFormatter;
    use Time/Format.DateFormatter.{DateFormatter};
    use Time/Format.DecimalStyle;
    use Time/Format.DecimalStyle.{DecimalStyle};
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


    pub def fromPattern(pattern: String): Option[DateFormatter] =
        import java.lang.String.strip();
        import java.time.format.DateTimeFormatter:ofPattern(String) as ofPattern;
        try {
            Some(DateFormatter(ofPattern(strip(pattern)))) as & Pure
        } catch {
            case _: ##java.lang.IllegalArgumentException => None
        }



    pub def getDecimalStyle(x: DateFormatter): DecimalStyle =
        import java.time.format.DateTimeFormatter.getDecimalStyle();
        let DateFormatter(x1) = x;
        DecimalStyle(getDecimalStyle(x1)) as & Pure

    pub def getResolverStyle(x: DateFormatter): ResolverStyle =
        import java.time.format.DateTimeFormatter.getResolverStyle();
        let DateFormatter(x1) = x;
        Time/Format/ResolverStyle.unmarshal(getResolverStyle(x1)) as & Pure

}
