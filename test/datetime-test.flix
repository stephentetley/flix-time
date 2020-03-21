

@test
def now01(): LocalDateTime & Impure = 
    LocalDateTime.now()


@test
def fromStringWithFormat01(): Result[LocalDateTime, String] = 
    use LocalDateTime.fromStringWithFormat;
    use Time/Formatter.iso_local_date_time;
    "2020-03-21T10:50:00".fromStringWithFormat(iso_local_date_time())