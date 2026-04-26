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
        .top-nav { background: #1a3a5c; height: 56px; }
        .nav-icon { width: 32px; height: 32px; background: #e53e3e; border-radius: 6px; display: flex; align-items: center; justify-content: center; color: #fff; font-size: 14px; }
        .sidebar { width: 220px; min-height: calc(100vh - 56px); background: #fff; border-right: 1px solid #e2e8f0; position: fixed; top: 56px; left: 0; padding-top: 16px; }
        .sidebar .nav-link { color: #4a5568; font-size: 13px; padding: 10px 20px; border-left: 3px solid transparent; border-radius: 0; }
        .sidebar .nav-link:hover { background: #f7fafc; color: #4a5568; }
        .sidebar .nav-link.active { background: #fff5f5; color: #c53030; border-left-color: #e53e3e; font-weight: 600; }
        .main-content { margin-left: 220px; padding: 28px 32px; }
        .action-card { text-decoration: none; color: inherit; transition: border-color .15s; border: 1px solid #e2e8f0; }
        .action-card:hover { border-color: #e53e3e; color: inherit; }
        .action-icon { font-size: 28px; }
    </style>
</head>
<body>

<nav class="top-nav d-flex align-items-center px-4 sticky-top shadow-sm">
    <div class="d-flex align-items-center gap-2 flex-grow-1">
        <div class="nav-icon">&#43;</div>
        <span class="text-white fw-semibold small">Medicinska sestra</span>
    </div>
    <span class="text-white-50 small me-3">${korisnik.korisnickoIme}</span>
    <form action="${pageContext.request.contextPath}/logout" method="post" class="m-0">
        <button type="submit" class="btn btn-sm btn-outline-light">Odjava</button>
    </form>
</nav>

<div class="sidebar">
    <ul class="nav flex-column">
        <li class="nav-item"><a href="${pageContext.request.contextPath}/sestra/pocetna" class="nav-link active">Početna</a></li>
        <li class="nav-item"><a href="${pageContext.request.contextPath}/sestra/kreirajPacijenta" class="nav-link">Novi pacijent</a></li>
        <li class="nav-item"><a href="${pageContext.request.contextPath}/sestra/prijaviPacijenta" class="nav-link">Zakaži pregled</a></li>
    </ul>
</div>

<div class="main-content">
    <h4 class="fw-semibold mb-4">Dobrodošli!</h4>

    <div class="row g-3" style="max-width:600px">
        <div class="col-md-6">
            <a href="${pageContext.request.contextPath}/sestra/kreirajPacijenta" class="card action-card p-4">
                <div class="action-icon mb-2">&#128100;</div>
                <h6 class="fw-semibold mb-1">Novi pacijent</h6>
                <small class="text-muted">Kreiranje korisničkog naloga i zdravstvenog kartona</small>
            </a>
        </div>
        <div class="col-md-6">
            <a href="${pageContext.request.contextPath}/sestra/prijaviPacijenta" class="card action-card p-4">
                <div class="action-icon mb-2">&#128203;</div>
                <h6 class="fw-semibold mb-1">Zakazivanje pregleda</h6>
                <small class="text-muted">Zakazivanje prvog pregleda</small>
            </a>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>