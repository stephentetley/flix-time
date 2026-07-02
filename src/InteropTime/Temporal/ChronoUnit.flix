/*
 * Copyright 2022 Stephen Tetley
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


pub mod InteropTime.Temporal.ChronoUnit {

    use InteropTime.Temporal.ChronoUnit.ChronoUnit
    use InteropTime.Temporal.ChronoUnit.ChronoUnit.{Nanos, Micros,
        Millis, Seconds, Minutes, Hours, HalfDays, Days, Weeks,
        Months, Years, Decades, Centuries, Millennia, Eras, Forever}

    import java.time.temporal.{ChronoUnit => JChronoUnit}

    pub enum ChronoUnit with Eq, Order, ToString, Hash {
        case Nanos
        case Micros
        case Millis
        case Seconds
        case Minutes
        case Hours
        case HalfDays
        case Days
        case Weeks
        case Months
        case Years
        case Decades
        case Centuries
        case Millennia
        case Eras
        case Forever
    }


    // DateChronoUnits = {Days, Months, Years, Centuries, Millennia, Eras}



    instance ToJava[ChronoUnit] {
        type Out = JChronoUnit
        pub def toJava(x: ChronoUnit): JChronoUnit = match x {
            case ChronoUnit.Nanos       => unsafe IO { JChronoUnit.NANOS }
            case ChronoUnit.Micros      => unsafe IO { JChronoUnit.MICROS }
            case ChronoUnit.Millis      => unsafe IO { JChronoUnit.MILLIS }
            case ChronoUnit.Seconds     => unsafe IO { JChronoUnit.SECONDS }
            case ChronoUnit.Minutes     => unsafe IO { JChronoUnit.MINUTES }
            case ChronoUnit.Hours       => unsafe IO { JChronoUnit.HOURS }
            case ChronoUnit.HalfDays    => unsafe IO { JChronoUnit.HALF_DAYS }
            case ChronoUnit.Days        => unsafe IO { JChronoUnit.DAYS }
            case ChronoUnit.Weeks       => unsafe IO { JChronoUnit.WEEKS }
            case ChronoUnit.Months      => unsafe IO { JChronoUnit.MONTHS }
            case ChronoUnit.Years       => unsafe IO { JChronoUnit.YEARS }
            case ChronoUnit.Decades     => unsafe IO { JChronoUnit.DECADES }
            case ChronoUnit.Centuries   => unsafe IO { JChronoUnit.CENTURIES }
            case ChronoUnit.Millennia   => unsafe IO { JChronoUnit.MILLENNIA }
            case ChronoUnit.Eras        => unsafe IO { JChronoUnit.ERAS }
            case ChronoUnit.Forever     => unsafe IO { JChronoUnit.FOREVER }
        }
    }


    instance ToFlix[ChronoUnit] {
        type In = JChronoUnit
        pub def toFlix(x: JChronoUnit): ChronoUnit = unsafe IO {
            if (x.equals(JChronoUnit.NANOS))            ChronoUnit.Nanos
            else if (x.equals(JChronoUnit.MICROS))      ChronoUnit.Micros
            else if (x.equals(JChronoUnit.MILLIS))      ChronoUnit.Millis
            else if (x.equals(JChronoUnit.SECONDS))     ChronoUnit.Seconds
            else if (x.equals(JChronoUnit.MINUTES))     ChronoUnit.Minutes
            else if (x.equals(JChronoUnit.HOURS))       ChronoUnit.Hours
            else if (x.equals(JChronoUnit.HALF_DAYS))   ChronoUnit.HalfDays
            else if (x.equals(JChronoUnit.DAYS))        ChronoUnit.Days
            else if (x.equals(JChronoUnit.WEEKS))       ChronoUnit.Weeks
            else if (x.equals(JChronoUnit.MONTHS))      ChronoUnit.Months
            else if (x.equals(JChronoUnit.YEARS))       ChronoUnit.Years
            else if (x.equals(JChronoUnit.DECADES))     ChronoUnit.Decades
            else if (x.equals(JChronoUnit.CENTURIES))   ChronoUnit.Centuries
            else if (x.equals(JChronoUnit.MILLENNIA))   ChronoUnit.Millennia
            else if (x.equals(JChronoUnit.ERAS))        ChronoUnit.Eras
            else if (x.equals(JChronoUnit.FOREVER))     ChronoUnit.Forever
            else bug!("toFlix[ChronoUnit]")
        }
    }

}
