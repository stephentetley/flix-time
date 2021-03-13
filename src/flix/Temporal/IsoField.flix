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

    pub opaque type IsoField = ##java.time.temporal.TemporalField

    instance ToString[IsoField] {
        pub def toString(x: IsoField): String =
            import java.time.temporal.TemporalField.toString() as toString;
            let IsoField(x1) = x;
            toString(x1) as & Pure
    }

    
    instance Eq[IsoField] {
        pub def eq(x: IsoField, y: IsoField): Bool = Time/Temporal/IsoField.equals(x, y)
        pub def neq(x: IsoField, y: IsoField): Bool = not (x == y)
    }

    instance Hash[IsoField] {
        pub def hash(x: IsoField): Int = Time/Temporal/IsoField.hashCode(x)
    }

}

namespace Time/Temporal/IsoField {

    use I18n.Locale;
    use I18n.Locale.{Locale};
    use Time/Temporal.IsoField;
    use Time/Temporal.IsoField.{IsoField};
    use Time.Month;
    use Time.Year;
    use Time.Year.{Year};
    use Time/Temporal.ChronoUnit;
    use Time/Temporal.ValueRange;
    use Time/Temporal.ValueRange.{ValueRange};

    pub def dayOfQuarter(): IsoField = 
        import get java.time.temporal.IsoFields:DAY_OF_QUARTER as getDAY_OF_QUARTER;
        IsoField(getDAY_OF_QUARTER()) as & Pure

    pub def quarterOfYear(): IsoField = 
        import get java.time.temporal.IsoFields:QUARTER_OF_YEAR as getQUARTER_OF_YEAR;
        IsoField(getQUARTER_OF_YEAR()) as & Pure

    pub def weekBasedYear(): IsoField = 
        import get java.time.temporal.IsoFields:WEEK_BASED_YEAR as getWEEK_BASED_YEAR;
        IsoField(getWEEK_BASED_YEAR()) as & Pure

    pub def weekOfWeekBasedYear(): IsoField = 
        import get java.time.temporal.IsoFields:WEEK_OF_WEEK_BASED_YEAR as getWEEK_OF_WEEK_BASED_YEAR;
        IsoField(getWEEK_OF_WEEK_BASED_YEAR()) as & Pure

    pub def equals(x: IsoField, y: IsoField): Bool =
        import java.lang.Object.equals(##java.lang.Object);
        let IsoField(x1) = x;
        let IsoField(y1) = y;
        equals(x1 as ##java.lang.Object, y1 as ##java.lang.Object) as & Pure

    pub def hashCode(x: IsoField): Int32 =
        import java.lang.Object.hashCode();
        let IsoField(x1) = x;
        hashCode(x1 as ##java.lang.Object) as & Pure


    pub def getDisplayName(x: IsoField, locale: Locale): String =
        import java.time.temporal.TemporalField.getDisplayName(##java.util.Locale);
        let IsoField(x1) = x;
        let Locale(locale1) = locale;
        getDisplayName(x1, locale1) as & Pure


    pub def range(x: IsoField): ValueRange =
        import java.time.temporal.TemporalField.range();
        let IsoField(x1) = x;
        ValueRange(range(x1)) as & Pure

    pub def isTimeBased(x: IsoField): Bool = 
        import java.time.temporal.TemporalField.isTimeBased();
        let IsoField(x1) = x;
        isTimeBased(x1) as & Pure

    pub def isDateBased(x: IsoField): Bool = 
        import java.time.temporal.TemporalField.isDateBased();
        let IsoField(x1) = x;
        isDateBased(x1) as & Pure

    pub def getRangeUnit(x: IsoField): ChronoUnit = 
        import java.time.temporal.TemporalField.getRangeUnit();
        let IsoField(x1) = x;
        let ans = getRangeUnit(x1) as ##java.time.temporal.ChronoUnit & Pure;
        Time/Temporal/ChronoUnit.unmarshal(ans)
        
    pub def getBaseUnit(x: IsoField): ChronoUnit = 
        import java.time.temporal.TemporalField.getBaseUnit();
        let IsoField(x1) = x;
        let ans = getBaseUnit(x1) as ##java.time.temporal.ChronoUnit & Pure;
        Time/Temporal/ChronoUnit.unmarshal(ans)

    /// TODO needs corresponding function for every type that implements TemporalAccessor!
    pub def isSupportedByMonth(x: IsoField, m: Month): Bool = 
        import java.time.temporal.TemporalField.isSupportedBy(##java.time.temporal.TemporalAccessor);
        let IsoField(x1) = x;
        let m1 = Time/Month.marshal(m);
        isSupportedBy(x1, m1 as ##java.time.temporal.TemporalAccessor) as & Pure

    pub def isSupportedByYear(x: IsoField, y: Year): Bool = 
        import java.time.temporal.TemporalField.isSupportedBy(##java.time.temporal.TemporalAccessor);
        let IsoField(x1) = x;
        let Year(y1) = y;
        isSupportedBy(x1, y1 as ##java.time.temporal.TemporalAccessor) as & Pure  

    /// TODO needs corresponding function for every type that implements TemporalAccessor!
    pub def getFromMonth(x: IsoField, m: Month): Int64 = 
        import java.time.temporal.TemporalField.getFrom(##java.time.temporal.TemporalAccessor);
        let IsoField(x1) = x;
        let m1 = Time/Month.marshal(m);
        getFrom(x1, m1 as ##java.time.temporal.TemporalAccessor) as & Pure

    pub def getFromYear(x: IsoField, y: Year): Int64 = 
        import java.time.temporal.TemporalField.getFrom(##java.time.temporal.TemporalAccessor);
        let IsoField(x1) = x;
        let Year(y1) = y;
        getFrom(x1, y1 as ##java.time.temporal.TemporalAccessor) as & Pure        

    /// TODO needs corresponding function for every type that implements TemporalAccessor!
    pub def rangeRefinedByMonth(x: IsoField, m: Month): ValueRange = 
        import java.time.temporal.TemporalField.rangeRefinedBy(##java.time.temporal.TemporalAccessor);
        let IsoField(x1) = x;
        let m1 = Time/Month.marshal(m);
        ValueRange(rangeRefinedBy(x1, m1 as ##java.time.temporal.TemporalAccessor) as & Pure)

    pub def rangeRefinedByYear(x: IsoField, y: Year): ValueRange = 
        import java.time.temporal.TemporalField.rangeRefinedBy(##java.time.temporal.TemporalAccessor);
        let IsoField(x1) = x;
        let Year(y1) = y;
        ValueRange(rangeRefinedBy(x1, y1 as ##java.time.temporal.TemporalAccessor) as & Pure )      

}