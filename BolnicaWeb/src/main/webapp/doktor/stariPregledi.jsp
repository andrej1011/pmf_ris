<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="sr">
<head>
    <meta charset="UTF-8">
    <title>Istorija pregleda</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="bg-dark text-white px-3 py-2 fw-semibold small">Prethodni pregledi pacijenta</div>
<div class="bg-dark text-white px-3 py-2 fw-semibold small">${p.pacijent.ime} ${p.pacijent.prezime}</div>
<div class="p-3">
    <c:choose>
        <c:when test="${empty pregledi}">
            <p class="text-muted small">Nema prethodnih zavrsenih pregleda.</p>
        </c:when>
        <c:otherwise>
            <c:forEach items="${pregledi}" var="p">
                <div class="card mb-2">
                    <div class="card-body py-2 px-3">
                        <div class="d-flex justify-content-between mb-1">
                            <span class="fw-semibold small"><fmt:formatDate value="${p.datumVreme}" pattern="dd-MM-yyyy HH:mm"/></span>
                            <span class="text-danger small fw-semibold">
                                <c:forEach items="${p.dijagnozas}" var="d" varStatus="st">
                                    ${d.sifra}<c:if test="${!st.last}">, </c:if>
                                </c:forEach>
                            </span>
                        </div>
                        <div class="small text-secondary" style="font-family:Georgia,serif;white-space:pre-wrap;line-height:1.7">${p.nalaz}</div>
                    </div>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>