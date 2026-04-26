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
        .main-content{margin-left:220px;padding:28px 32px;max-width:900px}
        .stat-card{text-decoration:none;color:inherit;transition:border-color .15s}
        .stat-card:hover{border-color:#2d7dd2!important;color:inherit}
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
        <li><a href="${pageContext.request.contextPath}/admin/pocetna" class="nav-link active">Početna</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/korisnici" class="nav-link">Korisnici</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/lozinka" class="nav-link">Promena lozinke</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/gdpr" class="nav-link">GDPR zahtevi</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/revizija" class="nav-link">Revizijski trag</a></li><br><br>
        <li><a href="${pageContext.request.contextPath}/admin/izvestaj" class="nav-link"> &#x1F4D1; Mesečni Izveštaj</a></li>
    </ul>
</div>
<div class="main-content">
    <h4 class="fw-semibold mb-4">Administratorski panel</h4>
    <div class="row g-3">
        <div class="col-md-3">
            <a href="${pageContext.request.contextPath}/admin/korisnici" class="card p-4 stat-card border d-block">
                <div style="font-size:24px" class="mb-2">&#128100;</div>
                <div class="fw-semibold">Upravljanje Korisnicima</div>
            </a>
        </div>
        <div class="col-md-3">
            <a href="${pageContext.request.contextPath}/admin/lozinka" class="card p-4 stat-card border d-block">
                <div style="font-size:24px" class="mb-2">&#128273;</div>
                <div class="fw-semibold">Promena Lozinke</div>
            </a>
        </div>
        <div class="col-md-3">
            <a href="${pageContext.request.contextPath}/admin/gdpr" class="card p-4 stat-card border d-block">
                <div style="font-size:24px" class="mb-2">&#128203;</div>
                <div class="fw-semibold">GDPR zahtevi</div>
            </a>
        </div>
        <div class="col-md-3">
            <a href="${pageContext.request.contextPath}/admin/revizija" class="card p-4 stat-card border d-block">
                <div style="font-size:24px" class="mb-2">&#128220;</div>
                <div class="fw-semibold">Revizijski trag</div>
            </a>
        </div>
    </div>
    
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>