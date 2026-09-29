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



pub mod InteropTime.Chrono.HijrahChronology {

    
    use ee::EffectExtras.Fail.Fail
    use ae::JavaInterop.InteropErr
    use ae::JavaInterop.AdaptorExtras.Collection
    use ae::JavaInterop.AdaptorChecked
    use ae::JavaInterop.AdaptorUnchecked
    use cl::InteropLocale.Locale.Locale

    use InteropTime.Chrono.HijrahDate.HijrahDate
    use InteropTime.Chrono.HijrahEra.HijrahEra
    use InteropTime.Format.ResolverStyle.ResolverStyle
    use InteropTime.Format.TextStyle.TextStyle
    use InteropTime.Temporal.ValueRange.ValueRange
    use InteropTime.Temporal.ChronoField
    use InteropTime.LocalDate
    use InteropTime.ClockZ.ClockZ
    use InteropTime.ZoneId.ZoneId

    import java.time.chrono.{HijrahChronology => JHijrahChronology}
    import java.time.chrono.{Chronology => JChronology, 
        ChronoLocalDate => JChronoLocalDate, 
        HijrahDate => JHijrahDate,
        Era => JEra, 
        HijrahEra => JHijrahEra}
    import java.time.temporal.{ChronoField => JChronoField}
    import java.util.{Iterator => JIterator}
    import java.lang.{Exception => JException}

    pub eff HijrahChronology {
        def date(prolepticYear: {prolepticYear = Int32}, 
                    month: {month = Int32}, 
                    dayOfMonth: {dayOfMonth = Int32}): HijrahDate
        def dateWithEra(era: HijrahEra, 
                        yearOfEra: {yearOfEra = Int32}, 
                        month: {month = Int32}, 
                        dayOfMonth: {dayOfMonth = Int32}): HijrahDate

        def dateNow(): HijrahDate
        def dateNowWithClock(clock: ClockZ): HijrahDate 
        def dateNowWithZoneId(zone: ZoneId): HijrahDate
        def dateEpochDay(epochDay: Int64): HijrahDate
        def eraOf(i: Int32): HijrahEra
        def eras(): List[HijrahEra]
        def getCalendarType(): String
        def getDisplayName(style: TextStyle, loc: Locale): String
        def getId(): String
        def isLeapYear(prolepticYear: Int64): Bool
        def prolepticYear(era: HijrahEra, yearOfEra: Int32): Int32
    }


    pub def handle(f: a -> b \ ef): a -> b \ (ef + IO + Fail[InteropErr] - HijrahChronology) = x -> 
        let jchrono = JHijrahChronology.INSTANCE;
        run {
            f(x)
        } with handler HijrahChronology {
            
            def date(prolepticYear, month, dayOfMonth, k) = try {
                let d1 = jchrono.date(prolepticYear#prolepticYear, month#month, dayOfMonth#dayOfMonth);
                k(ToFlix.toFlix(d1))
            } catch {
                case ex: JException => Fail.report(InteropErr.Exception(ex.getMessage()))
            }

            def dateWithEra(hera, yearOfEra, month, dayOfMonth, k) = try {
                let hera1: JHijrahEra = ToJava.toJava(hera);
                let era1: JEra = checked_cast(hera1);
                let ans: JHijrahDate = jchrono.date(era1, yearOfEra#yearOfEra, month#month, dayOfMonth#dayOfMonth);
                k(ToFlix.toFlix(ans))
            } catch {
                case ex: JException => Fail.report(InteropErr.Exception(ex.getMessage()))
            }

            def dateNow(k) = {
                let d1 = jchrono.dateNow();
                k(ToFlix.toFlix(d1))
            }

            def dateNowWithClock(clock, k) = {
                let clock1 = ToJava.toJava(clock);
                let d1 = jchrono.dateNow(clock1);
                k(ToFlix.toFlix(d1))
            }

            def dateNowWithZoneId(zone, k) = {
                let zone1 = ToJava.toJava(zone);
                let d1 = jchrono.dateNow(zone1);
                k(ToFlix.toFlix(d1))
            }

            def dateEpochDay(epochDay, k) = try {
                let d1 = jchrono.dateEpochDay(epochDay);
                k(ToFlix.toFlix(d1))
            } catch {
                case ex: JException => Fail.report(InteropErr.Exception(ex.getMessage()))
            }

            def eraOf(i, k) = {
                let ans = jchrono.eraOf(i);
                k(ToFlix.toFlix(ans))
            }

            def eras(k) = {
                let jiter: JIterator[JEra] = unsafe IO { let xs = jchrono.eras(); xs.iterator() };
                let xs = Collection.toList(jiter, e1 -> unchecked_cast(e1 as JHijrahEra) |> ToFlix.toFlix);
                k(xs)
            }

            def getCalendarType(k) = {
                let ans = jchrono.getCalendarType();
                k(ans)
            }

            def getDisplayName(style, loc, k) = {
                let style1 = ToJava.toJava(style);
                let loc1 = ToJava.toJava(loc);
                let ans = jchrono.getDisplayName(style1, loc1);
                k(ans)
            }


            def getId(k) = {
                let ans = jchrono.getId();
                k(ans)
            }

            def isLeapYear(prolepticYear, k) = {
                let ans = jchrono.isLeapYear(prolepticYear);
                k(ans)
            }
        
            def prolepticYear(era, yearOfEra, k) = {
                let era1 = ToJava.toJava(era);
                let ans = jchrono.prolepticYear(era1, yearOfEra);
                k(ans)
            }

        }

    pub def runHijrahChronology(f: Unit -> a \ ef): a \ (ef + IO + Fail[InteropErr] - HijrahChronology) = 
        handle(f)()
    

}

