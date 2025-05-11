<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0">
    
    <xsl:output encoding="UTF-8" method="xml" indent="yes"/>
    
    <xsl:strip-space elements="*"/>
    
    <xsl:template match="node()|@*">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*"/>
        </xsl:copy>
    </xsl:template>
    <!-- correction for mario's file old script under -->
    <xsl:template match="//body">
        <body xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:for-each select="surface">
                <!-- All xsl:sort go first -->
                <!-- 1. Extract numeric part from '241601A' => 241601 -->
                <xsl:sort select="number(translate(substring-before(substring-after(@xml:id, 'COLE_'), '_'), translate(substring-before(substring-after(@xml:id, 'COLE_'), '_'), '0123456789', ''), ''))" data-type="number"/>
                <!-- 2. Extract letter part from '241601A' => A -->
                <xsl:sort select="translate(substring-before(substring-after(@xml:id, 'COLE_'), '_'), '0123456789', '')" data-type="text"/>
                <!-- 3. Extract last numeric part '0886' -->
                <xsl:sort select="number(substring-after(substring-after(@xml:id, 'COLE_'), '_'))" data-type="number"/>
                
                <!-- Copy the sorted node -->
                <xsl:copy-of select="."/>
            </xsl:for-each>
        </body>
    </xsl:template>
    
    <!-- sorted every elements <surface> in numerical order for e-rara -->  
   <!-- <xsl:template match="//body">
        <body xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:for-each select="surface">
                <xsl:sort select="substring-after(@xml:id, 'f')" data-type="number"/>
                <xsl:copy-of select="."/>
            </xsl:for-each>
        </body>
    </xsl:template>  
    -->
    <!-- sorted every elements <surface> in numerical order for mdz -->   
    <!--<xsl:template match="//body">
        <!-\- Create the output element -\->
        <body xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:for-each select="surface">
                <!-\- Sort based on the numeric part after the underscore '_' -\->
                <xsl:sort select="substring-after(@xml:id, '_')" data-type="number"/>                
                <!-\- Copy the entire surface element to the output -\->
                <xsl:copy-of select="."/>
            </xsl:for-each>
        </body>
    </xsl:template>-->
    
</xsl:stylesheet>