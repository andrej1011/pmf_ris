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
        .doc-nav { background: #1a3a5c; height: 56px; }
        .nav-cross { width: 32px; height: 32px; background: #2d7dd2; border-radius: 6px; display: flex; align-items: center; justify-content: center; color: #fff; font-size: 14px; }
        .nav-tab { color: #9bbcd8; text-decoration: none; font-size: 13px; font-weight: 500; padding: 0 18px; height: 56px; display: flex; align-items: center; border-bottom: 3px solid transparent; }
        .nav-tab:hover { color: #fff; }
        .nav-tab.active { color: #fff; border-bottom-color: #2d7dd2; }
    </style>
</head>
<body>
<nav class="doc-nav d-flex align-items-center px-4 sticky-top shadow-sm">
    <div class="d-flex align-items-center gap-2 me-4">
        <div class="nav-cross">&#10010;</div>
        <div>
            <div class="text-white fw-semibold small">Dr. ${pregled.doktor.ime} ${pregled.doktor.prezime}</div>
            <div class="small" style="color:#7fafd4">${pregled.doktor.specijalizacija}</div>
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

<div class="container-fluid p-4" style="max-width:800px">
    <h4 class="fw-semibold mb-3">Pregled završen.</h4>
    <div class="alert alert-success py-2 small">Pregled br. <strong>${pregled.idPregled}</strong> je uspešno sačuvan.</div>

    <div class="card mb-3">
        <table class="table table-sm mb-0">
            <tbody>
                <tr><td class="text-muted small" style="width:160px">Pacijent</td><td>${pregled.pacijent.ime} ${pregled.pacijent.prezime}</td></tr>
                <tr><td class="text-muted small">Doktor</td><td>Dr. ${pregled.doktor.ime} ${pregled.doktor.prezime}</td></tr>
                <tr><td class="text-muted small">Početak pregleda</td><td><fmt:formatDate value="${pregled.datumVreme}" pattern="dd.MM.yyyy. HH:mm"/></td></tr>
                <tr><td class="text-muted small">Završetak pregleda</td><td><fmt:formatDate value="${pregled.vremeZavrsetka}" pattern="dd.MM.yyyy. HH:mm"/></td></tr>
                <tr><td class="text-muted small">Dijagnoze</td>
                    <td><c:forEach items="${pregled.dijagnozas}" var="d" varStatus="st">
                        ${d.sifra} - ${d.opis}<c:if test="${!st.last}"><br></c:if>
                    </c:forEach></td>
                </tr>
                <tr><td class="text-muted small">Nalaz</td><td style="white-space:pre-wrap;font-family:Georgia,serif">${pregled.nalaz}</td></tr>
                <c:if test="${not empty pregled.recepts}">
                <tr><td class="text-muted small">Recepti</td>
                    <td><c:forEach items="${pregled.recepts}" var="r" varStatus="st">
                        ${r.lek.naziv} (kol: ${r.kolicina})<c:if test="${not empty r.uputstvo}"> - ${r.uputstvo}</c:if><c:if test="${!st.last}"><br></c:if>
                    </c:forEach></td>
                </tr>
                </c:if>
            </tbody>
        </table>
    </div>

    <div class="d-flex gap-5">
        <a href="${pageContext.request.contextPath}/doktor/stampajIzvestaj?idPregled=${pregled.idPregled}" target="_blank" class="btn btn-primary">&#128438; Odštampaj izveštaj</a>
        <a href="${pageContext.request.contextPath}/doktor/pocetna" class="btn btn-outline-secondary">Početna</a>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>