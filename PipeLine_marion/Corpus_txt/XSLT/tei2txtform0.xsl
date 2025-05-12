<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    xmlns:alto="http://www.loc.gov/standards/alto/ns-v4#"
    version="2.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0">  <!-- add the name space of the alto file data/doc1/ *.xml --> 
    
    <xsl:output method="text" encoding="UTF-8"/>
    
    <xsl:strip-space elements="*"/>
    <!-- ce script sert à tester differente option de mise en page -->
    
    <xsl:variable name="document">FRCAOM06_COLE</xsl:variable>
    
    
    <xsl:template match="teiHeader"/>
    
    <xsl:template match="sourceDoc"/>
    
    <xsl:template match="teiHeader"/>
    <xsl:template match="sourceDoc"/>
    <xsl:template match="orig"/>
    
    
    <xsl:template match="reg">
        <xsl:apply-templates/><xsl:text> </xsl:text>
    </xsl:template>
 
 
    <xsl:template match="pb">
        <xsl:choose>
        <xsl:when test="@corresp">
            <xsl:text>
                
**</xsl:text>
            <xsl:value-of select="concat($document, '_', substring-after(@corresp, '#f'))"/>
        <xsl:text>**
</xsl:text>
        </xsl:when>
        </xsl:choose>
    </xsl:template>    
 
    

    <xsl:template match="lb">
        <xsl:text> </xsl:text>
    </xsl:template>
    
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