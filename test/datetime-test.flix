

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
    use Time/LocalDate.now;
    use Time/LocalDate.before;
    let d1 = now();
    let d2 = now();
    before(d1, d2)

@test 
def getDuration01(): String = 
    use Time/ChronoUnit.getDuration;
    use Time/Duration.toString;
    getDuration(Time/ChronoUnit.forever()) |> toString


@test 
def getDuration02(): String = 
    use Time/ChronoUnit.getDuration;
    use Time/Duration.toString;
    getDuration(Time/ChronoUnit.nanos()) |> toString

@test 
def toString01ChronoUnit(): String = 
    use Time/ChronoUnit.toString;
    Time/ChronoUnit.months() |> toString