<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="sr">
<head>
    <meta charset="UTF-8">
    <title>RIS Bolnica</title>
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/uploads/favicon.ico">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: #f5f6fa; }
        .doc-nav { background: #1a3a5c; height: 56px; }
        .nav-cross { width: 32px; height: 32px; background: #2d7dd2; border-radius: 6px; display: flex; align-items: center; justify-content: center; color: #fff; font-size: 14px; }
        .nav-tab { color: #9bbcd8; text-decoration: none; font-size: 13px; font-weight: 500; padding: 0 18px; height: 56px; display: flex; align-items: center; border-bottom: 3px solid transparent; }
        .nav-tab:hover { color: #fff; }
        .nav-tab.active { color: #fff; border-bottom-color: #2d7dd2; }
    </style>
</head>
<body>
<nav class="doc-nav d-flex align-items-center px-4 sticky-top shadow-sm">
    <div class="d-flex align-items-center gap-2 me-4">
        <div class="nav-cross">&#10010;</div>
        <div>
            <div class="text-white fw-semibold small">Dr. ${doktor.ime} ${doktor.prezime}</div>
            <div class="small" style="color:#7fafd4">${doktor.specijalizacija}</div>
        </div>
    </div>
    <div class="d-flex flex-grow-1 h-100">
        <a href="${pageContext.request.contextPath}/doktor/pocetna" class="nav-tab">Početna</a>
        <a href="${pageContext.request.contextPath}/doktor/zahtevi" class="nav-tab active">
            Zahtevi
            <c:if test="${not empty zahtevi}"><span class="badge bg-danger ms-1">${zahtevi.size()}</span></c:if>
        </a>
        <a href="${pageContext.request.contextPath}/doktor/pregledi" class="nav-tab">Budući pregledi</a>
        <a href="${pageContext.request.contextPath}/doktor/noviPregled" class="nav-tab">Novi pregled</a>
    </div>
    <form action="${pageContext.request.contextPath}/logout" method="post" class="m-0">
        <button type="submit" class="btn btn-sm btn-outline-light">Odjava</button>
    </form>
</nav>

<div class="container-fluid p-4" style="max-width:1100px">
    <h4 class="fw-semibold mb-4">Zahtevi za pregled</h4>
    <c:if test="${not empty poruka}"><div class="alert alert-success py-2 small">${poruka}</div></c:if>
    <c:if test="${not empty greska}"><div class="alert alert-danger py-2 small">${greska}</div></c:if>
    <c:choose>
        <c:when test="${empty zahtevi}">
            <p class="text-muted small">Nema novih zahteva.</p>
        </c:when>
        <c:otherwise>
            <c:forEach items="${zahtevi}" var="z">
                <div class="card mb-2 border-start border-4 border-purple" style="border-left-color:#6b46c1!important">
                    <div class="card-body d-flex justify-content-between align-items-start gap-3">
                        <div>
                            <div class="fw-semibold">${z.pacijent.ime} ${z.pacijent.prezime}</div>
                            <div class="text-muted small mt-1">
                                Termin: <strong><fmt:formatDate value="${z.termin.datumVreme}" pattern="dd-MM-yyyy HH:mm"/></strong><br>
                                Zahtev: <fmt:formatDate value="${z.datumZahteva}" pattern="dd-MM-yyyy HH:mm"/><br>
                                <c:if test="${not empty z.napomena}">Napomena: ${z.napomena}</c:if>
                            </div>
                        </div>
                        <div class="d-flex gap-2 flex-wrap">
                            <form action="${pageContext.request.contextPath}/doktor/odobriZahtev" method="post" class="m-0">
                                <input type="hidden" name="idZahtev" value="${z.idZahtev}"/>
                                <button type="submit" class="btn btn-sm btn-success">Odobri</button>
                            </form>
                            <form action="${pageContext.request.contextPath}/doktor/odbijZahtev" method="post" class="m-0 d-flex gap-2">
                                <input type="hidden" name="idZahtev" value="${z.idZahtev}"/>
                                <input type="text" name="komentar" class="form-control form-control-sm" style="width:180px" placeholder="Razlog odbijanja" required>
                                <button type="submit" class="btn btn-sm btn-danger">Odbij</button>
                            </form>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>