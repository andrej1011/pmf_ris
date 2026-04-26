<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
	background: #e53e3e;
	border-radius: 6px;
	display: flex;
	align-items: center;
	justify-content: center;
	color: #fff;
	font-size: 14px;
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
	background: #fff5f5;
	color: #c53030;
	border-left-color: #e53e3e;
	font-weight: 600;
}

.main-content {
	margin-left: 220px;
	padding: 28px 32px;
	max-width: 720px;
}

.creds-box {
	background: #f7fafc;
	border: 1px solid #e2e8f0;
	border-radius: 8px;
	padding: 14px 16px;
	font-family: monospace;
	line-height: 2;
}
</style>
</head>
<body>

	<nav
		class="top-nav d-flex align-items-center px-4 sticky-top shadow-sm">
		<div class="d-flex align-items-center gap-2 flex-grow-1">
			<div class="nav-icon">&#43;</div>
			<span class="text-white fw-semibold small">Medicinska sestra</span>
		</div>
		<span class="text-white-50 small me-3">${korisnik.korisnickoIme}</span>
		<form action="${pageContext.request.contextPath}/logout" method="post"
			class="m-0">
			<button type="submit" class="btn btn-sm btn-outline-light">Odjava</button>
		</form>
	</nav>

	<div class="sidebar">
		<ul class="nav flex-column">
			<li class="nav-item"><a
				href="${pageContext.request.contextPath}/sestra/pocetna"
				class="nav-link">Početna</a></li>
			<li class="nav-item"><a
				href="${pageContext.request.contextPath}/sestra/kreirajPacijenta"
				class="nav-link active">Novi pacijent</a></li>
			<li class="nav-item"><a
				href="${pageContext.request.contextPath}/sestra/prijaviPacijenta"
				class="nav-link">Zakaži pregled</a></li>
		</ul>
	</div>

	<div class="main-content">
		<h4 class="fw-semibold mb-4">Kreiranje novog naloga pacijenta</h4>

		<c:if test="${not empty poruka}">
			<div class="alert alert-success">
				${poruka}
				<div class="creds-box mt-2">
					Korisničko ime: <strong>${korisnickoIme}</strong><br> Lozinka:
					<strong>${lozinka}</strong>
				</div>
				<small class="text-muted d-block mt-2">Zapišite ovu lozinku.<br>
														Lozinka neće biti prikazana ponovo!</small>
			</div>
		</c:if>
		<c:if test="${not empty greska}">
			<div class="alert alert-danger py-2 small">${greska}</div>
		</c:if>
		<c:if test="${not empty errors}">
			<div class="alert alert-danger py-2 small">
				<c:forEach items="${errors}" var="e">
					<div>${e.defaultMessage}</div>
				</c:forEach>
			</div>
		</c:if>

		<div class="card">
			<div class="card-body">
				<form
					action="${pageContext.request.contextPath}/sestra/kreirajPacijenta"
					method="post">

					<div class="row g-3 mb-3">
						<div class="col-md-6">
							<label class="form-label small fw-semibold">Ime <span
								class="text-danger small">*</span></label> <input type="text" name="ime"
								class="form-control" required>
						</div>
						<div class="col-md-6">
							<label class="form-label small fw-semibold">Prezime <span
								class="text-danger small">*</span></label> <input type="text"
								name="prezime" class="form-control" required>
						</div>
					</div>

					<div class="mb-3">
						<label class="form-label small fw-semibold">Ime oca</label> <input
							type="text" name="imeOca" class="form-control">
					</div>

					<div class="row g-3 mb-3">
						<div class="col-md-6">
							<label class="form-label small fw-semibold">JMBG <span
								class="text-danger small">*</span></label> <input type="text"
								name="jmbg" class="form-control" maxlength="13" required>
						</div>
						<div class="col-md-6">
							<label class="form-label small fw-semibold">Datum
								rođenja <span class="text-danger small">*</span>
							</label> <input type="date" name="datumRodjenja" class="form-control"
								required>
						</div>
					</div>

					<div class="mb-3">
						<label class="form-label small fw-semibold d-block">Pol <span
							class="text-danger small">*</span></label>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="pol" id="polM"
								value="M" required> <label
								class="form-check-label small" for="polM">Muški</label>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="pol" id="polZ"
								value="Z" required> <label
								class="form-check-label small" for="polZ">Ženski</label>
						</div>
					</div>

					<div class="mb-3">
						<label class="form-label small fw-semibold">Adresa</label> <input
							type="text" name="adresa" class="form-control">
					</div>

					<div class="row g-3 mb-3">
						<div class="col-md-6">
							<label class="form-label small fw-semibold">Email</label> <input
								type="email" name="email" class="form-control">
						</div>
						<div class="col-md-6">
							<label class="form-label small fw-semibold">Telefon</label> <input
								type="text" name="telefon" class="form-control">
						</div>
					</div>

					<hr class="my-4">

					<div class="mb-3">
						<label class="form-label small fw-semibold">LBO</label> <input
							type="text" name="lbo" class="form-control" maxlength="11">
					</div>
					<div class="form-check mb-4">
						<input type="checkbox" class="form-check-input" name="osiguran"
							value="true" id="osiguran"> <label
							class="form-check-label small" for="osiguran">Osiguran
							(označiti samo uz LBO broj)</label>
					</div>
					<hr class="my-4">
					<h6 class="fw-semibold mb-3">Zdravstveni karton</h6>

					<div class="row g-3 mb-3">
						<div class="col-md-6">
							<label class="form-label small fw-semibold">Krvna grupa</label> <select
								name="krvnaGrupa" class="form-select">
								<option value="">-</option>
								<option value="A+">A+</option>
								<option value="A-">A-</option>
								<option value="B+">B+</option>
								<option value="B-">B-</option>
								<option value="AB+">AB+</option>
								<option value="AB-">AB-</option>
								<option value="0+">0+</option>
								<option value="0-">0-</option>
							</select>
						</div>
						<div class="col-md-6">
							<label class="form-label small fw-semibold">Hronični bolesnik</label>
							<div class="form-check mt-2">
								<input type="checkbox" class="form-check-input"
									name="hronicanBolesnik" value="true" id="hronicanBolesnik">
								<label class="form-check-label small" for="hronicanBolesnik">Da</label>
							</div>
						</div>
					</div>

					<div class="mb-3">
						<label class="form-label small fw-semibold">Alergije</label>
						<textarea name="alergije" class="form-control" rows="2"
							maxlength="500"></textarea>
					</div>

					<div class="mb-3">
						<label class="form-label small fw-semibold">Napomena</label>
						<textarea name="napomenKarton" class="form-control" rows="2"
							maxlength="500"></textarea>
					</div>
					<button type="submit" class="btn btn-primary px-4">Kreiraj nalog pacijenta</button>
				</form>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>