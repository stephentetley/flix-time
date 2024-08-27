/*
 * Copyright 2023 Stephen Tetley
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



mod Time.Temporal.IsoFields {

    use Time.Temporal.TemporalField
    use Time.Temporal.TemporalField.{TemporalField}
    use Time.Temporal.TemporalUnit
    use Time.Temporal.TemporalUnit.{TemporalUnit}
    import java.time.temporal.{IsoFields => JIsoFields}

    pub def dayOfQuarter(): TemporalField = TemporalField(unsafe JIsoFields.DAY_OF_QUARTER)

    pub def quarterOfYear(): TemporalField = TemporalField(unsafe JIsoFields.QUARTER_OF_YEAR)

    // pub def quarterYears(): TemporalUnit = TemporalField(unsafe JIsoFields.QUARTER_YEARS)

    pub def weekBasedYear(): TemporalField = TemporalField(unsafe JIsoFields.WEEK_BASED_YEAR)

    // pub def weekBasedYears(): TemporalUnit = TemporalField(unsafe JIsoFields.WEEK_BASED_YEARS)

    pub def weekOfWeekBasedYear(): TemporalField = TemporalField(unsafe JIsoFields.WEEK_OF_WEEK_BASED_YEAR)

}
