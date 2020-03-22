

@test
def now01(): LocalDateTime & Impure = 
    LocalDateTime.now()

@test
def fromString01(): Result[LocalDate, String] & Pure = 
    use LocalDate.fromString;
    "2007-12-03".fromString()

@test
def fromStringWithFormat01(): Result[LocalDateTime, String] = 
    use LocalDateTime.fromStringWithFormat;
    "2020-03-21T10:50:00".fromStringWithFormat(DateTimeFormatter.iso_local_date_time())

@test
def fromStringWithFormat02(): Result[LocalDateTime, String] = 
    use LocalDateTime.fromStringWithFormat;
    match DateTimeFormatter.fromPattern("dd/MM/yyyy HH:mm") {
        case Err(e) => Err(e)
        case Ok(fmt) => "19/12/2018 00:00".fromStringWithFormat(fmt)
    }
    

@test
def zoneId01(): Result[ZoneId, String] = 
    use Time/ZoneId.zoneId;
    zoneId("Europe/Paris")


@test
def systemDefault01(): Result[ZoneId, String] & Impure = 
    use Time/ZoneId.systemDefault;
    systemDefault()

@test
def toString01(): String & Impure = 
    use Time/ZoneId.systemDefault;
    use Time/ZoneId.toString;
    systemDefault() |> Result.map(toString) |> x -> Result.getWithDefault(x, "**error**")

@test
def equals01(): Bool & Impure = 
    use LocalDate.now;
    use LocalDate.equals;
    let d1 = now();
    let d2 = now();
    equals(d1, d2)

@test
def before01(): Bool & Impure = 
    use LocalDate.now;
    use LocalDate.before;
    let d1 = now();
    let d2 = now();
    before(d1, d2)

@test 
def getDuration01(): String = 
    use Time/ChronoUnit.getDuration;
    use Duration.toString;
    getDuration(Time/ChronoUnit.forever()) |> toString


@test 
def getDuration02(): String = 
    use Time/ChronoUnit.getDuration;
    use Duration.toString;
    getDuration(Time/ChronoUnit.nanos()) |> toString

@test 
def toString01ChronoUnit(): String = 
    use Time/ChronoUnit.toString;
    Time/ChronoUnit.months() |> toString