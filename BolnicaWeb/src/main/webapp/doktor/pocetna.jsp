<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        .home-center { display: flex; flex-direction: column; align-items: center; justify-content: center; min-height: calc(100vh - 56px); text-align: center; }
        .home-clock { font-size: 72px; font-weight: 700; color: #1a3a5c; letter-spacing: -2px; line-height: 1; }
        .btn-zapocni { background: #1a3a5c; color: #fff; border: none; border-radius: 8px; padding: 16px 48px; font-size: 16px; font-weight: 700; text-decoration: none; }
        .btn-zapocni:hover { background: #2d5a8a; color: #fff; }
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
        <a href="${pageContext.request.contextPath}/doktor/pocetna" class="nav-tab active">Početna</a>
        <a href="${pageContext.request.contextPath}/doktor/zahtevi" class="nav-tab">
            Zahtevi
            <c:if test="${not empty cekajuciZahtevi}">
                <span class="badge bg-danger ms-1">${cekajuciZahtevi.size()}</span>
            </c:if>
        </a>
        <a href="${pageContext.request.contextPath}/doktor/pregledi" class="nav-tab">Budući pregledi</a>
        <a href="${pageContext.request.contextPath}/doktor/noviPregled" class="nav-tab">Novi pregled</a>
    </div>
    <form action="${pageContext.request.contextPath}/logout" method="post" class="m-0">
        <button type="submit" class="btn btn-sm btn-outline-light">Odjava</button>
    </form>
</nav>

<div class="home-center gap-2">
    <h4 class="fw-light mb-3">Dobar dan, Dr. <strong>${doktor.prezime}</strong></h4>
    <div class="text-muted small text-uppercase letter-spacing-1 mb-1">Trenutno vreme</div>
    <div class="home-clock" id="clock">--:--</div>
    <div class="text-muted mb-4" id="dateStr"></div>
    <a href="${pageContext.request.contextPath}/doktor/noviPregled" class="btn-zapocni">ZAPOČNI PREGLED</a>
    <c:if test="${not empty aktivni}">
        <div class="mt-3">
            <span class="badge bg-warning text-dark">
                ${aktivni.size()} pregled(a) u toku &mdash;
                <a href="${pageContext.request.contextPath}/doktor/pregledi" class="text-dark">Prikaži</a>
            </span>
        </div>
    </c:if>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
const DANI = ['Nedelja','Ponedeljak','Utorak','Sreda','Cetvrtak','Petak','Subota'];
const MESECI = ['Jan','Feb','Mar','Apr','Maj','Jun','Jul','Avg','Sep','Okt','Nov','Dec'];
function tick() {
    const now = new Date();
    document.getElementById('clock').textContent = String(now.getHours()).padStart(2,'0') + ':' + String(now.getMinutes()).padStart(2,'0');
    document.getElementById('dateStr').textContent = DANI[now.getDay()] + ', ' + now.getDate() + '. ' + MESECI[now.getMonth()] + ' ' + now.getFullYear();
}
tick(); setInterval(tick, 1000);
</script>
</body>
</html>