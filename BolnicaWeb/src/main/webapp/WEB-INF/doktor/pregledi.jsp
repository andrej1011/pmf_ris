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
        <a href="${pageContext.request.contextPath}/doktor/zahtevi" class="nav-tab">Zahtevi</a>
        <a href="${pageContext.request.contextPath}/doktor/pregledi" class="nav-tab active">Budući pregledi</a>
        <a href="${pageContext.request.contextPath}/doktor/noviPregled" class="nav-tab">Novi pregled</a>
    </div>
    <form action="${pageContext.request.contextPath}/logout" method="post" class="m-0">
        <button type="submit" class="btn btn-sm btn-outline-light">Odjava</button>
    </form>
</nav>

<div class="container-fluid p-4" style="max-width:1100px">
    <h4 class="fw-semibold mb-4">Budući pregledi</h4>

    <c:if test="${not empty aktivni}">
        <h6 class="text fw-semibold mb-2">U toku</h6>
        <div class="card border mb-3">
            <div class="table-responsive">
                <table class="table table-sm align-middle mb-0">
                    <thead class="table-light"><tr><th>Br.</th><th>Pacijent</th><th>Termin</th><th></th></tr></thead>
                    <tbody>
                        <c:forEach items="${aktivni}" var="p">
                            <tr>
                                <td>${p.idPregled}</td>
                                <td>${p.pacijent.ime} ${p.pacijent.prezime}</td>
                                <td><fmt:formatDate value="${p.datumVreme}" pattern="dd-MM-yyyy HH:mm"/></td>
                                <td><a href="${pageContext.request.contextPath}/doktor/aktivanPregled?idPregled=${p.idPregled}" class="btn btn-sm btn-primary">Nastavi</a></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </c:if>
	<br>
    <h6 class="fw-semibold mb-2">Zakazani</h6>
    <div class="card">
        <div class="table-responsive">
            <c:choose>
                <c:when test="${empty zakazani}">
                    <p class="text-muted small p-3 mb-0">Nema zakazanih pregleda.</p>
                </c:when>
                <c:otherwise>
                    <table class="table table-sm align-middle mb-0">
                        <thead class="table-light"><tr><th>Br.</th><th>Pacijent</th><th>Datum i vreme</th><th>Status</th></tr></thead>
                        <tbody>
                            <c:forEach items="${zakazani}" var="p">
                                <tr>
                                    <td>${p.idPregled}</td>
                                    <td>${p.pacijent.ime} ${p.pacijent.prezime}</td>
                                    <td><fmt:formatDate value="${p.datumVreme}" pattern="dd-MM-yyyy HH:mm"/></td>
                                    <td><span class="badge bg-info text-dark">ZAKAZAN</span></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>