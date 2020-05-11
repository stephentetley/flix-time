

@test
def now01(): Time.LocalDateTime & Impure = 
    Time/LocalDateTime.now()

@test
def fromString01(): Result[Time.LocalDate, Time.Error] & Pure = 
    use Time/LocalDate.fromString;
    "2007-12-03".fromString()

@test
def parse01(): Result[Time.LocalDateTime, Time.Error] = 
    use Time/LocalDateTime.parse;
    "2020-03-21T10:50:00".parse(Time/Format/DateTimeFormatter.iso_local_date_time())

@test
def parse02(): Result[Time.LocalDateTime, Time.Error] = 
    use Time/LocalDateTime.parse;
    match Time/Format/DateTimeFormatter.fromPattern("dd/MM/yyyy HH:mm") {
        case Err(e) => Err(e)
        case Ok(fmt) => "19/12/2018 00:00".parse(fmt)
    }
    

@test
def zoneId01(): Result[Time.ZoneId, Time.Error] = 
    use Time/ZoneId.fromString;
    fromString("Europe/Paris")


@test
def systemDefault01(): Result[Time.ZoneId, Time.Error] & Impure = 
    use Time/ZoneId.systemDefault;
    systemDefault()

@test
def toString01(): String & Impure = 
    use Time/ZoneId.systemDefault;
    use Time/ZoneId.toString;
    systemDefault() |> Result.map(toString) |> x -> Result.getWithDefault(x, "**error**")

@test
def equals01(): Bool & Impure = 
    use Time/LocalDate.now;
    use Time/LocalDate.equals;
    let d1 = now();
    let d2 = now();
    equals(d1, d2)

@test
def before01(): Bool & Impure = 
    use Time/LocalDate.{now, isBefore};
    let d1 = now();
    let d2 = now();
    isBefore(d1, d2)

@test 
def getDuration01(): String = 
    use Time/Temporal/ChronoUnit.getDuration;
    use Time/Duration.toString;
    getDuration(Time/Temporal/ChronoUnit.Forever) |> toString


@test 
def getDuration02(): String = 
    use Time/Temporal/ChronoUnit.getDuration;
    use Time/Duration.toString;
    getDuration(Time/Temporal/ChronoUnit.Nanos) |> toString

@test 
def toString01ChronoUnit(): String = 
    use Time/Temporal/ChronoUnit.toString;
    Time/Temporal/ChronoUnit.Months |> toString

@test
def until01(): Int64 = 
    use Time/LocalDate.until;
    let t1 = Time/LocalDate.new({ year= 2020, month = 5, dayOfMonth = 10});
    let t2 = Time/LocalDate.new({ year= 2020, month = 6, dayOfMonth = 1});
    t1.until(t2, Time/Temporal/ChronoUnit.Days)

@test
def getDisplayName01(): String = 
    Time/DayOfWeek.getDisplayName(Time/DayOfWeek.Saturday, Time/Format/TextStyle.Full, I18n/Locale.french())


@test
def getDisplayName02(): String = 
    Time/DayOfWeek.getDisplayName(Time/DayOfWeek.Monday, Time/Format/TextStyle.FullStandalone, I18n/Locale.japanese())

@test
def plus01(): Time.Month = 
    Time/Month.plus(Time/Month.June, 3i64)

@test
def plus02(): Time.Month = 
    Time/Month.plus(Time/Month.June, 13i64)