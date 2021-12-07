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


namespace Time/Internal/ChronoUnit {

    pub def getNANOS(): ##java.time.temporal.ChronoUnit = 
        import static get java.time.temporal.ChronoUnit.NANOS as getNANOS;
        getNANOS() as & Pure

    pub def getMICROS(): ##java.time.temporal.ChronoUnit = 
        import static get java.time.temporal.ChronoUnit.MICROS as getMICROS;
        getMICROS() as & Pure

    pub def getMILLIS(): ##java.time.temporal.ChronoUnit = 
        import static get java.time.temporal.ChronoUnit.MILLIS as getMILLIS;
        getMILLIS() as & Pure

    pub def getSECONDS(): ##java.time.temporal.ChronoUnit = 
        import static get java.time.temporal.ChronoUnit.SECONDS as getSECONDS;
        getSECONDS() as & Pure

    pub def getMINUTES(): ##java.time.temporal.ChronoUnit = 
        import static get java.time.temporal.ChronoUnit.MINUTES as getMINUTES;
        getMINUTES() as & Pure

    pub def getHOURS(): ##java.time.temporal.ChronoUnit = 
        import static get java.time.temporal.ChronoUnit.HOURS as getHOURS;
        getHOURS() as & Pure

    pub def getHALF_DAYS(): ##java.time.temporal.ChronoUnit = 
        import static get java.time.temporal.ChronoUnit.HALF_DAYS as getHALF_DAYS;
        getHALF_DAYS() as & Pure

    pub def getDAYS(): ##java.time.temporal.ChronoUnit = 
        import static get java.time.temporal.ChronoUnit.DAYS as getDAYS;
        getDAYS() as & Pure

    pub def getWEEKS(): ##java.time.temporal.ChronoUnit = 
        import static get java.time.temporal.ChronoUnit.WEEKS as getWEEKS;
        getWEEKS() as & Pure

    pub def getMONTHS(): ##java.time.temporal.ChronoUnit = 
        import static get java.time.temporal.ChronoUnit.MONTHS as getMONTHS;
        getMONTHS() as & Pure

    pub def getYEARS(): ##java.time.temporal.ChronoUnit = 
        import static get java.time.temporal.ChronoUnit.YEARS as getYEARS;
        getYEARS() as & Pure

    pub def getDECADES(): ##java.time.temporal.ChronoUnit = 
        import static get java.time.temporal.ChronoUnit.DECADES as getDECADES;
        getDECADES() as & Pure

    pub def getCENTURIES(): ##java.time.temporal.ChronoUnit = 
        import static get java.time.temporal.ChronoUnit.CENTURIES as getCENTURIES;
        getCENTURIES() as & Pure

    pub def getMILLENNIA(): ##java.time.temporal.ChronoUnit = 
        import static get java.time.temporal.ChronoUnit.MILLENNIA as getMILLENNIA;
        getMILLENNIA() as & Pure

    pub def getERAS(): ##java.time.temporal.ChronoUnit = 
        import static get java.time.temporal.ChronoUnit.ERAS as getERAS;
        getERAS() as & Pure

    pub def getFOREVER(): ##java.time.temporal.ChronoUnit = 
        import static get java.time.temporal.ChronoUnit.FOREVER as getFOREVER;
        getFOREVER() as & Pure

}
