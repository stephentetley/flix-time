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
        import static get java.time.temporal.ChronoUnit.NANOS: ##java.time.temporal.ChronoUnit & Pure as getNANOS;
        getNANOS()

    pub def getMICROS(): ##java.time.temporal.ChronoUnit = 
        import static get java.time.temporal.ChronoUnit.MICROS: ##java.time.temporal.ChronoUnit & Pure as getMICROS;
        getMICROS()

    pub def getMILLIS(): ##java.time.temporal.ChronoUnit = 
        import static get java.time.temporal.ChronoUnit.MILLIS: ##java.time.temporal.ChronoUnit & Pure as getMILLIS;
        getMILLIS() as & Pure

    pub def getSECONDS(): ##java.time.temporal.ChronoUnit = 
        import static get java.time.temporal.ChronoUnit.SECONDS: ##java.time.temporal.ChronoUnit & Pure as getSECONDS;
        getSECONDS()

    pub def getMINUTES(): ##java.time.temporal.ChronoUnit = 
        import static get java.time.temporal.ChronoUnit.MINUTES: ##java.time.temporal.ChronoUnit & Pure as getMINUTES;
        getMINUTES()

    pub def getHOURS(): ##java.time.temporal.ChronoUnit = 
        import static get java.time.temporal.ChronoUnit.HOURS: ##java.time.temporal.ChronoUnit & Pure as getHOURS;
        getHOURS()

    pub def getHALF_DAYS(): ##java.time.temporal.ChronoUnit = 
        import static get java.time.temporal.ChronoUnit.HALF_DAYS: ##java.time.temporal.ChronoUnit & Pure as getHALF_DAYS;
        getHALF_DAYS()

    pub def getDAYS(): ##java.time.temporal.ChronoUnit = 
        import static get java.time.temporal.ChronoUnit.DAYS: ##java.time.temporal.ChronoUnit & Pure as getDAYS;
        getDAYS()

    pub def getWEEKS(): ##java.time.temporal.ChronoUnit = 
        import static get java.time.temporal.ChronoUnit.WEEKS: ##java.time.temporal.ChronoUnit & Pure as getWEEKS;
        getWEEKS()

    pub def getMONTHS(): ##java.time.temporal.ChronoUnit = 
        import static get java.time.temporal.ChronoUnit.MONTHS: ##java.time.temporal.ChronoUnit & Pure as getMONTHS;
        getMONTHS()

    pub def getYEARS(): ##java.time.temporal.ChronoUnit = 
        import static get java.time.temporal.ChronoUnit.YEARS: ##java.time.temporal.ChronoUnit & Pure as getYEARS;
        getYEARS()

    pub def getDECADES(): ##java.time.temporal.ChronoUnit = 
        import static get java.time.temporal.ChronoUnit.DECADES: ##java.time.temporal.ChronoUnit & Pure as getDECADES;
        getDECADES()

    pub def getCENTURIES(): ##java.time.temporal.ChronoUnit = 
        import static get java.time.temporal.ChronoUnit.CENTURIES: ##java.time.temporal.ChronoUnit & Pure as getCENTURIES;
        getCENTURIES()

    pub def getMILLENNIA(): ##java.time.temporal.ChronoUnit = 
        import static get java.time.temporal.ChronoUnit.MILLENNIA: ##java.time.temporal.ChronoUnit & Pure as getMILLENNIA;
        getMILLENNIA()

    pub def getERAS(): ##java.time.temporal.ChronoUnit = 
        import static get java.time.temporal.ChronoUnit.ERAS: ##java.time.temporal.ChronoUnit & Pure as getERAS;
        getERAS()

    pub def getFOREVER(): ##java.time.temporal.ChronoUnit = 
        import static get java.time.temporal.ChronoUnit.FOREVER: ##java.time.temporal.ChronoUnit & Pure as getFOREVER;
        getFOREVER()

}
