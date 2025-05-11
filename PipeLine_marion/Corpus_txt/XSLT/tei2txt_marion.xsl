<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0">
    
    <xsl:output method="text" encoding="UTF-8"/>
    
    <xsl:strip-space elements="*"/>
    <!-- ce script sert à tester differente option de mise en page -->
    <xsl:template match="teiHeader"/>
    
    <xsl:template match="sourceDoc"/>
    
    <xsl:template match="teiHeader"/>
    <xsl:template match="sourceDoc"/>
    <xsl:template match="orig"/>
    
    
    <xsl:template match="reg">
        <xsl:apply-templates/><xsl:text> </xsl:text>
    </xsl:template>
    
    <!-- if we do not need the title and pagination -->
    <xsl:template match="fw"/>
    
    <!-- if we need information on title and pagination
    <xsl:template match="fw">
        <xsl:choose>
            <xsl:when test="@type='NumberingZone'">
                <xsl:text>
[ p.</xsl:text><xsl:apply-templates/><xsl:text>]</xsl:text>
            </xsl:when>
            <xsl:when test="@type='RunningTitleZone'">
                <xsl:text>
[ titre: </xsl:text><xsl:apply-templates/><xsl:text>]</xsl:text>
            </xsl:when>
        </xsl:choose>
    </xsl:template>  -->
    
    <!-- Process text sections (ab elements) the following code structure the txt file by verset-->
    <xsl:template match="ab">
        <xsl:choose>
            <xsl:when test="@type='TitlePageZone'">
                <xsl:text>
                    

**</xsl:text><xsl:apply-templates/><xsl:text>**
</xsl:text>
            </xsl:when> <!-- I add 2 stars ** around the title -->
            <xsl:when test="@type='MainZone-P'">
                <xsl:apply-templates/>
            </xsl:when>
            <xsl:when test="@type='MainZone'">
            <xsl:apply-templates select="*|node()"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/> 
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="note">
        <xsl:choose>
        <xsl:when test="@type='MarginTextZone'">  <!--I add 2 -\-\ and 1 space around the note--> 
            <xsl:text>
-- </xsl:text>
            <xsl:apply-templates/><xsl:text> --
</xsl:text>
        </xsl:when>
        </xsl:choose>
    </xsl:template>
    

    
</xsl:stylesheet>