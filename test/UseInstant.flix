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



mod UseInstant {

    use EffectExtras.Fail.Fail
    use InteropTime.InstantZ

    @Test
    pub def test01(): Unit \ IO = 
        let ins = InstantZ.now();
        println("Instant now(): ${ins}")

    @Test
    pub def test02(): Unit \ IO + Fail = 
        let ld = InteropTime.LocalDate.newLocalDate(year=2026, month=8, dayOfMonth=30);
        let zone = InteropTime.ZoneId.utc();
        let ins1 = InteropTime.LocalDate.toInstantAtStartOfDay(zone, ld);
        println("Instant ins1(): ${ins1}");
        println("Instant ins1.getNano(): ${InstantZ.getNano(ins1)}");
        println("Instant ins1.getNano(): ${InstantZ.getNanoOfSecond(ins1)}")

    @Test
    pub def test03(): Unit \ IO + Fail = 
        let ldt = InteropTime.LocalDateTime.now();
        let zone = InteropTime.ZoneId.utc();
        let ins1 = InteropTime.LocalDateTime.toInstant(zone, ldt);
        println("Instant ins1(): ${ins1}");
        println("Instant ins1.getNano(): ${InstantZ.getNano(ins1)}");
        println("Instant ins1.getNano(): ${InstantZ.getNanoOfSecond(ins1)}")

}
