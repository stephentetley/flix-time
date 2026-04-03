/*
 * Copyright 2022 Stephen Tetley
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


pub mod InteropTime.Format.DateTimeFormatterBuilder {


    use InteropTime.Format.DateTimeFormatterBuilder.DateTimeFormatterBuilder
    use InteropTime.Format.DateTimeFormatter.DateTimeFormatter
    use InteropTime.Format.DateTimeFormatter.DateTimeFormatter.{DateTimeFormatter}
    use InteropTime.Format.FormatStyle.FormatStyle
    use InteropTime.Format.TextStyle.TextStyle

    use InteropLocale.Locale.Locale

    import java.time.format.{DateTimeFormatterBuilder => JDateTimeFormatterBuilder}
    import java.time.format.{DateTimeFormatter => JDateTimeFormatter}
    import java.util.{Set => JSet}
    import java.lang.{Exception}

    // Builder is like an array, doesn't need IO for evaluation

    pub eff DateTimeFormatterBuilder {
        def appendFormatter(fmt: DateTimeFormatter[_]): Unit
        def appendChronologyId(): Unit
        def appendChronologyText(style: TextStyle): Unit
        def appendDayPeriodText(style: TextStyle): Unit
        def appendGenericZoneText(style: TextStyle): Unit
        def appendInstant(): Unit
        def appendInstantWithFractionalDigits(i: Int32): Unit
        def appendStringLiteral(s: String): Unit
        def appendCharLiteral(c: Char): Unit
        def appendLocalized(timeStyle: {timeStyle = FormatStyle}, dateStyle: {dateStyle = FormatStyle}): Unit
        def appendLocalizedWithTemplateString(s: String): Unit
        def appendLocalizedOffset(style: TextStyle): Unit
        def appendOffset(pattern: {pattern = String}, noOffsetText: {noOffsetText = String}): Unit
        def appendOffsetId(): Unit
        def appendOptional(fmt: DateTimeFormatter[_]): Unit
        def appendPattern(patt: String): Unit
        def appendZoneId(): Unit
        def appendZoneOrOffsetId(): Unit
        def appendZoneRegionId(): Unit
        def appendZoneText(style: TextStyle): Unit
        def optionalStart(): Unit
        def optionalEnd(): Unit
        def padNext(n: Int32): Unit
        def padNextWithChar(n: Int32, ch: Char): Unit
        def parseCaseSensitive(): Unit
        def parseCaseInsensitive(): Unit
        def parseStrict(): Unit
        def parseLenient(): Unit
    }

    pub def handle(_: Region[r], f: a -> b \ ef): a -> Result[String, (DateTimeFormatter[t], b)] \ (ef - DateTimeFormatterBuilder + r) =
        x -> {
            let builder = unchecked_cast(new JDateTimeFormatterBuilder() as _ \ r);
            let ans = run {
                Ok(f(x))
            } with handler DateTimeFormatterBuilder {
                
                def appendFormatter(fmt, k) = {
                    let DateTimeFormatter(fmt1) = fmt;
                    unchecked_cast(discard builder.append(fmt1) as _ \ r);
                    k()
                }

                def appendChronologyId(k) = {
                    unchecked_cast(discard builder.appendChronologyId() as _ \ r);
                    k()
                }

                def appendChronologyText(style, k) = {
                    let style1 = InteropTime.Format.TextStyle.marshalTextStyle(style);
                    unchecked_cast(discard builder.appendChronologyText(style1) as _ \ r);
                    k()
                }

                def appendDayPeriodText(style, k) = {
                    let style1 = InteropTime.Format.TextStyle.marshalTextStyle(style);
                    unchecked_cast(discard builder.appendDayPeriodText(style1) as _ \ r);
                    k()
                }

                def appendGenericZoneText(style, k) = {
                    let style1 = InteropTime.Format.TextStyle.marshalTextStyle(style);
                    unchecked_cast(discard builder.appendGenericZoneText(style1) as _ \ r);
                    k()
                }

                def appendInstant(k) = try {
                    unchecked_cast(discard builder.appendInstant() as _ \ r);
                    k()
                } catch { 
                    case ex: Exception => Err(ex.getMessage())
                }

                def appendInstantWithFractionalDigits(i, k) = {
                    unchecked_cast(discard builder.appendInstant(i) as _ \ r);
                    k()
                }

                def appendStringLiteral(s, k) = {
                    unchecked_cast(discard builder.appendLiteral(s) as _ \ r);
                    k()
                }

                def appendCharLiteral(c, k) = {
                    unchecked_cast(discard builder.appendLiteral(c) as _ \ r);
                    k()
                }

                def appendLocalized(timeStyle, dateStyle, k) = {
                    let timeStyle1 = InteropTime.Format.FormatStyle.marshalFormatStyle(timeStyle#timeStyle);
                    let dateStyle1 = InteropTime.Format.FormatStyle.marshalFormatStyle(dateStyle#dateStyle);
                    unchecked_cast(discard builder.appendLocalized(timeStyle1, dateStyle1) as _ \ r);
                    k()
                }

                def appendLocalizedWithTemplateString(s, k) = {
                    unchecked_cast(discard builder.appendLocalized(s) as _  \ r);
                    k()
                }

                def appendLocalizedOffset(style, k) = {
                    let style1 = InteropTime.Format.TextStyle.marshalTextStyle(style);
                    unchecked_cast(discard builder.appendLocalizedOffset(style1) as _ \ r);
                    k()
                }

                def appendOffset(pattern, noOffsetText, k) = {
                    unchecked_cast(discard builder.appendOffset(pattern#pattern, noOffsetText#noOffsetText) as _ \ r);
                    k()
                }

                def appendOffsetId(k) = {
                    unchecked_cast(discard builder.appendOffsetId() as _ \ r);
                    k()
                }

                def appendOptional(fmt, k) = {
                    let DateTimeFormatter(fmt1) = fmt;
                    unchecked_cast(discard builder.appendOptional(fmt1) as _ \ r);
                    k()
                }

                def appendPattern(patt, k) = {
                    unchecked_cast(discard builder.appendPattern(patt) as _ \ r);
                    k()
                }

                def appendZoneId(k) = {
                    unchecked_cast(discard builder.appendZoneId() as _ \ r);
                    k()
                }


                def appendZoneOrOffsetId(k) = {
                    unchecked_cast(discard builder.appendZoneOrOffsetId() as _ \ r);
                    k()
                }

                def appendZoneRegionId(k) = {
                    unchecked_cast(discard builder.appendZoneRegionId() as _ \ r);
                    k()
                }

                def appendZoneText(style, k) = {
                    let style1 = InteropTime.Format.TextStyle.marshalTextStyle(style);
                    unchecked_cast(discard builder.appendZoneText(style1) as _ \ r);
                    k()
                }

                // TODO use wrapped types
                // def appendZoneTextWithZones(style: TextStyle, preferredZones: JSet): Unit
                //     let builder = DateTimeFormatterBuilder.currentDateTimeFormatterBuilder();
                //     let style1 = InteropTime.Format.TextStyle.marshalTextStyle(style);
                //     discard builder.appendZoneText(style1, preferredZones);
                //     ()

                def optionalStart(k) = {
                    unchecked_cast(discard builder.optionalStart() as _  \ r);
                    k()
                }

                def optionalEnd(k) = {
                    unchecked_cast(discard builder.optionalEnd() as _ \ r);
                    k()
                }


                def padNext(n, k) = {
                    unchecked_cast(discard builder.padNext(n) as _ \ r);
                    k()
                }

                def padNextWithChar(n, ch, k) = {
                    unchecked_cast(discard builder.padNext(n, ch) as _ \ r);
                    k()
                }

                def parseCaseSensitive(k) = {
                    unchecked_cast(discard builder.parseCaseSensitive() as _ \ r);
                    k()
                }

                def parseCaseInsensitive(k) = {
                    unchecked_cast(discard builder.parseCaseInsensitive() as _ \ r);
                    k()
                }

                def parseStrict(k) = {
                    unchecked_cast(discard builder.parseStrict() as _ \ r);
                    k()
                }

                def parseLenient(k) = {
                    unchecked_cast(discard builder.parseLenient() as _ \ r);
                    k()
                }
                
            };
            match ans {
                case Ok(ans1)    => { 
                    let jfmt: JDateTimeFormatter = unsafe IO { builder.toFormatter() };
                    Ok((DateTimeFormatter.DateTimeFormatter(jfmt), ans1))
                }
                case Err(msg) => Err(msg)
            }  
        }


    pub def runDefault(buildfun: Unit -> a \ ef): Result[String, (DateTimeFormatter[t], a)] \ (ef - DateTimeFormatterBuilder) = 
        region rc { 
            handle(rc, buildfun)()
        }




    // def handleWithLocale(loc: Locale, builder: a -> b \ ef): a -> Result[String, DateTimeFormatter[t]] \ (ef - DateTimeFormatterBuilder) = 
    //     let Locale.Locale(loc1) = loc;
    //     handleHelper(builder, bld -> unsafe IO { bld.toFormatter(loc1)}) 
    
    // def buildWithLocale(loc: Locale, builder: Unit -> a \ ef): Result[String, DateTimeFormatter[t]] \ (ef - DateTimeFormatterBuilder) = 
    //     let Locale.Locale(loc1) = loc;
    //     handleHelper(builder, bld -> unsafe IO { bld.toFormatter(loc1)})() 

    // // TODO: some builder functions are probably locale sensitive if so they should be in IO...


    // // Java 16

    // // TODO use wrapped types
    // def appendGenericZoneTextWithZones(style:TextStyle, preferredZones: JSet): Unit \ DateTimeFormatterBuilder =
    //     let builder = DateTimeFormatterBuilder.currentDateTimeFormatterBuilder();
    //     let style1 = InteropTime.Format.TextStyle.marshalTextStyle(style);
    //     discard builder.appendGenericZoneText(style1, preferredZones);
    //     ()

  


}

