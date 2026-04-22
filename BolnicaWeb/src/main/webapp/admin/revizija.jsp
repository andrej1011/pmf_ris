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
        body{background:#f5f6fa}.top-nav{background:#1a3a5c;height:56px}.nav-icon{width:32px;height:32px;background:#2d7dd2;border-radius:6px;display:flex;align-items:center;justify-content:center;color:#fff;font-size:14px}
        .sidebar{width:220px;min-height:calc(100vh - 56px);background:#fff;border-right:1px solid #e2e8f0;position:fixed;top:56px;left:0;padding-top:16px}
        .sidebar .nav-link{color:#4a5568;font-size:13px;padding:10px 20px;border-left:3px solid transparent;border-radius:0}
        .sidebar .nav-link:hover{background:#f7fafc;color:#4a5568}
        .sidebar .nav-link.active{background:#ebf8ff;color:#2b6cb0;border-left-color:#2d7dd2;font-weight:600}
        .main-content{margin-left:220px;padding:28px 32px;max-width:1200px}
        .filter-btn{padding:5px 14px;border-radius:20px;font-size:12px;border:1px solid #e2e8f0;background:#fff;color:#4a5568;text-decoration:none}
        .filter-btn.active,.filter-btn:hover{background:#1a3a5c;color:#fff;border-color:#1a3a5c}
        .badge-akcija{font-size:10px;font-family:monospace;font-weight:600;padding:2px 7px;border-radius:8px;display:inline-block}
        .kat-login{background:#ebf8ff;color:#2b6cb0}
        .kat-gdpr{background:#faf5ff;color:#6b46c1}
        .kat-pregled{background:#f0fff4;color:#276749}
        .kat-korisnik{background:#fffbeb;color:#b7791f}
        .kat-sistem{background:#f7fafc;color:#718096}
    </style>
</head>
<body>
<nav class="top-nav d-flex align-items-center px-4 sticky-top shadow-sm">
    <div class="d-flex align-items-center gap-2 flex-grow-1">
        <div class="nav-icon">&#9874;</div>
        <span class="text-white fw-semibold small">Administrator</span>
    </div>
    <span class="text-white-50 small me-3">${korisnik.korisnickoIme} (${korisnik.idKorisnik})</span>
    <form action="${pageContext.request.contextPath}/logout" method="post" class="m-0">
        <button type="submit" class="btn btn-sm btn-outline-light">Odjava</button>
    </form>
</nav>
<div class="sidebar">
    <ul class="nav flex-column">
        <li><a href="${pageContext.request.contextPath}/admin/pocetna" class="nav-link">Početna</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/korisnici" class="nav-link">Korisnici</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/lozinka" class="nav-link">Promena lozinke</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/gdpr" class="nav-link">GDPR zahtevi</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/revizija" class="nav-link active">Revizijski trag</a></li>
    </ul>
</div>
<div class="main-content">
    <h4 class="fw-semibold mb-4">Revizijski trag</h4>

    <div class="d-flex gap-2 flex-wrap mb-3">
        <a href="${pageContext.request.contextPath}/admin/revizija" class="filter-btn ${empty aktivnaKategorija ? 'active' : ''}">Sve</a>
        <a href="${pageContext.request.contextPath}/admin/revizija?kategorija=PREGLED" class="filter-btn ${aktivnaKategorija == 'PREGLED' ? 'active' : ''}">Pregledi</a>
        <a href="${pageContext.request.contextPath}/admin/revizija?kategorija=KORISNIK" class="filter-btn ${aktivnaKategorija == 'KORISNIK' ? 'active' : ''}">Korisnici</a>
<a href="${pageContext.request.contextPath}/admin/revizija?kategorija=LOG" class="filter-btn ${aktivnaKategorija == 'LOG' ? 'active' : ''}">Login/Logout</a>
        <a href="${pageContext.request.contextPath}/admin/revizija?kategorija=GDPR" class="filter-btn ${aktivnaKategorija == 'GDPR' ? 'active' : ''}">GDPR</a>
    </div>

    <div class="card">
        <div class="table-responsive">
            <table class="table table-sm align-middle mb-0">
                <thead class="table-light small text-uppercase">
                    <tr><th>Datum i vreme</th><th>Korisnik</th><th>Akcija</th><th>Tip entiteta</th><th>ID</th></tr>
                </thead>
                <tbody class="small">
                    <c:forEach items="${revizija}" var="r">
                        <tr>
                            <td class="text-nowrap"><fmt:formatDate value="${r.datum}" pattern="dd-MM-yyyy HH:mm:ss"/></td>
                            <td>${r.korisnik.korisnickoIme}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${r.akcija.startsWith('LOG')}">
                                        <span class="badge-akcija kat-login">${r.akcija}</span>
                                    </c:when>
                                    <c:when test="${r.akcija.startsWith('GDPR')}">
                                        <span class="badge-akcija kat-gdpr">${r.akcija}</span>
                                    </c:when>
                                    <c:when test="${r.akcija.startsWith('PREGLED') || r.akcija.startsWith('ZAHTEV_ZA_PREGLED')}">
                                        <span class="badge-akcija kat-pregled">${r.akcija}</span>
                                    </c:when>
                                    <c:when test="${r.akcija.startsWith('KORISNIK')}">
                                        <span class="badge-akcija kat-korisnik">${r.akcija}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge-akcija kat-sistem">${r.akcija}</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="text-muted">${r.objekat}</td>
                            <td class="text-muted"><c:if test="${r.idObjekta > 0}">${r.idObjekta}</c:if></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>