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
/// A wrapper around a Java DateTimeFormatter for dates.
///
opaque type DateFormatter = ##java.time.format.DateTimeFormatter

///
/// A wrapper around a Java DateTimeFormatter for times.
///
opaque type TimeFormatter = ##java.time.format.DateTimeFormatter


///
/// A wrapper around a Java DateTimeFormatter for date-times.
///
opaque type DateTimeFormatter = ##java.time.format.DateTimeFormatter

namespace Time/Formatter {


    pub def basic_iso_date(): DateFormatter =
        import get java.time.format.DateTimeFormatter:BASIC_ISO_DATE as get_basic_iso_date;
        DateFormatter(get_basic_iso_date()) as & Pure

    pub def iso_local_date(): DateFormatter =
        import get java.time.format.DateTimeFormatter:ISO_LOCAL_DATE as get_iso_local_date;
        DateFormatter(get_iso_local_date()) as & Pure

    pub def iso_offset_date(): DateFormatter =
        import get java.time.format.DateTimeFormatter:ISO_OFFSET_DATE as get_iso_offset_date;
        DateFormatter(get_iso_offset_date()) as & Pure

    pub def iso_date(): DateFormatter =
        import get java.time.format.DateTimeFormatter:ISO_DATE as get_iso_date;
        DateFormatter(get_iso_date()) as & Pure

    pub def iso_oridinal_date(): DateFormatter =
        import get java.time.format.DateTimeFormatter:ISO_ORDINAL_DATE as get_iso_oridinal_date;
        DateFormatter(get_iso_oridinal_date()) as & Pure

    pub def iso_week_date(): DateFormatter =
        import get java.time.format.DateTimeFormatter:ISO_WEEK_DATE as get_iso_week_date;
        DateFormatter(get_iso_week_date()) as & Pure

    pub def iso_local_time(): TimeFormatter =
        import get java.time.format.DateTimeFormatter:ISO_LOCAL_TIME as get_iso_local_time;
        TimeFormatter(get_iso_local_time()) as & Pure

    pub def iso_offset_time(): TimeFormatter =
        import get java.time.format.DateTimeFormatter:ISO_OFFSET_TIME as get_iso_offset_time;
        TimeFormatter(get_iso_offset_time()) as & Pure

    pub def basic_iso_time(): TimeFormatter =
        import get java.time.format.DateTimeFormatter:ISO_TIME as get_iso_time;
        TimeFormatter(get_iso_time()) as & Pure

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

    pub def dateFormatter(pattern: String): Result[DateFormatter, String] = try {
        import java.lang.String.strip();
        import java.time.format.DateTimeFormatter:ofPattern(String) as ofPattern;
        Ok(DateFormatter(pattern.strip().ofPattern())) as & Pure
    } catch {
        case _: ##java.lang.IllegalArgumentException => Err("Time/Formatter.dateFormatter")
    }

    pub def timeFormatter(pattern: String): Result[TimeFormatter, String] = try {
        import java.lang.String.strip();
        import java.time.format.DateTimeFormatter:ofPattern(String) as ofPattern;
        Ok(TimeFormatter(pattern.strip().ofPattern())) as & Pure
    } catch {
        case _: ##java.lang.IllegalArgumentException => Err("Time/Formatter.timeFormatter")
    }

    pub def dateTimeFormatter(pattern: String): Result[DateTimeFormatter, String] = try {
        import java.lang.String.strip();
        import java.time.format.DateTimeFormatter:ofPattern(String) as ofPattern;
        Ok(DateTimeFormatter(pattern.strip().ofPattern())) as & Pure
    } catch {
        case _: ##java.lang.IllegalArgumentException => Err("Time/Formatter.dateTimeFormatter")
    }


 }