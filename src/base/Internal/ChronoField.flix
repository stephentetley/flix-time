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


namespace Time/Internal/ChronoField {

    pub def getNANO_OF_SECOND(): ##java.time.temporal.ChronoField = 
        import static get java.time.temporal.ChronoField.NANO_OF_SECOND as getNANO_OF_SECOND;
        getNANO_OF_SECOND() as & Pure
    
    pub def getNANO_OF_DAY(): ##java.time.temporal.ChronoField = 
        import static get java.time.temporal.ChronoField.NANO_OF_DAY as getNANO_OF_DAY;
        getNANO_OF_DAY() as & Pure
    
    pub def getMICRO_OF_SECOND(): ##java.time.temporal.ChronoField = 
        import static get java.time.temporal.ChronoField.MICRO_OF_SECOND as getMICRO_OF_SECOND;
        getMICRO_OF_SECOND() as & Pure
    
    pub def getMICRO_OF_DAY(): ##java.time.temporal.ChronoField = 
        import static get java.time.temporal.ChronoField.MICRO_OF_DAY as getMICRO_OF_DAY;
        getMICRO_OF_DAY() as & Pure
    
    pub def getMILLI_OF_SECOND(): ##java.time.temporal.ChronoField = 
        import static get java.time.temporal.ChronoField.MILLI_OF_SECOND as getMILLI_OF_SECOND;
        getMILLI_OF_SECOND() as & Pure
    
    pub def getMILLI_OF_DAY(): ##java.time.temporal.ChronoField = 
        import static get java.time.temporal.ChronoField.MILLI_OF_DAY as getMILLI_OF_DAY;
        getMILLI_OF_DAY() as & Pure

    pub def getSECOND_OF_MINUTE(): ##java.time.temporal.ChronoField = 
        import static get java.time.temporal.ChronoField.SECOND_OF_MINUTE as getSECOND_OF_MINUTE;
        getSECOND_OF_MINUTE() as & Pure
        
    pub def getSECOND_OF_DAY(): ##java.time.temporal.ChronoField = 
        import static get java.time.temporal.ChronoField.SECOND_OF_DAY as getSECOND_OF_DAY;
        getSECOND_OF_DAY() as & Pure
    
    pub def getMINUTE_OF_HOUR(): ##java.time.temporal.ChronoField = 
        import static get java.time.temporal.ChronoField.MINUTE_OF_HOUR as getMINUTE_OF_HOUR;
        getMINUTE_OF_HOUR() as & Pure
    
    pub def getMINUTE_OF_DAY(): ##java.time.temporal.ChronoField = 
        import static get java.time.temporal.ChronoField.MINUTE_OF_DAY as getMINUTE_OF_DAY;
        getMINUTE_OF_DAY() as & Pure
    
    pub def getHOUR_OF_AMPM(): ##java.time.temporal.ChronoField = 
        import static get java.time.temporal.ChronoField.HOUR_OF_AMPM as getHOUR_OF_AMPM;
        getHOUR_OF_AMPM() as & Pure

    pub def getCLOCK_HOUR_OF_AMPM(): ##java.time.temporal.ChronoField = 
        import static get java.time.temporal.ChronoField.CLOCK_HOUR_OF_AMPM as getCLOCK_HOUR_OF_AMPM;
        getCLOCK_HOUR_OF_AMPM() as & Pure
    
    pub def getHOUR_OF_DAY(): ##java.time.temporal.ChronoField = 
        import static get java.time.temporal.ChronoField.HOUR_OF_DAY as getHOUR_OF_DAY;
        getHOUR_OF_DAY() as & Pure

    pub def getCLOCK_HOUR_OF_DAY(): ##java.time.temporal.ChronoField =     
        import static get java.time.temporal.ChronoField.CLOCK_HOUR_OF_DAY as getCLOCK_HOUR_OF_DAY;
        getCLOCK_HOUR_OF_DAY() as & Pure
    
    pub def getAMPM_OF_DAY(): ##java.time.temporal.ChronoField = 
        import static get java.time.temporal.ChronoField.AMPM_OF_DAY as getAMPM_OF_DAY;
        getAMPM_OF_DAY() as & Pure
    
