<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0">
    
    <xsl:output method="text" encoding="UTF-8"/>
    <xsl:strip-space elements="*"/>
    
    <xsl:template match="/">
        <xsl:text>
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% SCRIPT FOR E-RARA AND MDZ FILES     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%% fini le 30.04.2025 par F. GOY            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% !TeX TS-program = lualatex
\documentclass{article}
\usepackage[T1]{fontenc}
\usepackage{microtype}
\usepackage[pdfusetitle,hidelinks]{hyperref}

\usepackage{polyglossia}
\setmainlanguage{english}
\setotherlanguages{latin,greek}
\usepackage[series={},nocritical,noend,noeledsec,nofamiliar,noledgroup]{reledmac}
\usepackage{reledpar}

\usepackage{fontspec}
\setmainfont{TeX Gyre Termes}

\usepackage{sectsty}
\usepackage{xcolor}

\usepackage{fancyhdr}
\pagestyle{fancy}
\fancyhf{}
\fancyhead[LE,RO]{\nouppercase{\leftmark}}  
\cfoot{\thepage}
\renewcommand{\headrulewidth}{0.4pt}

% Redefine \section to remove numbering
\usepackage{titlesec}
\titleformat{\section}[block]{\normalfont\scshape\color{gray}}{}{0pt}{} 
\titleformat{\subsection}[hang]{\normalfont}{}{0pt}{} 
\titleformat{\subsubsection}[hang]{\normalfont\footnotesize\color{black}}{}{0pt}{}

\makeatletter
\renewcommand{\sectionmark}[1]{\markboth{#1}{}} 
\renewcommand{\subsectionmark}[1]{\markright{#1}} 
\renewcommand{\numberline}[1]{} 
\makeatother

\begin{document}

\date{}
</xsl:text>
        
        <xsl:text>\title{</xsl:text>
        <xsl:value-of select="replace(//title[parent::titleStmt], '_', '\\_')"/>
        <xsl:text>}
\maketitle
\tableofcontents
\clearpage
\begin{pages} 
\beginnumbering
</xsl:text>
        
        <xsl:apply-templates/>
        
        <xsl:text>
\endnumbering
\end{pages}
\end{document}
</xsl:text>
    </xsl:template>
    
        <!-- Skip unnecessary elements -->
        <xsl:template match="teiHeader"/>
        <xsl:template match="sourceDoc"/>
        <xsl:template match="orig"/>
        
        <!-- Select only <reg> inside <choice> -->
        <xsl:template match="choice">
            <xsl:apply-templates select="reg"/>
        </xsl:template>
        
        <!-- Line breaks for <lb> -->
        <xsl:template match="lb">
            <xsl:text>\\
</xsl:text>
        </xsl:template>
        
        <!-- Apply escape on text() directly -->
        <xsl:template match="text()">
            <xsl:call-template name="escape-latex">
                <xsl:with-param name="text" select="."/>
            </xsl:call-template>
        </xsl:template>
        
        <!-- fw logic for margins and headers -->
        <xsl:template match="fw">
            <xsl:choose>
                <xsl:when test="@type='NumberingZone'">
                    <xsl:text>
\marginpar{[ p.</xsl:text><xsl:apply-templates/><xsl:text>]}</xsl:text>
                </xsl:when>
                <xsl:when test="@type='RunningTitleZone'">
                    <xsl:text>
\section*{</xsl:text><xsl:apply-templates/><xsl:text>}</xsl:text>
                </xsl:when>
            </xsl:choose>
        </xsl:template>
        
        <!-- Handle <ab> content with LaTeX structure -->
        <xsl:template match="ab">
            <xsl:choose>
                <xsl:when test="@type='TitlePageZone'">
                    <xsl:text>
\endnumbering\beginnumbering\section{</xsl:text>
                    <xsl:value-of select="replace(title, '_', '\\_')"/>
                    <xsl:text>}</xsl:text>
                </xsl:when>
                <xsl:when test="@type='MainZone'">
                    <xsl:text>\pstart
</xsl:text>
                    <xsl:apply-templates/>
                    <xsl:text>
\pend</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:template>
        
        <!-- Margin note handling -->
        <xsl:template match="note">
            <xsl:if test="@type='MarginTextZone'">
                <xsl:if test="not(preceding-sibling::note[@type='MarginTextZone-Notes'])">
                    <xsl:text>
\vspace{0.5cm}\noindent</xsl:text>
                </xsl:if>
                <xsl:text>
\textit{mg}
\footnotesize </xsl:text>
                <xsl:apply-templates/>
                <xsl:text>
\normalsize </xsl:text>
            </xsl:if>
        </xsl:template>
        
        <!-- Escape LaTeX special characters -->
        <xsl:template name="escape-latex">
            <xsl:param name="text"/>
            <xsl:variable name="step1" select="replace($text, '\\', '\\\\')" />
            <xsl:variable name="step2" select="replace($step1, '_', '\\_')" />
            <xsl:variable name="step3" select="replace($step2, '\^', '\\^{}')" />
            <xsl:variable name="step4" select="replace($step3, '&amp;', '\\&amp;')" />
            <xsl:value-of select="$step4"/>
        </xsl:template>
        
</xsl:stylesheet>
    
    
    
