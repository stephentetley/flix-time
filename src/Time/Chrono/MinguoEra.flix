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


    pub enum MinguoEra with Eq, Order, ToString, Hash, Boxable {
        case BEFORE_ROC
        case ROC
    }   
  

}

namespace Time/Chrono/MinguoEra {

    use FlixSandbox/I18n.Locale;
    use FlixSandbox/I18n.Locale.{Locale};

    use Time/Chrono.MinguoEra;
    use Time/Chrono.MinguoEra.{BEFORE_ROC, ROC};
    use Time/Format.TextStyle;
    use Time/Temporal.ValueRange;
    use Time/Temporal.ValueRange.{ValueRange};

    pub def marshal(x: MinguoEra): ##java.time.chrono.MinguoEra = 
        import static get java.time.chrono.MinguoEra.BEFORE_ROC: ##java.time.chrono.MinguoEra & Pure as getBEFORE_ROC;
        import static get java.time.chrono.MinguoEra.ROC: ##java.time.chrono.MinguoEra & Pure as getROC;
        match x {
            case BEFORE_ROC => getBEFORE_ROC()
            case ROC        => getROC() 
        }

    def primEquals(x: ##java.time.chrono.MinguoEra, y: ##java.time.chrono.MinguoEra): Bool =
        import java.lang.Enum.equals(##java.lang.Object): Bool & Pure;
        let x1 = x as ##java.lang.Enum;
        let y1 = y as ##java.lang.Object;
        equals(x1, y1)

    pub def unmarshal(x: ##java.time.chrono.MinguoEra): MinguoEra =
        import static get java.time.chrono.MinguoEra.BEFORE_ROC: ##java.time.chrono.MinguoEra & Pure as getBEFORE_ROC;
        import static get java.time.chrono.MinguoEra.ROC: ##java.time.chrono.MinguoEra & Pure as getROC;
        match x {
            case x1 if primEquals(x1, getBEFORE_ROC())  => BEFORE_ROC
            case x1 if primEquals(x1, getROC())         => ROC
        }

    pub def getValue(x: MinguoEra): Int32 = 
        import java.time.chrono.MinguoEra.getValue(): Int32 & Pure;
        let x1 = marshal(x);
        getValue(x1)



    pub def getDisplayName(style: TextStyle, locale: Locale, x: MinguoEra): String = 
        import java.time.chrono.MinguoEra.getDisplayName(##java.time.format.TextStyle, ##java.util.Locale): String & Pure;
        let x1 = marshal(x);
        let style1 = Time/Format/TextStyle.marshal(style);
        let Locale(locale1) = locale;
        getDisplayName(x1, style1, locale1)



}
