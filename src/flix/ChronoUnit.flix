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

use Time.ChronoUnit;
use Time.ChronoUnit.{ChronoUnit};
use Time.Duration;
use Time.Duration.{Duration};

namespace Time {

    pub opaque type ChronoUnit = ##java.time.temporal.ChronoUnit

}

namespace Time/ChronoUnit {

    /// TODO - enum or not enum?
    /// Unlike DayOfWeek or Month this feels a bit arbitrary, but in favour of an enum
    /// there is a natural ordering.

    /// TODO - push into a sub-namespace (Temporal) like Java?

    ///
    /// The unit of nanoseconds.
    ///
    pub def nanos(): ChronoUnit =
        import get java.time.temporal.ChronoUnit:NANOS as getNANOS;
        ChronoUnit(getNANOS()) as & Pure

    ///
    /// The unit of microseconds.
    ///
    pub def micros(): ChronoUnit =
        import get java.time.temporal.ChronoUnit:MICROS as getMICROS;
        ChronoUnit(getMICROS()) as & Pure

    ///
    /// The unit of milliseconds.
    ///
    pub def millis(): ChronoUnit =
        import get java.time.temporal.ChronoUnit:MILLIS as getMILLIS;
        ChronoUnit(getMILLIS()) as & Pure

    ///
    /// The unit of seconds.
    ///
    pub def seconds(): ChronoUnit =
        import get java.time.temporal.ChronoUnit:SECONDS as getSECONDS;
        ChronoUnit(getSECONDS()) as & Pure

    ///
    /// The unit of minutes.
    ///
    pub def minutes(): ChronoUnit =
        import get java.time.temporal.ChronoUnit:MINUTES as getMINUTES;
        ChronoUnit(getMINUTES()) as & Pure

    ///
    /// The unit of hours.
    ///
    pub def hours(): ChronoUnit =
        import get java.time.temporal.ChronoUnit:HOURS as getHOURS;
        ChronoUnit(getHOURS()) as & Pure

    ///
    /// The unit of half_days.
    ///
    pub def half_days(): ChronoUnit =
        import get java.time.temporal.ChronoUnit:HALF_DAYS as getHALF_DAYS;
        ChronoUnit(getHALF_DAYS()) as & Pure

    ///
    /// The unit of days.
    ///
    pub def days(): ChronoUnit =
        import get java.time.temporal.ChronoUnit:DAYS as getDAYS;
        ChronoUnit(getDAYS()) as & Pure

    ///
    /// The unit of weeks.
    ///
    pub def weeks(): ChronoUnit =
        import get java.time.temporal.ChronoUnit:WEEKS as getWEEKS;
        ChronoUnit(getWEEKS()) as & Pure

    ///
    /// The unit of months.
    ///
    pub def months(): ChronoUnit =
        import get java.time.temporal.ChronoUnit:MONTHS as getMONTHS;
        ChronoUnit(getMONTHS()) as & Pure

    ///
    /// The unit of year.
    ///
    pub def year(): ChronoUnit =
        import get java.time.temporal.ChronoUnit:YEARS as getYEARS;
        ChronoUnit(getYEARS()) as & Pure

    ///
    /// The unit of decades.
    ///
    pub def decades(): ChronoUnit =
        import get java.time.temporal.ChronoUnit:DECADES as getDECADES;
        ChronoUnit(getDECADES()) as & Pure

    ///
    /// The unit of centuries.
    ///
    pub def centuries(): ChronoUnit =
        import get java.time.temporal.ChronoUnit:CENTURIES as getCENTURIES;
        ChronoUnit(getCENTURIES()) as & Pure

    ///
    /// The unit of millenia.
    ///
    pub def millenia(): ChronoUnit =
        import get java.time.temporal.ChronoUnit:MILLENNIA as getMILLENNIA;
        ChronoUnit(getMILLENNIA()) as & Pure

    ///
    /// The unit of eras.
    ///
    pub def eras(): ChronoUnit =
        import get java.time.temporal.ChronoUnit:ERAS as getERAS;
        ChronoUnit(getERAS()) as & Pure

    ///
    /// The abstract unit of forever.
    ///
    pub def forever(): ChronoUnit =
        import get java.time.temporal.ChronoUnit:FOREVER as getFOREVER;
        ChronoUnit(getFOREVER()) as & Pure

    pub def getDuration(x: ChronoUnit): Duration =
        import java.time.temporal.ChronoUnit.getDuration();
        let ChronoUnit(x1) = x;
        Duration(x1.getDuration()) as & Pure

    pub def isDurationEstimated(x: ChronoUnit): Bool =
        import java.time.temporal.ChronoUnit.isDurationEstimated();
        let ChronoUnit(x1) = x;
        x1.isDurationEstimated() as & Pure

    pub def isDateBased(x: ChronoUnit): Bool =
        import java.time.temporal.ChronoUnit.isDateBased();
        let ChronoUnit(x1) = x;
        x1.isDateBased() as & Pure

    pub def isTimeBased(x: ChronoUnit): Bool =
        import java.time.temporal.ChronoUnit.isTimeBased();
        let ChronoUnit(x1) = x;
        x1.isTimeBased() as & Pure


    pub def toString(x: ChronoUnit): String =
        import java.time.temporal.ChronoUnit.toString();
        let ChronoUnit(x1) = x;
        x1.toString() as & Pure

}