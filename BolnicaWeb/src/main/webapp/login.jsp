<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="sr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RIS Bolnica</title>
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/uploads/favicon.ico">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: #f0f4f8; min-height: 100vh; display: flex; align-items: center; justify-content: center; }
        .login-card { max-width: 400px; width: 100%; border: none; border-radius: 12px; box-shadow: 0 4px 24px rgba(0,0,0,0.08); }
        .login-logo { width: 48px; height: 48px; border-radius: 1px; }
        .btn-login { background: #1a5fa8; color: #fff; border: none; }
        .btn-login:hover { background: #154d8a; color: #fff; }
        .btn-euprava { background: #fff; border: 1px solid #d1d9e0; color: #253965; }
        .btn-euprava:hover { background: #f0f4f8; }
        .divider { display: flex; align-items: center; gap: 10px; color: #9ca3af; font-size: 0.8rem; }
        .divider::before, .divider::after { content: ''; flex: 1; height: 1px; background: #e5e7eb; }
        .capslock-warn { display: none; background: #fffbeb; border: 1px solid #f6e05e; color: #b7791f; font-size: 0.78rem; padding: 4px 8px; border-radius: 4px; margin-top: 4px; }
    </style>
</head>
<body>

<div class="card login-card p-4">
    <div class="text-center mb-3">
        <img src="${pageContext.request.contextPath}/uploads/favicon.ico" alt="RIS Bolnica" class="login-logo mb-2">
        <h5 class="fw-semibold">Bolnički portal</h5>
        <p class="text-muted small">Prijavite se da nastavite</p>
    </div>

    <c:if test="${param.error != null}"><div class="alert alert-danger py-2 small">Pogrešno korisničko ime ili lozinka.</div></c:if>
    <c:if test="${param.logout != null}"><div class="alert alert-success py-2 small">Uspešno ste se odjavili.</div></c:if>
    <c:if test="${param.timeout != null}"><div class="alert alert-warning py-2 small">Sesija je istekla. Prijavite se ponovo.</div></c:if>

    <form action="${pageContext.request.contextPath}/login" method="post">
        <div class="mb-3">
            <label for="username" class="form-label small fw-semibold">Korisničko ime</label>
            <input type="text" id="username" name="username" class="form-control" required autofocus>
        </div>
        <div class="mb-3">
            <label for="password" class="form-label small fw-semibold">Lozinka</label>
            <input type="password" id="password" name="password" class="form-control" required>
            <div class="capslock-warn" id="capsWarn">&#9650; Caps Lock je uključen!</div>
        </div>
        <button type="submit" class="btn btn-login w-100 fw-semibold">Prijavi se</button>
    </form>

    <div class="divider my-3">ili</div>

    <button class="btn btn-euprava w-100 d-flex align-items-center justify-content-center gap-2" data-bs-toggle="modal" data-bs-target="#eupravaModal">
        <img src="${pageContext.request.contextPath}/uploads/euprava.svg" alt="eUprava" style="width:22px;height:22px;">
        Prijavite se preko portala eid.gov.rs
    </button>

    <p class="text-center text-muted small mt-3 mb-0">
        Ako ste zaboravili lozinku ili nemate nalog, kontaktirajte administratora.
    </p>
</div>

<%-- eUprava Bootstrap modal --%>
<div class="modal fade" id="eupravaModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h6 class="modal-title fw-semibold">Prijava preko eUprave</h6>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body small text-muted">
                <strong>eUprava</strong> koristi <strong>OAuth 2.0 + OpenID Connect</strong> (isto kao Google/Facebook login). <br><br> Spring Boot ima <em>spring-boot-starter-oauth2-client</em> koji to radi skoro automatski.
                <br><br>
                Integracija zahteva registraciju aplikacije kod eUprave i dodelu <em>client-id</em> i <em>client-secret</em> kredencijala. Nakon toga, prijava bi bila automatska bez korisnickog imena i lozinke.
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
const passInput = document.getElementById('password');
const capsWarn = document.getElementById('capsWarn');
passInput.addEventListener('keyup', e => capsWarn.style.display = e.getModifierState('CapsLock') ? 'block' : 'none');
</script>
</body>
</html>