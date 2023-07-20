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


    pub enum MinguoEra with Eq, Order, ToString, Hash {
        case BEFORE_ROC
        case ROC
    }   
  

}

mod Time.Chrono.MinguoEra {

    use Interop.Util.Locale;

    use Time.Chrono.MinguoEra;
    use Time.Chrono.MinguoEra.{BEFORE_ROC, ROC};
    use Time.Format.TextStyle;

    pub def marshalMinguoEra(x: MinguoEra): ##java.time.chrono.MinguoEra = 
        import static get java.time.chrono.MinguoEra.BEFORE_ROC: ##java.time.chrono.MinguoEra \ {} as getBEFORE_ROC;
        import static get java.time.chrono.MinguoEra.ROC: ##java.time.chrono.MinguoEra \ {} as getROC;
        match x {
            case BEFORE_ROC => getBEFORE_ROC()
            case ROC        => getROC() 
        }

    def primEquals(x: ##java.time.chrono.MinguoEra, y: ##java.time.chrono.MinguoEra): Bool =
        import java.lang.Enum.equals(##java.lang.Object): Bool \ {};
        let x1 = unchecked_cast(x as ##java.lang.Enum);
        let y1 = checked_cast(y);
        equals(x1, y1)

    pub def unmarshalMinguoEra(x: ##java.time.chrono.MinguoEra): MinguoEra =
        import static get java.time.chrono.MinguoEra.BEFORE_ROC: ##java.time.chrono.MinguoEra \ {} as getBEFORE_ROC;
        import static get java.time.chrono.MinguoEra.ROC: ##java.time.chrono.MinguoEra \ {} as getROC;
        match x {
            case x1 if primEquals(x1, getBEFORE_ROC())  => BEFORE_ROC
            case x1 if primEquals(x1, getROC())         => ROC
            case _                                      => bug!("unmarshalMinguoEra")
        }

    pub def getValue(x: MinguoEra): Int32 = 
        import java.time.chrono.MinguoEra.getValue(): Int32 \ {};
        let x1 = marshalMinguoEra(x);
        getValue(x1)



    pub def getDisplayName(style: TextStyle, locale: Locale, x: MinguoEra): String = 
        import java.time.chrono.MinguoEra.getDisplayName(##java.time.format.TextStyle, ##java.util.Locale): String \ {};
        let x1 = marshalMinguoEra(x);
        let style1 = Time.Format.TextStyle.marshalTextStyle(style);
        let locale1 = Interop.Util.Locale.getHH(locale);
        getDisplayName(x1, style1, locale1)



}
