/*
 * Copyright 2026 Stephen Tetley
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

pub mod InteropTime.Compat { 

    use ee::EffectExtras.Fail.Fail
    use ae::JavaInterop.InteropErr
    use ae::JavaInterop.AdaptorChecked

    use InteropTime.InstantZ
    use InteropTime.LocalDate
    use InteropTime.LocalDateTime
    use InteropTime.ZonedDateTime
    use InteropTime.ZoneId

    import java.util.{Date => JDate}

    pub def utilDateToInstant(d: JDate): InstantZ \ Fail[InteropErr] = 
        AdaptorChecked.of(() -> unsafe IO { d.toInstant() })

    pub def utilDateToLocalDate(d: JDate): LocalDate \ IO + Fail[InteropErr] = 
        let ins = utilDateToInstant(d);
        let zone = ZoneId.systemDefault();
        InstantZ.toLocalDate(zone, ins)


    pub def utilDateToLocalDateTime(d: JDate): LocalDateTime \ IO + Fail[InteropErr] = 
        let ins = utilDateToInstant(d);
        let zone = ZoneId.systemDefault();
        InstantZ.toLocalDateTime(zone, ins)

    pub def instantToUtilDate(ins: InstantZ): JDate \ Fail[InteropErr] = 
        AdaptorChecked.extract(ins, ins1 -> unsafe IO { JDate.$from(ins1) })

    pub def localDateToUtilDate(ld: LocalDate): JDate \ IO + Fail[InteropErr] = 
        let ldt = LocalDate.atStartOfDay(ld);
        let zone = ZoneId.systemDefault();
        let zdt = LocalDateTime.toZonedDateTime(zone, ldt);
        let ins = ZonedDateTime.toInstant(zdt);
        instantToUtilDate(ins)

    pub def localDateTimeToUtilDate(ldt: LocalDateTime): JDate \ IO + Fail[InteropErr] = 
        let zone = ZoneId.systemDefault();
        let zdt = LocalDateTime.toZonedDateTime(zone, ldt);
        let ins = ZonedDateTime.toInstant(zdt);
        instantToUtilDate(ins)


}

