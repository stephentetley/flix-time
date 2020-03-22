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

opaque type ChronoUnit = ##java.time.temporal.ChronoUnit

namespace Time/ChronoUnit {


    ///
    /// The unit of nanoseconds.
    ///
    pub def nanos(): ChronoUnit =
        import get java.time.temporal.ChronoUnit:NANOS as get_nanos;
        ChronoUnit(get_nanos()) as & Pure

    ///
    /// The unit of microseconds.
    ///
    pub def micros(): ChronoUnit =
        import get java.time.temporal.ChronoUnit:MICROS as get_micros;
        ChronoUnit(get_micros()) as & Pure

    ///
    /// The unit of milliseconds.
    ///
    pub def millis(): ChronoUnit =
        import get java.time.temporal.ChronoUnit:MILLIS as get_millis;
        ChronoUnit(get_millis()) as & Pure

    ///
    /// The unit of seconds.
    ///
    pub def seconds(): ChronoUnit =
        import get java.time.temporal.ChronoUnit:SECONDS as get_seconds;
        ChronoUnit(get_seconds()) as & Pure

    ///
    /// The unit of minutes.
    ///
    pub def minutes(): ChronoUnit =
        import get java.time.temporal.ChronoUnit:MINUTES as get_minutes;
        ChronoUnit(get_minutes()) as & Pure

    ///
    /// The unit of hours.
    ///
    pub def hours(): ChronoUnit =
        import get java.time.temporal.ChronoUnit:HOURS as get_hours;
        ChronoUnit(get_hours()) as & Pure

    ///
    /// The unit of half_days.
    ///
    pub def half_days(): ChronoUnit =
        import get java.time.temporal.ChronoUnit:HALF_DAYS as get_half_days;
        ChronoUnit(get_half_days()) as & Pure

    ///
    /// The unit of days.
    ///
    pub def days(): ChronoUnit =
        import get java.time.temporal.ChronoUnit:DAYS as get_days;
        ChronoUnit(get_days()) as & Pure

    ///
    /// The unit of weeks.
    ///
    pub def weeks(): ChronoUnit =
        import get java.time.temporal.ChronoUnit:WEEKS as get_weeks;
        ChronoUnit(get_weeks()) as & Pure

    ///
    /// The unit of months.
    ///
    pub def months(): ChronoUnit =
        import get java.time.temporal.ChronoUnit:MONTHS as get_months;
        ChronoUnit(get_months()) as & Pure

    ///
    /// The unit of year.
    ///
    pub def year(): ChronoUnit =
        import get java.time.temporal.ChronoUnit:YEARS as get_years;
        ChronoUnit(get_years()) as & Pure

    ///
    /// The unit of decades.
    ///
    pub def decades(): ChronoUnit =
        import get java.time.temporal.ChronoUnit:DECADES as get_decades;
        ChronoUnit(get_decades()) as & Pure

    ///
    /// The unit of centuries.
    ///
    pub def centuries(): ChronoUnit =
        import get java.time.temporal.ChronoUnit:CENTURIES as get_centuries;
        ChronoUnit(get_centuries()) as & Pure

    ///
    /// The unit of millenia.
    ///
    pub def millenia(): ChronoUnit =
        import get java.time.temporal.ChronoUnit:MILLENNIA as get_millenia;
        ChronoUnit(get_millenia()) as & Pure

    ///
    /// The unit of eras.
    ///
    pub def eras(): ChronoUnit =
        import get java.time.temporal.ChronoUnit:ERAS as get_eras;
        ChronoUnit(get_eras()) as & Pure

    ///
    /// The abstract unit of forever.
    ///
    pub def forever(): ChronoUnit =
        import get java.time.temporal.ChronoUnit:FOREVER as get_forever;
        ChronoUnit(get_forever()) as & Pure

    pub def getDuration(x: ChronoUnit): Duration =
        import java.time.temporal.ChronoUnit.getDuration();
        let ChronoUnit(x1) = x;
        Duration(x1.getDuration()) as & Pure

    pub def toString(x: ChronoUnit): String =
        import java.time.temporal.ChronoUnit.toString();
        let ChronoUnit(x1) = x;
        x1.toString() as & Pure

}