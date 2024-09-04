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

    use Time.Temporal.ChronoUnit
    use Time.Temporal.ChronoUnit.{Nanos, Micros, Millis, Seconds, Minutes, Hours, HalfDays, Days, 
        Weeks, Months, Years, Decades, Centuries, Millenia, Eras, Forever}


    ///
    /// ChronoUnit
    ///
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
        case Millenia
        case Eras
        case Forever
    }

    instance FromString[ChronoUnit] {
        pub def fromString(x: String): Option[ChronoUnit] = match x {
            case "Nanos"        => Some(Nanos)
            case "Micros"       => Some(Micros)
            case "Millis"       => Some(Millis)
            case "Seconds"      => Some(Seconds)
            case "Minutes"      => Some(Minutes)
            case "Hours"        => Some(Hours)
            case "HalfDays"     => Some(HalfDays)
            case "Days"         => Some(Days)
            case "Weeks"        => Some(Weeks)
            case "Months"       => Some(Months)
            case "Years"        => Some(Years)
            case "Decades"      => Some(Decades)
            case "Centuries"    => Some(Centuries)
            case "Millenia"     => Some(Millenia)
            case "Eras"         => Some(Eras)
            case "Forever"      => Some(Forever)
            case _              => None
        }
    }

}

mod Time.Temporal.ChronoUnit {

    use Time.Temporal.ChronoUnit
    use Time.Temporal.ChronoUnit.{Nanos, Micros, Millis, Seconds, Minutes, Hours, HalfDays, Days, 
        Weeks, Months, Years, Decades, Centuries, Millenia, Eras, Forever}
    use Time.Temporal.TemporalUnit
    use Time.Temporal.TemporalUnit.{TemporalUnit}
    use Time.DurationZ
    use Time.DurationZ.{DurationZ}

    import java.time.temporal.{ChronoUnit => JChronoUnit}
    import java.time.temporal.{TemporalUnit => JTemporalUnit}
    import java.time.{Duration => JDuration}
    import java.lang.{Enum => JEnum}

    /// ## Marshal enums

    pub def marshalChronoUnit(x: ChronoUnit): JChronoUnit =
        match x {
            case Nanos      => unsafe JChronoUnit.NANOS
            case Micros     => unsafe JChronoUnit.MICROS
            case Millis     => unsafe JChronoUnit.MILLIS
            case Seconds    => unsafe JChronoUnit.SECONDS
            case Minutes    => unsafe JChronoUnit.MINUTES
            case Hours      => unsafe JChronoUnit.HOURS
            case HalfDays   => unsafe JChronoUnit.HALF_DAYS
            case Days       => unsafe JChronoUnit.DAYS
            case Weeks      => unsafe JChronoUnit.WEEKS
            case Months     => unsafe JChronoUnit.MONTHS
            case Years      => unsafe JChronoUnit.YEARS
            case Decades    => unsafe JChronoUnit.DECADES
            case Centuries  => unsafe JChronoUnit.CENTURIES
            case Millenia   => unsafe JChronoUnit.MILLENNIA
            case Eras       => unsafe JChronoUnit.ERAS
            case Forever    => unsafe JChronoUnit.FOREVER
        }

    def primEquals(x: JChronoUnit, y: JChronoUnit): Bool =
        let x1 = (checked_cast(x) : JEnum);
        let y1 = (checked_cast(y) : JEnum);
        unsafe x1.equals(y1)


    pub def unmarshalChronoUnit(x: JChronoUnit): ChronoUnit =
        match x {
            case x1 if primEquals(x1, unsafe JChronoUnit.NANOS)      => Nanos
            case x1 if primEquals(x1, unsafe JChronoUnit.MICROS)     => Micros
            case x1 if primEquals(x1, unsafe JChronoUnit.MILLIS)     => Millis
            case x1 if primEquals(x1, unsafe JChronoUnit.SECONDS)    => Seconds
            case x1 if primEquals(x1, unsafe JChronoUnit.MINUTES)    => Minutes
            case x1 if primEquals(x1, unsafe JChronoUnit.HOURS)      => Hours
            case x1 if primEquals(x1, unsafe JChronoUnit.HALF_DAYS)  => HalfDays
            case x1 if primEquals(x1, unsafe JChronoUnit.DAYS)       => Days
            case x1 if primEquals(x1, unsafe JChronoUnit.WEEKS)      => Weeks
            case x1 if primEquals(x1, unsafe JChronoUnit.MONTHS)     => Months
            case x1 if primEquals(x1, unsafe JChronoUnit.YEARS)      => Years
            case x1 if primEquals(x1, unsafe JChronoUnit.DECADES)    => Decades
            case x1 if primEquals(x1, unsafe JChronoUnit.CENTURIES)  => Centuries
            case x1 if primEquals(x1, unsafe JChronoUnit.MILLENNIA)  => Millenia
            case x1 if primEquals(x1, unsafe JChronoUnit.ERAS)       => Eras
            case x1 if primEquals(x1, unsafe JChronoUnit.FOREVER)    => Forever
            case _                                      => bug!("unmarshalTimeDefinition")     
        }


    pub def asTemporalUnit(x: ChronoUnit): TemporalUnit = 
        let x1 = Time.Temporal.ChronoUnit.marshalChronoUnit(x);
        let cx1 = unchecked_cast(x1 as JTemporalUnit);
        TemporalUnit(cx1)


    /// ChronoUnit functions

    pub def getDuration(x: ChronoUnit): DurationZ =
        let x1 = marshalChronoUnit(x);
        DurationZ(unsafe x1.getDuration())




}
