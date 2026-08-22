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

    use EffectExtras.Fail.Fail
    use InteropLocale.Locale.Locale

    use JavaInterop.AdaptorExtras

    use InteropTime.ZoneId
    use InteropTime.Format.DateTimeFormatter.DateTimeFormatter
    use InteropTime.Format.FormatStyle.FormatStyle
    use InteropTime.Format.TextStyle.TextStyle


    import java.time.format.{DateTimeFormatterBuilder => JDateTimeFormatterBuilder}
    import java.time.format.{DateTimeFormatter => JDateTimeFormatter}
    import java.time.{ZoneId => JZoneId}
    import java.util.{Set => JSet}
    import java.lang.{Exception => JException}


    // Builder doesn't need IO for evaluation

    pub eff DateTimeFormatterBuilder {
        def appendFormatter(fmt: DateTimeFormatter): Unit
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
        def appendOptional(fmt: DateTimeFormatter): Unit
        def appendPattern(patt: String): Unit
        def appendZoneId(): Unit
        def appendZoneOrOffsetId(): Unit
        def appendZoneRegionId(): Unit
        def appendZoneText(style: TextStyle): Unit
        def appendZoneTextWithZoneIds(style: TextStyle, zones: List[ZoneId]): Unit
        def optionalStart(): Unit
        def optionalEnd(): Unit
        def padNext(n: Int32): Unit
        def padNextWithChar(n: Int32, ch: Char): Unit
        def parseCaseSensitive(): Unit
        def parseCaseInsensitive(): Unit
        def parseStrict(): Unit
        def parseLenient(): Unit
    }

    pub def handle(f: a -> b \ ef): a -> (DateTimeFormatter, b) \ (ef + Fail - DateTimeFormatterBuilder) = x -> {
        let builder = unsafe IO { new JDateTimeFormatterBuilder() };
        let ans = run {
            f(x)
        } with handler DateTimeFormatterBuilder {
            
            def appendFormatter(fmt, k) = {
                let fmt1 = ToJava.toJava(fmt);
                unsafe IO as {ef + Fail - DateTimeFormatterBuilder} { discard builder.append(fmt1) };
                k()
            }

            def appendChronologyId(k) = {
                unsafe IO as {ef + Fail - DateTimeFormatterBuilder} { discard builder.appendChronologyId() };
                k()
            }

            def appendChronologyText(style, k) = {
                let style1 = ToJava.toJava(style);
                unsafe IO as {ef + Fail - DateTimeFormatterBuilder} { discard builder.appendChronologyText(style1) };
                k()
            }

            def appendDayPeriodText(style, k) = {
                let style1 = ToJava.toJava(style);
                unsafe IO as {ef + Fail - DateTimeFormatterBuilder} { discard builder.appendDayPeriodText(style1) };
                k()
            }

            def appendGenericZoneText(style, k) = {
                let style1 = ToJava.toJava(style);
                unsafe IO as {ef + Fail - DateTimeFormatterBuilder} { discard builder.appendGenericZoneText(style1) };
                k()
            }

            def appendInstant(k) = try {
                unsafe IO as {ef + Fail - DateTimeFormatterBuilder} { discard builder.appendInstant() };
                k()
            } catch { 
                case ex: JException => Fail.report(ex.getMessage())
            }

            def appendInstantWithFractionalDigits(i, k) = {
                unsafe IO as {ef + Fail - DateTimeFormatterBuilder} { discard builder.appendInstant(i) };
                k()
            }

            def appendStringLiteral(s, k) = {
                unsafe IO as {ef + Fail - DateTimeFormatterBuilder} { discard builder.appendLiteral(s) };
                k()
            }

            def appendCharLiteral(c, k) = {
                unsafe IO as {ef + Fail - DateTimeFormatterBuilder} { discard builder.appendLiteral(c) };
                k()
            }

            def appendLocalized(timeStyle, dateStyle, k) = try {
                let timeStyle1 = ToJava.toJava(timeStyle#timeStyle);
                let dateStyle1 = ToJava.toJava(dateStyle#dateStyle);
                unsafe IO as {ef + Fail - DateTimeFormatterBuilder} { discard builder.appendLocalized(timeStyle1, dateStyle1) };
                k()
            } catch {
                case ex: JException => Fail.report(ex.getMessage())
            }

            def appendLocalizedWithTemplateString(s, k) = {
                unsafe IO as {ef + Fail - DateTimeFormatterBuilder} { discard builder.appendLocalized(s) };
                k()
            }

            def appendLocalizedOffset(style, k) = try {
                let style1 = ToJava.toJava(style);
                unsafe IO as {ef + Fail - DateTimeFormatterBuilder} { discard builder.appendLocalizedOffset(style1) };
                k()
            } catch {
                case ex: JException => Fail.report(ex.getMessage())
            }

            def appendOffset(pattern, noOffsetText, k) = try {
                unsafe IO as {ef + Fail - DateTimeFormatterBuilder} { discard builder.appendOffset(pattern#pattern, noOffsetText#noOffsetText) };
                k()
            } catch {
                case ex: JException => Fail.report(ex.getMessage())
            }

            def appendOffsetId(k) = {
                unsafe IO as {ef + Fail - DateTimeFormatterBuilder} { discard builder.appendOffsetId() };
                k()
            }

            def appendOptional(fmt, k) = {
                let fmt1 = ToJava.toJava(fmt);
                unsafe IO as {ef + Fail - DateTimeFormatterBuilder} { discard builder.appendOptional(fmt1) };
                k()
            }

            def appendPattern(patt, k) = try {
                unsafe IO as {ef + Fail - DateTimeFormatterBuilder} { discard builder.appendPattern(patt) };
                k()
            } catch {
                case ex: JException => Fail.report(ex.getMessage())
            }

            def appendZoneId(k) = {
                unsafe IO as {ef + Fail - DateTimeFormatterBuilder} { discard builder.appendZoneId() };
                k()
            }


            def appendZoneOrOffsetId(k) = {
                unsafe IO as {ef + Fail - DateTimeFormatterBuilder} { discard builder.appendZoneOrOffsetId() };
                k()
            }

            def appendZoneRegionId(k) = {
                unsafe IO as {ef + Fail - DateTimeFormatterBuilder} { discard builder.appendZoneRegionId() };
                k()
            }

            def appendZoneText(style, k) = {
                let style1 = ToJava.toJava(style);
                unsafe IO as {ef + Fail - DateTimeFormatterBuilder} { discard builder.appendZoneText(style1) };
                k()
            }

            
            def appendZoneTextWithZoneIds(style, preferredZones, k) = {
                let style1 = ToJava.toJava(style);
                let jset: JSet[JZoneId] = AdaptorExtras.Collection.toJSet(preferredZones, ToJava.toJava);
                unsafe IO as {ef + Fail - DateTimeFormatterBuilder} { discard builder.appendZoneText(style1, jset) };
                k()
            }

            def optionalStart(k) = {
                unsafe IO as {ef + Fail - DateTimeFormatterBuilder} { discard builder.optionalStart() };
                k()
            }

            def optionalEnd(k) = try {
                unsafe IO as {ef + Fail - DateTimeFormatterBuilder} { discard builder.optionalEnd() };
                k()
            } catch {
                case ex: JException => Fail.report(ex.getMessage())
            }


            def padNext(n, k) = try {
                unsafe IO as {ef + Fail - DateTimeFormatterBuilder} { discard builder.padNext(n) };
                k()
            } catch {
                case ex: JException => Fail.report(ex.getMessage())
            }

            def padNextWithChar(n, ch, k) = try {
                unsafe IO as {ef + Fail - DateTimeFormatterBuilder} { discard builder.padNext(n, ch) };
                k()
            } catch {
                case ex: JException => Fail.report(ex.getMessage())
            }

            def parseCaseSensitive(k) = {
                unsafe IO as {ef + Fail - DateTimeFormatterBuilder} { discard builder.parseCaseSensitive() };
                k()
            }

            def parseCaseInsensitive(k) = {
                unsafe IO as {ef + Fail - DateTimeFormatterBuilder} { discard builder.parseCaseInsensitive() };
                k()
            }

            def parseStrict(k) = {
                unsafe IO as {ef + Fail - DateTimeFormatterBuilder} { discard builder.parseStrict() };
                k()
            }

            def parseLenient(k) = {
                unsafe IO as {ef + Fail - DateTimeFormatterBuilder} { discard builder.parseLenient() };
                k()
            }
            
        };
        let jfmt: JDateTimeFormatter = unsafe IO { builder.toFormatter() };
        (ToFlix.toFlix(jfmt), ans)
    }


    pub def runDateTimeFormatterBuilder(buildfun: Unit -> a \ ef): (DateTimeFormatter, a) \ (ef + Fail - DateTimeFormatterBuilder) = 
        handle(buildfun)()

    pub def execDateTimeFormatterBuilder(buildfun: Unit -> a \ ef): DateTimeFormatter \ (ef + Fail - DateTimeFormatterBuilder)  = 
        handle(buildfun)() |> fst

    pub def runDateTimeFormatterBuilderWithResult(buildfun: Unit -> a \ ef): Result[String, (DateTimeFormatter, a)] \ (ef - Fail - DateTimeFormatterBuilder)  = 
        run { handle(buildfun)() } with EffectExtras.Fail.runWithResult

    pub def execDateTimeFormatterBuilderWithResult(buildfun: Unit -> a \ ef): Result[String, DateTimeFormatter] \ (ef - Fail - DateTimeFormatterBuilder)  = 
        { run { handle(buildfun)() } with EffectExtras.Fail.runWithResult } |> Result.map(fst)


}

