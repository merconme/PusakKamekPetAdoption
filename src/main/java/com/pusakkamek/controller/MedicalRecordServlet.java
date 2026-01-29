/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.pusakkamek.controller;

import com.pusakkamek.dao.MedicalRecordDAO;
import com.pusakkamek.model.MedicalRecord;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "MedicalRecordServlet", value = "/MedicalRecordServlet")
public class MedicalRecordServlet extends HttpServlet {
    private MedicalRecordDAO medicalDAO;

    @Override
    public void init() {
        medicalDAO = new MedicalRecordDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<MedicalRecord> list = medicalDAO.getAll();
        request.setAttribute("recordList", list);
        RequestDispatcher dispatcher = request.getRequestDispatcher("medical-record.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        MedicalRecord record = new MedicalRecord();
        record.setPetId(Integer.parseInt(request.getParameter("petId")));
        record.setVaccine(request.getParameter("vaccine"));
        record.setDate(request.getParameter("date"));
        record.setStatus(request.getParameter("status"));

        medicalDAO.insert(record);
        response.sendRedirect("MedicalRecordServlet");
    }
}

