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
        .main-content{margin-left:220px;padding:28px 32px;max-width:800px}
        .info-label{color:#718096;font-size:13px}
        .info-value{font-size:13px}
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
        <li><a href="${pageContext.request.contextPath}/pacijent/recepti" class="nav-link">&#128138; Recepti</a></li>
    </ul>
    <hr class="mx-3 my-1">
    <div class="sidebar-section">Zdravlje</div>
    <ul class="nav flex-column">
        <li><a href="${pageContext.request.contextPath}/pacijent/karton" class="nav-link active">&#128218; Zdravstveni karton</a></li>
        <li><a href="${pageContext.request.contextPath}/pacijent/gdpr" class="nav-link">&#9881; Podešavanja (GDPR)</a></li>
    </ul>
</div>
<div class="main-content">
    <h4 class="fw-semibold mb-4">Zdravstveni karton</h4>

    <div class="card mb-3">
        <div class="card-body">
            <h6 class="text-muted text-uppercase small fw-semibold mb-3">Lični podaci</h6>
            <div class="row g-2">
                <div class="col-5 info-label">Ime i prezime</div><div class="col-7 info-value">${pacijent.ime} ${pacijent.prezime}</div>
                <div class="col-5 info-label">Ime oca</div><div class="col-7 info-value">${not empty pacijent.imeOca ? pacijent.imeOca : '-'}</div>
                <div class="col-5 info-label">Datum rođenja</div><div class="col-7 info-value"><fmt:formatDate value="${pacijent.datumRodjenja}" pattern="dd.MM.yyyy."/></div>
                <div class="col-5 info-label">Pol</div><div class="col-7 info-value">${pacijent.pol == 'M' ? 'Muški' : (pacijent.pol == 'Z' ? 'Ženski' : '-')}</div>
                <div class="col-5 info-label">JMBG</div><div class="col-7 info-value">${pacijent.jmbg}</div>
                <div class="col-5 info-label">Adresa</div><div class="col-7 info-value">${not empty pacijent.adresa ? pacijent.adresa : '-'}</div>
                <div class="col-5 info-label">Email</div><div class="col-7 info-value">${not empty pacijent.email ? pacijent.email : '-'}</div>
                <div class="col-5 info-label">Telefon</div><div class="col-7 info-value">${not empty pacijent.telefon ? pacijent.telefon : '-'}</div>
                
            </div>
        </div>
    </div>

    <c:forEach items="${pacijent.zdravstveniKartons}" var="k">
        <div class="card mb-3">
            <div class="card-body">
                <div class="row g-2">
                	<div class="col-5 info-label">Osiguran</div><div class="col-7 info-value">${pacijent.osiguran == 1 ? 'Da' : 'Ne'}</div>
                	<div class="col-5 info-label">LBO</div><div class="col-7 info-value">${not empty pacijent.lbo ? pacijent.lbo : '-'}</div>
                 </div>
            </div>
        </div>
        <div class="card mb-3">
            <div class="card-body">
                <div class="row g-2">
                    <div class="col-5 info-label">Krvna grupa</div><div class="col-7 info-value">${not empty k.krvnaGrupa ? k.krvnaGrupa : '-'}</div>
                    <div class="col-5 info-label">Alergije</div><div class="col-7 info-value">${not empty k.alergije ? k.alergije : '-'}</div>
                    <div class="col-5 info-label">Hronični bolesnik</div><div class="col-7 info-value">${k.hronicanBolesnik == 1 ? 'Da' : 'Ne'}</div>
                    <div class="col-5 info-label">Napomena</div><div class="col-7 info-value">${not empty k.napomena ? k.napomena : '-'}</div>
                    <div class="col-5 info-label">Karton kreiran</div><div class="col-7 info-value"><fmt:formatDate value="${k.datumKreiranja}" pattern="dd.MM.yyyy."/></div>
                </div>
            </div>
        </div>
    </c:forEach>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>