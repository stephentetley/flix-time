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

    pub enum MinguoEra {
        case BEFORE_ROC
        case ROC
    }   

    instance ToString[MinguoEra] {
        pub def toString(x: MinguoEra): String = match x {
            case BEFORE_ROC => "BEFORE_ROC"
            case ROC        => "ROC"
        }
    }

    instance Eq[MinguoEra] {
        pub def eq(x: MinguoEra, y: MinguoEra): Bool = match (x, y) {
            case (BEFORE_ROC, BEFORE_ROC) => true
            case (ROC, ROC) => true
            case (_, _) => false
        }
    }

    instance Hash[MinguoEra] {
        pub def hash(x: MinguoEra): Int = Time/Chrono/MinguoEra.hashCode(x)
    }    

}

namespace Time/Chrono/MinguoEra {

    use I18n.Locale;
    use I18n.Locale.{Locale};

    use Time/Chrono.MinguoEra;
    use Time/Chrono.MinguoEra.{BEFORE_ROC, ROC};
    use Time/Format.TextStyle;
    use Time/Temporal.ChronoField;
    use Time/Temporal.ValueRange;
    use Time/Temporal.ValueRange.{ValueRange};

    pub def toNative(x: MinguoEra): ##java.time.chrono.MinguoEra = 
        import static get java.time.chrono.MinguoEra.BEFORE_ROC    as getBEFORE_ROC;
        import static get java.time.chrono.MinguoEra.ROC           as getROC;
        match x {
            case BEFORE_ROC => getBEFORE_ROC()
            case ROC        => getROC() 
        } as & Pure

    def primEquals(x: ##java.time.chrono.MinguoEra, y: ##java.time.chrono.MinguoEra): Bool =
        import java.lang.Object.equals(##java.lang.Object);
        let x1 = x as ##java.lang.Object;
        let y1 = y as ##java.lang.Object;
        equals(x1, y1) as & Pure

    pub def fromNative(x: ##java.time.chrono.MinguoEra): MinguoEra =
        import static get java.time.chrono.MinguoEra.BEFORE_ROC    as getBEFORE_ROC;
        import static get java.time.chrono.MinguoEra.ROC           as getROC;
        match x {
            case x1 if primEquals(x1, getBEFORE_ROC())  => BEFORE_ROC
            case x1 if primEquals(x1, getROC())         => ROC
        } as & Pure

    pub def getValue(x: MinguoEra): Int32 = 
        import java.time.chrono.MinguoEra.getValue();
        let x1 = toNative(x);
        getValue(x1) as & Pure 


    pub def hashCode(x: MinguoEra): Int32 =
        import java.lang.Enum.hashCode();
        let en1 = toNative(x) as ##java.lang.Enum;
        hashCode(en1) as & Pure


    /// 
    pub def getDisplayName(x: MinguoEra, style: TextStyle, locale: Locale): String = 
        import java.time.chrono.MinguoEra.getDisplayName(##java.time.format.TextStyle, ##java.util.Locale);
        let x1 = toNative(x);
        let style1 = Time/Format/TextStyle.toNative(style);
        let Locale(locale1) = locale;
        getDisplayName(x1, style1, locale1) as & Pure
        
    pub def range(x: MinguoEra, field: ChronoField): ValueRange = 
        import java.time.chrono.Era.range(##java.time.temporal.TemporalField);
        let x1 = toNative(x) as ##java.time.chrono.Era;
        let field1 = Time/Temporal/ChronoField.toNative(field) as ##java.time.temporal.TemporalField;
        ValueRange(range(x1, field1) as & Pure)

}
