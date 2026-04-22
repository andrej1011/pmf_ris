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
        body{background:#f5f6fa}.top-nav{background:#1a3a5c;height:56px}.nav-icon{width:32px;height:32px;background:#38a169;border-radius:6px;display:flex;align-items:center;justify-content:center;color:#fff;font-size:16px}
        .sidebar{width:220px;min-height:calc(100vh - 56px);background:#fff;border-right:1px solid #e2e8f0;position:fixed;top:56px;left:0;padding-top:16px}
        .sidebar .nav-link{color:#4a5568;font-size:13px;padding:10px 20px;border-left:3px solid transparent;border-radius:0}
        .sidebar .nav-link:hover{background:#f7fafc;color:#4a5568}
        .sidebar .nav-link.active{background:#f0fff4;color:#276749;border-left-color:#38a169;font-weight:600}
        .sidebar-section{font-size:10px;font-weight:700;color:#a0aec0;text-transform:uppercase;letter-spacing:.8px;padding:12px 20px 4px}
        .main-content{margin-left:220px;padding:28px 32px;max-width:960px}
    </style>
</head>
<body>
<nav class="top-nav d-flex align-items-center px-4 sticky-top shadow-sm">
    <div class="d-flex align-items-center gap-2 flex-grow-1">
        <div class="nav-icon">&#43;</div>
        <span class="text-white fw-semibold small">Bolnički portal</span>
    </div>
    <a href="${pageContext.request.contextPath}/pacijent/gdpr" class="text-white-50 small me-3 text-decoration-none">${pacijent.ime} ${pacijent.prezime}</a>
    <form action="${pageContext.request.contextPath}/logout" method="post" class="m-0">
        <button type="submit" class="btn btn-sm btn-outline-light">Odjava</button>
    </form>
</nav>
<div class="sidebar">
    <ul class="nav flex-column">
        <li><a href="${pageContext.request.contextPath}/pacijent/pocetna" class="nav-link">&#127968; Početna</a></li>
    </ul>
    <hr class="mx-3 my-1">
    <div class="sidebar-section">Pregledi</div>
    <ul class="nav flex-column">
        <li><a href="${pageContext.request.contextPath}/pacijent/zakazivanje" class="nav-link">&#128197; Zakaži pregled</a></li>
        <li><a href="${pageContext.request.contextPath}/pacijent/buduciPregledi" class="nav-link">&#128337; Budući pregledi</a></li>
        <li><a href="${pageContext.request.contextPath}/pacijent/prosliPregledi" class="nav-link">&#128196; Stari pregledi</a></li>
        <li><a href="${pageContext.request.contextPath}/pacijent/recepti" class="nav-link active">&#128138; Recepti</a></li>
    </ul>
    <hr class="mx-3 my-1">
    <div class="sidebar-section">Zdravlje</div>
    <ul class="nav flex-column">
        <li><a href="${pageContext.request.contextPath}/pacijent/karton" class="nav-link">&#128218; Zdravstveni karton</a></li>
        <li><a href="${pageContext.request.contextPath}/pacijent/gdpr" class="nav-link">&#9881; Podešavanja (GDPR)</a></li>
    </ul>
</div>
<div class="main-content">
    <h4 class="fw-semibold mb-4">&#128138;  Recepti</h4>
    <div class="card">
        <div class="table-responsive">
            <c:choose>
                <c:when test="${empty recepti}">
                    <p class="text-muted small p-3 mb-0 text-center">Nemate izdatih recepata.</p>
                </c:when>
                <c:otherwise>
                    <table class="table table-sm align-middle mb-0">
                        <thead class="table-light small text-uppercase">
                            <tr><th>Lek</th><th>Količina</th><th>Uputstvo</th><th>Izdat</th><th>Važi do</th><th>Podignut</th></tr>
                        </thead>
                        <tbody class="small">
                            <c:forEach items="${recepti}" var="r">
                                <tr>
                                    <td>
                                        <div class="fw-semibold">${r.lek.naziv}</div>
                                        <div class="text-muted" style="font-size:11px">${r.lek.aktivnaMaterija}</div>
                                    </td>
                                    <td>${r.kolicina}</td>
                                    <td class="text-muted">${r.uputstvo}</td>
                                    <td><fmt:formatDate value="${r.datumIzdavanja}" pattern="dd.MM.yyyy."/></td>
                                    <td><fmt:formatDate value="${r.datumVazenja}" pattern="dd.MM.yyyy."/></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${r.podignut == 1}"><span class="badge bg-success">Da</span></c:when>
                                            <c:otherwise><span class="badge bg-secondary">Ne</span></c:otherwise>
                                        </c:choose>
                                    </td>
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