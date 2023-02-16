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



namespace Time/Temporal/IsoFields {

    use Time/Temporal/TemporalField
    use Time/Temporal/TemporalField.{TemporalField}
    use Time/Temporal/TemporalUnit
    use Time/Temporal/TemporalUnit.{TemporalUnit}

    pub def dayOfQuarter(): TemporalField =
        import static get java.time.temporal.IsoFields.DAY_OF_QUARTER: ##java.time.temporal.TemporalField \ {} as get_DAY_OF_QUARTER;
        get_DAY_OF_QUARTER() |> TemporalField

    pub def quarterOfYear(): TemporalField =
        import static get java.time.temporal.IsoFields.QUARTER_OF_YEAR: ##java.time.temporal.TemporalField \ {} as get_QUARTER_OF_YEAR;
        get_QUARTER_OF_YEAR() |> TemporalField

    pub def quarterYears(): TemporalUnit =
        import static get java.time.temporal.IsoFields.QUARTER_YEARS: ##java.time.temporal.TemporalUnit \ {} as get_QUARTER_YEARS;
        get_QUARTER_YEARS() |> TemporalUnit

    pub def weekBasedYear(): TemporalField =
        import static get java.time.temporal.IsoFields.WEEK_BASED_YEAR: ##java.time.temporal.TemporalField \ {} as get_WEEK_BASED_YEAR;
        get_WEEK_BASED_YEAR() |> TemporalField

    pub def weekBasedYears(): TemporalUnit =
        import static get java.time.temporal.IsoFields.WEEK_BASED_YEARS: ##java.time.temporal.TemporalUnit \ {} as get_WEEK_BASED_YEARS;
        get_WEEK_BASED_YEARS() |> TemporalUnit

    pub def weekOfWeekBasedYear(): TemporalField =
        import static get java.time.temporal.IsoFields.WEEK_OF_WEEK_BASED_YEAR: ##java.time.temporal.TemporalField \ {} as get_WEEK_OF_WEEK_BASED_YEAR;
        get_WEEK_OF_WEEK_BASED_YEAR() |> TemporalField
}
