

@test
def now01(): LocalDateTime & Impure = 
    LocalDateTime.now()


@test
def fromStringWithFormat01(): Result[LocalDateTime, String] = 
    use LocalDateTime.fromStringWithFormat;
    use Time/Formatter.iso_local_date_time;
    "2020-03-21T10:50:00".fromStringWithFormat(iso_local_date_time())

@test
def fromStringWithFormat02(): Result[LocalDateTime, String] = 
    use LocalDateTime.fromStringWithFormat;
    use Time/Formatter.dateTimeFormatter;
    match dateTimeFormatter("dd/MM/yyyy HH:mm") {
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
