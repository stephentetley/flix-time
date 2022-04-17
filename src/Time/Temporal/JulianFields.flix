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


namespace Time/Temporal/JulianFields {

    use Time/Temporal.TemporalField;

    def primEqualsJulianFields(x: ##java.time.temporal.JulianFields, y: ##java.time.temporal.JulianFields): Bool =
        import java.lang.Enum.equals(##java.lang.Object): Bool & Pure;
        let x1 = x as ##java.lang.Enum;
        let y1 = y as ##java.lang.Object;
        equals(x1, y1)

    /// Bugs! should be unreachable due to class qualification at the API level...
    def assertJulianFields(x: a, fn: Unit -> ##java.time.temporal.JulianFields, ans: b): b with ToString[b]= 
        try {
            if (primEqualsJulianFields(x as ##java.time.temporal.JulianFields, fn()))
                ans
            else 
                bug!("unmarshalFromNativeTemporalField - not ${ans}")
        } catch {
            case ex: ##java.lang.Exception => bug!(FlixSandbox/Marshal.unmarshalExceptionMessage(ex) as & Pure)
        }  

    /// JULIAN_DAY JulianDay

    pub enum JulianDay with ToString { case JulianDay }

    pub def julianDay(): JulianDay = JulianDay

    instance TemporalField[JulianDay] {
        pub def marshalToNativeTemporalField(_: JulianDay): ##java.time.temporal.TemporalField =
            import static get java.time.temporal.JulianFields.JULIAN_DAY: ##java.time.temporal.JulianFields & Pure as get_JULIAN_DAY;
            get_JULIAN_DAY() as ##java.time.temporal.TemporalField

        pub def unmarshalFromNativeTemporalField(x: ##java.time.temporal.TemporalField): JulianDay = 
            import static get java.time.temporal.JulianFields.JULIAN_DAY: ##java.time.temporal.JulianFields & Pure as get_JULIAN_DAY;
            assertJulianFields(x, get_JULIAN_DAY, JulianDay) 
    }

    /// MODIFIED_JULIAN_DAY ModifiedJulianDay

    pub enum ModifiedJulianDay with ToString { case ModifiedJulianDay }

    pub def modifiedJulianDay(): ModifiedJulianDay = ModifiedJulianDay

    instance TemporalField[ModifiedJulianDay] {
        pub def marshalToNativeTemporalField(_: ModifiedJulianDay): ##java.time.temporal.TemporalField =
            import static get java.time.temporal.JulianFields.MODIFIED_JULIAN_DAY: ##java.time.temporal.JulianFields & Pure as get_MODIFIED_JULIAN_DAY;
            get_MODIFIED_JULIAN_DAY() as ##java.time.temporal.TemporalField

        pub def unmarshalFromNativeTemporalField(x: ##java.time.temporal.TemporalField): ModifiedJulianDay = 
            import static get java.time.temporal.JulianFields.MODIFIED_JULIAN_DAY: ##java.time.temporal.JulianFields & Pure as get_MODIFIED_JULIAN_DAY;
            assertJulianFields(x, get_MODIFIED_JULIAN_DAY, ModifiedJulianDay) 
    }

    /// RATA_DIE RataDie

    pub enum RataDie with ToString { case RataDie }

    pub def rataDie(): RataDie = RataDie

    instance TemporalField[RataDie] {
        pub def marshalToNativeTemporalField(_: RataDie): ##java.time.temporal.TemporalField =
            import static get java.time.temporal.JulianFields.RATA_DIE: ##java.time.temporal.JulianFields & Pure as get_RATA_DIE;
            get_RATA_DIE() as ##java.time.temporal.TemporalField

        pub def unmarshalFromNativeTemporalField(x: ##java.time.temporal.TemporalField): RataDie = 
            import static get java.time.temporal.JulianFields.RATA_DIE: ##java.time.temporal.JulianFields & Pure as get_RATA_DIE;
            assertJulianFields(x, get_RATA_DIE, RataDie) 
    }        

}

