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
        .main-content{margin-left:220px;padding:28px 32px;max-width:1100px}
        .creds-box{background:#f7fafc;border:1px solid #e2e8f0;border-radius:8px;padding:12px 16px;font-family:monospace;font-size:13px;margin-top:8px}
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
        <li><a href="${pageContext.request.contextPath}/admin/korisnici" class="nav-link active">Korisnici</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/lozinka" class="nav-link">Promena lozinke</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/gdpr" class="nav-link">GDPR zahtevi</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/revizija" class="nav-link">Revizijski trag</a></li>
    </ul>
</div>
<div class="main-content">
    <h4 class="fw-semibold mb-4">Upravljanje korisnicima</h4>

    <c:if test="${not empty poruka}">
        <div class="alert alert-success">
            ${poruka}
            <c:if test="${not empty noviKorisnickoIme}">
                <div class="creds-box mt-2">
                    Korisničko ime: <strong>${noviKorisnickoIme}</strong><br>
                    Lozinka: <strong>${novaLozinka}</strong>
                </div>
                <small class="text-muted d-block mt-1">Zapišite ovu lozinku - neće biti prikazana ponovo.</small>
            </c:if>
        </div>
    </c:if>
    <c:if test="${not empty greska}"><div class="alert alert-danger py-2 small">${greska}</div></c:if>

    <ul class="nav nav-tabs mb-3" id="adminTabs">
        <li class="nav-item"><a class="nav-link ${empty tab || tab == 'svi' ? 'active' : ''}" href="#svi" data-bs-toggle="tab">Svi korisnici</a></li>
        <li class="nav-item"><a class="nav-link ${tab == 'doktor' ? 'active' : ''}" href="#doktor" data-bs-toggle="tab">Kreiraj nalog doktora</a></li>
        <li class="nav-item"><a class="nav-link ${tab == 'sestra' ? 'active' : ''}" href="#sestra" data-bs-toggle="tab">Kreiraj nalog medicinske sestre</a></li>
    </ul>

    <div class="tab-content">
        <div class="tab-pane fade ${empty tab || tab == 'svi' ? 'show active' : ''}" id="svi">
            <div class="card">
                <div class="table-responsive">
                    <table class="table table-sm align-middle mb-0">
                        <thead class="table-light small text-uppercase">
                            <tr><th>ID</th><th>Korisničko ime</th><th>Uloga</th><th>Aktivan</th><th>Kreiran</th></tr>
                        </thead>
                        <tbody class="small">
                            <c:forEach items="${korisnici}" var="k">
                                <tr>
                                    <td>${k.idKorisnik}</td>
                                    <td>${k.korisnickoIme}</td>
                                    <td>${k.uloga}</td>
                                    <td><span class="badge ${k.aktivan == 1 ? 'bg-success' : 'bg-secondary'}">${k.aktivan == 1 ? 'Da' : 'Ne'}</span></td>
                                    <td><fmt:formatDate value="${k.datumKreiranja}" pattern="dd-MM-yyyy HH:mm:ss"/></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <div class="tab-pane fade ${tab == 'doktor' ? 'show active' : ''}" id="doktor">
            <div class="card p-4" style="max-width:560px">
                <c:if test="${not empty errorsDoktor}">
                    <div class="alert alert-danger py-2 small">
                        <c:forEach items="${errorsDoktor}" var="e"><div>${e.defaultMessage}</div></c:forEach>
                    </div>
                </c:if>
                <form action="${pageContext.request.contextPath}/admin/kreirajDoktora" method="post">
                    <input type="hidden" name="tab" value="doktor"/>
                    <div class="mb-2"><label class="form-label small fw-semibold">Ime <span class="text-danger small">*</span></label><input type="text" name="ime" class="form-control form-control-sm" required></div>
                    <div class="mb-2"><label class="form-label small fw-semibold">Prezime <span class="text-danger small">*</span></label><input type="text" name="prezime" class="form-control form-control-sm" required></div>
                    <div class="mb-2"><label class="form-label small fw-semibold">Specijalizacija</label><input type="text" name="specijalizacija" class="form-control form-control-sm"></div>
                    <div class="mb-2"><label class="form-label small fw-semibold">Broj licence <span class="text-danger small">*</span></label><input type="text" name="brojLicence" class="form-control form-control-sm" required></div>
                    <div class="mb-2"><label class="form-label small fw-semibold">Email</label><input type="email" name="email" class="form-control form-control-sm"></div>
                    <div class="mb-3">
                        <label class="form-label small fw-semibold">Odeljenje <span class="text-danger small">*</span></label>
                        <select name="idOdeljenja" class="form-select form-select-sm" required>
                            <option value="">- Odaberi odeljenje -</option>
                            <c:forEach items="${odeljenja}" var="o">
                                <option value="${o.idOdeljenje}">${o.naziv}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <button type="submit" class="btn btn-primary btn-sm">Kreiraj nalog doktora</button>
                </form>
            </div>
        </div>

        <div class="tab-pane fade ${tab == 'sestra' ? 'show active' : ''}" id="sestra">
            <div class="card p-4" style="max-width:400px">
                <c:if test="${not empty errorsSestra}">
                    <div class="alert alert-danger py-2 small">
                        <c:forEach items="${errorsSestra}" var="e"><div>${e.defaultMessage}</div></c:forEach>
                    </div>
                </c:if>
                <form action="${pageContext.request.contextPath}/admin/kreirajSestru" method="post">
                    <input type="hidden" name="tab" value="sestra"/>
                    <div class="mb-2"><label class="form-label small fw-semibold">Ime <span class="text-danger small">*</span></label><input type="text" name="ime" class="form-control form-control-sm" required></div>
                    <div class="mb-3"><label class="form-label small fw-semibold">Prezime <span class="text-danger small">*</span></label><input type="text" name="prezime" class="form-control form-control-sm" required></div>
                    <button type="submit" class="btn btn-primary btn-sm">Kreiraj nalog medicinske sestre</button>
                </form>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>