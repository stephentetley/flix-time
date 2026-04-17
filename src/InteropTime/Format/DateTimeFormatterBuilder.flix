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

    pub def handle(f: a -> b \ ef): a -> Result[String, (DateTimeFormatter[t], b)] \ (ef - DateTimeFormatterBuilder) = x -> region rc {
        handleHelper(rc, f, x)
    }

    def handleHelper(_: Region[r], f: a -> b \ ef): a -> Result[String, (DateTimeFormatter[t], b)] \ (ef - DateTimeFormatterBuilder + r) =
        x -> {
            let builder = unsafe IO as r { new JDateTimeFormatterBuilder() };
            let ans = run {
                Ok(f(x))
            } with handler DateTimeFormatterBuilder {
                
                def appendFormatter(fmt, k) = {
                    let DateTimeFormatter(fmt1) = fmt;
                    unsafe IO as r { discard builder.append(fmt1) };
                    k()
                }

                def appendChronologyId(k) = {
                    unsafe IO as r { discard builder.appendChronologyId() };
                    k()
                }

                def appendChronologyText(style, k) = {
                    let style1 = InteropTime.Format.TextStyle.marshalTextStyle(style);
                    unsafe IO as r { discard builder.appendChronologyText(style1) };
                    k()
                }

                def appendDayPeriodText(style, k) = {
                    let style1 = InteropTime.Format.TextStyle.marshalTextStyle(style);
                    unsafe IO as r { discard builder.appendDayPeriodText(style1) };
                    k()
                }

                def appendGenericZoneText(style, k) = {
                    let style1 = InteropTime.Format.TextStyle.marshalTextStyle(style);
                    unsafe IO as r { discard builder.appendGenericZoneText(style1) };
                    k()
                }

                def appendInstant(k) = try {
                    unsafe IO as r { discard builder.appendInstant() };
                    k()
                } catch { 
                    case ex: Exception => Err(ex.getMessage())
                }

                def appendInstantWithFractionalDigits(i, k) = {
                    unsafe IO as r { discard builder.appendInstant(i) };
                    k()
                }

                def appendStringLiteral(s, k) = {
                    unsafe IO as r { discard builder.appendLiteral(s) };
                    k()
                }

                def appendCharLiteral(c, k) = {
                    unsafe IO as r { discard builder.appendLiteral(c) };
                    k()
                }

                def appendLocalized(timeStyle, dateStyle, k) = {
                    let timeStyle1 = InteropTime.Format.FormatStyle.marshalFormatStyle(timeStyle#timeStyle);
                    let dateStyle1 = InteropTime.Format.FormatStyle.marshalFormatStyle(dateStyle#dateStyle);
                    unsafe IO as r { discard builder.appendLocalized(timeStyle1, dateStyle1) };
                    k()
                }

                def appendLocalizedWithTemplateString(s, k) = {
                    unsafe IO as r { discard builder.appendLocalized(s) };
                    k()
                }

                def appendLocalizedOffset(style, k) = {
                    let style1 = InteropTime.Format.TextStyle.marshalTextStyle(style);
                    unsafe IO as r { discard builder.appendLocalizedOffset(style1) };
                    k()
                }

                def appendOffset(pattern, noOffsetText, k) = {
                    unsafe IO as r { discard builder.appendOffset(pattern#pattern, noOffsetText#noOffsetText) };
                    k()
                }

                def appendOffsetId(k) = {
                    unsafe IO as r { discard builder.appendOffsetId() };
                    k()
                }

                def appendOptional(fmt, k) = {
                    let DateTimeFormatter(fmt1) = fmt;
                    unsafe IO as r { discard builder.appendOptional(fmt1) };
                    k()
                }

                def appendPattern(patt, k) = {
                    unsafe IO as r { discard builder.appendPattern(patt) };
                    k()
                }

                def appendZoneId(k) = {
                    unsafe IO as r { discard builder.appendZoneId() };
                    k()
                }


                def appendZoneOrOffsetId(k) = {
                    unsafe IO as r { discard builder.appendZoneOrOffsetId() };
                    k()
                }

                def appendZoneRegionId(k) = {
                    unsafe IO as r { discard builder.appendZoneRegionId() };
                    k()
                }

                def appendZoneText(style, k) = {
                    let style1 = InteropTime.Format.TextStyle.marshalTextStyle(style);
                    unsafe IO as r { discard builder.appendZoneText(style1) };
                    k()
                }

                // TODO use wrapped types
                // def appendZoneTextWithZones(style: TextStyle, preferredZones: JSet): Unit
                //     let builder = DateTimeFormatterBuilder.currentDateTimeFormatterBuilder();
                //     let style1 = InteropTime.Format.TextStyle.marshalTextStyle(style);
                //     discard builder.appendZoneText(style1, preferredZones);
                //     ()

                def optionalStart(k) = {
                    unsafe IO as r { discard builder.optionalStart() };
                    k()
                }

                def optionalEnd(k) = {
                    unsafe IO as r { discard builder.optionalEnd() };
                    k()
                }


                def padNext(n, k) = {
                    unsafe IO as r { discard builder.padNext(n) };
                    k()
                }

                def padNextWithChar(n, ch, k) = {
                    unsafe IO as r { discard builder.padNext(n, ch) };
                    k()
                }

                def parseCaseSensitive(k) = {
                    unsafe IO as r { discard builder.parseCaseSensitive() };
                    k()
                }

                def parseCaseInsensitive(k) = {
                    unsafe IO as r { discard builder.parseCaseInsensitive() };
                    k()
                }

                def parseStrict(k) = {
                    unsafe IO as r { discard builder.parseStrict() };
                    k()
                }

                def parseLenient(k) = {
                    unsafe IO as r { discard builder.parseLenient() };
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
        handle(buildfun)()




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

