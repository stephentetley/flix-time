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

package flix.runtime.library;

import java.time.*;
import java.time.format.DateTimeFormatter;

/**
 * A wrapper class for Date, Time and DateTimerelated functions that provides concrete, non-overloaded methods.
 */
public class DateTimeWrapper {

    // Parse the string `s` as an LocalDate.
    public static LocalDate localDateParse(String s) throws Exception {
        final CharSequence cs = s;
        return LocalDate.parse(cs);
    }

    // Parse the string `s` as an LocalDate. The format of the input string
    // should be in the format mandated by `formatter`.
    public static LocalDate localDateParseWithFormatter(String s, DateTimeFormatter formatter) throws Exception {
        final CharSequence cs = s;
        return LocalDate.parse(cs, formatter);
    }

    // Parse the string `s` as an LocalTime.
    public static LocalTime localTimeParse(String s) throws Exception {
        final CharSequence cs = s;
        return LocalTime.parse(cs);
    }

    // Parse the string `s` as an LocalTime. The format of the input string
    // should be in the format mandated by `formatter`.
    public static LocalTime localTimeParseWithFormatter(String s, DateTimeFormatter formatter) throws Exception {
        final CharSequence cs = s;
        return LocalTime.parse(cs, formatter);
    }

    // Parse the string `s` as an LocalDateTime. The format of the input string
    // should be ISO-8601 extended offset date-time format.
    public static LocalDateTime localDateTimeParse(String s) throws Exception {
        final CharSequence cs = s;
        return LocalDateTime.parse(cs);
    }

    // Parse the string `s` as an LocalDateTime. The format of the input string
    // should be in the format mandated by `formatter`.
    public static LocalDateTime localDateTimeParseWithFormatter(String s, DateTimeFormatter formatter) throws Exception {
        final CharSequence cs = s;
        return LocalDateTime.parse(cs, formatter);
    }

}
