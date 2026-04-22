<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="sr">
<head>
    <meta charset="UTF-8">
    <title>RIS Bolnica</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light d-flex align-items-center justify-content-center" style="min-height:100vh">
<div class="card p-4 text-center" style="max-width:420px;width:100%">
    <div class="text-success mb-3" style="font-size:48px">&#10003;</div>
    <h5 class="fw-semibold mb-2">Izmene su uspešno sačuvane</h5>
    <p class="text-muted small mb-3">Zahtev je označen kao završen.</p>
    <div class="alert alert-light border text-start small">
        <strong>Pacijent:</strong> ${pacijentIme}<br>
        <strong>Izmenjeno:</strong> ${izmene}
    </div>
    <a href="${pageContext.request.contextPath}/admin/gdpr" class="btn btn-primary btn-sm">Nazad</a>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>