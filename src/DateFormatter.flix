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
/// A wrapper around a Java DateTimeFormatter for date formats.
///
opaque type DateFormatter = ##java.time.format.DateTimeFormatter

namespace Time/DateFormatter {

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


    pub def fromPattern(pattern: String): Result[DateFormatter, String] = try {
        import java.lang.String.strip();
        import java.time.format.DateTimeFormatter:ofPattern(String) as ofPattern;
        Ok(DateFormatter(pattern.strip().ofPattern())) as & Pure
    } catch {
        case _: ##java.lang.IllegalArgumentException => Err("Time/TimeFormatter.fromPattern")
    }

    pub def toString(x: DateFormatter): String =
        import java.time.format.DateTimeFormatter.toString();
        let DateFormatter(x1) = x;
        x1.toString() as & Pure

}