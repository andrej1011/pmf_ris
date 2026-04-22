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
        .tip-uvid{background:#f0fff4;color:#276749}.tip-brisanje{background:#fff5f5;color:#c53030}
        .tip-prenosivost{background:#ebf8ff;color:#2b6cb0}.tip-ispravka{background:#faf5ff;color:#6b46c1}
    </style>
</head>
<body>
<nav class="top-nav d-flex align-items-center px-4 sticky-top shadow-sm">
    <div class="d-flex align-items-center gap-2 flex-grow-1">
        <div class="nav-icon">&#9874;</div>
        <span class="text-white fw-semibold small">Administrator</span>
    </div>
    <span class="text-white-50 small me-3">${korisnik.korisnickoIme}</span>
    <form action="${pageContext.request.contextPath}/logout" method="post" class="m-0">
        <button type="submit" class="btn btn-sm btn-outline-light">Odjava</button>
    </form>
</nav>
<div class="sidebar">
    <ul class="nav flex-column">
        <li><a href="${pageContext.request.contextPath}/admin/pocetna" class="nav-link">Početna</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/korisnici" class="nav-link">Korisnici</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/lozinka" class="nav-link">Promena lozinke</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/gdpr" class="nav-link active">GDPR zahtevi</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/revizija" class="nav-link">Revizijski trag</a></li>
    </ul>
</div>
<div class="main-content">
    <h4 class="fw-semibold mb-1">GDPR zahtevi</h4>
    <p class="text-muted small mb-4">Obrada zahteva pacijenata u skladu sa GDPR uredbom</p>

    <c:if test="${not empty poruka}"><div class="alert alert-success py-2 small">${poruka}</div></c:if>
    <c:if test="${not empty greska}"><div class="alert alert-danger py-2 small">${greska}</div></c:if>

    <div class="d-flex gap-2 flex-wrap mb-3">
        <a href="${pageContext.request.contextPath}/admin/gdpr" class="filter-btn ${empty param.tip ? 'active' : ''}">Svi</a>
        <a href="${pageContext.request.contextPath}/admin/gdpr?tip=UVID" class="filter-btn ${param.tip == 'UVID' ? 'active' : ''}">Uvid</a>
        <a href="${pageContext.request.contextPath}/admin/gdpr?tip=PRENOSIVOST" class="filter-btn ${param.tip == 'PRENOSIVOST' ? 'active' : ''}">Prenosivost</a>
        <a href="${pageContext.request.contextPath}/admin/gdpr?tip=BRISANJE" class="filter-btn ${param.tip == 'BRISANJE' ? 'active' : ''}">Brisanje</a>
        <a href="${pageContext.request.contextPath}/admin/gdpr?tip=ISPRAVKA" class="filter-btn ${param.tip == 'ISPRAVKA' ? 'active' : ''}">Ispravka</a>
    </div>

    <div class="card">
        <div class="table-responsive">
            <table class="table table-sm align-middle mb-0">
                <thead class="table-light small text-uppercase">
                    <tr><th>ID</th><th>Pacijent</th><th>Tip</th><th>Datum zahteva</th><th>Status</th><th>Napomena</th><th>Datum obrade</th><th>Akcija</th></tr>
                </thead>
                <tbody class="small">
                    <c:forEach items="${zahtevi}" var="z">
                        <c:if test="${empty param.tip || z.tipZahteva == param.tip}">
                        <tr>
                            <td>${z.idZahtev}</td>
                            <td>${z.korisnik != null ? z.korisnik.korisnickoIme : 'OBRISAN'}</td>
                            <td>
                                <span class="badge tip-${z.tipZahteva.toLowerCase()}">${z.tipZahteva}</span>
                                <div class="text-muted" style="font-size:11px">
                                    <c:choose>
                                        <c:when test="${z.tipZahteva == 'UVID'}">Pravo pristupa (cl. 15)</c:when>
                                        <c:when test="${z.tipZahteva == 'PRENOSIVOST'}">Prenosivost (cl. 20)</c:when>
                                        <c:when test="${z.tipZahteva == 'BRISANJE'}">Pravo na zaborav (cl. 17)</c:when>
                                        <c:when test="${z.tipZahteva == 'ISPRAVKA'}">Ispravka (cl. 16)</c:when>
                                    </c:choose>
                                </div>
                            </td>
                            <td><fmt:formatDate value="${z.datumZahteva}" pattern="dd-MM-yyyy HH:mm:ss"/></td>
                            <td>
                                <c:choose>
                                    <c:when test="${z.status == 'PRIMLJEN'}"><span class="badge bg-warning text-dark">PRIMLJEN</span></c:when>
                                    <c:when test="${z.status == 'U_OBRADI'}"><span class="badge bg-info text-dark">U OBRADI</span></c:when>
                                    <c:when test="${z.status == 'ZAVRSEN'}"><span class="badge bg-success">ZAVRŠEN</span></c:when>
                                    <c:otherwise><span class="badge bg-secondary">${z.status}</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td style="max-width:160px">${z.napomena}</td>
                            <td><c:if test="${not empty z.datumObrade}"><fmt:formatDate value="${z.datumObrade}" pattern="dd-MM-yyyy HH:mm:ss"/></c:if></td>
                            <td>
                                <c:if test="${z.status == 'PRIMLJEN'}">
                                    <form action="${pageContext.request.contextPath}/admin/promeniStatusGdpr" method="post" class="m-0">
                                        <input type="hidden" name="idZahtev" value="${z.idZahtev}"/>
                                        <input type="hidden" name="status" value="U_OBRADI"/>
                                        <button type="submit" class="btn btn-sm btn-primary">Uzmi u obradu</button>
                                    </form>
                                </c:if>
                                <c:if test="${z.status == 'U_OBRADI'}">
                                    <c:choose>
                                        <c:when test="${z.tipZahteva == 'BRISANJE'}">
                                            <form action="${pageContext.request.contextPath}/admin/obradiGdprBrisanje" method="post" class="m-0"
                                                  onsubmit="return confirm('Brisanje je NEPOVRATNO. Sigurno?')">
                                                <input type="hidden" name="idZahtev" value="${z.idZahtev}"/>
                                                <button type="submit" class="btn btn-sm btn-danger">Obriši podatke</button>
                                            </form>
                                        </c:when>
                                        <c:when test="${z.tipZahteva == 'UVID' || z.tipZahteva == 'PRENOSIVOST'}">
                                            <a href="${pageContext.request.contextPath}/admin/izvezi/${z.idZahtev}" class="btn btn-sm btn-info text-dark">Izvezi JSON</a>
                                        </c:when>
                                        	<c:otherwise>
    											<a href="${pageContext.request.contextPath}/admin/gdprIzmena/${z.idZahtev}" target="_blank" class="btn btn-sm btn-warning text-dark">Izmeni podatke</a>
											</c:otherwise>
                                    </c:choose>
                                </c:if>
                                <c:if test="${z.status == 'ZAVRSEN'}"><span class="text-muted">-</span></c:if>
                            </td>
                        </tr>
                        </c:if>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>