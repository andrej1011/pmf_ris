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
        body{background:#f5f6fa}.top-nav{background:#1a3a5c;height:56px}.nav-icon{width:32px;height:32px;background:#2d7dd2;border-radius:6px;display:flex;align-items:center;justify-content:center;color:#fff;font-size:14px}
        .sidebar{width:220px;min-height:calc(100vh - 56px);background:#fff;border-right:1px solid #e2e8f0;position:fixed;top:56px;left:0;padding-top:16px}
        .sidebar .nav-link{color:#4a5568;font-size:13px;padding:10px 20px;border-left:3px solid transparent;border-radius:0}
        .sidebar .nav-link:hover{background:#f7fafc;color:#4a5568}
        .sidebar .nav-link.active{background:#ebf8ff;color:#2b6cb0;border-left-color:#2d7dd2;font-weight:600}
        .main-content{margin-left:220px;padding:28px 32px;max-width:560px}
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
        <li><a href="${pageContext.request.contextPath}/admin/lozinka" class="nav-link active">Promena lozinke</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/gdpr" class="nav-link">GDPR zahtevi</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/revizija" class="nav-link">Revizijski trag</a></li>
    </ul>
</div>
<div class="main-content">
    <h4 class="fw-semibold mb-4">Promena lozinke</h4>
    <c:if test="${not empty poruka}"><div class="alert alert-success py-2 small">${poruka}</div></c:if>
    <c:if test="${not empty greska}"><div class="alert alert-danger py-2 small">${greska}</div></c:if>
    <div class="card p-4">
        <form action="${pageContext.request.contextPath}/admin/promeniLozinku" method="post">
            <div class="mb-3">
                <label class="form-label small fw-semibold">Korisnik</label>
                <select name="idKorisnika" class="form-select form-select-sm" required>
                    <option value="">- Odaberi korisnika -</option>
                    <c:forEach items="${korisnici}" var="k">
                        <option value="${k.idKorisnik}">${k.korisnickoIme} (${k.uloga})</option>
                    </c:forEach>
                </select>
            </div>
            <div class="mb-3">
                <label class="form-label small fw-semibold">Nova lozinka</label>
                <input type="text" name="novaLozinka" class="form-control form-control-sm" required>
            </div>
            <button type="submit" class="btn btn-primary btn-sm">Promeni lozinku</button>
        </form>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>