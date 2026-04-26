<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="sr">
<head>
    <meta charset="UTF-8">
    <title>RIS Bolnica — GDPR</title>
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
        .gdpr-option{border:1px solid #e2e8f0;border-radius:8px;padding:14px 16px;cursor:pointer;display:block;transition: all 0.2s}
        .gdpr-option:has(input:checked){border-color:#2d7dd2;background:#ebf8ff}
        .gdpr-option input{display:none}
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
        <li><a href="${pageContext.request.contextPath}/pacijent/karton" class="nav-link">&#128218; Zdravstveni karton</a></li>
        <li><a href="${pageContext.request.contextPath}/pacijent/gdpr" class="nav-link active">&#9881; Podešavanja (GDPR)</a></li>
    </ul>
</div>

<div class="main-content">
    <h4 class="fw-semibold mb-1">Podešavanja i privatnost</h4>
    <p class="text-muted small mb-4">Upravljajte vašim pravima u skladu sa GDPR uredbom (EU 2016/679)</p>

    <c:if test="${not empty poruka}"><div class="alert alert-success py-2 small">${poruka}</div></c:if>
    <c:if test="${not empty greska}"><div class="alert alert-danger py-2 small">${greska}</div></c:if>
	
	<c:forEach items="${zahtevi}" var="z">
    <c:if test="${z.status == 'ZAVRSEN' && not empty z.putanjaFajla}">
        <div class="alert alert-success d-flex align-items-center justify-content-between py-2 mb-2">
            <span class="small"><strong>Obaveštenje:</strong> <br> Vaš zahtev #${z.idZahtev} je obrađen. Podaci su dostupni za preuzimanje.</span>
            <a href="${pageContext.request.contextPath}/pacijent/preuzmiPodatke/${z.idZahtev}" class="btn btn-sm btn-success ms-3">Izvezi JSON</a>
        </div>
    </c:if>
	</c:forEach>
	
	<c:forEach items="${zahtevi}" var="z">
    <c:if test="${z.tipZahteva == 'UVID' && z.status == 'ZAVRSEN'}">
        <div class="alert alert-info d-flex align-items-center justify-content-between py-2 mb-2">
            <span class="small"><strong>Obaveštenje:</strong> Vaš zahtev #${z.idZahtev} za uvid je odobren.</span>
            <c:choose>
                <c:when test="${not empty z.pdfPutanja}">
                    <a href="${pageContext.request.contextPath}/pacijent/uvid/preuzmi/${z.idZahtev}" class="btn btn-sm btn-primary ms-3">Preuzmi PDF</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/pacijent/uvid/generisi/${z.idZahtev}" class="btn btn-sm btn-info text-dark ms-3">Generiši PDF</a>
                </c:otherwise>
            </c:choose>
        </div>
    </c:if>
	</c:forEach>
    <div class="card mb-3 shadow-sm border-0">
        <div class="card-body">
            <h6 class="fw-semibold mb-3">Pošalji novi GDPR zahtev</h6>
            <form action="${pageContext.request.contextPath}/pacijent/posaljiGdpr" method="post">
                <div class="row g-2 mb-3">
                    <div class="col-md-6">
                        <label class="gdpr-option">
                            <input type="radio" name="tipZahteva" value="UVID" onchange="proveriTip(this)" required>
                            <div class="fw-semibold small">Uvid u podatke</div>
                            <div class="text-muted" style="font-size:11px">Pristup vašim podacima</div>
                            <div class="text-muted" style="font-size:10px">Član 15 GDPR</div>
                        </label>
                    </div>
                    <div class="col-md-6">
                        <label class="gdpr-option">
                            <input type="radio" name="tipZahteva" value="PRENOSIVOST" onchange="proveriTip(this)">
                            <div class="fw-semibold small">Prenosivost podataka</div>
                            <div class="text-muted" style="font-size:11px">Izvoz podataka (JSON format)</div>
                            <div class="text-muted" style="font-size:10px">Član 20 GDPR</div>
                        </label>
                    </div>
                    <div class="col-md-6">
                        <label class="gdpr-option">
                            <input type="radio" name="tipZahteva" value="ISPRAVKA" onchange="proveriTip(this)">
                            <div class="fw-semibold small">Ispravka podataka</div>
                            <div class="text-muted" style="font-size:11px">Korekcija netačnih podataka</div>
                            <div class="text-muted" style="font-size:10px">Član 16 GDPR</div>
                        </label>
                    </div>
                    <div class="col-md-6">
                        <label class="gdpr-option">
                            <input type="radio" name="tipZahteva" value="BRISANJE" onchange="proveriTip(this)">
                            <div class="fw-semibold small">Brisanje podataka</div>
                            <div class="text-muted" style="font-size:11px">Pravo na zaborav</div>
                            <div class="text-muted" style="font-size:10px">Član 17 GDPR</div>
                        </label>
                    </div>
                </div>

                <div class="alert alert-warning py-2 small">Zahtev za brisanje rezultuje pseudonimizacijom podataka. Medicinska dokumentacija ostaje anonimizovana zbog zakonske obaveze čuvanja medicinskih zapisa.</div>
                
                <label class="form-label small fw-semibold">Napomena (opciono)</label>
                <p id="napomenaIspravka" class="text-muted small mb-2" style="display:none">U napomeni napišite koje podatke želite da promenite i kako</p>
                <textarea name="napomena" class="form-control form-control-sm mb-3" rows="3" maxlength="500"></textarea>
                
                <button type="submit" class="btn btn-primary btn-sm px-4">Pošalji zahtev</button>
            </form>
        </div>
    </div>
	
	
    <div class="card shadow-sm border-0">
        <div class="card-body">
            <h6 class="fw-semibold mb-3">Istorija mojih zahteva</h6>
            <c:choose>
                <c:when test="${empty zahtevi}">
                    <p class="text-muted small mb-0">Nemate poslatih zahteva.</p>
                </c:when>
                <c:otherwise>
                    <table class="table table-sm align-middle mb-0">
                        <thead class="table-light small text-uppercase text-muted">
                            <tr><th>Tip</th><th>Datum zahteva</th><th>Status</th><th>Datum obrade</th></tr>
                        </thead>
                        <tbody class="small">
                            <c:forEach items="${zahtevi}" var="z">
                                <tr>
                                    <td class="fw-medium">${z.tipZahteva}</td>
                                    <td><fmt:formatDate value="${z.datumZahteva}" pattern="dd.MM.yyyy. HH:mm:ss"/></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${z.status == 'PRIMLJEN'}"><span class="badge bg-warning text-dark">PRIMLJEN</span></c:when>
                                            <c:when test="${z.status == 'U_OBRADI'}"><span class="badge bg-info text-dark">U OBRADI</span></c:when>
                                            <c:when test="${z.status == 'ZAVRSEN'}"><span class="badge bg-success">ZAVRŠEN</span></c:when>
                                            <c:otherwise><span class="badge bg-secondary">${z.status}</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="text-muted">
                                        <c:if test="${not empty z.datumObrade}">
                                            <fmt:formatDate value="${z.datumObrade}" pattern="dd.MM.yyyy. HH:mm:ss"/>
                                        </c:if>
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
<script>
    function proveriTip(radio) {
        const infoTekst = document.getElementById('napomenaIspravka');
        if (radio.value === 'ISPRAVKA') {
            infoTekst.style.display = 'block';
        } else {
            infoTekst.style.display = 'none';
        }
    }

    // Provera pri učitavanju (u slučaju da je ISPRAVKA već čekirana od strane servera)
    window.onload = function() {
        const checkedRadio = document.querySelector('input[name="tipZahteva"]:checked');
        if (checkedRadio) {
            proveriTip(checkedRadio);
        }
    };
</script>
</body>
</html>