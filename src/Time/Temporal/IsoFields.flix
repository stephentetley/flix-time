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

/// Notes - should provide methods from TemporalField interface


namespace Time/Temporal {

    pub opaque type IsoFields = ##java.time.temporal.TemporalField

    instance ToString[IsoFields] {
        pub def toString(x: IsoFields): String =
            import java.time.temporal.TemporalField.toString(): String & Pure;
            let IsoFields(x1) = x;
            toString(x1)
    }

    
    instance Eq[IsoFields] {
        pub def eq(x: IsoFields, y: IsoFields): Bool = Time/Temporal/IsoFields.equals(x, y)
    }

    instance Hash[IsoFields] {
        pub def hash(x: IsoFields): Int32 = Time/Temporal/IsoFields.hashCode(x)
    }

}

namespace Time/Temporal/IsoFields {

    use FlixSandbox/I18n.Locale;
    use FlixSandbox/I18n.Locale.{Locale};
    use Time/Temporal.IsoFields;
    use Time/Temporal.IsoFields.{IsoFields};
    use Time.Month;
    use Time.Year;
    use Time.Year.{Year};
    use Time/Temporal.ChronoUnit;
    use Time/Temporal.ValueRange;
    use Time/Temporal.ValueRange.{ValueRange};

    pub def dayOfQuarter(): IsoFields = 
        import static get java.time.temporal.IsoFields.DAY_OF_QUARTER: ##java.time.temporal.TemporalField & Pure as getDAY_OF_QUARTER;
        IsoFields(getDAY_OF_QUARTER())

    pub def quarterOfYear(): IsoFields = 
        import static get java.time.temporal.IsoFields.QUARTER_OF_YEAR: ##java.time.temporal.TemporalField & Pure as getQUARTER_OF_YEAR;
        IsoFields(getQUARTER_OF_YEAR())

    pub def weekBasedYear(): IsoFields = 
        import static get java.time.temporal.IsoFields.WEEK_BASED_YEAR: ##java.time.temporal.TemporalField & Pure as getWEEK_BASED_YEAR;
        IsoFields(getWEEK_BASED_YEAR())

    pub def weekOfWeekBasedYear(): IsoFields = 
        import static get java.time.temporal.IsoFields.WEEK_OF_WEEK_BASED_YEAR: ##java.time.temporal.TemporalField & Pure as getWEEK_OF_WEEK_BASED_YEAR;
        IsoFields(getWEEK_OF_WEEK_BASED_YEAR())

    pub def equals(x: IsoFields, y: IsoFields): Bool =
        import java.lang.Object.equals(##java.lang.Object): Bool & Pure;
        let IsoFields(x1) = x;
        let IsoFields(y1) = y;
        equals(x1 as ##java.lang.Object, y1 as ##java.lang.Object)

    pub def hashCode(x: IsoFields): Int32 =
        import java.lang.Object.hashCode(): Int32 & Pure;
        let IsoFields(x1) = x;
        hashCode(x1 as ##java.lang.Object)


    pub def getDisplayName(x: IsoFields, locale: Locale): String =
        import java.time.temporal.TemporalField.getDisplayName(##java.util.Locale): String & Pure;
        let IsoFields(x1) = x;
        let Locale(locale1) = locale;
        getDisplayName(x1, locale1)


    pub def range(x: IsoFields): ValueRange =
        import java.time.temporal.TemporalField.range(): ##java.time.temporal.ValueRange & Pure;
        let IsoFields(x1) = x;
        ValueRange(range(x1))

    pub def isTimeBased(x: IsoFields): Bool = 
        import java.time.temporal.TemporalField.isTimeBased(): Bool & Pure;
        let IsoFields(x1) = x;
        isTimeBased(x1)

    pub def isDateBased(x: IsoFields): Bool = 
        import java.time.temporal.TemporalField.isDateBased(): Bool & Pure;
        let IsoFields(x1) = x;
        isDateBased(x1)

    pub def getRangeUnit(x: IsoFields): ChronoUnit = 
        import java.time.temporal.TemporalField.getRangeUnit(): ##java.time.temporal.TemporalField & Pure;
        let IsoFields(x1) = x;
        let ans = getRangeUnit(x1) as ##java.time.temporal.ChronoUnit;
        Time/Temporal/ChronoUnit.unmarshal(ans)
        
    pub def getBaseUnit(x: IsoFields): ChronoUnit = 
        import java.time.temporal.TemporalField.getBaseUnit(): ##java.time.temporal.TemporalField & Pure;
        let IsoFields(x1) = x;
        let ans = getBaseUnit(x1) as ##java.time.temporal.ChronoUnit;
        Time/Temporal/ChronoUnit.unmarshal(ans)

    /// TODO needs corresponding function for every type that implements TemporalAccessor!
    pub def isSupportedByMonth(x: IsoFields, m: Month): Bool = 
        import java.time.temporal.TemporalField.isSupportedBy(##java.time.temporal.TemporalAccessor): Bool & Pure;
        let IsoFields(x1) = x;
        let m1 = Time/Month.marshal(m);
        isSupportedBy(x1, m1 as ##java.time.temporal.TemporalAccessor)

    pub def isSupportedByYear(x: IsoFields, y: Year): Bool = 
        import java.time.temporal.TemporalField.isSupportedBy(##java.time.temporal.TemporalAccessor): Bool & Pure;
        let IsoFields(x1) = x;
        let Year(y1) = y;
        isSupportedBy(x1, y1 as ##java.time.temporal.TemporalAccessor) 

    /// TODO needs corresponding function for every type that implements TemporalAccessor!
    pub def getFromMonth(x: IsoFields, m: Month): Int64 = 
        import java.time.temporal.TemporalField.getFrom(##java.time.temporal.TemporalAccessor): Int64 & Pure;
        let IsoFields(x1) = x;
        let m1 = Time/Month.marshal(m);
        getFrom(x1, m1 as ##java.time.temporal.TemporalAccessor)

    pub def getFromYear(x: IsoFields, y: Year): Int64 = 
        import java.time.temporal.TemporalField.getFrom(##java.time.temporal.TemporalAccessor): Int64 & Pure;
        let IsoFields(x1) = x;
        let Year(y1) = y;
        getFrom(x1, y1 as ##java.time.temporal.TemporalAccessor)       

    /// TODO needs corresponding function for every type that implements TemporalAccessor!
    pub def rangeRefinedByMonth(x: IsoFields, m: Month): ValueRange = 
        import java.time.temporal.TemporalField.rangeRefinedBy(##java.time.temporal.TemporalAccessor): ##java.time.temporal.ValueRange & Pure;
        let IsoFields(x1) = x;
        let m1 = Time/Month.marshal(m);
        ValueRange(rangeRefinedBy(x1, m1 as ##java.time.temporal.TemporalAccessor))

    pub def rangeRefinedByYear(x: IsoFields, y: Year): ValueRange = 
        import java.time.temporal.TemporalField.rangeRefinedBy(##java.time.temporal.TemporalAccessor): ##java.time.temporal.ValueRange & Pure;
        let IsoFields(x1) = x;
        let Year(y1) = y;
        ValueRange(rangeRefinedBy(x1, y1 as ##java.time.temporal.TemporalAccessor))

}
