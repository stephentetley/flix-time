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
 /// A wrapper around a Java DateTimeFormatter.
 ///
 opaque type DateFormatter = ##java.time.format.DateTimeFormatter

  ///
  /// A wrapper around a Java DateTimeFormatter.
  ///
  opaque type DateTimeFormatter = ##java.time.format.DateTimeFormatter

 namespace Time/Formatter {


    pub def basic_iso_date(): DateFormatter =
        import get java.time.format.DateTimeFormatter:BASIC_ISO_DATE as get_basic_iso_date;
        DateFormatter(get_basic_iso_date()) as & Pure

    pub def iso_local_date_time(): DateTimeFormatter =
        import get java.time.format.DateTimeFormatter:ISO_LOCAL_DATE_TIME as get_iso_local_date;
        DateTimeFormatter(get_iso_local_date()) as & Pure

 }