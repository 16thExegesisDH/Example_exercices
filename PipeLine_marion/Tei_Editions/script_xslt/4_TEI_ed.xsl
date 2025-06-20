<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0">
    
    <xsl:output encoding="UTF-8" method="xml" indent="yes"/>
    <!-- Adapted to the new segmenentation model -->
    <xsl:strip-space elements="*"/>
    
    <xsl:template match="node()|@*">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*"/>
        </xsl:copy>
    </xsl:template>
    
    <!--<xsl:template match="surface[ancestor::body]">
        <xsl:element name="pb" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:attribute name="corresp"><xsl:value-of select="@xml:id"/></xsl:attribute>
        </xsl:element> 
        <xsl:apply-templates/>      
    </xsl:template>-->
    
    <xsl:template match="surface[ancestor::body]">
        <!-- Generate pb -->
        <xsl:element name="pb" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:attribute name="corresp">
                <xsl:value-of select="@xml:id"/>
            </xsl:attribute>
        </xsl:element>  
            <!-- la création de la title page Zone est ajoutée pour les données de marion -->
            <!-- Inject ab TitlePageZone -->
            <xsl:element name="ab" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:attribute name="corresp">
                    <xsl:text>#</xsl:text>
                    <xsl:value-of select="@xml:id"/>
                </xsl:attribute>
                <xsl:attribute name="type">TitlePageZone</xsl:attribute>
                <xsl:element name="lb" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:attribute name="corresp"><xsl:text>#</xsl:text><xsl:value-of select="@xml:id"/><xsl:text>_ligne_0</xsl:text></xsl:attribute>  
                </xsl:element>
                <xsl:element name="title" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:value-of select="substring(@xml:id, 2)"/> <!-- I use substring for delete the first lettre of the @xml:id, keeping the folder name -->
                </xsl:element>
                
            </xsl:element>
            
            <!-- Apply templates to child zones, which will match the rules you listed -->
            <xsl:apply-templates select="zone"/>
        
    </xsl:template>
    
    
    <xsl:template match="//body/surface/zone">
        
        <xsl:choose>
            <!--  <ab> (anonymous block) contains any component-level unit of text, acting as a container for phrase or inter level elements analogous to, but without the same constraints as, a paragraph -->
            
            <!-- commenter si on est dans la nouvelle segmentation, sans MainZone -->
            <xsl:when test="@type='MainZone'">
                 
                <xsl:element name="ab" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:attribute name="corresp"><xsl:text>#</xsl:text><xsl:value-of select="@xml:id"/></xsl:attribute>
                    <xsl:attribute name="type"><xsl:value-of select="@type"/></xsl:attribute>
                    <xsl:apply-templates/>
                </xsl:element>      
            </xsl:when>

            <xsl:when test="@type='MainZone-P'">
                <!-- <ab> (anonymous block) contains any component-level unit of text, acting as a container for phrase or inter level elements analogous to, but without the same constraints as, a paragraph. -->
                <xsl:element name="ab" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:attribute name="corresp"><xsl:text>#</xsl:text><xsl:value-of select="@xml:id"/></xsl:attribute>
                    <xsl:attribute name="type"><xsl:value-of select="@type"/></xsl:attribute>
                    <xsl:apply-templates/>
                </xsl:element>      
            </xsl:when>
            
            <xsl:when test="@type='MainZone-P-Continued'">
                <!-- <ab> (anonymous block) contains any component-level unit of text, acting as a container for phrase or inter level elements analogous to, but without the same constraints as, a paragraph. -->
                <xsl:element name="ab" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:attribute name="corresp"><xsl:text>#</xsl:text><xsl:value-of select="@xml:id"/></xsl:attribute>
                    <xsl:attribute name="type"><xsl:value-of select="@type"/></xsl:attribute>
                    <xsl:apply-templates/>
                </xsl:element>      
            </xsl:when>
            
            <xsl:when test="@type='MainZone-Head'">
                <!-- <ab> (anonymous block) contains any component-level unit of text, acting as a container for phrase or inter level elements analogous to, but without the same constraints as, a paragraph. -->
                <xsl:element name="ab" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:attribute name="corresp"><xsl:text>#</xsl:text><xsl:value-of select="@xml:id"/></xsl:attribute>
                    <xsl:attribute name="type"><xsl:value-of select="@type"/></xsl:attribute>
                    <xsl:apply-templates/>
                </xsl:element>      
            </xsl:when>
            
            <xsl:when test="@type='NumberingZone'">
                <!-- <fw> (forme work) contains a running head (e.g. a header, footer), catchword, or similar material appearing on the current page. -->
                <xsl:element name="fw" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:attribute name="corresp"><xsl:text>#</xsl:text><xsl:value-of select="@xml:id"/></xsl:attribute>
                    <xsl:attribute name="type"><xsl:value-of select="@type"/></xsl:attribute>
                    <xsl:apply-templates/>
                </xsl:element>      
            </xsl:when>
            <xsl:when test="@type='QuireMarksZone'">
                <!-- <fw> (forme work) contains a running head (e.g. a header, footer), catchword, or similar material appearing on the current page. -->
                <xsl:element name="fw" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:attribute name="corresp"><xsl:text>#</xsl:text><xsl:value-of select="@xml:id"/></xsl:attribute>
                    <xsl:attribute name="type"><xsl:value-of select="@type"/></xsl:attribute>
                    <xsl:apply-templates/>
                </xsl:element>   
            </xsl:when>
            <xsl:when test="@type='RunningTitleZone'">
                <!-- <fw> (forme work) contains a running head (e.g. a header, footer), catchword, or similar material appearing on the current page. -->
                <xsl:element name="fw" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:attribute name="corresp"><xsl:text>#</xsl:text><xsl:value-of select="@xml:id"/></xsl:attribute>
                    <xsl:attribute name="type"><xsl:value-of select="@type"/></xsl:attribute>
                    <xsl:apply-templates/>
                </xsl:element>      
            </xsl:when>
            <!--<xsl:when test="@type='TitlePageZone'">
                <!-\- <ab> (anonymous block) contains any component-level unit of text, acting as a container for phrase or inter level elements analogous to, but without the same constraints as, a paragraph. -\->
                <xsl:element name="ab" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:attribute name="corresp"><xsl:text>#</xsl:text><xsl:value-of select="@xml:id"/></xsl:attribute>
                    <xsl:attribute name="type"><xsl:value-of select="@type"/></xsl:attribute>
                    <xsl:apply-templates/>
                </xsl:element>      
            </xsl:when>-->
            <xsl:when test="@type='DropCapitalZone'">
                <!-- <ab> (anonymous block) contains any component-level unit of text, acting as a container for phrase or inter level elements analogous to, but without the same constraints as, a paragraph. -->
                <xsl:element name="ab" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:attribute name="corresp"><xsl:text>#</xsl:text><xsl:value-of select="@xml:id"/></xsl:attribute>
                    <xsl:attribute name="type"><xsl:value-of select="@type"/></xsl:attribute>
                    <xsl:apply-templates/>
                </xsl:element>      
            </xsl:when>
            <xsl:when test="@type='MarginTextZone'">
                <!-- <note> (note) contains a note or annotation. -->
                <xsl:element name="note" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:attribute name="corresp"><xsl:text>#</xsl:text><xsl:value-of select="@xml:id"/></xsl:attribute>
                    <xsl:attribute name="type"><xsl:value-of select="@type"/></xsl:attribute>
                    <xsl:apply-templates/>
                </xsl:element>      
            </xsl:when>
            <xsl:when test="@type='MarginTextZone-Notes'">
                <!-- <note> (note) contains a note or annotation. -->
                <xsl:element name="note" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:attribute name="corresp"><xsl:text>#</xsl:text><xsl:value-of select="@xml:id"/></xsl:attribute>
                    <xsl:attribute name="type"><xsl:value-of select="@type"/></xsl:attribute>
                    <xsl:apply-templates/>
                </xsl:element>      
            </xsl:when>
            <xsl:when test="@type='TableZone'">
                <!-- <ab> (anonymous block) contains any component-level unit of text, acting as a container for phrase or inter level elements analogous to, but without the same constraints as, a paragraph. -->
                <xsl:element name="note" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:attribute name="corresp"><xsl:text>#</xsl:text><xsl:value-of select="@xml:id"/></xsl:attribute>
                    <xsl:attribute name="type"><xsl:value-of select="@type"/></xsl:attribute>
                    <xsl:apply-templates/>
                </xsl:element>      
            </xsl:when>
            <!-- GraphicZone with some text? -->
            <xsl:otherwise/>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="//body/surface/zone/zone">
        <xsl:choose>
            <xsl:when test="@type='default'">
                <xsl:apply-templates/>
            </xsl:when>
            <xsl:when test="@type='DefaultLine'">
                <xsl:apply-templates/>
            </xsl:when>
            <xsl:when test="@type='HeadingLine'">
                <xsl:element name="hi" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:apply-templates/>
                </xsl:element>
            </xsl:when>
            <xsl:when test="@type='DropCapitalLine'">
                <xsl:element name="hi" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:apply-templates/>
                </xsl:element>
            </xsl:when>
            <xsl:when test="@type='CustomLine:BiblicalText'">
                <xsl:element name="hi" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:apply-templates/>
                </xsl:element>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="line[ancestor::body]">
        <xsl:element name="lb" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:attribute name="corresp"><xsl:text>#</xsl:text><xsl:value-of select="@xml:id"/></xsl:attribute>
        </xsl:element>
        <xsl:element name="choice" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:element name="orig" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:apply-templates/>
            </xsl:element>
            <xsl:element name="reg" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:attribute name="type">modernize</xsl:attribute>
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    
    
    <xsl:template match="path[ancestor::body]"/>
    <xsl:template match="graphic[ancestor::body]"/>
    
</xsl:stylesheet>