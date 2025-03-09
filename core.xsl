<?xml version="1.0"?>
<!-- SPDX-License-Identifier: CC0-1.0 -->
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:f="http://www.jonmsterling.com/jms-005P.xml"
  xmlns:mml="http://www.w3.org/1998/Math/MathML"
  xmlns:html="http://www.w3.org/1999/xhtml">

  <!-- The following ensures that node not matched by a template will show up as an error. -->
  <xsl:template match="node()|@*">
    <xsl:copy>
      <span style="background-color:red">
        <xsl:text>[</xsl:text>
        <xsl:value-of select="name(.)" />
        <xsl:text>]</xsl:text>
      </span>
      <span style="background-color:red">
        <xsl:apply-templates select="node()|@*" />
      </span>
    </xsl:copy>
  </xsl:template>

  <!-- HTML and MathML nodes should be copied with namespace prefixes stripped.-->
  <xsl:template match="html:*">
    <xsl:element namespace="http://www.w3.org/1999/xhtml" name="{local-name()}">
      <xsl:apply-templates select="@* | node()" />
    </xsl:element>
  </xsl:template>

  <xsl:template match="mml:*">
    <xsl:element namespace="http://www.w3.org/1998/Math/MathML" name="{local-name()}">
      <xsl:apply-templates select="@* | node()" />
    </xsl:element>
  </xsl:template>

  <xsl:template match="f:error | f:info">
    <span class="error">
      <xsl:apply-templates />
    </span>
  </xsl:template>

  <xsl:template match="f:info">
    <span class="info">
      <xsl:apply-templates />
    </span>
  </xsl:template>

  <xsl:template match="f:tex[@display='block']">
    <xsl:text>\[</xsl:text>
    <xsl:value-of select="." />
    <xsl:text>\]</xsl:text>
  </xsl:template>

  <xsl:template match="f:tex[not(@display='block')]">
    <xsl:text>\(</xsl:text>
    <xsl:value-of select="." />
    <xsl:text>\)</xsl:text>
  </xsl:template>

</xsl:stylesheet>
