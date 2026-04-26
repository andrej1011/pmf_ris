<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="sr">
<head>
    <meta charset="UTF-8">
    <title>RIS Bolnica - GDPR Izmena</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light p-4">
<div class="card" style="max-width:680px;margin:auto">
    <div class="card-body">
        <h5 class="fw-semibold mb-1">GDPR Ispravka podataka</h5><br>
        <h7 class="fw-semibold mb-1">${pacijent.ime} ${pacijent.prezime} <br>JMBG: ${pacijent.jmbg}<br><br></h7>
		
        <div class="alert alert-info py-2 small mb-3">
            
            <c:if test="${not empty zahtev.napomena}"><strong>Napomena pacijenta:</strong> ${zahtev.napomena}</c:if>
        </div>

        <form action="${pageContext.request.contextPath}/admin/sacuvajIzmenu" method="post">
            <input type="hidden" name="idZahtev" value="${zahtev.idZahtev}"/>

            <h6 class="text-uppercase text-muted small fw-semibold mt-3 mb-2">Lični podaci</h6>

            <div class="row g-2 mb-2">
                <div class="col-md-6">
                    <label class="form-label small fw-semibold">Ime <span class="text-muted">(trenutno: ${pacijent.ime})</span></label>
                    <input type="text" name="ime" class="form-control form-control-sm" value="${pacijent.ime}">
                </div>
                <div class="col-md-6">
                    <label class="form-label small fw-semibold">Prezime <span class="text-muted">(trenutno: ${pacijent.prezime})</span></label>
                    <input type="text" name="prezime" class="form-control form-control-sm" value="${pacijent.prezime}">
                </div>
            </div>
				
            <div class="mb-2">
                <label class="form-label small fw-semibold">Ime oca <span class="text-muted">(trenutno: ${pacijent.imeOca})</span></label>
                <input type="text" name="imeOca" class="form-control form-control-sm" value="${pacijent.imeOca}">
            </div>
			
			<div class="mb-2">
                <label class="form-label small fw-semibold">JMBG <span class="text-muted">(trenutno: ${pacijent.jmbg})</span></label>
                <input type="text" name="imeOca" class="form-control form-control-sm" value="${pacijent.jmbg}">
            </div>
			
            <div class="mb-2">
                <label class="form-label small fw-semibold">Pol <span class="text-muted">(trenutno: ${pacijent.pol == 'M' ? 'Muški' : 'Ženski'})</span></label>
                <select name="pol" class="form-select form-select-sm">
                    <option value="M" ${pacijent.pol == 'M' ? 'selected' : ''}>Muški</option>
                    <option value="Z" ${pacijent.pol == 'Z' ? 'selected' : ''}>Ženski</option>
                </select>
            </div>

            <div class="mb-2">
                <label class="form-label small fw-semibold">Adresa <span class="text-muted">(trenutno: ${pacijent.adresa})</span></label>
                <input type="text" name="adresa" class="form-control form-control-sm" value="${pacijent.adresa}">
            </div>

            <div class="row g-2 mb-2">
                <div class="col-md-6">
                    <label class="form-label small fw-semibold">Email <span class="text-muted">(trenutno: ${pacijent.email})</span></label>
                    <input type="email" name="email" class="form-control form-control-sm" value="${pacijent.email}">
                </div>
                <div class="col-md-6">
                    <label class="form-label small fw-semibold">Telefon <span class="text-muted">(trenutno: ${pacijent.telefon})</span></label>
                    <input type="text" name="telefon" class="form-control form-control-sm" value="${pacijent.telefon}">
                </div>
            </div>

            <c:if test="${not empty karton}">
                <h6 class="text-uppercase text-muted small fw-semibold mt-3 mb-2">Zdravstveni karton</h6>
				
				<div class="form-check mb-3">
                    <input type="checkbox" class="form-check-input" name="hronicanBolesnik" id="hb" value="true" ${karton.hronicanBolesnik == 1 ? 'checked' : ''}>
                    <label class="form-check-label small" for="hb">Hronični bolesnik (trenutno: ${karton.hronicanBolesnik == 1 ? 'Da' : 'Ne'})</label>
                </div>
				
                <div class="mb-2">
                    <label class="form-label small fw-semibold">Krvna grupa <span class="text-muted">(trenutno: ${karton.krvnaGrupa})</span></label>
                    <select name="krvnaGrupa" class="form-select form-select-sm">
                        <option value="">-</option>
                        <c:forEach var="kg" items="${['A+','A-','B+','B-','AB+','AB-','0+','0-']}">
                            <option value="${kg}" ${karton.krvnaGrupa == kg ? 'selected' : ''}>${kg}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="mb-2">
                    <label class="form-label small fw-semibold">Alergije <span class="text-muted">(trenutno: ${karton.alergije})</span></label>
                    <textarea name="alergije" class="form-control form-control-sm" rows="2">${karton.alergije}</textarea>
                </div>
				
                <div class="mb-2">
                    <label class="form-label small fw-semibold">Napomena kartona <span class="text-muted">(trenutno: ${karton.napomena})</span></label>
                    <textarea name="napomena" class="form-control form-control-sm" rows="2">${karton.napomena}</textarea>
                </div>

            </c:if>
			<br>
            <div class="d-flex gap-2">
                <button type="submit" class="btn btn-success btn-sm">Sačuvaj izmene</button>
                <button type="button" class="btn btn-outline-secondary btn-sm" onclick="window.close()">Otkaži</button>
            </div>
        </form>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>