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
    use Time.Temporal.TemporalUnit
    use Time.Temporal.TemporalUnit.{TemporalUnit}

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

    instance Interop.Flix.Marshal[ChronoUnit] {
        pub def toJavaObject(x: ChronoUnit): ##java.lang.Object =
            let x1 = Time.Temporal.ChronoUnit.marshal(x);
            checked_cast(x1)

        pub def fromJavaObject(o: ##java.lang.Object): ChronoUnit = 
            let x1 = unchecked_cast(o as ##java.time.temporal.ChronoUnit);
            Time.Temporal.ChronoUnit.unmarshal(x1)
    }

    instance Time.Temporal.ImplementsTemporalUnit[ChronoUnit] {
        pub def toTemporalUnit(x: ChronoUnit): TemporalUnit = 
            let x1 = Time.Temporal.ChronoUnit.marshal(x);
            TemporalUnit(unchecked_cast(x1 as ##java.time.temporal.TemporalUnit))

        pub def fromTemporalUnit(x: TemporalUnit): ChronoUnit = 
            let TemporalUnit(x1) = x;
            Time.Temporal.ChronoUnit.unmarshal(unchecked_cast(x1 as ##java.time.temporal.ChronoUnit))
    }


}

mod Time.Temporal.ChronoUnit {

    use Time.Temporal.ChronoUnit
    use Time.Temporal.ChronoUnit.{Nanos, Micros, Millis, Seconds, Minutes, Hours, HalfDays, Days, 
        Weeks, Months, Years, Decades, Centuries, Millenia, Eras, Forever}

    use Time.DurationZ
    use Time.DurationZ.{DurationZ}

    /// ## Marshal enums

    pub def marshal(x: ChronoUnit): ##java.time.temporal.ChronoUnit =
        import static get java.time.temporal.ChronoUnit.NANOS: ##java.time.temporal.ChronoUnit \ {} as get_NANOS;
        import static get java.time.temporal.ChronoUnit.MICROS: ##java.time.temporal.ChronoUnit \ {} as get_MICROS;
        import static get java.time.temporal.ChronoUnit.MILLIS: ##java.time.temporal.ChronoUnit \ {} as get_MILLIS;
        import static get java.time.temporal.ChronoUnit.SECONDS: ##java.time.temporal.ChronoUnit \ {} as get_SECONDS;
        import static get java.time.temporal.ChronoUnit.MINUTES: ##java.time.temporal.ChronoUnit \ {} as get_MINUTES;
        import static get java.time.temporal.ChronoUnit.HOURS: ##java.time.temporal.ChronoUnit \ {} as get_HOURS;
        import static get java.time.temporal.ChronoUnit.HALF_DAYS: ##java.time.temporal.ChronoUnit \ {} as get_HALF_DAYS;
        import static get java.time.temporal.ChronoUnit.DAYS: ##java.time.temporal.ChronoUnit \ {} as get_DAYS;
        import static get java.time.temporal.ChronoUnit.WEEKS: ##java.time.temporal.ChronoUnit \ {} as get_WEEKS;
        import static get java.time.temporal.ChronoUnit.MONTHS: ##java.time.temporal.ChronoUnit \ {} as get_MONTHS;
        import static get java.time.temporal.ChronoUnit.YEARS: ##java.time.temporal.ChronoUnit \ {} as get_YEARS;
        import static get java.time.temporal.ChronoUnit.DECADES: ##java.time.temporal.ChronoUnit \ {} as get_DECADES;
        import static get java.time.temporal.ChronoUnit.CENTURIES: ##java.time.temporal.ChronoUnit \ {} as get_CENTURIES;
        import static get java.time.temporal.ChronoUnit.MILLENNIA: ##java.time.temporal.ChronoUnit \ {} as get_MILLENNIA;
        import static get java.time.temporal.ChronoUnit.ERAS: ##java.time.temporal.ChronoUnit \ {} as get_ERAS;
        import static get java.time.temporal.ChronoUnit.FOREVER: ##java.time.temporal.ChronoUnit \ {} as get_FOREVER;
        match x {
            case Nanos      => get_NANOS()
            case Micros     => get_MICROS()
            case Millis     => get_MILLIS()
            case Seconds    => get_SECONDS()
            case Minutes    => get_MINUTES()
            case Hours      => get_HOURS()
            case HalfDays   => get_HALF_DAYS()
            case Days       => get_DAYS()
            case Weeks      => get_WEEKS()
            case Months     => get_MONTHS()
            case Years      => get_YEARS()
            case Decades    => get_DECADES()
            case Centuries  => get_CENTURIES()
            case Millenia   => get_MILLENNIA()
            case Eras       => get_ERAS()
            case Forever    => get_FOREVER()
        }

    def primEquals(x: ##java.time.temporal.ChronoUnit, y: ##java.time.temporal.ChronoUnit): Bool =
        import java.lang.Enum.equals(##java.lang.Object): Bool \ {};
        let x1 = unchecked_cast(x as ##java.lang.Enum);
        let y1 = checked_cast(y);
        equals(x1, y1)


    pub def unmarshal(x: ##java.time.temporal.ChronoUnit): ChronoUnit =
        import static get java.time.temporal.ChronoUnit.NANOS: ##java.time.temporal.ChronoUnit \ {} as get_NANOS;
        import static get java.time.temporal.ChronoUnit.MICROS: ##java.time.temporal.ChronoUnit \ {} as get_MICROS;
        import static get java.time.temporal.ChronoUnit.MILLIS: ##java.time.temporal.ChronoUnit \ {} as get_MILLIS;
        import static get java.time.temporal.ChronoUnit.SECONDS: ##java.time.temporal.ChronoUnit \ {} as get_SECONDS;
        import static get java.time.temporal.ChronoUnit.MINUTES: ##java.time.temporal.ChronoUnit \ {} as get_MINUTES;
        import static get java.time.temporal.ChronoUnit.HOURS: ##java.time.temporal.ChronoUnit \ {} as get_HOURS;
        import static get java.time.temporal.ChronoUnit.HALF_DAYS: ##java.time.temporal.ChronoUnit \ {} as get_HALF_DAYS;
        import static get java.time.temporal.ChronoUnit.DAYS: ##java.time.temporal.ChronoUnit \ {} as get_DAYS;
        import static get java.time.temporal.ChronoUnit.WEEKS: ##java.time.temporal.ChronoUnit \ {} as get_WEEKS;
        import static get java.time.temporal.ChronoUnit.MONTHS: ##java.time.temporal.ChronoUnit \ {} as get_MONTHS;
        import static get java.time.temporal.ChronoUnit.YEARS: ##java.time.temporal.ChronoUnit \ {} as get_YEARS;
        import static get java.time.temporal.ChronoUnit.DECADES: ##java.time.temporal.ChronoUnit \ {} as get_DECADES;
        import static get java.time.temporal.ChronoUnit.CENTURIES: ##java.time.temporal.ChronoUnit \ {} as get_CENTURIES;
        import static get java.time.temporal.ChronoUnit.MILLENNIA: ##java.time.temporal.ChronoUnit \ {} as get_MILLENNIA;
        import static get java.time.temporal.ChronoUnit.ERAS: ##java.time.temporal.ChronoUnit \ {} as get_ERAS;
        import static get java.time.temporal.ChronoUnit.FOREVER: ##java.time.temporal.ChronoUnit \ {} as get_FOREVER;
        match x {
            case x1 if primEquals(x1, get_NANOS())      => Nanos
            case x1 if primEquals(x1, get_MICROS())     => Micros
            case x1 if primEquals(x1, get_MILLIS())     => Millis
            case x1 if primEquals(x1, get_SECONDS())    => Seconds
            case x1 if primEquals(x1, get_MINUTES())    => Minutes
            case x1 if primEquals(x1, get_HOURS())      => Hours
            case x1 if primEquals(x1, get_HALF_DAYS())  => HalfDays
            case x1 if primEquals(x1, get_DAYS())       => Days
            case x1 if primEquals(x1, get_WEEKS())      => Weeks
            case x1 if primEquals(x1, get_MONTHS())     => Months
            case x1 if primEquals(x1, get_YEARS())      => Years
            case x1 if primEquals(x1, get_DECADES())    => Decades
            case x1 if primEquals(x1, get_CENTURIES())  => Centuries
            case x1 if primEquals(x1, get_MILLENNIA())  => Millenia
            case x1 if primEquals(x1, get_ERAS())       => Eras
            case x1 if primEquals(x1, get_FOREVER())    => Forever
        }

    /// ## ChronoUnit functions

    pub def getDuration(x: ChronoUnit): DurationZ =
        import java.time.temporal.ChronoUnit.getDuration(): ##java.time.Duration \ {};
        let x1 = marshal(x);
        getDuration(x1) |> DurationZ




}
