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

use Time/Temporal.ChronoUnit;
use Time/Temporal.ChronoUnit.{Nanos, Micros, Millis, Seconds, Minutes, Hours, HalfDays,
                                Days, Weeks, Months, Years, Decades, Centuries, Millenia, 
                                Eras, Forever};
use Time.Duration;
use Time.Duration.{Duration};

namespace Time/Temporal {

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

}

namespace Time/Temporal/ChronoUnit {

    pub def marshal(x: ChronoUnit): ##java.time.temporal.ChronoUnit = 
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
            case Millenia   => getMILLENNIA()
            case Eras       => getERAS()
            case Forever    => getFOREVER()
        } as & Pure

    pub def unmarshal(x: ##java.time.temporal.ChronoUnit): ChronoUnit = 
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
            case x1 if x1 == getNANOS()     => Nanos
            case x1 if x1 == getMICROS()    => Micros
            case x1 if x1 == getMILLIS()    => Millis
            case x1 if x1 == getSECONDS()   => Seconds
            case x1 if x1 == getMINUTES()   => Minutes
            case x1 if x1 == getHOURS()     => Hours
            case x1 if x1 == getHALF_DAYS() => HalfDays
            case x1 if x1 == getDAYS()      => Days
            case x1 if x1 == getWEEKS()     => Weeks
            case x1 if x1 == getMONTHS()    => Months
            case x1 if x1 == getYEARS()     => Years
            case x1 if x1 == getDECADES()   => Decades
            case x1 if x1 == getCENTURIES() => Centuries
            case x1 if x1 == getMILLENNIA() => Millenia
            case x1 if x1 == getERAS()      => Eras
            case x1 if x1 == getFOREVER()   => Forever
        } as & Pure

    pub def getDuration(x: ChronoUnit): Duration =
        import java.time.temporal.ChronoUnit.getDuration();
        Duration(x.marshal().getDuration()) as & Pure

    pub def isDurationEstimated(x: ChronoUnit): Bool =
        import java.time.temporal.ChronoUnit.isDurationEstimated();
        x.marshal().isDurationEstimated() as & Pure

    pub def isDateBased(x: ChronoUnit): Bool =
        import java.time.temporal.ChronoUnit.isDateBased();
        x.marshal().isDateBased() as & Pure

    pub def isTimeBased(x: ChronoUnit): Bool =
        import java.time.temporal.ChronoUnit.isTimeBased();
        x.marshal().isTimeBased() as & Pure


    pub def toString(x: ChronoUnit): String =
        import java.time.temporal.ChronoUnit.toString();
        x.marshal().toString() as & Pure

}