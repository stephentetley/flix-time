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

    /// Millis

    pub enum Millis with ToString { case Millis }

    pub def millis(): Millis = Millis

    instance Time/Temporal/TemporalUnit.TemporalUnit[Millis] {
        pub def marshalToNativeTemporalUnit(_: Millis): ##java.time.temporal.TemporalUnit =
            import static get java.time.temporal.ChronoUnit.MILLIS: ##java.time.temporal.ChronoUnit & Pure as get_MILLIS;
            get_MILLIS() as ##java.time.temporal.TemporalUnit

        pub def unmarshalFromNativeTemporalUnit(x: ##java.time.temporal.TemporalUnit): Millis = 
            import static get java.time.temporal.ChronoUnit.MILLIS: ##java.time.temporal.ChronoUnit & Pure as get_MILLIS;
            assertChronoUnit(x, get_MILLIS, Millis) 
    }

    /// Seconds

    pub enum Seconds with ToString { case Seconds }

    pub def seconds(): Seconds = Seconds

    instance Time/Temporal/TemporalUnit.TemporalUnit[Seconds] {
        pub def marshalToNativeTemporalUnit(_: Seconds): ##java.time.temporal.TemporalUnit =
            import static get java.time.temporal.ChronoUnit.SECONDS: ##java.time.temporal.ChronoUnit & Pure as get_SECONDS;
            get_SECONDS() as ##java.time.temporal.TemporalUnit

        pub def unmarshalFromNativeTemporalUnit(x: ##java.time.temporal.TemporalUnit): Seconds = 
            import static get java.time.temporal.ChronoUnit.SECONDS: ##java.time.temporal.ChronoUnit & Pure as get_SECONDS;
            assertChronoUnit(x, get_SECONDS, Seconds) 
    }

    /// Minutes

    pub enum Minutes with ToString { case Minutes }

    pub def minutes(): Minutes = Minutes

    instance Time/Temporal/TemporalUnit.TemporalUnit[Minutes] {
        pub def marshalToNativeTemporalUnit(_: Minutes): ##java.time.temporal.TemporalUnit =
            import static get java.time.temporal.ChronoUnit.MINUTES: ##java.time.temporal.ChronoUnit & Pure as get_MINUTES;
            get_MINUTES() as ##java.time.temporal.TemporalUnit

        pub def unmarshalFromNativeTemporalUnit(x: ##java.time.temporal.TemporalUnit): Minutes = 
            import static get java.time.temporal.ChronoUnit.MINUTES: ##java.time.temporal.ChronoUnit & Pure as get_MINUTES;
            assertChronoUnit(x, get_MINUTES, Minutes) 
    }

    /// Hours

    pub enum Hours with ToString { case Hours }

    pub def hours(): Hours = Hours

    instance Time/Temporal/TemporalUnit.TemporalUnit[Hours] {
        pub def marshalToNativeTemporalUnit(_: Hours): ##java.time.temporal.TemporalUnit =
            import static get java.time.temporal.ChronoUnit.HOURS: ##java.time.temporal.ChronoUnit & Pure as get_HOURS;
            get_HOURS() as ##java.time.temporal.TemporalUnit

        pub def unmarshalFromNativeTemporalUnit(x: ##java.time.temporal.TemporalUnit): Hours = 
            import static get java.time.temporal.ChronoUnit.HOURS: ##java.time.temporal.ChronoUnit & Pure as get_HOURS;
            assertChronoUnit(x, get_HOURS, Hours) 
    }

    /// HalfDays

    pub enum HalfDays with ToString { case HalfDays }

    pub def halfDays(): HalfDays = HalfDays

    instance Time/Temporal/TemporalUnit.TemporalUnit[HalfDays] {
        pub def marshalToNativeTemporalUnit(_: HalfDays): ##java.time.temporal.TemporalUnit =
            import static get java.time.temporal.ChronoUnit.HALF_DAYS: ##java.time.temporal.ChronoUnit & Pure as get_HALF_DAYS;
            get_HALF_DAYS() as ##java.time.temporal.TemporalUnit

        pub def unmarshalFromNativeTemporalUnit(x: ##java.time.temporal.TemporalUnit): HalfDays = 
            import static get java.time.temporal.ChronoUnit.HALF_DAYS: ##java.time.temporal.ChronoUnit & Pure as get_HALF_DAYS;
            assertChronoUnit(x, get_HALF_DAYS, HalfDays) 
    }

    /// Days

    pub enum Days with ToString { case Days }

    pub def days(): Days = Days

    instance Time/Temporal/TemporalUnit.TemporalUnit[Days] {
        pub def marshalToNativeTemporalUnit(_: Days): ##java.time.temporal.TemporalUnit =
            import static get java.time.temporal.ChronoUnit.DAYS: ##java.time.temporal.ChronoUnit & Pure as get_DAYS;
            get_DAYS() as ##java.time.temporal.TemporalUnit

        pub def unmarshalFromNativeTemporalUnit(x: ##java.time.temporal.TemporalUnit): Days = 
            import static get java.time.temporal.ChronoUnit.DAYS: ##java.time.temporal.ChronoUnit & Pure as get_DAYS;
            assertChronoUnit(x, get_DAYS, Days) 
    }

    /// Weeks

    pub enum Weeks with ToString { case Weeks }

    pub def weeks(): Weeks = Weeks

    instance Time/Temporal/TemporalUnit.TemporalUnit[Weeks] {
        pub def marshalToNativeTemporalUnit(_: Weeks): ##java.time.temporal.TemporalUnit =
            import static get java.time.temporal.ChronoUnit.WEEKS: ##java.time.temporal.ChronoUnit & Pure as get_WEEKS;
            get_WEEKS() as ##java.time.temporal.TemporalUnit

        pub def unmarshalFromNativeTemporalUnit(x: ##java.time.temporal.TemporalUnit): Weeks = 
            import static get java.time.temporal.ChronoUnit.WEEKS: ##java.time.temporal.ChronoUnit & Pure as get_WEEKS;
            assertChronoUnit(x, get_WEEKS, Weeks) 
    }

    /// Months

    pub enum Months with ToString { case Months }

    pub def months(): Months = Months

    instance Time/Temporal/TemporalUnit.TemporalUnit[Months] {
        pub def marshalToNativeTemporalUnit(_: Months): ##java.time.temporal.TemporalUnit =
            import static get java.time.temporal.ChronoUnit.MONTHS: ##java.time.temporal.ChronoUnit & Pure as get_MONTHS;
            get_MONTHS() as ##java.time.temporal.TemporalUnit

        pub def unmarshalFromNativeTemporalUnit(x: ##java.time.temporal.TemporalUnit): Months = 
            import static get java.time.temporal.ChronoUnit.MONTHS: ##java.time.temporal.ChronoUnit & Pure as get_MONTHS;
            assertChronoUnit(x, get_MONTHS, Months) 
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

    /// Decades

    pub enum Decades with ToString { case Decades }

    pub def decades(): Decades = Decades

    instance Time/Temporal/TemporalUnit.TemporalUnit[Decades] {
        pub def marshalToNativeTemporalUnit(_: Decades): ##java.time.temporal.TemporalUnit =
            import static get java.time.temporal.ChronoUnit.DECADES: ##java.time.temporal.ChronoUnit & Pure as get_DECADES;
            get_DECADES() as ##java.time.temporal.TemporalUnit

        pub def unmarshalFromNativeTemporalUnit(x: ##java.time.temporal.TemporalUnit): Decades = 
            import static get java.time.temporal.ChronoUnit.DECADES: ##java.time.temporal.ChronoUnit & Pure as get_DECADES;
            assertChronoUnit(x, get_DECADES, Decades) 
    }

    /// Centuries

    pub enum Centuries with ToString { case Centuries }

    pub def centuries(): Centuries = Centuries

    instance Time/Temporal/TemporalUnit.TemporalUnit[Centuries] {
        pub def marshalToNativeTemporalUnit(_: Centuries): ##java.time.temporal.TemporalUnit =
            import static get java.time.temporal.ChronoUnit.CENTURIES: ##java.time.temporal.ChronoUnit & Pure as get_CENTURIES;
            get_CENTURIES() as ##java.time.temporal.TemporalUnit

        pub def unmarshalFromNativeTemporalUnit(x: ##java.time.temporal.TemporalUnit): Centuries = 
            import static get java.time.temporal.ChronoUnit.CENTURIES: ##java.time.temporal.ChronoUnit & Pure as get_CENTURIES;
            assertChronoUnit(x, get_CENTURIES, Centuries) 
    }

    /// Millennia

    pub enum Millennia with ToString { case Millennia }

    pub def millennia(): Millennia = Millennia

    instance Time/Temporal/TemporalUnit.TemporalUnit[Millennia] {
        pub def marshalToNativeTemporalUnit(_: Millennia): ##java.time.temporal.TemporalUnit =
            import static get java.time.temporal.ChronoUnit.MILLENNIA: ##java.time.temporal.ChronoUnit & Pure as get_MILLENNIA;
            get_MILLENNIA() as ##java.time.temporal.TemporalUnit

        pub def unmarshalFromNativeTemporalUnit(x: ##java.time.temporal.TemporalUnit): Millennia = 
            import static get java.time.temporal.ChronoUnit.MILLENNIA: ##java.time.temporal.ChronoUnit & Pure as get_MILLENNIA;
            assertChronoUnit(x, get_MILLENNIA, Millennia) 
    }

    /// Millennia

    pub enum Eras with ToString { case Eras }

    pub def eras(): Eras = Eras

    instance Time/Temporal/TemporalUnit.TemporalUnit[Eras] {
        pub def marshalToNativeTemporalUnit(_: Eras): ##java.time.temporal.TemporalUnit =
            import static get java.time.temporal.ChronoUnit.ERAS: ##java.time.temporal.ChronoUnit & Pure as get_ERAS;
            get_ERAS() as ##java.time.temporal.TemporalUnit

        pub def unmarshalFromNativeTemporalUnit(x: ##java.time.temporal.TemporalUnit): Eras = 
            import static get java.time.temporal.ChronoUnit.ERAS: ##java.time.temporal.ChronoUnit & Pure as get_ERAS;
            assertChronoUnit(x, get_ERAS, Eras) 
    }

    /// Forever

    pub enum Forever with ToString { case Forever }

    pub def forever(): Forever = Forever

    instance Time/Temporal/TemporalUnit.TemporalUnit[Forever] {
        pub def marshalToNativeTemporalUnit(_: Forever): ##java.time.temporal.TemporalUnit =
            import static get java.time.temporal.ChronoUnit.FOREVER: ##java.time.temporal.ChronoUnit & Pure as get_FOREVER;
            get_FOREVER() as ##java.time.temporal.TemporalUnit

        pub def unmarshalFromNativeTemporalUnit(x: ##java.time.temporal.TemporalUnit): Forever = 
            import static get java.time.temporal.ChronoUnit.FOREVER: ##java.time.temporal.ChronoUnit & Pure as get_FOREVER;
            assertChronoUnit(x, get_FOREVER, Forever) 
    }

}
