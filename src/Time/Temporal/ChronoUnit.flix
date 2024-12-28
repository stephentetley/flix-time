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

 mod Time.Temporal {

    pub restrictable enum ChronoUnit[i] with Eq, Order, ToString, Hash {
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



}

mod Time.Temporal.ChronoUnit {

    use Time.Temporal.ChronoUnit
    
    import java.time.temporal.{ChronoUnit => JChronoUnit}


    pub def marshalChronoUnit(x: ChronoUnit[s]): JChronoUnit = 
        choose x {
            case Nanos              => unsafe JChronoUnit.NANOS
            case Micros             => unsafe JChronoUnit.MICROS
            case Millis             => unsafe JChronoUnit.MILLIS
            case Seconds            => unsafe JChronoUnit.SECONDS
            case Minutes            => unsafe JChronoUnit.MINUTES
            case Hours              => unsafe JChronoUnit.HOURS
            case HalfDays           => unsafe JChronoUnit.HALF_DAYS
            case Days               => unsafe JChronoUnit.DAYS
            case Weeks              => unsafe JChronoUnit.WEEKS
            case Months             => unsafe JChronoUnit.MONTHS
            case Years              => unsafe JChronoUnit.YEARS
            case Decades            => unsafe JChronoUnit.DECADES
            case Centuries          => unsafe JChronoUnit.CENTURIES
            case Millennia          => unsafe JChronoUnit.MILLENNIA
            case Eras               => unsafe JChronoUnit.ERAS
            case Forever            => unsafe JChronoUnit.FOREVER
        }


    def primEquals(x: JChronoUnit, y: JChronoUnit): Bool =
        unsafe x.equals(y)

    pub def unmarshalChronoUnit(x: JChronoUnit): ChronoUnit[<Nanos, Micros, Millis, Seconds, Minutes, Hours, HalfDays, Days, Weeks, Months, Years, Decades, Centuries, Millennia, Eras, Forever>] = 
        match x {
            case x1 if primEquals(x1, unsafe JChronoUnit.NANOS)         => open_variant Nanos
            case x1 if primEquals(x1, unsafe JChronoUnit.MICROS)        => open_variant Micros
            case x1 if primEquals(x1, unsafe JChronoUnit.MILLIS)        => open_variant Millis
            case x1 if primEquals(x1, unsafe JChronoUnit.SECONDS)       => open_variant Seconds
            case x1 if primEquals(x1, unsafe JChronoUnit.MINUTES)       => open_variant Minutes
            case x1 if primEquals(x1, unsafe JChronoUnit.HOURS)         => open_variant Hours
            case x1 if primEquals(x1, unsafe JChronoUnit.HALF_DAYS)     => open_variant HalfDays
            case x1 if primEquals(x1, unsafe JChronoUnit.DAYS)          => open_variant Days
            case x1 if primEquals(x1, unsafe JChronoUnit.WEEKS)         => open_variant Weeks
            case x1 if primEquals(x1, unsafe JChronoUnit.MONTHS)        => open_variant Months
            case x1 if primEquals(x1, unsafe JChronoUnit.YEARS)         => open_variant Years
            case x1 if primEquals(x1, unsafe JChronoUnit.DECADES)       => open_variant Decades
            case x1 if primEquals(x1, unsafe JChronoUnit.CENTURIES)     => open_variant Centuries
            case x1 if primEquals(x1, unsafe JChronoUnit.MILLENNIA)     => open_variant Millennia
            case x1 if primEquals(x1, unsafe JChronoUnit.ERAS)          => open_variant Eras
            case x1 if primEquals(x1, unsafe JChronoUnit.FOREVER)       => open_variant Forever
            case _                                                      => bug!("unmarshalChronoUnit")
        }



}
