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

namespace Time/Chrono {


    pub enum ThaiBuddhistEra with Eq, Order, ToString, Hash, Boxable {
        case BEFORE_BE
        case BE
    }   
 

}

namespace Time/Chrono/ThaiBuddhistEra {

    use Basis/Util.Locale;

    use Time/Chrono.ThaiBuddhistEra;
    use Time/Chrono.ThaiBuddhistEra.{BEFORE_BE, BE};
    use Time/Format.TextStyle;

    pub def marshal(x: ThaiBuddhistEra): ##java.time.chrono.ThaiBuddhistEra = 
        import static get java.time.chrono.ThaiBuddhistEra.BEFORE_BE: ##java.time.chrono.ThaiBuddhistEra \ {} as getBEFORE_BE;
        import static get java.time.chrono.ThaiBuddhistEra.BE: ##java.time.chrono.ThaiBuddhistEra \ {} as getBE;
        match x {
            case BEFORE_BE  => getBEFORE_BE()
            case BE         => getBE() 
        }

    def primEquals(x: ##java.time.chrono.ThaiBuddhistEra, y: ##java.time.chrono.ThaiBuddhistEra): Bool =
        import java.lang.Enum.equals(##java.lang.Object): Bool \ {};
        let x1 = unsafe_cast x as ##java.lang.Enum;
        let y1 = unsafe_cast y as ##java.lang.Object;
        equals(x1, y1)

    pub def unmarshal(x: ##java.time.chrono.ThaiBuddhistEra): ThaiBuddhistEra =
        import static get java.time.chrono.ThaiBuddhistEra.BEFORE_BE: ##java.time.chrono.ThaiBuddhistEra \ {} as getBEFORE_BE;
        import static get java.time.chrono.ThaiBuddhistEra.BE: ##java.time.chrono.ThaiBuddhistEra \ {} as getBE;
        match x {
            case x1 if primEquals(x1, getBEFORE_BE())  => BEFORE_BE
            case x1 if primEquals(x1, getBE())         => BE
        }

    pub def getValue(x: ThaiBuddhistEra): Int32 = 
        import java.time.chrono.ThaiBuddhistEra.getValue(): Int32 \ {};
        let x1 = marshal(x);
        getValue(x1)



    /// 
    pub def getDisplayName(style: TextStyle, locale: Locale, x: ThaiBuddhistEra): String = 
        import java.time.chrono.ThaiBuddhistEra.getDisplayName(##java.time.format.TextStyle, ##java.util.Locale): String \ {};
        let x1 = marshal(x);
        let style1 = Time/Format/TextStyle.marshal(style);
        let locale1 = Interop/Util/Locale.getHH(locale);
        getDisplayName(x1, style1, locale1)
        

        
    /// /// NOTE - maybe this should return Option [/ Result] ?
    /// pub def adjustInto(t: a, x: ThaiBuddhistEra): a with Temporal[a] = 
    ///     import java.time.chrono.Era.adjustInto(##java.time.temporal.Temporal): ##java.time.temporal.Temporal \ {};
    ///     let x1 = marshal(x) as ##java.time.chrono.Era;
    ///     let t1 = Time/Temporal/Temporal.marshalToNativeTemporal(t);
    ///     Time/Temporal/Temporal.unmarshalFromNativeTemporal(adjustInto(x1, t1))

 
    /// pub def get(t: a, x: ThaiBuddhistEra): Int32 with TemporalField[a] = 
    ///     import java.time.chrono.Era.get(##java.time.temporal.TemporalField): Int32 \ {};
    ///     let x1 = marshal(x) as ##java.time.chrono.Era;
    ///     let t1 = Time/Temporal/TemporalField.marshalToNativeTemporalField(t);
    ///     get(x1, t1)

    /// pub def getLong(t: a, x: ThaiBuddhistEra): Int64 with TemporalField[a] = 
    ///     import java.time.chrono.Era.getLong(##java.time.temporal.TemporalField): Int64 \ {};
    ///     let x1 = marshal(x) as ##java.time.chrono.Era;
    ///     let t1 = Time/Temporal/TemporalField.marshalToNativeTemporalField(t);
    ///     getLong(x1, t1)

}
