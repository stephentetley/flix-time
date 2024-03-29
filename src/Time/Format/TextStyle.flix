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

mod Time.Format {

    pub enum TextStyle with Eq, Order, ToString, Hash {
        case Full
        case FullStandalone
        case Narrow
        case NarrowStandalone
        case Short
        case ShortStandalone
    }


}

mod Time.Format.TextStyle {

    use Time.Format.TextStyle;
    use Time.Format.TextStyle.{Full, FullStandalone, Narrow, NarrowStandalone,
            Short, ShortStandalone};


    pub def marshalTextStyle(x: TextStyle): ##java.time.format.TextStyle = 
        import static java_get_field java.time.format.TextStyle.FULL: ##java.time.format.TextStyle \ {} as getFULL;
        import static java_get_field java.time.format.TextStyle.FULL_STANDALONE: ##java.time.format.TextStyle \ {} as getFULL_STANDALONE;
        import static java_get_field java.time.format.TextStyle.NARROW: ##java.time.format.TextStyle \ {} as getNARROW;
        import static java_get_field java.time.format.TextStyle.NARROW_STANDALONE: ##java.time.format.TextStyle \ {} as getNARROW_STANDALONE;	
        import static java_get_field java.time.format.TextStyle.SHORT: ##java.time.format.TextStyle \ {} as getSHORT;
        import static java_get_field java.time.format.TextStyle.SHORT_STANDALONE: ##java.time.format.TextStyle \ {} as getSHORT_STANDALONE;
        match x {
            case Full               => getFULL()
            case FullStandalone     => getFULL_STANDALONE()
            case Narrow             => getNARROW()
            case NarrowStandalone   => getNARROW_STANDALONE()
            case Short              => getSHORT()
            case ShortStandalone    => getSHORT_STANDALONE() 
        }

    def primEquals(x: ##java.time.format.TextStyle, y: ##java.time.format.TextStyle): Bool =
        import java.lang.Enum.equals(##java.lang.Object): Bool \ {};
        let x1 = unchecked_cast(x as ##java.lang.Enum);
        let y1 = checked_cast(y);
        equals(x1, y1)

    pub def unmarshalTextStyle(x: ##java.time.format.TextStyle): TextStyle = 
        import static java_get_field java.time.format.TextStyle.FULL: ##java.time.format.TextStyle \ {} as getFULL;
        import static java_get_field java.time.format.TextStyle.FULL_STANDALONE: ##java.time.format.TextStyle \ {} as getFULL_STANDALONE;
        import static java_get_field java.time.format.TextStyle.NARROW: ##java.time.format.TextStyle \ {} as getNARROW;
        import static java_get_field java.time.format.TextStyle.NARROW_STANDALONE: ##java.time.format.TextStyle \ {} as getNARROW_STANDALONE;	
        import static java_get_field java.time.format.TextStyle.SHORT: ##java.time.format.TextStyle \ {} as getSHORT;
        import static java_get_field java.time.format.TextStyle.SHORT_STANDALONE: ##java.time.format.TextStyle \ {} as getSHORT_STANDALONE;
        match x {
            case x1 if primEquals(x1, getFULL())                => Full
            case x1 if primEquals(x1, getFULL_STANDALONE())     => FullStandalone
            case x1 if primEquals(x1, getNARROW())              => Narrow
            case x1 if primEquals(x1, getNARROW_STANDALONE())   => NarrowStandalone
            case x1 if primEquals(x1, getSHORT())               => Short
            case x1 if primEquals(x1, getSHORT_STANDALONE())    => ShortStandalone
            case _                                              => bug!("unmarshalTextStyle")
        }

    
    /// ## predicates / comparisons

    pub def isStandalone(x: TextStyle): Bool =
        import java.time.format.TextStyle.isStandalone(): Bool \ {};
        let x1 = marshalTextStyle(x);
        isStandalone(x1)

    /// ## Getters and Setters
    
    pub def asStandalone(x: TextStyle): TextStyle =
        import java.time.format.TextStyle.asStandalone(): ##java.time.format.TextStyle \ {};
        marshalTextStyle(x) |> asStandalone |> unmarshalTextStyle
    
    pub def asNormal(x: TextStyle): TextStyle =
        import java.time.format.TextStyle.asNormal(): ##java.time.format.TextStyle \ {};
        marshalTextStyle(x) |> asNormal |> unmarshalTextStyle

}
