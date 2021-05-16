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


/// DEPRECATED
/// It is planned to replace this with direct functions see Year.
/// This will remove the problem that not all ChronoUnits in the enum work for 
/// operations on a given type.

namespace Time/Temporal {

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

    instance ToString[ChronoUnit] {
        pub def toString(x: ChronoUnit): String = match x {
            case Nanos => "Nanos"
            case Micros => "Micros"
            case Millis => "Millis"
            case Seconds => "Seconds"
            case Minutes => "Minutes"
            case Hours => "Hours"
            case HalfDays => "HalfDays"
            case Days => "Days"
            case Weeks => "Weeks"
            case Months => "Months"
            case Years => "Years"
            case Decades => "Decades"
            case Centuries => "Centuries"
            case Millennia => "Millennia"
            case Eras => "Eras"
            case Forever => "Forever"
        }
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
        pub def hash(x: ChronoUnit): Int = Time/Temporal/ChronoUnit.hashCode(x)
    }

    instance Order[ChronoUnit] {
        pub def compare(x: ChronoUnit, y: ChronoUnit): Comparison = match Time/Temporal/ChronoUnit.compareTo(x,y) {
            case n if n < 0 => LessThan
            case n if n == 0 => EqualTo
            case _ => GreaterThan
        }
    }

}

/// TODO should provide functions from the TemporalUnit interface

namespace Time/Temporal/ChronoUnit {

    use Time/Temporal.ChronoUnit;
    use Time/Temporal.ChronoUnit.{Nanos, Micros, Millis, Seconds, Minutes,
            Hours, HalfDays, Days, Weeks, Months, Years, Decades, Centuries,
            Millennia, Eras, Forever};
    use Time.Duration;
    use Time.Duration.{Duration};

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

    pub def toNative(x: ChronoUnit): ##java.time.temporal.ChronoUnit = 
        import get java.time.temporal.ChronoUnit:NANOS      as getNANOS;
        import get java.time.temporal.ChronoUnit:MICROS     as getMICROS;
        import get java.time.temporal.ChronoUnit:MILLIS     as getMILLIS;
        import get java.time.temporal.ChronoUnit:SECONDS    as getSECONDS;
        import get java.time.temporal.ChronoUnit:MINUTES    as getMINUTES;
        import get java.time.temporal.ChronoUnit:HOURS      as getHOURS;
        import get java.time.temporal.ChronoUnit:HALF_DAYS  as getHALF_DAYS;
        import get java.time.temporal.ChronoUnit:DAYS       as getDAYS;
        import get java.time.temporal.ChronoUnit:WEEKS      as getWEEKS;
        import get java.time.temporal.ChronoUnit:MONTHS     as getMONTHS;
        import get java.time.temporal.ChronoUnit:YEARS      as getYEARS;
        import get java.time.temporal.ChronoUnit:DECADES    as getDECADES;
        import get java.time.temporal.ChronoUnit:CENTURIES  as getCENTURIES;
        import get java.time.temporal.ChronoUnit:MILLENNIA  as getMILLENNIA;
        import get java.time.temporal.ChronoUnit:ERAS       as getERAS;
        import get java.time.temporal.ChronoUnit:FOREVER    as getFOREVER;
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
            case Millennia   => getMILLENNIA()
            case Eras       => getERAS()
            case Forever    => getFOREVER()
        } as & Pure

    def primEquals(x: ##java.time.temporal.ChronoUnit, y: ##java.time.temporal.ChronoUnit): Bool =
        import java.lang.Object.equals(##java.lang.Object);
        let x1 = x as ##java.lang.Object;
        let y1 = y as ##java.lang.Object;
        equals(x1, y1) as & Pure

    pub def fromNative(x: ##java.time.temporal.ChronoUnit): ChronoUnit = 
        import get java.time.temporal.ChronoUnit:NANOS      as getNANOS;
        import get java.time.temporal.ChronoUnit:MICROS     as getMICROS;
        import get java.time.temporal.ChronoUnit:MILLIS     as getMILLIS;
        import get java.time.temporal.ChronoUnit:SECONDS    as getSECONDS;
        import get java.time.temporal.ChronoUnit:MINUTES    as getMINUTES;
        import get java.time.temporal.ChronoUnit:HOURS      as getHOURS;
        import get java.time.temporal.ChronoUnit:HALF_DAYS  as getHALF_DAYS;
        import get java.time.temporal.ChronoUnit:DAYS       as getDAYS;
        import get java.time.temporal.ChronoUnit:WEEKS      as getWEEKS;
        import get java.time.temporal.ChronoUnit:MONTHS     as getMONTHS;
        import get java.time.temporal.ChronoUnit:YEARS      as getYEARS;
        import get java.time.temporal.ChronoUnit:DECADES    as getDECADES;
        import get java.time.temporal.ChronoUnit:CENTURIES  as getCENTURIES;
        import get java.time.temporal.ChronoUnit:MILLENNIA  as getMILLENNIA;
        import get java.time.temporal.ChronoUnit:ERAS       as getERAS;
        import get java.time.temporal.ChronoUnit:FOREVER    as getFOREVER;
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
        } as & Pure

    

    pub def hashCode(x: ChronoUnit): Int32 =
        import java.lang.Enum.hashCode();
        let en1 = toNative(x) as ##java.lang.Enum;
        hashCode(en1) as & Pure

    pub def compareTo(x: ChronoUnit, y: ChronoUnit): Int32 = 
        import java.lang.Enum.compareTo(##java.lang.Enum);
        let x1 = toNative(x) as ##java.lang.Enum;
        let y1 = toNative(y) as ##java.lang.Enum;
        compareTo(x1, y1) as & Pure

    pub def getDuration(x: ChronoUnit): Duration =
        import java.time.temporal.ChronoUnit.getDuration();
        let x1 = toNative(x);
        Duration(getDuration(x1)) as & Pure

    pub def isDurationEstimated(x: ChronoUnit): Bool =
        import java.time.temporal.ChronoUnit.isDurationEstimated();
        let x1 = toNative(x);
        isDurationEstimated(x1) as & Pure

    pub def isDateBased(x: ChronoUnit): Bool =
        import java.time.temporal.ChronoUnit.isDateBased();
        let x1 = toNative(x);
        isDateBased(x1) as & Pure

    pub def isTimeBased(x: ChronoUnit): Bool =
        import java.time.temporal.ChronoUnit.isTimeBased();
        let x1 = toNative(x);
        isTimeBased(x1) as & Pure

}
