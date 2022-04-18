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



namespace Time {

    use Time/Temporal.TemporalAccessor;
    use Time/Temporal.TemporalAdjuster;

    ///
    /// A wrapper around java.time.MonthDay.
    ///
    pub opaque type MonthDay = ##java.time.MonthDay


    instance ToString[MonthDay] {
        pub def toString(x: MonthDay): String =
            import java.time.MonthDay.toString(): String & Pure;
            let MonthDay(x1) = x;
            toString(x1)
    }

    ///
    /// Returns the month / day ...
    ///
    instance FromString[MonthDay] {
        pub def fromString(s: String): Option[MonthDay] = try {
            import static java.time.MonthDay.parse(##java.lang.CharSequence): ##java.time.MonthDay & Pure;
            let cs = String.trim(s) as ##java.lang.CharSequence;
            Some(MonthDay(parse(cs)))
        } catch {
            case _: ##java.time.format.DateTimeParseException => None
        }
    }

    instance Eq[MonthDay] {
        pub def eq(x: MonthDay, y: MonthDay): Bool = Time/MonthDay.equals(x, y)
    }

    instance Hash[MonthDay] {
        pub def hash(x: MonthDay): Int32 = Time/MonthDay.hashCode(x)
    }

    instance Order[MonthDay] {
        pub def compare(x: MonthDay, y: MonthDay): Comparison =
            Time/MonthDay.compareTo(x,y) |> Comparison.fromInt32
    }

    instance TemporalAccessor[MonthDay] {
        pub def marshalToNativeTemporalAccessor(x: MonthDay): ##java.time.temporal.TemporalAccessor =         
            Time/MonthDay.getMonthDay(x) as ##java.time.temporal.TemporalAccessor
        
        pub def unmarshalFromNativeTemporalAccessor(x: ##java.time.temporal.TemporalAccessor): MonthDay = 
            MonthDay(x as ##java.time.MonthDay)
    }

    instance TemporalAdjuster[MonthDay] {
        pub def marshalToNativeTemporalAdjuster(x: MonthDay): ##java.time.temporal.TemporalAdjuster =         
            Time/MonthDay.getMonthDay(x) as ##java.time.temporal.TemporalAdjuster
        
        pub def unmarshalFromNativeTemporalAdjuster(x: ##java.time.temporal.TemporalAdjuster): MonthDay = 
            MonthDay(x as ##java.time.MonthDay)
    }


}

namespace Time/MonthDay {

    use Time/Format.DateFormat;
    use Time/Format.DateTimeFormatter;
    use Time/Format.DateTimeFormatter.{DateTimeFormatter};
    use Time/Temporal.Temporal;
    use Time/Temporal.TemporalAccessor;
    use Time/Temporal.TemporalField;
    use Time.Month;
    use Time.MonthDay;
    use Time.MonthDay.{MonthDay};
    use Time.ZoneId;
    use Time.ZoneId.{ZoneId};
    
    pub def getMonthDay(x: MonthDay): ##java.time.MonthDay = 
        let MonthDay(x1) = x;
        x1

    /// NOTE - maybe this should return Option [/ Result] ?
    pub def fromTemporalAccessor(x: a): MonthDay with TemporalAccessor[a] = 
        import static java.time.MonthDay.from(##java.time.temporal.TemporalAccessor): ##java.time.MonthDay & Pure as fromTA;
        let x1 = Time/Temporal/TemporalAccessor.marshalToNativeTemporalAccessor(x);
        MonthDay(fromTA(x1))


    pub def of(r: {month :: Int32, dayOfMonth :: Int32}): MonthDay =
        import static java.time.MonthDay.of(Int32, Int32): ##java.time.MonthDay & Pure;
        MonthDay(of(r.month, r.dayOfMonth))

    pub def ofWithMonth(r: {month :: Month, dayOfMonth :: Int32}): MonthDay =
        import static java.time.MonthDay.of(##java.time.Month, Int32): ##java.time.MonthDay & Pure;
        let m1 = Time/Month.marshal(r.month);
        MonthDay(of(m1, r.dayOfMonth))

    pub def now(): MonthDay & Impure =
        import static java.time.MonthDay.now(): ##java.time.MonthDay & Impure;
        MonthDay(now())

    pub def nowWithZoneId(x: ZoneId): MonthDay & Impure =
        import static java.time.MonthDay.now(##java.time.ZoneId): ##java.time.MonthDay & Impure;
        let ZoneId(x1) = x;
        MonthDay(now(x1))

    ///
    /// Returns MonthDay `x` as a String using `formatter`.
    ///
    pub def format(formatter: DateTimeFormatter[DateFormat], x: MonthDay): String =
        import java.time.MonthDay.format(##java.time.format.DateTimeFormatter): String & Pure;
        let MonthDay(x1) = x;
        let DateTimeFormatter(fmtr) = formatter;
        format(x1, fmtr)

    ///
    /// Parse the string `s` as a MonthDay, leading or trailing whitespace is trimmed.
    /// The format of the input string should in the format mandated by `formatter`.
    ///
    /// A successful parse is wrapped with `Some(x)`, a parse failure is indicated by `None`.
    ///
    pub def parse(formatter: DateTimeFormatter[DateFormat], s: String): Option[MonthDay] =
        import static java.time.MonthDay.parse(##java.lang.CharSequence, ##java.time.format.DateTimeFormatter): ##java.time.MonthDay & Pure;
        try {
            let DateTimeFormatter(fmtr) = formatter;
            let cs = String.trim(s) as ##java.lang.CharSequence;
            Some(MonthDay(parse(cs, fmtr)))
        } catch {
            case _: ##java.time.format.DateTimeParseException => None
        }

    pub def equals(x: MonthDay, y: MonthDay): Bool =
        import java.time.MonthDay.equals(##java.lang.Object): Bool & Pure;
        let MonthDay(x1) = x;
        let MonthDay(y1) = y;
        equals(x1, y1 as ##java.lang.Object)

    pub def hashCode(x: MonthDay): Int32 =
        import java.time.MonthDay.hashCode(): Int32 & Pure;
        let MonthDay(x1) = x;
        hashCode(x1)

    ///
    /// Returns ...
    ///
    pub def compareTo(x: MonthDay, y: MonthDay): Int32 =
        import java.time.MonthDay.compareTo(##java.time.MonthDay): Int32 & Pure;
        let MonthDay(x1) = x;
        let MonthDay(y1) = y;
        compareTo(x1, y1)

    pub def getDayOfMonth(x: MonthDay): Int32 =
        import java.time.MonthDay.getDayOfMonth(): Int32 & Pure;
        let MonthDay(x1) = x;
        getDayOfMonth(x1)

    pub def withDayOfMonth(x: MonthDay, dayOfMonth: Int32): MonthDay =
        import java.time.MonthDay.withDayOfMonth(Int32): ##java.time.MonthDay & Pure;
        let MonthDay(x1) = x;
        MonthDay(withDayOfMonth(x1, dayOfMonth))

    pub def getMonth(x: MonthDay): Month =
        import java.time.MonthDay.getMonth(): ##java.time.Month & Pure;
        use Time/Month.{unmarshal};
        let MonthDay(x1) = x;
        unmarshal(getMonth(x1))

    pub def withMonth(x: MonthDay, month: Month): MonthDay =
        import java.time.MonthDay.with(##java.time.Month): ##java.time.MonthDay & Pure;
        use Time/Month.{marshal};
        let MonthDay(x1) = x;
        let m1 = marshal(month);
        MonthDay(with(x1, m1))

    pub def getMonthValue(x: MonthDay): Int32 =
        import java.time.MonthDay.getMonthValue(): Int32 & Pure;
        let MonthDay(x1) = x;
        getMonthValue(x1)

    pub def withMonthValue(x: MonthDay, month: Int32): MonthDay =
        import java.time.MonthDay.withMonth(Int32): ##java.time.MonthDay & Pure;
        let MonthDay(x1) = x;
        MonthDay(withMonth(x1, month))

    ///
    /// Returns `true` if `x` is before `y`.
    ///
    pub def isBefore(x: MonthDay, y: MonthDay): Bool =
        import java.time.MonthDay.isBefore(##java.time.MonthDay): Bool & Pure;
        let MonthDay(x1) = x;
        let MonthDay(y1) = y;
        isBefore(x1, y1)

    ///
    /// Returns `true` if `x` is after `y`.
    ///
    pub def isAfter(x: MonthDay, y: MonthDay): Bool =
        import java.time.MonthDay.isAfter(##java.time.MonthDay): Bool & Pure;
        let MonthDay(x1) = x;
        let MonthDay(y1) = y;
        isAfter(x1, y1)

    ///
    /// Returns `true` if `year` is valid for the MonthDay `x`.
    ///
    pub def isValidYear(x: MonthDay, year: Int32): Bool =
        import java.time.MonthDay.isValidYear(Int32): Bool & Pure;
        let MonthDay(x1) = x;
        isValidYear(x1, year)

    /// NOTE - maybe this should return Option [/ Result] ?
    pub def adjustInto(t: a, x: MonthDay): a with Temporal[a] = 
        import java.time.MonthDay.adjustInto(##java.time.temporal.Temporal): ##java.time.temporal.Temporal & Pure;
        let x1 = getMonthDay(x);
        let t1 = Time/Temporal/Temporal.marshalToNativeTemporal(t);
        Time/Temporal/Temporal.unmarshalFromNativeTemporal(adjustInto(x1, t1))


    pub def get(t: a, x: MonthDay): Int32 with TemporalField[a] = 
        import java.time.MonthDay.get(##java.time.temporal.TemporalField): Int32 & Pure;
        let x1 = getMonthDay(x);
        let t1 = Time/Temporal/TemporalField.marshalToNativeTemporalField(t);
        get(x1, t1)

    pub def getLong(t: a, x: MonthDay): Int64 with TemporalField[a] = 
        import java.time.MonthDay.getLong(##java.time.temporal.TemporalField): Int64 & Pure;
        let x1 = getMonthDay(x);
        let t1 = Time/Temporal/TemporalField.marshalToNativeTemporalField(t);
        getLong(x1, t1)

}
