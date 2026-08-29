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

    use EffectExtras.Fail.Fail
    use JavaInterop.AdaptorExtras2

    use InteropTime.InstantZ
    use InteropTime.LocalDate
    use InteropTime.LocalDateTime
    use InteropTime.ZonedDateTime
    use InteropTime.ZoneId

    import java.util.{Date => JDate}

    pub def jdateToInstant(d: JDate): InstantZ \ Fail = 
        AdaptorExtras2.of(() -> unsafe IO { d.toInstant() })

    pub def utilDateToLocaleDate(d: JDate): LocalDate \ IO + Fail = 
        let ins = jdateToInstant(d);
        let zone = ZoneId.systemDefault();
        let ldt = InstantZ.toLocalDateTime(zone, ins);
        LocalDateTime.toLocalDate(ldt)

    pub def localDateToUtilDate(d: LocalDate): JDate \ IO + Fail = 
        let ldt = LocalDate.atStartOfDay(d);
        let zone = ZoneId.systemDefault();
        let zdt = LocalDateTime.toZonedDateTime(zone, ldt);
        let ins = ZonedDateTime.toInstant(zdt);
        AdaptorExtras2.extract(ins, ins1 -> unsafe IO { JDate.$from(ins1) })



}

