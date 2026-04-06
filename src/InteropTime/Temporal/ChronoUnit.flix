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


    
    pub def marshalChronoUnit(x: ChronoUnit): JChronoUnit \ {} =
        match x {
            case ChronoUnit.Nanos       => JChronoUnit.NANOS
            case ChronoUnit.Micros      => JChronoUnit.MICROS
            case ChronoUnit.Millis      => JChronoUnit.MILLIS
            case ChronoUnit.Seconds     => JChronoUnit.SECONDS
            case ChronoUnit.Minutes     => JChronoUnit.MINUTES
            case ChronoUnit.Hours       => JChronoUnit.HOURS
            case ChronoUnit.HalfDays    => JChronoUnit.HALF_DAYS
            case ChronoUnit.Days        => JChronoUnit.DAYS
            case ChronoUnit.Weeks       => JChronoUnit.WEEKS
            case ChronoUnit.Months      => JChronoUnit.MONTHS
            case ChronoUnit.Years       => JChronoUnit.YEARS
            case ChronoUnit.Decades     => JChronoUnit.DECADES
            case ChronoUnit.Centuries   => JChronoUnit.CENTURIES
            case ChronoUnit.Millennia   => JChronoUnit.MILLENNIA
            case ChronoUnit.Eras        => JChronoUnit.ERAS
            case ChronoUnit.Forever     => JChronoUnit.FOREVER
        }


    def primEquals(x: JChronoUnit, y: JChronoUnit): Bool =
        unsafe IO { x.equals(y) }

    pub def unmarshalChronoUnit(x: JChronoUnit): ChronoUnit =
        match x {
            case x1 if primEquals(x1, unsafe IO { JChronoUnit.NANOS })         => Nanos
            case x1 if primEquals(x1, unsafe IO { JChronoUnit.MICROS })        => Micros
            case x1 if primEquals(x1, unsafe IO { JChronoUnit.MILLIS })        => Millis
            case x1 if primEquals(x1, unsafe IO { JChronoUnit.SECONDS })       => Seconds
            case x1 if primEquals(x1, unsafe IO { JChronoUnit.MINUTES })       => Minutes
            case x1 if primEquals(x1, unsafe IO { JChronoUnit.HOURS })         => Hours
            case x1 if primEquals(x1, unsafe IO { JChronoUnit.HALF_DAYS })     => HalfDays
            case x1 if primEquals(x1, unsafe IO { JChronoUnit.DAYS })          => Days
            case x1 if primEquals(x1, unsafe IO { JChronoUnit.WEEKS })         => Weeks
            case x1 if primEquals(x1, unsafe IO { JChronoUnit.MONTHS })        => Months
            case x1 if primEquals(x1, unsafe IO { JChronoUnit.YEARS })         => Years
            case x1 if primEquals(x1, unsafe IO { JChronoUnit.DECADES })       => Decades
            case x1 if primEquals(x1, unsafe IO { JChronoUnit.CENTURIES })     => Centuries
            case x1 if primEquals(x1, unsafe IO { JChronoUnit.MILLENNIA })     => Millennia
            case x1 if primEquals(x1, unsafe IO { JChronoUnit.ERAS })          => Eras
            case x1 if primEquals(x1, unsafe IO { JChronoUnit.FOREVER })       => Forever
            case _                                                      => bug!("unmarshalChronoUnit")
        }



}
