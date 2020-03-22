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

///
/// A wrapper around a Java DateTimeFormatter for date-time formats.
///
opaque type DateTimeFormatter = ##java.time.format.DateTimeFormatter

namespace DateTimeFormatter {

    /// Formatters

    pub def iso_local_date_time(): DateTimeFormatter =
        import get java.time.format.DateTimeFormatter:ISO_LOCAL_DATE_TIME as get_iso_local_date;
        DateTimeFormatter(get_iso_local_date()) as & Pure

    pub def iso_offset_date_time(): DateTimeFormatter =
        import get java.time.format.DateTimeFormatter:ISO_OFFSET_DATE_TIME as get_iso_offset_date_time;
        DateTimeFormatter(get_iso_offset_date_time()) as & Pure

    pub def iso_zoned_date_time(): DateTimeFormatter =
        import get java.time.format.DateTimeFormatter:ISO_ZONED_DATE_TIME as get_iso_zoned_date_time;
        DateTimeFormatter(get_iso_zoned_date_time()) as & Pure

    pub def iso_date_time(): DateTimeFormatter =
        import get java.time.format.DateTimeFormatter:ISO_DATE_TIME as get_iso_date_time;
        DateTimeFormatter(get_iso_date_time()) as & Pure

    pub def rfc_1123_date_time(): DateTimeFormatter =
        import get java.time.format.DateTimeFormatter:RFC_1123_DATE_TIME as get_rfc_1123_date_time;
        DateTimeFormatter(get_rfc_1123_date_time()) as & Pure

    pub def fromPattern(pattern: String): Result[DateTimeFormatter, String] = try {
        import java.lang.String.strip();
        import java.time.format.DateTimeFormatter:ofPattern(String) as ofPattern;
        Ok(DateTimeFormatter(pattern.strip().ofPattern())) as & Pure
    } catch {
        case _: ##java.lang.IllegalArgumentException => Err("Time/Formatter.formatter")
    }

    pub def withZone(fmt: DateTimeFormatter, zone: ZoneId): DateTimeFormatter =
        import java.time.format.DateTimeFormatter.withZone(##java.time.ZoneId) as withZone;
        let DateTimeFormatter(fm) = fmt;
        let ZoneId(z) = zone;
        DateTimeFormatter(fm.withZone(z)) as & Pure

    pub def getZone(x: DateTimeFormatter): ZoneId =
        import java.time.format.DateTimeFormatter.getZone();
        let DateTimeFormatter(x1) = x;
        ZoneId(x1.getZone()) as & Pure

    pub def putZone(x: DateTimeFormatter, zone: ZoneId): DateTimeFormatter =
        import java.time.format.DateTimeFormatter.withZone(##java.time.ZoneId);
        let DateTimeFormatter(x1) = x;
        let ZoneId(z1) = zone;
        DateTimeFormatter(x1.withZone(z1)) as & Pure

    pub def toString(x: DateTimeFormatter): String =
        import java.time.format.DateTimeFormatter.toString();
        let DateTimeFormatter(x1) = x;
        x1.toString() as & Pure

}