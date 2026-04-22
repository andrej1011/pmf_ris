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
        body { background: #f5f6fa; }
        .top-nav { background: #1a3a5c; height: 56px; }
        .nav-icon { width: 32px; height: 32px; background: #e53e3e; border-radius: 6px; display: flex; align-items: center; justify-content: center; color: #fff; font-size: 14px; }
        .sidebar { width: 220px; min-height: calc(100vh - 56px); background: #fff; border-right: 1px solid #e2e8f0; position: fixed; top: 56px; left: 0; padding-top: 16px; }
        .sidebar .nav-link { color: #4a5568; font-size: 13px; padding: 10px 20px; border-left: 3px solid transparent; border-radius: 0; }
        .sidebar .nav-link:hover { background: #f7fafc; color: #4a5568; }
        .sidebar .nav-link.active { background: #fff5f5; color: #c53030; border-left-color: #e53e3e; font-weight: 600; }
        .main-content { margin-left: 220px; padding: 28px 32px; max-width: 960px; }
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
        <li><a href="${pageContext.request.contextPath}/sestra/pocetna" class="nav-link">Početna</a></li>
        <li><a href="${pageContext.request.contextPath}/sestra/kreirajPacijenta" class="nav-link">Novi pacijent</a></li>
        <li><a href="${pageContext.request.contextPath}/sestra/prijaviPacijenta" class="nav-link active">Zakaži pregled</a></li>
    </ul>
</div>
<div class="main-content">
    <h4 class="fw-semibold mb-4">Prijava pacijenta na pregled</h4>

    <%-- Pretraga --%>
    <div class="card mb-3">
        <div class="card-body">
            <form action="${pageContext.request.contextPath}/sestra/traziPacijenta" method="get">
                <label class="form-label small fw-semibold">JMBG pacijenta</label>
                <div class="d-flex gap-2">
                    <input type="text" name="jmbg" class="form-control" maxlength="13" value="${param.jmbg}" autofocus style="max-width:240px">
                    <button type="submit" class="btn btn-primary">Pretraži</button>
                </div>
            </form>
        </div>
    </div>

    <c:if test="${not empty greska}"><div class="alert alert-danger py-2 small">${greska}</div></c:if>
    <c:if test="${not empty poruka}"><div class="alert alert-success py-2 small">${poruka}</div></c:if>

    <c:if test="${not empty pacijent}">
        <div class="card mb-3">
            <div class="card-body">
                <h6 class="fw-semibold mb-1">${pacijent.ime} ${pacijent.prezime}</h6>
                <p class="text-muted small mb-3">JMBG: ${pacijent.jmbg}</p>

                <%-- Postojeci zakazani pregledi --%>
                <h6 class="small fw-semibold text-uppercase text-muted mb-2">Zakazani pregledi</h6>
                <c:choose>
                    <c:when test="${empty pregledi}">
                        <p class="text-muted small">Nema zakazanih pregleda.</p>
                    </c:when>
                    <c:otherwise>
                        <table class="table table-sm align-middle mb-3">
                            <thead class="table-light">
                                <tr><th>Br.</th><th>Doktor</th><th>Datum i vreme</th><th>Status</th><th>Akcija</th></tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${pregledi}" var="p">
                                    <tr>
                                        <td>${p.idPregled}</td>
                                        <td>Dr. ${p.doktor.ime} ${p.doktor.prezime}</td>
                                        <td><fmt:formatDate value="${p.datumVreme}" pattern="dd-MM-yyyy HH:mm:ss"/></td>
                                        <td><span class="badge bg-warning text-dark">${p.status}</span></td>
                                        <td>
                                            <form action="${pageContext.request.contextPath}/sestra/prijaviNaPregled" method="post" class="m-0">
                                                <input type="hidden" name="idPregled" value="${p.idPregled}"/>
                                                <input type="hidden" name="jmbg" value="${pacijent.jmbg}"/>
                                                <button type="submit" class="btn btn-sm btn-success">Zakaži pregled</button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:otherwise>
                </c:choose>

                <%-- Zakazi novi pregled --%>
                <hr>
                <h6 class="small fw-semibold text-uppercase text-muted mb-2">Zakaži novi pregled</h6>

                <%-- Izbor doktora --%>
                <form action="${pageContext.request.contextPath}/sestra/traziTermine" method="get" class="d-flex gap-2 align-items-end mb-3">
                    <input type="hidden" name="jmbg" value="${pacijent.jmbg}"/>
                    <div>
                        <label class="form-label small fw-semibold mb-1">Doktor</label>
                        <select name="idDoktora" class="form-select form-select-sm" style="min-width:220px">
                            <c:forEach items="${doktori}" var="d">
                                <option value="${d.idDoktor}" ${d.idDoktor == izabraniDoktor ? 'selected' : ''}>
                                    Dr. ${d.ime} ${d.prezime} - ${d.specijalizacija}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    <button type="submit" class="btn btn-sm btn-secondary">Prikaži termine</button>
                </form>

                <%-- Lista slobodnih termina --%>
                <c:if test="${not empty termini}">
                    <form action="${pageContext.request.contextPath}/sestra/zakaziPregled" method="post">
                        <input type="hidden" name="jmbg" value="${pacijent.jmbg}"/>
                        <input type="hidden" name="idDoktora" value="${izabraniDoktor}"/>
                        <table class="table table-sm align-middle mb-3">
                            <thead class="table-light">
                                <tr><th>Odabir</th><th>Datum</th><th>Vreme</th></tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${termini}" var="t">
                                    <tr>
                                        <td><input type="radio" name="idTermina" value="${t.idTermin}" required></td>
                                        <td><fmt:formatDate value="${t.datumVreme}" pattern="dd.MM.yyyy."/></td>
                                        <td><fmt:formatDate value="${t.datumVreme}" pattern="HH:mm"/></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        <div class="mb-3">
                            <label class="form-label small fw-semibold">Napomena (opciono)</label>
                            <input type="text" name="napomena" class="form-control form-control-sm" maxlength="500">
                        </div>
                        <button type="submit" class="btn btn-sm btn-primary">Zakaži pregled</button>
                    </form>
                </c:if>
                <c:if test="${not empty izabraniDoktor && empty termini}">
                    <p class="text-muted small">Nema slobodnih termina za izabranog doktora.</p>
                </c:if>
            </div>
        </div>
    </c:if>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>