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




namespace Time/Temporal/IsoFields {

    use Time/Temporal.TemporalField;
    use Time/Temporal.TemporalUnit;

    def primEqualsIsoFields(x: ##java.time.temporal.IsoFields, y: ##java.time.temporal.IsoFields): Bool =
        import java.lang.Enum.equals(##java.lang.Object): Bool & Pure;
        let x1 = x as ##java.lang.Enum;
        let y1 = y as ##java.lang.Object;
        equals(x1, y1)

    /// Bugs! should be unreachable due to class qualification at the API level...
    def assertIsoFields(x: a, fn: Unit -> ##java.time.temporal.IsoFields, ans: b): b with ToString[b]= 
        try {
            if (primEqualsIsoFields(x as ##java.time.temporal.IsoFields, fn()))
                ans
            else 
                bug!("unmarshalFromNativeTemporalField - not ${ans}")
        } catch {
            case ex: ##java.lang.Exception => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }  


    /// DayOfQuarter

    pub enum DayOfQuarter with ToString { case DayOfQuarter }

    pub def dayOfQuarter(): DayOfQuarter = DayOfQuarter

    instance TemporalField[DayOfQuarter] {
        pub def marshalToNativeTemporalField(_: DayOfQuarter): ##java.time.temporal.TemporalField =
            import static get java.time.temporal.IsoFields.DAY_OF_QUARTER: ##java.time.temporal.IsoFields & Pure as get_DAY_OF_QUARTER;
            get_DAY_OF_QUARTER() as ##java.time.temporal.TemporalField

        pub def unmarshalFromNativeTemporalField(x: ##java.time.temporal.TemporalField): DayOfQuarter = 
            import static get java.time.temporal.IsoFields.DAY_OF_QUARTER: ##java.time.temporal.IsoFields & Pure as get_DAY_OF_QUARTER;
            assertIsoFields(x, get_DAY_OF_QUARTER, DayOfQuarter) 
    }

    ///  QuarterOfYear

    pub enum QuarterOfYear with ToString { case QuarterOfYear }

    pub def quarterOfYear(): QuarterOfYear = QuarterOfYear

    instance TemporalField[QuarterOfYear] {
        pub def marshalToNativeTemporalField(_: QuarterOfYear): ##java.time.temporal.TemporalField =
            import static get java.time.temporal.IsoFields.QUARTER_OF_YEAR: ##java.time.temporal.IsoFields & Pure as get_QUARTER_OF_YEAR;
            get_QUARTER_OF_YEAR() as ##java.time.temporal.TemporalField

        pub def unmarshalFromNativeTemporalField(x: ##java.time.temporal.TemporalField): QuarterOfYear = 
            import static get java.time.temporal.IsoFields.QUARTER_OF_YEAR: ##java.time.temporal.IsoFields & Pure as get_QUARTER_OF_YEAR;
            assertIsoFields(x, get_QUARTER_OF_YEAR, QuarterOfYear) 
    }


    ///  WEEK_BASED_YEAR WeekBasedYear

    pub enum WeekBasedYear with ToString { case WeekBasedYear }

    pub def weekBasedYear(): WeekBasedYear = WeekBasedYear

    instance TemporalField[WeekBasedYear] {
        pub def marshalToNativeTemporalField(_: WeekBasedYear): ##java.time.temporal.TemporalField =
            import static get java.time.temporal.IsoFields.WEEK_BASED_YEAR: ##java.time.temporal.IsoFields & Pure as get_WEEK_BASED_YEAR;
            get_WEEK_BASED_YEAR() as ##java.time.temporal.TemporalField

        pub def unmarshalFromNativeTemporalField(x: ##java.time.temporal.TemporalField): WeekBasedYear = 
            import static get java.time.temporal.IsoFields.WEEK_BASED_YEAR: ##java.time.temporal.IsoFields & Pure as get_WEEK_BASED_YEAR;
            assertIsoFields(x, get_WEEK_BASED_YEAR, WeekBasedYear) 
    }


    /// WEEK_OF_WEEK_BASED_YEAR WeekOfWeekBasedYear
    
    pub enum WeekOfWeekBasedYear with ToString { case WeekOfWeekBasedYear }

    pub def weekOfWeekBasedYear(): WeekOfWeekBasedYear = WeekOfWeekBasedYear

    instance TemporalField[WeekOfWeekBasedYear] {
        pub def marshalToNativeTemporalField(_: WeekOfWeekBasedYear): ##java.time.temporal.TemporalField =
            import static get java.time.temporal.IsoFields.WEEK_OF_WEEK_BASED_YEAR: ##java.time.temporal.IsoFields & Pure as get_WEEK_OF_WEEK_BASED_YEAR;
            get_WEEK_OF_WEEK_BASED_YEAR() as ##java.time.temporal.TemporalField

        pub def unmarshalFromNativeTemporalField(x: ##java.time.temporal.TemporalField): WeekOfWeekBasedYear = 
            import static get java.time.temporal.IsoFields.WEEK_OF_WEEK_BASED_YEAR: ##java.time.temporal.IsoFields & Pure as get_WEEK_OF_WEEK_BASED_YEAR;
            assertIsoFields(x, get_WEEK_OF_WEEK_BASED_YEAR, WeekOfWeekBasedYear) 
    }


    /// QUARTER_YEARS QuarterYears (TemporalUnit)
    
    pub enum QuarterYears with ToString { case QuarterYears }

    pub def quarterYears(): QuarterYears = QuarterYears

    instance TemporalUnit[QuarterYears] {
        pub def marshalToNativeTemporalUnit(_: QuarterYears): ##java.time.temporal.TemporalUnit =
            import static get java.time.temporal.IsoFields.QUARTER_YEARS: ##java.time.temporal.IsoFields & Pure as get_QUARTER_YEARS;
            get_QUARTER_YEARS() as ##java.time.temporal.TemporalUnit

        pub def unmarshalFromNativeTemporalUnit(x: ##java.time.temporal.TemporalUnit): QuarterYears = 
            import static get java.time.temporal.IsoFields.QUARTER_YEARS: ##java.time.temporal.IsoFields & Pure as get_QUARTER_YEARS;
            assertIsoFields(x, get_QUARTER_YEARS, QuarterYears) 
    }

    /// WEEK_BASED_YEARS WeekBasedYears (TemporalUnit)
    
    pub enum WeekBasedYears with ToString { case WeekBasedYears }

    pub def weekBasedYears(): WeekBasedYears = WeekBasedYears

    instance TemporalUnit[WeekBasedYears] {
        pub def marshalToNativeTemporalUnit(_: WeekBasedYears): ##java.time.temporal.TemporalUnit =
            import static get java.time.temporal.IsoFields.WEEK_BASED_YEARS: ##java.time.temporal.IsoFields & Pure as get_WEEK_BASED_YEARS;
            get_WEEK_BASED_YEARS() as ##java.time.temporal.TemporalUnit

        pub def unmarshalFromNativeTemporalUnit(x: ##java.time.temporal.TemporalUnit): WeekBasedYears = 
            import static get java.time.temporal.IsoFields.WEEK_BASED_YEARS: ##java.time.temporal.IsoFields & Pure as get_WEEK_BASED_YEARS;
            assertIsoFields(x, get_WEEK_BASED_YEARS, WeekBasedYears) 
    }
}
