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


namespace Time/Temporal {

    pub opaque type JulianFields = ##java.time.temporal.TemporalField

    instance ToString[JulianFields] {
        pub def toString(x: JulianFields): String =
            import java.time.temporal.TemporalField.toString(): String & Pure;
            let JulianFields(x1) = x;
            toString(x1)
    }
    
    instance Eq[JulianFields] {
        pub def eq(x: JulianFields, y: JulianFields): Bool = Time/Temporal/JulianFields.equals(x, y)
    }

    instance Hash[JulianFields] {
        pub def hash(x: JulianFields): Int32 = Time/Temporal/JulianFields.hashCode(x)
    }

}

namespace Time/Temporal/JulianFields {

    use Time/Temporal.JulianFields;
    use Time/Temporal.JulianFields.{JulianFields};
    use Time/Temporal.ValueRange;
    use Time/Temporal.ValueRange.{ValueRange};

    pub def dayOfQuarter(): JulianFields = 
        import static get java.time.temporal.JulianFields.JULIAN_DAY: ##java.time.temporal.TemporalField & Pure as getJULIAN_DAY;
        JulianFields(getJULIAN_DAY())


    pub def modifiedJulianDay(): JulianFields = 
        import static get java.time.temporal.JulianFields.MODIFIED_JULIAN_DAY: ##java.time.temporal.TemporalField & Pure as getMODIFIED_JULIAN_DAY;
        JulianFields(getMODIFIED_JULIAN_DAY())

    pub def rataDie(): JulianFields = 
        import static get java.time.temporal.JulianFields.RATA_DIE: ##java.time.temporal.TemporalField & Pure as getRATA_DIE;
        JulianFields(getRATA_DIE())



    pub def equals(x: JulianFields, y: JulianFields): Bool =
        import java.lang.Object.equals(##java.lang.Object): Bool & Pure;
        let JulianFields(x1) = x;
        let JulianFields(y1) = y;
        equals(x1 as ##java.lang.Object, y1 as ##java.lang.Object)

    pub def hashCode(x: JulianFields): Int32 =
        import java.lang.Object.hashCode(): Int32 & Pure;
        let JulianFields(x1) = x;
        hashCode(x1 as ##java.lang.Object)

    pub def range(x: JulianFields): ValueRange =
        import java.time.temporal.TemporalField.range(): ##java.time.temporal.ValueRange & Pure;
        let JulianFields(x1) = x;
        ValueRange(range(x1))

}

