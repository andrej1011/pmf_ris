<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="sr">
<head>
    <meta charset="UTF-8">
    <title>RIS Bolnica - Pregled</title>
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/uploads/favicon.ico">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: #e8ecf0; }
        .toolbar { background: #1a3a5c; height: 48px; position: sticky; top: 0; z-index: 100; }
        .doc-page { max-width: 820px; margin: 28px auto; background: #fff; border-radius: 4px; box-shadow: 0 2px 20px rgba(0,0,0,0.12); padding: 40px 48px 48px; min-height: calc(100vh - 120px); }
        .patient-header { border-bottom: 2px solid #1a3a5c; padding-bottom: 14px; margin-bottom: 24px; }
        .dijagnoza-select { width: 100%; border: 1px solid #dee2e6; border-radius: 6px; font-size: 13px; padding: 4px; height: 110px; }
        .dijagnoza-select:focus { outline: none; border-color: #2d7dd2; }
        .nalaz-area { width: 100%; border: 1px solid #dee2e6; border-radius: 6px; font-size: 14px; font-family: Georgia, serif; padding: 14px; resize: vertical; min-height: 280px; line-height: 1.8; }
        .nalaz-area:focus { outline: none; border-color: #2d7dd2; }
        .section-title { font-size: 12px; font-weight: 700; color: #718096; text-transform: uppercase; letter-spacing: 0.5px; margin-bottom: 8px; margin-top: 22px; }
        .recept-row select, .recept-row input[type=text], .recept-row input[type=date] { border: 1px solid #dee2e6; border-radius: 5px; padding: 6px 9px; font-size: 12px; }
        .btn-rm { background: none; border: none; color: #e53e3e; font-size: 16px; cursor: pointer; }
        .karton-item { background: #f7fafc; border: 1px solid #e2e8f0; border-radius: 6px; padding: 8px 12px; font-size: 12px; }
        .info-badge { font-size: 11px; background: #f7fafc; border: 1px solid #e2e8f0; border-radius: 4px; padding: 3px 8px; color: #4a5568; display: inline-block; margin-bottom: 4px; }
    </style>
</head>
<body>

<div class="toolbar d-flex align-items-center justify-content-between px-3">
    <div>
        <span class="text-white fw-semibold small">Pregled br. ${pregled.idPregled}</span>
        <span class="text-white-50 small ms-2"><fmt:formatDate value="${pregled.datumVreme}" pattern="dd.MM.yyyy. HH:mm"/></span>
    </div>
    <a href="${pageContext.request.contextPath}/doktor/stariPregledi?idPregled=${pregled.idPregled}"
       class="btn btn-sm btn-secondary"
       onclick="otvoriStare(this); return false;">&#128196; Stari pregledi</a>
</div>

<form action="${pageContext.request.contextPath}/doktor/sacuvajNalaz" method="post" id="pregledForm">
    <input type="hidden" name="idPregled" value="${pregled.idPregled}"/>

    <div class="doc-page">
        <c:if test="${not empty greska}"><div class="alert alert-danger py-2 small">${greska}</div></c:if>

        <div class="patient-header d-flex justify-content-between align-items-start">
            <div>
                <h5 class="fw-bold mb-1">
                    ${pregled.pacijent.ime}
                    <c:if test="${not empty pregled.pacijent.imeOca}">(${pregled.pacijent.imeOca})</c:if>
                    ${pregled.pacijent.prezime}
                </h5>
                <div class="text-muted small" style="line-height:1.7">
                    JMBG: ${pregled.pacijent.jmbg}<br>
                    <c:if test="${not empty pregled.pacijent.lbo}">LBO: ${pregled.pacijent.lbo}<br></c:if>
                    <c:if test="${not empty pregled.pacijent.adresa}">${pregled.pacijent.adresa}</c:if>
                </div>
            </div>
            <div class="text-end">
                <div class="info-badge">Br. protokola: ${pregled.idPregled}</div><br>
                <c:forEach items="${pregled.pacijent.zdravstveniKartons}" var="k">
                    <c:if test="${not empty k.krvnaGrupa}"><div class="info-badge">Krvna gr.: ${k.krvnaGrupa}</div><br></c:if>
                </c:forEach>
                <div class="info-badge">${pregled.pacijent.osiguran == 1 ? 'Osiguran' : 'Nije osiguran'}</div>
            </div>
        </div>

        <c:forEach items="${pregled.pacijent.zdravstveniKartons}" var="k">
            <div class="d-flex gap-2 flex-wrap mb-3">
                <c:if test="${not empty k.alergije}">
                    <div class="karton-item"><div class="text-muted" style="font-size:11px">Alergije</div><div class="fw-semibold">${k.alergije}</div></div>
                </c:if>
                <div class="karton-item"><div class="text-muted" style="font-size:11px">Hronični bolesnik</div><div class="fw-semibold">${k.hronicanBolesnik == 1 ? 'Da' : 'Ne'}</div></div>
                <c:if test="${not empty k.napomena}">
                    <div class="karton-item"><div class="text-muted" style="font-size:11px">Napomena</div><div class="fw-semibold">${k.napomena}</div></div>
                </c:if>
            </div>
        </c:forEach>

        <div class="section-title">Dijagnoze (MKB-10)</div>
        <select name="dijagnoze" class="dijagnoza-select" multiple>
            <c:forEach items="${dijagnoze}" var="d">
                <option value="${d.sifra}">${d.sifra} - 	${d.opis}</option>
            </c:forEach>
        </select>
		<div class="text-muted mb-3" style="font-size:11px;margin-top:4px">	Za odabir 2 ili više dijagnoze držite dugme CTRL na tastaturi</div>
        <div class="section-title">Nalaz lekara</div>
        <textarea name="nalaz" class="nalaz-area" maxlength="3000" placeholder="Unos nalaza..."></textarea>
        <div class="text-muted mb-3" style="font-size:11px;margin-top:4px" id="charCount">0 / 3000 karaktera</div>

        <div class="section-title">Recepti</div>
        <div id="recepti">
            <div class="recept-row d-flex gap-2 align-items-center flex-wrap mb-2">
                <select name="lekovi" style="width:200px">
                    <option value="0">- Lek -</option>
                    <c:forEach items="${lekovi}" var="l">
                        <option value="${l.idLek}">${l.naziv}</option>
                    </c:forEach>
                </select>
                <input type="number" name="kolicine" style="width:65px" placeholder="Kol." min="1" value="1">
                <input type="text" name="uputstva" style="width:200px" placeholder="Uputstvo">
                <input type="date" name="datumiVazenja" style="width:140px">
                <button type="button" class="btn-rm" onclick="this.closest('.recept-row').remove()">&#x2715;</button>
            </div>
        </div>
        <button type="button" class="btn btn-sm btn-outline-secondary mb-4" onclick="dodajRecept()">+ Dodaj lek</button>

        <div class="border-top pt-3 d-flex justify-content-end">
            <button type="submit" class="btn btn-success px-4 fw-semibold" onclick="return potvrdiZavrsetak()">&#10003; Završi pregled</button>
        </div>
    </div>
</form>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
const nalazArea = document.querySelector('.nalaz-area');
const charCount = document.getElementById('charCount');
nalazArea.addEventListener('input', () => { charCount.textContent = nalazArea.value.length + ' / 3000 karaktera'; });

function dodajRecept() {
    const container = document.getElementById('recepti');
    const clone = container.querySelector('.recept-row').cloneNode(true);
    clone.querySelectorAll('input').forEach(i => { i.value = i.type === 'number' ? '1' : ''; });
    clone.querySelector('select').selectedIndex = 0;
    clone.querySelector('.btn-rm').onclick = function() { this.closest('.recept-row').remove(); };
    container.appendChild(clone);
}

function potvrdiZavrsetak() {
    if (nalazArea.value.trim().length === 0) {
        if (!confirm('Nalaz je prazan. Sigurno želite završiti pregled?')) return false;
    }
    if (window._stariWin && !window._stariWin.closed) window._stariWin.close();
    return true;
}

function otvoriStare(link) {
    window._stariWin = window.open(link.href, 'stariPregledi', 'width=800,height=600,scrollbars=yes');
    window._stariWin.focus();
}
</script>
</body>
</html>