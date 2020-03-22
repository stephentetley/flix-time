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

pub enum ChronoUnit {
    case Nanos,
    case Micros,
    case Millis,
    case Seconds,
    case Minutes,
    case Hours,
    case HalfDays,
    case Days,
    case Weeks,
    case Months,
    case Years,
    case Decades,
    case Centuries,
    case Millenia,
    case Eras,
    case Forever
}

namespace Time/ChronoUnit {

    type alias InternalChronoUnit = ##java.time.temporal.ChronoUnit

    pub def toInternal(x: ChronoUnit): InternalChronoUnit =
        import get java.time.temporal.ChronoUnit:NANOS as get_nanos;
        import get java.time.temporal.ChronoUnit:MICROS as get_micros;
        import get java.time.temporal.ChronoUnit:MILLIS as get_millis;
        import get java.time.temporal.ChronoUnit:SECONDS as get_seconds;
        import get java.time.temporal.ChronoUnit:MINUTES as get_minutes;
        import get java.time.temporal.ChronoUnit:HOURS as get_hours;
        import get java.time.temporal.ChronoUnit:HALF_DAYS as get_half_days;
        import get java.time.temporal.ChronoUnit:DAYS as get_days;
        import get java.time.temporal.ChronoUnit:WEEKS as get_weeks;
        import get java.time.temporal.ChronoUnit:MONTHS as get_months;
        import get java.time.temporal.ChronoUnit:YEARS as get_years;
        import get java.time.temporal.ChronoUnit:DECADES as get_decades;
        import get java.time.temporal.ChronoUnit:CENTURIES as get_centuries;
        import get java.time.temporal.ChronoUnit:MILLENNIA as get_millenia;
        import get java.time.temporal.ChronoUnit:ERAS as get_eras;
        import get java.time.temporal.ChronoUnit:FOREVER as get_forever;
        match x {
            case Nanos => get_nanos() as & Pure
            case Micros => get_micros() as & Pure
            case Millis => get_millis() as & Pure
            case Seconds => get_seconds() as & Pure
            case Minutes => get_minutes() as & Pure
            case Hours => get_hours() as & Pure
            case HalfDays => get_half_days() as & Pure
            case Days => get_days() as & Pure
            case Weeks => get_weeks() as & Pure
            case Months => get_months() as & Pure
            case Years => get_years() as & Pure
            case Decades => get_decades() as & Pure
            case Centuries => get_centuries() as & Pure
            case Millenia => get_millenia() as & Pure
            case Eras => get_eras() as & Pure
            case Forever => get_forever() as & Pure
    }

    pub def getDuration(x: ChronoUnit): Duration =
        import java.time.temporal.ChronoUnit.getDuration();
        let x1 = toInternal(x);
        Duration(x1.getDuration()) as & Pure

}