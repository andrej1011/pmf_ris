package com.example.demo.controller;

import java.io.OutputStream;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import com.example.demo.service.AdminIzvestajService;
import jakarta.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperPrint;

@Controller
@RequestMapping("/admin/")
public class AdminIzvestajController {

    @Autowired AdminIzvestajService service;

    @GetMapping("izvestaj")
    public void izvestaj(HttpServletResponse response) throws Exception {
        JasperPrint jp = service.kreirajIzvestaj();
        response.setContentType("application/x-download");
        response.addHeader("Content-Disposition", "attachment; filename=izvestaj "
        		+ new java.text.SimpleDateFormat("MMMMyyyy").format(new Date())
        		+ ".pdf");
        OutputStream out = response.getOutputStream();
        JasperExportManager.exportReportToPdfStream(jp, out);
        out.close();
    }
}