<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="sr">
<head>
<meta charset="UTF-8">
<title>RIS Bolnica</title>
<link rel="icon" type="image/x-icon"
	href="${pageContext.request.contextPath}/uploads/favicon.ico">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
body {
	background: #f5f6fa;
}

.top-nav {
	background: #1a3a5c;
	height: 56px;
}

.nav-icon {
	width: 32px;
	height: 32px;
	background: #38a169;
	border-radius: 6px;
	display: flex;
	align-items: center;
	justify-content: center;
	color: #fff;
	font-size: 16px;
}

.sidebar {
	width: 220px;
	min-height: calc(100vh - 56px);
	background: #fff;
	border-right: 1px solid #e2e8f0;
	position: fixed;
	top: 56px;
	left: 0;
	padding-top: 16px;
}

.sidebar .nav-link {
	color: #4a5568;
	font-size: 13px;
	padding: 10px 20px;
	border-left: 3px solid transparent;
	border-radius: 0;
}

.sidebar .nav-link:hover {
	background: #f7fafc;
	color: #4a5568;
}

.sidebar .nav-link.active {
	background: #f0fff4;
	color: #276749;
	border-left-color: #38a169;
	font-weight: 600;
}

.sidebar-section {
	font-size: 10px;
	font-weight: 700;
	color: #a0aec0;
	text-transform: uppercase;
	letter-spacing: 0.8px;
	padding: 12px 20px 4px;
}

.main-content {
	margin-left: 220px;
	padding: 28px 32px;
	max-width: 860px;
}
</style>
</head>
<body>
	<nav
		class="top-nav d-flex align-items-center px-4 sticky-top shadow-sm">
		<div class="d-flex align-items-center gap-2 flex-grow-1">
			<div class="nav-icon">&#43;</div>
			<span class="text-white fw-semibold small">Bolnički portal</span>
		</div>
		<a href="${pageContext.request.contextPath}/pacijent/gdpr"
			class="text-white-50 small me-3 text-decoration-none">${pacijent.ime}
			${pacijent.prezime}</a>
		<form action="${pageContext.request.contextPath}/logout" method="post"
			class="m-0">
			<button type="submit" class="btn btn-sm btn-outline-light">Odjava</button>
		</form>
	</nav>
	<div class="sidebar">
		<ul class="nav flex-column">
			<li><a
				href="${pageContext.request.contextPath}/pacijent/pocetna"
				class="nav-link">&#127968; Početna</a></li>
		</ul>
		<hr class="mx-3 my-1">
		<div class="sidebar-section">Pregledi</div>
		<ul class="nav flex-column">
			<li><a
				href="${pageContext.request.contextPath}/pacijent/zakazivanje"
				class="nav-link active">&#128197; Zakaži pregled</a></li>
			<li><a
				href="${pageContext.request.contextPath}/pacijent/buduciPregledi"
				class="nav-link">&#128337; Budući pregledi</a></li>
			<li><a
				href="${pageContext.request.contextPath}/pacijent/prosliPregledi"
				class="nav-link">&#128196; Stari pregledi</a></li>
			<li><a
				href="${pageContext.request.contextPath}/pacijent/recepti"
				class="nav-link">&#128138; Recepti</a></li>
		</ul>
		<hr class="mx-3 my-1">
		<div class="sidebar-section">Zdravlje</div>
		<ul class="nav flex-column">
			<li><a href="${pageContext.request.contextPath}/pacijent/karton" class="nav-link">&#128218; Zdravstveni karton</a></li>
			<li><a href="${pageContext.request.contextPath}/pacijent/gdpr" class="nav-link">&#9881; Podešavanja (GDPR)</a></li>
		</ul>
	</div>
	<div class="main-content">
		<h4 class="fw-semibold mb-4">Zakazivanje pregleda</h4>
		<a href="${pageContext.request.contextPath}/pacijent/mojiZahtevi"
			class="btn btn-sm btn-success mb-3">Pogledaj zahteve za zakazivanje</a>
		<c:if test="${not empty poruka}">
			<div class="alert alert-success py-2 small">${poruka}</div>
		</c:if>
		<c:if test="${not empty greska}">
			<div class="alert alert-danger py-2 small">${greska}</div>
		</c:if>

		<div class="card mb-3">
			<div class="card-body">
				<p class="text-muted small text-uppercase fw-semibold mb-3">Odaberi doktora</p>
				<form
					action="${pageContext.request.contextPath}/pacijent/slobodniTermini"
					method="get">
					<label class="form-label small fw-semibold">Doktor</label> <select
						name="idDoktora" class="form-select form-select-sm mb-2" required
						style="max-width: 400px">
						<option value="">- Odaberi doktora -</option>
						<c:forEach items="${doktori}" var="d">
							<option value="${d.idDoktor}"
								${d.idDoktor == idDoktora ? 'selected' : ''}>Dr. ${d.ime} ${d.prezime}
								<c:if test="${not empty d.specijalizacija}"> - ${d.specijalizacija}</c:if>
							</option>
						</c:forEach>
					</select>
					<button type="submit" class="btn btn-sm btn-primary">Prikaži slobodne termine</button>
				</form>
			</div>
		</div>

		<c:if test="${not empty termini}">
			<div class="card">
				<div class="card-body">
					<p class="text-muted small text-uppercase fw-semibold mb-3">Odaberi termin</p>
					<form
						action="${pageContext.request.contextPath}/pacijent/posaljiZahtev"
						method="post">
						<input type="hidden" name="idDoktora" value="${idDoktora}" /> <label
							class="form-label small fw-semibold">Slobodni termini</label> <select
							name="idTermina" class="form-select form-select-sm mb-2" required
							style="max-width: 400px">
							<option value="">- Odaberi termin -</option>
							<c:forEach items="${termini}" var="t">
								<option value="${t.idTermin}"><fmt:formatDate
										value="${t.datumVreme}" pattern="dd.MM.yyyy. HH:mm" /></option>
							</c:forEach>
						</select> 
						<label class="form-label small fw-semibold">Napomena (opciono)</label>
						<textarea name="napomena" class="form-control form-control-sm mb-3" rows="3" maxlength="500" style="max-width: 400px"></textarea>
						<br>
						<button type="submit" class="btn btn-sm btn-success">Pošalji zahtev</button>
					</form>
				</div>
			</div>
		</c:if>
		<c:if test="${not empty idDoktora && empty termini}">
			<div class="alert alert-warning py-2 small">Izabrani doktor nema slobodnih termina. Pokušajte drugi termin ili drugog doktora.</div>
		</c:if>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>