    pub def getDAY_OF_WEEK(): ##java.time.temporal.ChronoField = 
        import static get java.time.temporal.ChronoField.DAY_OF_WEEK as getDAY_OF_WEEK;
        getDAY_OF_WEEK() as & Pure
    
    pub def getALIGNED_DAY_OF_WEEK_IN_MONTH(): ##java.time.temporal.ChronoField = 
        import static get java.time.temporal.ChronoField.ALIGNED_DAY_OF_WEEK_IN_MONTH as getALIGNED_DAY_OF_WEEK_IN_MONTH;
        getALIGNED_DAY_OF_WEEK_IN_MONTH() as & Pure
    
    pub def getALIGNED_DAY_OF_WEEK_IN_YEAR(): ##java.time.temporal.ChronoField = 
        import static get java.time.temporal.ChronoField.ALIGNED_DAY_OF_WEEK_IN_YEAR as getALIGNED_DAY_OF_WEEK_IN_YEAR;
        getALIGNED_DAY_OF_WEEK_IN_YEAR() as & Pure
    
    pub def getDAY_OF_MONTH(): ##java.time.temporal.ChronoField = 
        import static get java.time.temporal.ChronoField.DAY_OF_MONTH as getDAY_OF_MONTH;
        getDAY_OF_MONTH() as & Pure
    
    pub def getDAY_OF_YEAR(): ##java.time.temporal.ChronoField = 
        import static get java.time.temporal.ChronoField.DAY_OF_YEAR as getDAY_OF_YEAR;
        getDAY_OF_YEAR() as & Pure
    
    pub def getEPOCH_DAY(): ##java.time.temporal.ChronoField = 
        import static get java.time.temporal.ChronoField.EPOCH_DAY as getEPOCH_DAY;
        getEPOCH_DAY() as & Pure
    
    pub def getALIGNED_WEEK_OF_MONTH(): ##java.time.temporal.ChronoField = 
        import static get java.time.temporal.ChronoField.ALIGNED_WEEK_OF_MONTH as getALIGNED_WEEK_OF_MONTH;
        getALIGNED_WEEK_OF_MONTH() as & Pure
    
    pub def getALIGNED_WEEK_OF_YEAR(): ##java.time.temporal.ChronoField = 
        import static get java.time.temporal.ChronoField.ALIGNED_WEEK_OF_YEAR as getALIGNED_WEEK_OF_YEAR;
        getALIGNED_WEEK_OF_YEAR() as & Pure
    
    pub def getMONTH_OF_YEAR(): ##java.time.temporal.ChronoField = 
        import static get java.time.temporal.ChronoField.MONTH_OF_YEAR as getMONTH_OF_YEAR;
        getMONTH_OF_YEAR() as & Pure
    
    pub def getPROLEPTIC_MONTH(): ##java.time.temporal.ChronoField = 
        import static get java.time.temporal.ChronoField.PROLEPTIC_MONTH as getPROLEPTIC_MONTH;
        getPROLEPTIC_MONTH() as & Pure
    
    pub def getYEAR_OF_ERA(): ##java.time.temporal.ChronoField = 
        import static get java.time.temporal.ChronoField.YEAR_OF_ERA as getYEAR_OF_ERA;
        getYEAR_OF_ERA() as & Pure
    
    pub def getYEAR(): ##java.time.temporal.ChronoField = 
        import static get java.time.temporal.ChronoField.YEAR as getYEAR;
        getYEAR() as & Pure
    
    pub def getERA(): ##java.time.temporal.ChronoField = 
        import static get java.time.temporal.ChronoField.ERA as getERA;
        getERA() as & Pure

    pub def getINSTANT_SECONDS(): ##java.time.temporal.ChronoField = 
        import static get java.time.temporal.ChronoField.INSTANT_SECONDS as getINSTANT_SECONDS;
        getINSTANT_SECONDS() as & Pure
    
    pub def getOFFSET_SECONDS(): ##java.time.temporal.ChronoField = 
        import static get java.time.temporal.ChronoField.OFFSET_SECONDS as getOFFSET_SECONDS;
        getOFFSET_SECONDS() as & Pure

}
