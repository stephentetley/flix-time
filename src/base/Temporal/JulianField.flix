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

    pub opaque type JulianField = ##java.time.temporal.TemporalField

    instance ToString[JulianField] {
        pub def toString(x: JulianField): String =
            import java.time.temporal.TemporalField.toString() as toString;
            let JulianField(x1) = x;
            toString(x1) as & Pure
    }
    
    instance Eq[JulianField] {
        pub def eq(x: JulianField, y: JulianField): Bool = Time/Temporal/JulianField.equals(x, y)
    }

    instance Hash[JulianField] {
        pub def hash(x: JulianField): Int32 = Time/Temporal/JulianField.hashCode(x)
    }

}

namespace Time/Temporal/JulianField {

    use Time/Temporal.JulianField;
    use Time/Temporal.JulianField.{JulianField};
    use Time/Temporal.ValueRange;
    use Time/Temporal.ValueRange.{ValueRange};

    pub def dayOfQuarter(): JulianField = 
        import static get java.time.temporal.JulianFields.JULIAN_DAY as getJULIAN_DAY;
        JulianField(getJULIAN_DAY()) as & Pure


    pub def modifiedJulianDay(): JulianField = 
        import static get java.time.temporal.JulianFields.MODIFIED_JULIAN_DAY as getMODIFIED_JULIAN_DAY;
        JulianField(getMODIFIED_JULIAN_DAY()) as & Pure

    pub def rataDie(): JulianField = 
        import static get java.time.temporal.JulianFields.RATA_DIE as getRATA_DIE;
        JulianField(getRATA_DIE()) as & Pure



    pub def equals(x: JulianField, y: JulianField): Bool =
        import java.lang.Object.equals(##java.lang.Object);
        let JulianField(x1) = x;
        let JulianField(y1) = y;
        equals(x1 as ##java.lang.Object, y1 as ##java.lang.Object) as & Pure

    pub def hashCode(x: JulianField): Int32 =
        import java.lang.Object.hashCode();
        let JulianField(x1) = x;
        hashCode(x1 as ##java.lang.Object) as & Pure

    pub def range(x: JulianField): ValueRange =
        import java.time.temporal.TemporalField.range();
        let JulianField(x1) = x;
        ValueRange(range(x1)) as & Pure

}

