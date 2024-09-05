/*
 * Copyright 2021 Stephen Tetley
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

mod Time.Chrono {


    pub enum ThaiBuddhistEra with Eq, Order, ToString, Hash {
        case BEFORE_BE
        case BE
    }   
 

}

mod Time.Chrono.ThaiBuddhistEra {

    use Locale.{Locale}

    use Time.Chrono.ThaiBuddhistEra
    use Time.Chrono.ThaiBuddhistEra.{BEFORE_BE, BE}
    use Time.Format.TextStyle

    import java.time.chrono.{ThaiBuddhistEra => JThaiBuddhistEra}
    import java.lang.{Enum => JEnum}

    pub def marshalThaiBuddhistEra(x: ThaiBuddhistEra): JThaiBuddhistEra = 
        match x {
            case BEFORE_BE  => unsafe JThaiBuddhistEra.BEFORE_BE
            case BE         => unsafe JThaiBuddhistEra.BE
        }

    def primEquals(x: JThaiBuddhistEra, y: JThaiBuddhistEra): Bool =
        let x1 = (checked_cast(x) : JEnum);
        let y1 = (checked_cast(y) : JEnum);
        unsafe x1.equals(y1)

    pub def unmarshalThaiBuddhistEra(x: JThaiBuddhistEra): ThaiBuddhistEra =
        match x {
            case x1 if primEquals(x1, unsafe JThaiBuddhistEra.BEFORE_BE)  => BEFORE_BE
            case x1 if primEquals(x1, unsafe JThaiBuddhistEra.BE)         => BE
            case _                                      => bug!("unmarshalThaiBuddhistEra")
        }

    pub def getValue(x: ThaiBuddhistEra): Int32 = 
        let x1 = marshalThaiBuddhistEra(x);
        unsafe x1.getValue()



    //
    pub def getDisplayName(style: TextStyle, locale: Locale, x: ThaiBuddhistEra): String = 
        let x1 = marshalThaiBuddhistEra(x);
        let style1 = Time.Format.TextStyle.marshalTextStyle(style);
        let Locale(locale1) = locale;
        unsafe x1.getDisplayName(style1, locale1)
        

        
    // NOTE - maybe this should return Option [/ Result] ?

    // pub def adjustInto(t: a, x: ThaiBuddhistEra): a with Temporal[a] = 
    //     import java.time.chrono.Era.adjustInto(##java.time.temporal.Temporal): ##java.time.temporal.Temporal \ {};
    //     let x1 = marshal(x) as ##java.time.chrono.Era;
    //     let t1 = Time.Temporal.Temporal.marshalToNativeTemporal(t);
    //     Time.Temporal.Temporal.unmarshalFromNativeTemporal(adjustInto(x1, t1))

 
    // pub def get(t: a, x: ThaiBuddhistEra): Int32 with TemporalField[a] = 
    //     import java.time.chrono.Era.get(##java.time.temporal.TemporalField): Int32 \ {};
    //     let x1 = marshal(x) as ##java.time.chrono.Era;
    //     let t1 = Time.Temporal.TemporalField.marshalToNativeTemporalField(t);
    //     get(x1, t1)

    // pub def getLong(t: a, x: ThaiBuddhistEra): Int64 with TemporalField[a] = 
    //     import java.time.chrono.Era.getLong(##java.time.temporal.TemporalField): Int64 \ {};
    //     let x1 = marshal(x) as ##java.time.chrono.Era;
    //     let t1 = Time.Temporal.TemporalField.marshalToNativeTemporalField(t);
    //     getLong(x1, t1)

}
