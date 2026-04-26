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
        .tooltip-icon { width: 16px; height: 16px; background: #cbd5e0; color: #4a5568; border-radius: 50%; font-size: 10px; font-weight: 700; display: inline-flex; align-items: center; justify-content: center; cursor: default; }
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
        <a href="${pageContext.request.contextPath}/doktor/pregledi" class="nav-tab">Budući pregledi</a>
        <a href="${pageContext.request.contextPath}/doktor/noviPregled" class="nav-tab active">Novi pregled</a>
    </div>
    <form action="${pageContext.request.contextPath}/logout" method="post" class="m-0">
        <button type="submit" class="btn btn-sm btn-outline-light">Odjava</button>
    </form>
</nav>

<div class="d-flex align-items-center justify-content-center" style="min-height:calc(100vh - 40px)">
    <div class="card p-4" style="max-width:400px;width:100%">
        <h5 class="fw-semibold mb-4">Novi pregled</h5>
        <c:if test="${not empty greska}"><div class="alert alert-danger py-2 small">${greska}</div></c:if>
        <form action="${pageContext.request.contextPath}/doktor/zapocniPregled" method="post">
            <label class="form-label small fw-semibold d-flex align-items-center gap-2">
                JMBG/LBO pacijenta
                <span class="tooltip-icon" data-bs-toggle="tooltip" title="JMBG = 13 cifara, LBO = 11 cifara">?</span>
            </label>
            <div class="d-flex gap-2">
                <input type="text" name="brojUnos" class="form-control" maxlength="13" autofocus>
                <button type="submit" class="btn btn-primary">Dalje</button>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
document.querySelectorAll('[data-bs-toggle="tooltip"]').forEach(el => new bootstrap.Tooltip(el));
</script>
</body>
</html>