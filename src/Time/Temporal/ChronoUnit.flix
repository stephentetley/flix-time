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



namespace Time/Temporal/ChronoUnit {

    def primEquals(x: ##java.time.temporal.ChronoUnit, y: ##java.time.temporal.ChronoUnit): Bool =
        import java.lang.Enum.equals(##java.lang.Object): Bool & Pure;
        let x1 = x as ##java.lang.Enum;
        let y1 = y as ##java.lang.Object;
        equals(x1, y1)


    /// Bugs! should be unreachable due to class qualification at the API level...
    def assertChronoUnit(x: a, fn: Unit -> ##java.time.temporal.ChronoUnit, ans: b): b with ToString[b]= 
        try {
            if (primEquals(x as ##java.time.temporal.ChronoUnit, fn()))
                ans
            else 
                bug!("unmarshalFromNativeTemporalUnit - not ${ans}")
        } catch {
            case ex: ##java.lang.Exception => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        } 

    /// Nanos

    pub enum Nanos with ToString { case Nanos }

    pub def nanos(): Nanos = Nanos

    instance Time/Temporal/TemporalUnit.TemporalUnit[Nanos] {
        pub def marshalToNativeTemporalUnit(_: Nanos): ##java.time.temporal.TemporalUnit =
            import static get java.time.temporal.ChronoUnit.NANOS: ##java.time.temporal.ChronoUnit & Pure as get_NANOS;
            get_NANOS() as ##java.time.temporal.TemporalUnit

        pub def unmarshalFromNativeTemporalUnit(x: ##java.time.temporal.TemporalUnit): Nanos = 
            import static get java.time.temporal.ChronoUnit.NANOS: ##java.time.temporal.ChronoUnit & Pure as get_NANOS;
            assertChronoUnit(x, get_NANOS, Nanos) 
    }

    /// Micros

    pub enum Micros with ToString { case Micros }

    pub def micros(): Micros = Micros

    instance Time/Temporal/TemporalUnit.TemporalUnit[Micros] {
        pub def marshalToNativeTemporalUnit(_: Micros): ##java.time.temporal.TemporalUnit =
            import static get java.time.temporal.ChronoUnit.MICROS: ##java.time.temporal.ChronoUnit & Pure as get_MICROS;
            get_MICROS() as ##java.time.temporal.TemporalUnit

        pub def unmarshalFromNativeTemporalUnit(x: ##java.time.temporal.TemporalUnit): Micros = 
            import static get java.time.temporal.ChronoUnit.MICROS: ##java.time.temporal.ChronoUnit & Pure as get_MICROS;
            assertChronoUnit(x, get_MICROS, Micros) 
    }

    /// Years

    pub enum Years with ToString { case Years }

    pub def years(): Years = Years

    instance Time/Temporal/TemporalUnit.TemporalUnit[Years] {
        pub def marshalToNativeTemporalUnit(_: Years): ##java.time.temporal.TemporalUnit =
            import static get java.time.temporal.ChronoUnit.YEARS: ##java.time.temporal.ChronoUnit & Pure as get_YEARS;
            get_YEARS() as ##java.time.temporal.TemporalUnit

        pub def unmarshalFromNativeTemporalUnit(x: ##java.time.temporal.TemporalUnit): Years = 
            import static get java.time.temporal.ChronoUnit.YEARS: ##java.time.temporal.ChronoUnit & Pure as get_YEARS;
            assertChronoUnit(x, get_YEARS, Years) 
    }


/*
    pub enum ChronoUnit {
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


    instance FromString[ChronoUnit] {
        pub def fromString(x: String): Option[ChronoUnit] = match x {
            case "Nanos" => Some(Nanos)
            case "Micros" => Some(Micros)
            case "Millis" => Some(Millis)
            case "Seconds" => Some(Seconds)
            case "Minutes" => Some(Minutes)
            case "Hours" => Some(Hours)
            case "HalfDays" => Some(HalfDays)
            case "Days" => Some(Days)
            case "Weeks" => Some(Weeks)
            case "Months" => Some(Months)
            case "Years" => Some(Years)
            case "Decades" => Some(Decades)
            case "Centuries" => Some(Centuries)
            case "Millennia" => Some(Millennia)
            case "Eras" => Some(Eras)
            case "Forever" => Some(Forever)
            case _ => None
        }
    }

    instance Eq[ChronoUnit] {
        pub def eq(x: ChronoUnit, y: ChronoUnit): Bool = match (x,y) {
            case (Nanos, Nanos) => true
            case (Micros, Micros) => true
            case (Millis, Millis) => true
            case (Seconds, Seconds) => true
            case (Minutes, Minutes) => true
            case (Hours, Hours) => true
            case (HalfDays, HalfDays) => true
            case (Days, Days) => true
            case (Weeks, Weeks) => true
            case (Months, Months) => true
            case (Years, Years) => true
            case (Decades, Decades) => true
            case (Centuries, Centuries) => true
            case (Millennia, Millennia) => true
            case (Eras, Eras) => true
            case (Forever, Forever) => true
            case (_,_) => false
        }
    }

    instance Hash[ChronoUnit] {
        pub def hash(x: ChronoUnit): Int32 = Time/Temporal/ChronoUnit.hashCode(x)
    }

    instance Order[ChronoUnit] {
        pub def compare(x: ChronoUnit, y: ChronoUnit): Comparison =
            Time/Temporal/ChronoUnit.compareTo(x,y) |> Comparison.fromInt32
    }

    use Time/Temporal.ChronoUnit;
    use Time/Temporal.ChronoUnit.{Nanos, Micros, Millis, Seconds, Minutes,
            Hours, HalfDays, Days, Weeks, Months, Years, Decades, Centuries,
            Millennia, Eras, Forever};
//    use Time.Duration;
//    use Time.Duration.{Duration};

    pub def fromEnum(x: ChronoUnit): Int32 = match x {
        case Nanos => 0
        case Micros => 1
        case Millis => 2
        case Seconds => 3
        case Minutes => 4
        case Hours => 5
        case HalfDays => 6
        case Days => 7
        case Weeks => 8
        case Months => 9
        case Years => 10
        case Decades => 11
        case Centuries => 12
        case Millennia => 13
        case Eras => 14
        case Forever => 15
    }

    pub def toEnum(x: Int32): Option[ChronoUnit] = match x {
        case 0 => Some(Nanos)
        case 1 => Some(Micros)
        case 2 => Some(Millis)
        case 3 => Some(Seconds)
        case 4 => Some(Minutes)
        case 5 => Some(Hours)
        case 6 => Some(HalfDays)
        case 7 => Some(Days)
        case 8 => Some(Weeks)
        case 9 => Some(Months)
        case 10 => Some(Years)
        case 11 => Some(Decades)
        case 12 => Some(Centuries)
        case 13 => Some(Millennia)
        case 14 => Some(Eras)
        case 15 => Some(Forever)
        case _ =>   None
    }

    pub def marshal(x: ChronoUnit): ##java.time.temporal.ChronoUnit =
        import static get java.time.temporal.ChronoUnit.NANOS: ##java.time.temporal.ChronoUnit & Pure as getNANOS;
        import static get java.time.temporal.ChronoUnit.MICROS: ##java.time.temporal.ChronoUnit & Pure as getMICROS;
        import static get java.time.temporal.ChronoUnit.MILLIS: ##java.time.temporal.ChronoUnit & Pure as getMILLIS;
        import static get java.time.temporal.ChronoUnit.SECONDS: ##java.time.temporal.ChronoUnit & Pure as getSECONDS;
        import static get java.time.temporal.ChronoUnit.MINUTES: ##java.time.temporal.ChronoUnit & Pure as getMINUTES;
        import static get java.time.temporal.ChronoUnit.HOURS: ##java.time.temporal.ChronoUnit & Pure as getHOURS;
        import static get java.time.temporal.ChronoUnit.HALF_DAYS: ##java.time.temporal.ChronoUnit & Pure as getHALF_DAYS;
        import static get java.time.temporal.ChronoUnit.DAYS: ##java.time.temporal.ChronoUnit & Pure as getDAYS;
        import static get java.time.temporal.ChronoUnit.WEEKS: ##java.time.temporal.ChronoUnit & Pure as getWEEKS;
        import static get java.time.temporal.ChronoUnit.MONTHS: ##java.time.temporal.ChronoUnit & Pure as getMONTHS;
        import static get java.time.temporal.ChronoUnit.YEARS: ##java.time.temporal.ChronoUnit & Pure as getYEARS;
        import static get java.time.temporal.ChronoUnit.DECADES: ##java.time.temporal.ChronoUnit & Pure as getDECADES;
        import static get java.time.temporal.ChronoUnit.CENTURIES: ##java.time.temporal.ChronoUnit & Pure as getCENTURIES;
        import static get java.time.temporal.ChronoUnit.MILLENNIA: ##java.time.temporal.ChronoUnit & Pure as getMILLENNIA;
        import static get java.time.temporal.ChronoUnit.ERAS: ##java.time.temporal.ChronoUnit & Pure as getERAS;
        import static get java.time.temporal.ChronoUnit.FOREVER: ##java.time.temporal.ChronoUnit & Pure as getFOREVER;
        match x {
            case Nanos      => getNANOS()
            case Micros     => getMICROS()
            case Millis     => getMILLIS()
            case Seconds    => getSECONDS()
            case Minutes    => getMINUTES()
            case Hours      => getHOURS()
            case HalfDays   => getHALF_DAYS()
            case Days       => getDAYS()
            case Weeks      => getWEEKS()
            case Months     => getMONTHS()
            case Years      => getYEARS()
            case Decades    => getDECADES()
            case Centuries  => getCENTURIES()
            case Millennia  => getMILLENNIA()
            case Eras       => getERAS()
            case Forever    => getFOREVER()
        }


    pub def unmarshal(x: ##java.time.temporal.ChronoUnit): ChronoUnit =
        import static get java.time.temporal.ChronoUnit.NANOS: ##java.time.temporal.ChronoUnit & Pure as getNANOS;
        import static get java.time.temporal.ChronoUnit.MICROS: ##java.time.temporal.ChronoUnit & Pure as getMICROS;
        import static get java.time.temporal.ChronoUnit.MILLIS: ##java.time.temporal.ChronoUnit & Pure as getMILLIS;
        import static get java.time.temporal.ChronoUnit.SECONDS: ##java.time.temporal.ChronoUnit & Pure as getSECONDS;
        import static get java.time.temporal.ChronoUnit.MINUTES: ##java.time.temporal.ChronoUnit & Pure as getMINUTES;
        import static get java.time.temporal.ChronoUnit.HOURS: ##java.time.temporal.ChronoUnit & Pure as getHOURS;
        import static get java.time.temporal.ChronoUnit.HALF_DAYS: ##java.time.temporal.ChronoUnit & Pure as getHALF_DAYS;
        import static get java.time.temporal.ChronoUnit.DAYS: ##java.time.temporal.ChronoUnit & Pure as getDAYS;
        import static get java.time.temporal.ChronoUnit.WEEKS: ##java.time.temporal.ChronoUnit & Pure as getWEEKS;
        import static get java.time.temporal.ChronoUnit.MONTHS: ##java.time.temporal.ChronoUnit & Pure as getMONTHS;
        import static get java.time.temporal.ChronoUnit.YEARS: ##java.time.temporal.ChronoUnit & Pure as getYEARS;
        import static get java.time.temporal.ChronoUnit.DECADES: ##java.time.temporal.ChronoUnit & Pure as getDECADES;
        import static get java.time.temporal.ChronoUnit.CENTURIES: ##java.time.temporal.ChronoUnit & Pure as getCENTURIES;
        import static get java.time.temporal.ChronoUnit.MILLENNIA: ##java.time.temporal.ChronoUnit & Pure as getMILLENNIA;
        import static get java.time.temporal.ChronoUnit.ERAS: ##java.time.temporal.ChronoUnit & Pure as getERAS;
        import static get java.time.temporal.ChronoUnit.FOREVER: ##java.time.temporal.ChronoUnit & Pure as getFOREVER;
        match x {
            case x1 if primEquals(x1, getNANOS())       => Nanos
            case x1 if primEquals(x1, getMICROS())      => Micros
            case x1 if primEquals(x1, getMILLIS())      => Millis
            case x1 if primEquals(x1, getSECONDS())     => Seconds
            case x1 if primEquals(x1, getMINUTES())     => Minutes
            case x1 if primEquals(x1, getHOURS())       => Hours
            case x1 if primEquals(x1, getHALF_DAYS())   => HalfDays
            case x1 if primEquals(x1, getDAYS())        => Days
            case x1 if primEquals(x1, getWEEKS())       => Weeks
            case x1 if primEquals(x1, getMONTHS())      => Months
            case x1 if primEquals(x1, getYEARS())       => Years
            case x1 if primEquals(x1, getDECADES())     => Decades
            case x1 if primEquals(x1, getCENTURIES())   => Centuries
            case x1 if primEquals(x1, getMILLENNIA())   => Millennia
            case x1 if primEquals(x1, getERAS())        => Eras
            case x1 if primEquals(x1, getFOREVER())     => Forever
        }



    pub def hashCode(x: ChronoUnit): Int32 =
        import java.lang.Enum.hashCode(): Int32 & Pure;
        let en1 = marshal(x) as ##java.lang.Enum;
        hashCode(en1)

    pub def compareTo(x: ChronoUnit, y: ChronoUnit): Int32 =
        import java.lang.Enum.compareTo(##java.lang.Enum): Int32 & Pure;
        let x1 = marshal(x) as ##java.lang.Enum;
        let y1 = marshal(y) as ##java.lang.Enum;
        compareTo(x1, y1)

/*
    pub def getDuration(x: ChronoUnit): Duration =
        import java.time.temporal.ChronoUnit.getDuration();
        let x1 = marshal(x);
        Duration(getDuration(x1)) as & Pure

    pub def isDurationEstimated(x: ChronoUnit): Bool =
        import java.time.temporal.ChronoUnit.isDurationEstimated();
        let x1 = marshal(x);
        isDurationEstimated(x1) as & Pure

    pub def isDateBased(x: ChronoUnit): Bool =
        import java.time.temporal.ChronoUnit.isDateBased();
        let x1 = marshal(x);
        isDateBased(x1) as & Pure

    pub def isTimeBased(x: ChronoUnit): Bool =
        import java.time.temporal.ChronoUnit.isTimeBased();
        let x1 = marshal(x);
        isTimeBased(x1) as & Pure
*/

}
