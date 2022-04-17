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


namespace Time/Temporal/ChronoField {

    use Time/Temporal.TemporalField;

    def primEquals(x: ##java.time.temporal.ChronoField, y: ##java.time.temporal.ChronoField): Bool =
        import java.lang.Enum.equals(##java.lang.Object): Bool & Pure;
        let x1 = x as ##java.lang.Enum;
        let y1 = y as ##java.lang.Object;
        equals(x1, y1)

    /// Bugs! should be unreachable due to class qualification at the API level...
    def assertChronoField(x: a, fn: Unit -> ##java.time.temporal.ChronoField, ans: b): b with ToString[b]= 
        try {
            if (primEquals(x as ##java.time.temporal.ChronoField, fn()))
                ans
            else 
                bug!("unmarshalFromNativeTemporalField - not ${ans}")
        } catch {
            case ex: ##java.lang.Exception => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }  


    /// NanoOfSecond

    pub enum NanoOfSecond with ToString { case NanoOfSecond }

    pub def nanoOfSecond(): NanoOfSecond = NanoOfSecond

    instance TemporalField[NanoOfSecond] {
        pub def marshalToNativeTemporalField(_: NanoOfSecond): ##java.time.temporal.TemporalField =
            import static get java.time.temporal.ChronoField.NANO_OF_SECOND: ##java.time.temporal.ChronoField & Pure as get_NANO_OF_SECOND;
            get_NANO_OF_SECOND() as ##java.time.temporal.TemporalField

        pub def unmarshalFromNativeTemporalField(x: ##java.time.temporal.TemporalField): NanoOfSecond = 
            import static get java.time.temporal.ChronoField.NANO_OF_SECOND: ##java.time.temporal.ChronoField & Pure as get_NANO_OF_SECOND;
            assertChronoField(x, get_NANO_OF_SECOND, NanoOfSecond) 
    }

    /// NanoOfDay

    pub enum NanoOfDay with ToString { case NanoOfDay }

    pub def nanoOfDay(): NanoOfDay = NanoOfDay

    instance TemporalField[NanoOfDay] {
        pub def marshalToNativeTemporalField(_: NanoOfDay): ##java.time.temporal.TemporalField =
            import static get java.time.temporal.ChronoField.NANO_OF_DAY: ##java.time.temporal.ChronoField & Pure as get_NANO_OF_DAY;
            get_NANO_OF_DAY() as ##java.time.temporal.TemporalField

        pub def unmarshalFromNativeTemporalField(x: ##java.time.temporal.TemporalField): NanoOfDay = 
            import static get java.time.temporal.ChronoField.NANO_OF_DAY: ##java.time.temporal.ChronoField & Pure as get_NANO_OF_DAY;
            assertChronoField(x, get_NANO_OF_DAY, NanoOfDay) 
    }

    /// MicroOfSecond

    pub enum MicroOfSecond with ToString { case MicroOfSecond }

    pub def microOfSecond(): MicroOfSecond = MicroOfSecond

    instance TemporalField[MicroOfSecond] {
        pub def marshalToNativeTemporalField(_: MicroOfSecond): ##java.time.temporal.TemporalField =
            import static get java.time.temporal.ChronoField.MICRO_OF_SECOND: ##java.time.temporal.ChronoField & Pure as get_MICRO_OF_SECOND;
            get_MICRO_OF_SECOND() as ##java.time.temporal.TemporalField

        pub def unmarshalFromNativeTemporalField(x: ##java.time.temporal.TemporalField): MicroOfSecond = 
            import static get java.time.temporal.ChronoField.MICRO_OF_SECOND: ##java.time.temporal.ChronoField & Pure as get_MICRO_OF_SECOND;
            assertChronoField(x, get_MICRO_OF_SECOND, MicroOfSecond) 
    }

    /// MicroOfDay

    pub enum MicroOfDay with ToString { case MicroOfDay }

    pub def microOfDay(): MicroOfDay = MicroOfDay

    instance TemporalField[MicroOfDay] {
        pub def marshalToNativeTemporalField(_: MicroOfDay): ##java.time.temporal.TemporalField =
            import static get java.time.temporal.ChronoField.MICRO_OF_DAY: ##java.time.temporal.ChronoField & Pure as get_MICRO_OF_DAY;
            get_MICRO_OF_DAY() as ##java.time.temporal.TemporalField

        pub def unmarshalFromNativeTemporalField(x: ##java.time.temporal.TemporalField): MicroOfDay = 
            import static get java.time.temporal.ChronoField.MICRO_OF_DAY: ##java.time.temporal.ChronoField & Pure as get_MICRO_OF_DAY;
            assertChronoField(x, get_MICRO_OF_DAY, MicroOfDay) 
    }

    /// MilliOfSecond

    pub enum MilliOfSecond with ToString { case MilliOfSecond }

    pub def milliOfSecond(): MilliOfSecond = MilliOfSecond

    instance TemporalField[MilliOfSecond] {
        pub def marshalToNativeTemporalField(_: MilliOfSecond): ##java.time.temporal.TemporalField =
            import static get java.time.temporal.ChronoField.MILLI_OF_SECOND: ##java.time.temporal.ChronoField & Pure as get_MILLI_OF_SECOND;
            get_MILLI_OF_SECOND() as ##java.time.temporal.TemporalField

        pub def unmarshalFromNativeTemporalField(x: ##java.time.temporal.TemporalField): MilliOfSecond = 
            import static get java.time.temporal.ChronoField.MILLI_OF_SECOND: ##java.time.temporal.ChronoField & Pure as get_MILLI_OF_SECOND;
            assertChronoField(x, get_MILLI_OF_SECOND, MilliOfSecond) 
    }

    /// MilliOfDay

    pub enum MilliOfDay with ToString { case MilliOfDay }

    pub def milliOfDay(): MilliOfDay = MilliOfDay

    instance TemporalField[MilliOfDay] {
        pub def marshalToNativeTemporalField(_: MilliOfDay): ##java.time.temporal.TemporalField =
            import static get java.time.temporal.ChronoField.MILLI_OF_DAY: ##java.time.temporal.ChronoField & Pure as get_MILLI_OF_DAY;
            get_MILLI_OF_DAY() as ##java.time.temporal.TemporalField

        pub def unmarshalFromNativeTemporalField(x: ##java.time.temporal.TemporalField): MilliOfDay = 
            import static get java.time.temporal.ChronoField.MILLI_OF_DAY: ##java.time.temporal.ChronoField & Pure as get_MILLI_OF_DAY;
            assertChronoField(x, get_MILLI_OF_DAY, MilliOfDay) 
    }
    
    /// SecondOfMinute

    pub enum SecondOfMinute with ToString { case SecondOfMinute }

    pub def secondOfMinute(): SecondOfMinute = SecondOfMinute

    instance TemporalField[SecondOfMinute] {
        pub def marshalToNativeTemporalField(_: SecondOfMinute): ##java.time.temporal.TemporalField =
            import static get java.time.temporal.ChronoField.SECOND_OF_MINUTE: ##java.time.temporal.ChronoField & Pure as get_SECOND_OF_MINUTE;
            get_SECOND_OF_MINUTE() as ##java.time.temporal.TemporalField

        pub def unmarshalFromNativeTemporalField(x: ##java.time.temporal.TemporalField): SecondOfMinute = 
            import static get java.time.temporal.ChronoField.SECOND_OF_MINUTE: ##java.time.temporal.ChronoField & Pure as get_SECOND_OF_MINUTE;
            assertChronoField(x, get_SECOND_OF_MINUTE, SecondOfMinute) 
    }

    /// SecondOfDay

    pub enum SecondOfDay with ToString { case SecondOfDay }

    pub def secondOfDay(): SecondOfDay = SecondOfDay

    instance TemporalField[SecondOfDay] {
        pub def marshalToNativeTemporalField(_: SecondOfDay): ##java.time.temporal.TemporalField =
            import static get java.time.temporal.ChronoField.SECOND_OF_DAY: ##java.time.temporal.ChronoField & Pure as get_SECOND_OF_DAY;
            get_SECOND_OF_DAY() as ##java.time.temporal.TemporalField

        pub def unmarshalFromNativeTemporalField(x: ##java.time.temporal.TemporalField): SecondOfDay = 
            import static get java.time.temporal.ChronoField.SECOND_OF_DAY: ##java.time.temporal.ChronoField & Pure as get_SECOND_OF_DAY;
            assertChronoField(x, get_SECOND_OF_DAY, SecondOfDay) 
    }

    /// MinuteOfHour

    pub enum MinuteOfHour with ToString { case MinuteOfHour }

    pub def minuteOfHour(): MinuteOfHour = MinuteOfHour

    instance TemporalField[MinuteOfHour] {
        pub def marshalToNativeTemporalField(_: MinuteOfHour): ##java.time.temporal.TemporalField =
            import static get java.time.temporal.ChronoField.MINUTE_OF_HOUR: ##java.time.temporal.ChronoField & Pure as get_MINUTE_OF_HOUR;
            get_MINUTE_OF_HOUR() as ##java.time.temporal.TemporalField

        pub def unmarshalFromNativeTemporalField(x: ##java.time.temporal.TemporalField): MinuteOfHour = 
            import static get java.time.temporal.ChronoField.MINUTE_OF_HOUR: ##java.time.temporal.ChronoField & Pure as get_MINUTE_OF_HOUR;
            assertChronoField(x, get_MINUTE_OF_HOUR, MinuteOfHour) 
    }

    /// MinuteOfDay

    pub enum MinuteOfDay with ToString { case MinuteOfDay }

    pub def minuteOfDay(): MinuteOfDay = MinuteOfDay

    instance TemporalField[MinuteOfDay] {
        pub def marshalToNativeTemporalField(_: MinuteOfDay): ##java.time.temporal.TemporalField =
            import static get java.time.temporal.ChronoField.MINUTE_OF_DAY: ##java.time.temporal.ChronoField & Pure as get_MINUTE_OF_DAY;
            get_MINUTE_OF_DAY() as ##java.time.temporal.TemporalField

        pub def unmarshalFromNativeTemporalField(x: ##java.time.temporal.TemporalField): MinuteOfDay = 
            import static get java.time.temporal.ChronoField.MINUTE_OF_DAY: ##java.time.temporal.ChronoField & Pure as get_MINUTE_OF_DAY;
            assertChronoField(x, get_MINUTE_OF_DAY, MinuteOfDay) 
    }

    /// HourOfAmPm

    pub enum HourOfAmPm with ToString { case HourOfAmPm }

    pub def hourOfAmPm(): HourOfAmPm = HourOfAmPm

    instance TemporalField[HourOfAmPm] {
        pub def marshalToNativeTemporalField(_: HourOfAmPm): ##java.time.temporal.TemporalField =
            import static get java.time.temporal.ChronoField.HOUR_OF_AMPM: ##java.time.temporal.ChronoField & Pure as get_HOUR_OF_AMPM;
            get_HOUR_OF_AMPM() as ##java.time.temporal.TemporalField

        pub def unmarshalFromNativeTemporalField(x: ##java.time.temporal.TemporalField): HourOfAmPm = 
            import static get java.time.temporal.ChronoField.HOUR_OF_AMPM: ##java.time.temporal.ChronoField & Pure as get_HOUR_OF_AMPM;
            assertChronoField(x, get_HOUR_OF_AMPM, HourOfAmPm) 
    }

    /// ClockHourOfAmPm

    pub enum ClockHourOfAmPm with ToString { case ClockHourOfAmPm }

    pub def clockHourOfAmPm(): ClockHourOfAmPm = ClockHourOfAmPm

    instance TemporalField[ClockHourOfAmPm] {
        pub def marshalToNativeTemporalField(_: ClockHourOfAmPm): ##java.time.temporal.TemporalField =
            import static get java.time.temporal.ChronoField.CLOCK_HOUR_OF_AMPM: ##java.time.temporal.ChronoField & Pure as get_CLOCK_HOUR_OF_AMPM;
            get_CLOCK_HOUR_OF_AMPM() as ##java.time.temporal.TemporalField

        pub def unmarshalFromNativeTemporalField(x: ##java.time.temporal.TemporalField): ClockHourOfAmPm = 
            import static get java.time.temporal.ChronoField.CLOCK_HOUR_OF_AMPM: ##java.time.temporal.ChronoField & Pure as get_CLOCK_HOUR_OF_AMPM;
            assertChronoField(x, get_CLOCK_HOUR_OF_AMPM, ClockHourOfAmPm) 
    }

    /// HourOfDay

    pub enum HourOfDay with ToString { case HourOfDay }

    pub def hourOfDay(): HourOfDay = HourOfDay

    instance TemporalField[HourOfDay] {
        pub def marshalToNativeTemporalField(_: HourOfDay): ##java.time.temporal.TemporalField =
            import static get java.time.temporal.ChronoField.HOUR_OF_DAY: ##java.time.temporal.ChronoField & Pure as get_HOUR_OF_DAY;
            get_HOUR_OF_DAY() as ##java.time.temporal.TemporalField

        pub def unmarshalFromNativeTemporalField(x: ##java.time.temporal.TemporalField): HourOfDay = 
            import static get java.time.temporal.ChronoField.HOUR_OF_DAY: ##java.time.temporal.ChronoField & Pure as get_HOUR_OF_DAY;
            assertChronoField(x, get_HOUR_OF_DAY, HourOfDay) 
    }

    /// ClockHourOfDay

    pub enum ClockHourOfDay with ToString { case ClockHourOfDay }

    pub def clockHourOfDay(): ClockHourOfDay = ClockHourOfDay

    instance TemporalField[ClockHourOfDay] {
        pub def marshalToNativeTemporalField(_: ClockHourOfDay): ##java.time.temporal.TemporalField =
            import static get java.time.temporal.ChronoField.CLOCK_HOUR_OF_DAY: ##java.time.temporal.ChronoField & Pure as get_CLOCK_HOUR_OF_DAY;
            get_CLOCK_HOUR_OF_DAY() as ##java.time.temporal.TemporalField

        pub def unmarshalFromNativeTemporalField(x: ##java.time.temporal.TemporalField): ClockHourOfDay = 
            import static get java.time.temporal.ChronoField.CLOCK_HOUR_OF_DAY: ##java.time.temporal.ChronoField & Pure as get_CLOCK_HOUR_OF_DAY;
            assertChronoField(x, get_CLOCK_HOUR_OF_DAY, ClockHourOfDay) 
    }

    /// AmPmOfDay

    pub enum AmPmOfDay with ToString { case AmPmOfDay }

    pub def amPmOfDay(): AmPmOfDay = AmPmOfDay

    instance TemporalField[AmPmOfDay] {
        pub def marshalToNativeTemporalField(_: AmPmOfDay): ##java.time.temporal.TemporalField =
            import static get java.time.temporal.ChronoField.AMPM_OF_DAY: ##java.time.temporal.ChronoField & Pure as get_AMPM_OF_DAY;
            get_AMPM_OF_DAY() as ##java.time.temporal.TemporalField

        pub def unmarshalFromNativeTemporalField(x: ##java.time.temporal.TemporalField): AmPmOfDay = 
            import static get java.time.temporal.ChronoField.AMPM_OF_DAY: ##java.time.temporal.ChronoField & Pure as get_AMPM_OF_DAY;
            assertChronoField(x, get_AMPM_OF_DAY, AmPmOfDay) 
    }

    /// DayOfWeek

    pub enum DayOfWeek with ToString { case DayOfWeek }

    pub def dayOfWeek(): DayOfWeek = DayOfWeek

    instance TemporalField[DayOfWeek] {
        pub def marshalToNativeTemporalField(_: DayOfWeek): ##java.time.temporal.TemporalField =
            import static get java.time.temporal.ChronoField.DAY_OF_WEEK: ##java.time.temporal.ChronoField & Pure as get_DAY_OF_WEEK;
            get_DAY_OF_WEEK() as ##java.time.temporal.TemporalField

        pub def unmarshalFromNativeTemporalField(x: ##java.time.temporal.TemporalField): DayOfWeek = 
            import static get java.time.temporal.ChronoField.DAY_OF_WEEK: ##java.time.temporal.ChronoField & Pure as get_DAY_OF_WEEK;
            assertChronoField(x, get_DAY_OF_WEEK, DayOfWeek) 
    }

    /// AlignedDayOfWeekInMonth

    pub enum AlignedDayOfWeekInMonth with ToString { case AlignedDayOfWeekInMonth }

    pub def alignedDayOfWeekInMonth(): AlignedDayOfWeekInMonth = AlignedDayOfWeekInMonth

    instance TemporalField[AlignedDayOfWeekInMonth] {
        pub def marshalToNativeTemporalField(_: AlignedDayOfWeekInMonth): ##java.time.temporal.TemporalField =
            import static get java.time.temporal.ChronoField.ALIGNED_DAY_OF_WEEK_IN_MONTH: ##java.time.temporal.ChronoField & Pure as get_ALIGNED_DAY_OF_WEEK_IN_MONTH;
            get_ALIGNED_DAY_OF_WEEK_IN_MONTH() as ##java.time.temporal.TemporalField

        pub def unmarshalFromNativeTemporalField(x: ##java.time.temporal.TemporalField): AlignedDayOfWeekInMonth = 
            import static get java.time.temporal.ChronoField.ALIGNED_DAY_OF_WEEK_IN_MONTH: ##java.time.temporal.ChronoField & Pure as get_ALIGNED_DAY_OF_WEEK_IN_MONTH;
            assertChronoField(x, get_ALIGNED_DAY_OF_WEEK_IN_MONTH, AlignedDayOfWeekInMonth) 
    }

    /// AlignedDayOfWeekInYear

    pub enum AlignedDayOfWeekInYear with ToString { case AlignedDayOfWeekInYear }

    pub def alignedDayOfWeekInYear(): AlignedDayOfWeekInYear = AlignedDayOfWeekInYear

    instance TemporalField[AlignedDayOfWeekInYear] {
        pub def marshalToNativeTemporalField(_: AlignedDayOfWeekInYear): ##java.time.temporal.TemporalField =
            import static get java.time.temporal.ChronoField.ALIGNED_DAY_OF_WEEK_IN_YEAR: ##java.time.temporal.ChronoField & Pure as get_ALIGNED_DAY_OF_WEEK_IN_YEAR;
            get_ALIGNED_DAY_OF_WEEK_IN_YEAR() as ##java.time.temporal.TemporalField

        pub def unmarshalFromNativeTemporalField(x: ##java.time.temporal.TemporalField): AlignedDayOfWeekInYear = 
            import static get java.time.temporal.ChronoField.ALIGNED_DAY_OF_WEEK_IN_YEAR: ##java.time.temporal.ChronoField & Pure as get_ALIGNED_DAY_OF_WEEK_IN_YEAR;
            assertChronoField(x, get_ALIGNED_DAY_OF_WEEK_IN_YEAR, AlignedDayOfWeekInYear) 
    }

    /// DayOfMonth

    pub enum DayOfMonth with ToString { case DayOfMonth }

    pub def dayOfMonth(): DayOfMonth = DayOfMonth

    instance TemporalField[DayOfMonth] {
        pub def marshalToNativeTemporalField(_: DayOfMonth): ##java.time.temporal.TemporalField =
            import static get java.time.temporal.ChronoField.DAY_OF_MONTH: ##java.time.temporal.ChronoField & Pure as get_DAY_OF_MONTH;
            get_DAY_OF_MONTH() as ##java.time.temporal.TemporalField

        pub def unmarshalFromNativeTemporalField(x: ##java.time.temporal.TemporalField): DayOfMonth = 
            import static get java.time.temporal.ChronoField.DAY_OF_MONTH: ##java.time.temporal.ChronoField & Pure as get_DAY_OF_MONTH;
            assertChronoField(x, get_DAY_OF_MONTH, DayOfMonth) 
    }

    /// DayOfYear

    pub enum DayOfYear with ToString { case DayOfYear }

    pub def dayOfYear(): DayOfYear = DayOfYear

    instance TemporalField[DayOfYear] {
        pub def marshalToNativeTemporalField(_: DayOfYear): ##java.time.temporal.TemporalField =
            import static get java.time.temporal.ChronoField.DAY_OF_YEAR: ##java.time.temporal.ChronoField & Pure as get_DAY_OF_YEAR;
            get_DAY_OF_YEAR() as ##java.time.temporal.TemporalField

        pub def unmarshalFromNativeTemporalField(x: ##java.time.temporal.TemporalField): DayOfYear = 
            import static get java.time.temporal.ChronoField.DAY_OF_YEAR: ##java.time.temporal.ChronoField & Pure as get_DAY_OF_YEAR;
            assertChronoField(x, get_DAY_OF_YEAR, DayOfYear) 
    }

    /// EpochDay

    pub enum EpochDay with ToString { case EpochDay }

    pub def epochDay(): EpochDay = EpochDay

    instance TemporalField[EpochDay] {
        pub def marshalToNativeTemporalField(_: EpochDay): ##java.time.temporal.TemporalField =
            import static get java.time.temporal.ChronoField.EPOCH_DAY: ##java.time.temporal.ChronoField & Pure as get_EPOCH_DAY;
            get_EPOCH_DAY() as ##java.time.temporal.TemporalField

        pub def unmarshalFromNativeTemporalField(x: ##java.time.temporal.TemporalField): EpochDay = 
            import static get java.time.temporal.ChronoField.EPOCH_DAY: ##java.time.temporal.ChronoField & Pure as get_EPOCH_DAY;
            assertChronoField(x, get_EPOCH_DAY, EpochDay) 
    }

    /// AlignedWeekOfMonth

    pub enum AlignedWeekOfMonth with ToString { case AlignedWeekOfMonth }

    pub def alignedWeekOfMonth(): AlignedWeekOfMonth = AlignedWeekOfMonth

    instance TemporalField[AlignedWeekOfMonth] {
        pub def marshalToNativeTemporalField(_: AlignedWeekOfMonth): ##java.time.temporal.TemporalField =
            import static get java.time.temporal.ChronoField.ALIGNED_WEEK_OF_MONTH: ##java.time.temporal.ChronoField & Pure as get_ALIGNED_WEEK_OF_MONTH;
            get_ALIGNED_WEEK_OF_MONTH() as ##java.time.temporal.TemporalField

        pub def unmarshalFromNativeTemporalField(x: ##java.time.temporal.TemporalField): AlignedWeekOfMonth = 
            import static get java.time.temporal.ChronoField.ALIGNED_WEEK_OF_MONTH: ##java.time.temporal.ChronoField & Pure as get_ALIGNED_WEEK_OF_MONTH;
            assertChronoField(x, get_ALIGNED_WEEK_OF_MONTH, AlignedWeekOfMonth) 
    }

    /// AlignedWeekOfYear

    pub enum AlignedWeekOfYear with ToString { case AlignedWeekOfYear }

    pub def alignedWeekOfYear(): AlignedWeekOfYear = AlignedWeekOfYear

    instance TemporalField[AlignedWeekOfYear] {
        pub def marshalToNativeTemporalField(_: AlignedWeekOfYear): ##java.time.temporal.TemporalField =
            import static get java.time.temporal.ChronoField.ALIGNED_WEEK_OF_YEAR: ##java.time.temporal.ChronoField & Pure as get_ALIGNED_WEEK_OF_YEAR;
            get_ALIGNED_WEEK_OF_YEAR() as ##java.time.temporal.TemporalField

        pub def unmarshalFromNativeTemporalField(x: ##java.time.temporal.TemporalField): AlignedWeekOfYear = 
            import static get java.time.temporal.ChronoField.ALIGNED_WEEK_OF_YEAR: ##java.time.temporal.ChronoField & Pure as get_ALIGNED_WEEK_OF_YEAR;
            assertChronoField(x, get_ALIGNED_WEEK_OF_YEAR, AlignedWeekOfYear) 
    }

    /// MonthOfYear

    pub enum MonthOfYear with ToString { case MonthOfYear }

    pub def monthOfYear(): MonthOfYear = MonthOfYear

    instance TemporalField[MonthOfYear] {
        pub def marshalToNativeTemporalField(_: MonthOfYear): ##java.time.temporal.TemporalField =
            import static get java.time.temporal.ChronoField.MONTH_OF_YEAR: ##java.time.temporal.ChronoField & Pure as get_MONTH_OF_YEAR;
            get_MONTH_OF_YEAR() as ##java.time.temporal.TemporalField

        pub def unmarshalFromNativeTemporalField(x: ##java.time.temporal.TemporalField): MonthOfYear = 
            import static get java.time.temporal.ChronoField.MONTH_OF_YEAR: ##java.time.temporal.ChronoField & Pure as get_MONTH_OF_YEAR;
            assertChronoField(x, get_MONTH_OF_YEAR, MonthOfYear) 
    }

    /// ProlepticMonth

    pub enum ProlepticMonth with ToString { case ProlepticMonth }

    pub def prolepticMonth(): ProlepticMonth = ProlepticMonth

    instance TemporalField[ProlepticMonth] {
        pub def marshalToNativeTemporalField(_: ProlepticMonth): ##java.time.temporal.TemporalField =
            import static get java.time.temporal.ChronoField.PROLEPTIC_MONTH: ##java.time.temporal.ChronoField & Pure as get_PROLEPTIC_MONTH;
            get_PROLEPTIC_MONTH() as ##java.time.temporal.TemporalField

        pub def unmarshalFromNativeTemporalField(x: ##java.time.temporal.TemporalField): ProlepticMonth = 
            import static get java.time.temporal.ChronoField.PROLEPTIC_MONTH: ##java.time.temporal.ChronoField & Pure as get_PROLEPTIC_MONTH;
            assertChronoField(x, get_PROLEPTIC_MONTH, ProlepticMonth) 
    }

    /// YearOfEra

    pub enum YearOfEra with ToString { case YearOfEra }

    pub def yearOfEra(): YearOfEra = YearOfEra

    instance TemporalField[YearOfEra] {
        pub def marshalToNativeTemporalField(_: YearOfEra): ##java.time.temporal.TemporalField =
            import static get java.time.temporal.ChronoField.YEAR_OF_ERA: ##java.time.temporal.ChronoField & Pure as get_YEAR_OF_ERA;
            get_YEAR_OF_ERA() as ##java.time.temporal.TemporalField

        pub def unmarshalFromNativeTemporalField(x: ##java.time.temporal.TemporalField): YearOfEra = 
            import static get java.time.temporal.ChronoField.YEAR_OF_ERA: ##java.time.temporal.ChronoField & Pure as get_YEAR_OF_ERA;
            assertChronoField(x, get_YEAR_OF_ERA, YearOfEra) 
    }

    /// Year

    pub enum Year with ToString { case Year }

    pub def year(): Year = Year

    instance TemporalField[Year] {
        pub def marshalToNativeTemporalField(_: Year): ##java.time.temporal.TemporalField =
            import static get java.time.temporal.ChronoField.YEAR: ##java.time.temporal.ChronoField & Pure as get_YEAR;
            get_YEAR() as ##java.time.temporal.TemporalField

        pub def unmarshalFromNativeTemporalField(x: ##java.time.temporal.TemporalField): Year = 
            import static get java.time.temporal.ChronoField.YEAR: ##java.time.temporal.ChronoField & Pure as get_YEAR;
            assertChronoField(x, get_YEAR, Year) 
    }

    /// Era

    pub enum Era with ToString { case Era }

    pub def era(): Era = Era

    instance TemporalField[Era] {
        pub def marshalToNativeTemporalField(_: Era): ##java.time.temporal.TemporalField =
            import static get java.time.temporal.ChronoField.ERA: ##java.time.temporal.ChronoField & Pure as get_ERA;
            get_ERA() as ##java.time.temporal.TemporalField

        pub def unmarshalFromNativeTemporalField(x: ##java.time.temporal.TemporalField): Era = 
            import static get java.time.temporal.ChronoField.ERA: ##java.time.temporal.ChronoField & Pure as get_ERA;
            assertChronoField(x, get_ERA, Era) 
    }

    /// InstantSeconds

    pub enum InstantSeconds with ToString { case InstantSeconds }

    pub def instantSeconds(): InstantSeconds = InstantSeconds

    instance TemporalField[InstantSeconds] {
        pub def marshalToNativeTemporalField(_: InstantSeconds): ##java.time.temporal.TemporalField =
            import static get java.time.temporal.ChronoField.INSTANT_SECONDS: ##java.time.temporal.ChronoField & Pure as get_INSTANT_SECONDS;
            get_INSTANT_SECONDS() as ##java.time.temporal.TemporalField

        pub def unmarshalFromNativeTemporalField(x: ##java.time.temporal.TemporalField): InstantSeconds = 
            import static get java.time.temporal.ChronoField.INSTANT_SECONDS: ##java.time.temporal.ChronoField & Pure as get_INSTANT_SECONDS;
            assertChronoField(x, get_INSTANT_SECONDS, InstantSeconds) 
    }

    /// OffsetSeconds

    pub enum OffsetSeconds with ToString { case OffsetSeconds }

    pub def offsetSeconds(): OffsetSeconds = OffsetSeconds

    instance TemporalField[OffsetSeconds] {
        pub def marshalToNativeTemporalField(_: OffsetSeconds): ##java.time.temporal.TemporalField =
            import static get java.time.temporal.ChronoField.OFFSET_SECONDS: ##java.time.temporal.ChronoField & Pure as get_OFFSET_SECONDS;
            get_OFFSET_SECONDS() as ##java.time.temporal.TemporalField

        pub def unmarshalFromNativeTemporalField(x: ##java.time.temporal.TemporalField): OffsetSeconds = 
            import static get java.time.temporal.ChronoField.OFFSET_SECONDS: ##java.time.temporal.ChronoField & Pure as get_OFFSET_SECONDS;
            assertChronoField(x, get_OFFSET_SECONDS, OffsetSeconds) 
    }

 
}
