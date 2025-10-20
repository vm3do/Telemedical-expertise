<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.telemedicalexpertise.model.User" %>
<%@ page import="com.example.telemedicalexpertise.model.GeneralPractitioner" %>
<%@ page import="com.example.telemedicalexpertise.model.Patient" %>
<%@ page import="com.example.telemedicalexpertise.model.Consultation" %>
<%@ page import="com.example.telemedicalexpertise.utils.CSRFUtil" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !(user instanceof GeneralPractitioner)) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    GeneralPractitioner gp = (GeneralPractitioner) user;

    // Generate CSRF token for this session
    String csrfToken = CSRFUtil.getToken(session);

    // Get attributes
    List<Patient> waitingPatients = (List<Patient>) request.getAttribute("waitingPatients");
    List<Consultation> recentConsultations = (List<Consultation>) request.getAttribute("recentConsultations");
    List<Consultation> consultations = (List<Consultation>) request.getAttribute("consultations");
    Consultation consultation = (Consultation) request.getAttribute("consultation");
    Patient patient = (Patient) request.getAttribute("patient");
    String viewMode = (String) request.getAttribute("viewMode");
    String error = (String) request.getAttribute("error");
    String success = (String) request.getAttribute("success");
    String action = request.getParameter("action");
    String status = request.getParameter("status");

    DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
    DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>General Practitioner Dashboard - Telemedical Expertise</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gradient-to-br from-green-50 to-emerald-100 min-h-screen">
    <!-- Header -->
    <header class="bg-white shadow-lg">
        <div class="container mx-auto px-4 py-4">
            <div class="flex justify-between items-center">
                <div class="flex items-center space-x-3">
                    <div class="w-12 h-12 bg-green-600 rounded-full flex items-center justify-center">
                        <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-6 9l2 2 4-4"/>
                        </svg>
                    </div>
                    <div>
                        <h1 class="text-2xl font-bold text-gray-800">General Practitioner</h1>
                        <p class="text-sm text-gray-600">Patient Consultation Management</p>
                    </div>
                </div>
                <div class="flex items-center space-x-4">
                    <div class="text-right">
                        <p class="text-sm font-semibold text-gray-800">Dr. <%= gp.getFirstName() %> <%= gp.getLastName() %></p>
                        <p class="text-xs text-green-600">General Practitioner</p>
                    </div>
                    <a href="<%= request.getContextPath() %>/logout" class="bg-red-500 hover:bg-red-600 text-white px-4 py-2 rounded-lg transition">
                        Logout
                    </a>
                </div>
            </div>
        </div>
    </header>

    <div class="container mx-auto px-4 py-8">
        <!-- Navigation Tabs -->
        <div class="mb-6 flex space-x-4">
            <a href="<%= request.getContextPath() %>/general?action=dashboard"
               class="px-4 py-2 rounded-lg <%= (action == null || "dashboard".equals(action)) ? "bg-green-600 text-white" : "bg-white text-gray-700" %>">
                Dashboard
            </a>
            <a href="<%= request.getContextPath() %>/general?action=viewQueue"
               class="px-4 py-2 rounded-lg <%= "viewQueue".equals(action) ? "bg-green-600 text-white" : "bg-white text-gray-700" %>">
                Waiting Queue
            </a>
            <a href="<%= request.getContextPath() %>/general?action=myConsultations"
               class="px-4 py-2 rounded-lg <%= "myConsultations".equals(action) ? "bg-green-600 text-white" : "bg-white text-gray-700" %>">
                My Consultations
            </a>
        </div>

        <!-- Success/Error Messages -->
        <% if (success != null) { %>
            <div class="mb-4 bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded">
                <%= success %>
            </div>
        <% } %>
        <% if (error != null) { %>
            <div class="mb-4 bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded">
                <%= error %>
            </div>
        <% } %>

        <!-- Stats Cards -->
        <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">
            <div class="bg-white rounded-xl shadow-md p-6">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-gray-500 text-sm">Waiting Queue</p>
                        <p class="text-3xl font-bold text-green-600"><%= (waitingPatients != null ? waitingPatients.size() : 0) %></p>
                    </div>
                    <div class="bg-green-100 rounded-full p-3">
                        <svg class="w-8 h-8 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z"/>
                        </svg>
                    </div>
                </div>
            </div>

            <div class="bg-white rounded-xl shadow-md p-6">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-gray-500 text-sm">My Consultations</p>
                        <p class="text-3xl font-bold text-blue-600"><%= (recentConsultations != null ? recentConsultations.size() : 0) %></p>
                    </div>
                    <div class="bg-blue-100 rounded-full p-3">
                        <svg class="w-8 h-8 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                        </svg>
                    </div>
                </div>
            </div>

            <div class="bg-white rounded-xl shadow-md p-6">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-gray-500 text-sm">Open Cases</p>
                        <p class="text-3xl font-bold text-orange-600">0</p>
                    </div>
                    <div class="bg-orange-100 rounded-full p-3">
                        <svg class="w-8 h-8 text-orange-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"/>
                        </svg>
                    </div>
                </div>
            </div>

            <div class="bg-white rounded-xl shadow-md p-6">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-gray-500 text-sm">Consultation Fee</p>
                        <p class="text-3xl font-bold text-purple-600">150 DH</p>
                    </div>
                    <div class="bg-purple-100 rounded-full p-3">
                        <svg class="w-8 h-8 text-purple-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
                        </svg>
                    </div>
                </div>
            </div>
        </div>

        <!-- Main Content Area -->
        <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
            <!-- Patient Queue Sidebar -->
            <div class="lg:col-span-1">
                <div class="bg-white rounded-xl shadow-md p-6">
                    <h2 class="text-xl font-bold text-gray-800 mb-4 flex items-center">
                        <svg class="w-5 h-5 mr-2 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"/>
                        </svg>
                        Waiting Patients
                    </h2>

                    <div class="space-y-3 max-h-[600px] overflow-y-auto">
                        <% if (waitingPatients != null && !waitingPatients.isEmpty()) { %>
                            <% for (Patient p : waitingPatients) { %>
                                <div class="border border-gray-200 rounded-lg p-4 hover:bg-gray-50 transition">
                                    <div class="flex justify-between items-start mb-2">
                                        <div>
                                            <h3 class="font-semibold text-gray-800"><%= p.getFullName() %></h3>
                                            <p class="text-xs text-gray-500">SS: <%= p.getSocialSecurityNumber() %></p>
                                        </div>
                                        <span class="text-xs bg-green-100 text-green-700 px-2 py-1 rounded">Waiting</span>
                                    </div>
                                    <div class="text-xs text-gray-600 space-y-1">
                                        <% if (p.getRegisteredAt() != null) { %>
                                            <p>⏰ <%= p.getRegisteredAt().format(timeFormatter) %></p>
                                        <% } %>
                                        <% if (p.getBloodPressure() != null) { %>
                                            <p>🩺 BP: <%= p.getBloodPressure() %></p>
                                        <% } %>
                                    </div>
                                    <a href="<%= request.getContextPath() %>/general?action=newConsultation&patientId=<%= p.getId() %>"
                                       class="mt-3 block text-center bg-green-600 text-white py-2 rounded hover:bg-green-700 transition text-sm">
                                        Start Consultation
                                    </a>
                                </div>
                            <% } %>
                        <% } else { %>
                            <div class="text-center py-8 text-gray-500">
                                <svg class="w-16 h-16 mx-auto mb-3 text-gray-300" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z"/>
                                </svg>
                                <p class="text-sm">No patients in queue</p>
                            </div>
                        <% } %>
                    </div>
                </div>
            </div>

            <!-- Main Content Panel -->
            <div class="lg:col-span-2">
                <% if ("newConsultation".equals(viewMode)) { %>
                    <!-- New Consultation Form -->
                    <div class="bg-white rounded-xl shadow-md p-6">
                        <h2 class="text-2xl font-bold text-gray-800 mb-6">New Consultation</h2>

                        <% if (patient != null) { %>
                            <div class="mb-6 p-4 bg-blue-50 rounded-lg">
                                <h3 class="font-semibold text-gray-800 mb-2">Patient Information</h3>
                                <div class="grid grid-cols-2 gap-4 text-sm">
                                    <div>
                                        <p class="text-gray-600">Name: <span class="font-semibold"><%= patient.getFullName() %></span></p>
                                        <p class="text-gray-600">SS#: <%= patient.getSocialSecurityNumber() %></p>
                                    </div>
                                    <div>
                                        <p class="text-gray-600">BP: <%= patient.getBloodPressure() != null ? patient.getBloodPressure() : "N/A" %></p>
                                        <p class="text-gray-600">Temp: <%= patient.getTemperature() != null ? patient.getTemperature() + "°C" : "N/A" %></p>
                                    </div>
                                </div>
                            </div>
                        <% } %>

                        <form action="<%= request.getContextPath() %>/general" method="post" class="space-y-4">
                            <input type="hidden" name="action" value="createConsultation">
                            <input type="hidden" name="patientId" value="<%= patient != null ? patient.getId() : "" %>">
                            <input type="hidden" name="csrfToken" value="<%= csrfToken %>">

                            <div>
                                <label class="block text-sm font-semibold text-gray-700 mb-2">Chief Complaint (Motif)</label>
                                <textarea name="motif" rows="3" required
                                          placeholder="What is the patient's main concern?"
                                          class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-green-500"></textarea>
                            </div>

                            <div>
                                <label class="block text-sm font-semibold text-gray-700 mb-2">Observations</label>
                                <textarea name="observations" rows="6"
                                          placeholder="Clinical examination findings and observations..."
                                          class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-green-500"></textarea>
                            </div>

                            <button type="submit"
                                    class="w-full bg-green-600 text-white font-semibold py-3 rounded-lg hover:bg-green-700 transition">
                                Create Consultation
                            </button>
                        </form>
                    </div>

                <% } else if ("viewConsultation".equals(viewMode) && consultation != null) { %>
                    <!-- View Consultation -->
                    <div class="bg-white rounded-xl shadow-md p-6">
                        <h2 class="text-2xl font-bold text-gray-800 mb-6">Consultation Details</h2>

                        <div class="space-y-6">
                            <div class="grid grid-cols-2 gap-4 p-4 bg-gray-50 rounded-lg">
                                <div>
                                    <p class="text-sm text-gray-600">Patient</p>
                                    <p class="font-semibold"><%= consultation.getPatient().getFullName() %></p>
                                </div>
                                <div>
                                    <p class="text-sm text-gray-600">Status</p>
                                    <span class="inline-block px-3 py-1 text-sm rounded-full
                                        <%= consultation.getStatus().name().equals("TERMINEE") ? "bg-gray-200 text-gray-700" :
                                            consultation.getStatus().name().equals("EN_ATTENTE_AVIS_SPECIALISTE") ? "bg-orange-200 text-orange-700" :
                                            "bg-blue-200 text-blue-700" %>">
                                        <%= consultation.getStatus().getDisplayName() %>
                                    </span>
                                </div>
                                <div>
                                    <p class="text-sm text-gray-600">Date</p>
                                    <p class="font-semibold"><%= consultation.getCreatedAt().format(dateFormatter) %></p>
                                </div>
                                <div>
                                    <p class="text-sm text-gray-600">Cost</p>
                                    <p class="font-semibold"><%= consultation.getConsultationCost() %> DH</p>
                                </div>
                            </div>

                            <div>
                                <h3 class="font-semibold text-gray-800 mb-2">Motif</h3>
                                <p class="text-gray-700"><%= consultation.getMotif() %></p>
                            </div>

                            <div>
                                <h3 class="font-semibold text-gray-800 mb-2">Observations</h3>
                                <p class="text-gray-700"><%= consultation.getObservations() != null ? consultation.getObservations() : "N/A" %></p>
                            </div>

                            <% if (consultation.isOpen()) { %>
                                <form action="<%= request.getContextPath() %>/general" method="post" class="space-y-4 border-t pt-4">
                                    <input type="hidden" name="action" value="closeConsultation">
                                    <input type="hidden" name="consultationId" value="<%= consultation.getId() %>">
                                    <input type="hidden" name="csrfToken" value="<%= csrfToken %>">

                                    <div>
                                        <label class="block text-sm font-semibold text-gray-700 mb-2">Diagnostic</label>
                                        <textarea name="diagnostic" rows="4" required
                                                  placeholder="Enter diagnosis..."
                                                  class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-green-500"><%= consultation.getDiagnostic() != null ? consultation.getDiagnostic() : "" %></textarea>
                                    </div>

                                    <div>
                                        <label class="block text-sm font-semibold text-gray-700 mb-2">Prescription</label>
                                        <textarea name="prescription" rows="4"
                                                  placeholder="Enter prescription details..."
                                                  class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-green-500"><%= consultation.getPrescription() != null ? consultation.getPrescription() : "" %></textarea>
                                    </div>

                                    <div class="flex space-x-4">
                                        <button type="submit"
                                                class="flex-1 bg-green-600 text-white font-semibold py-3 rounded-lg hover:bg-green-700 transition">
                                            Close Consultation
                                        </button>
                                        <a href="<%= request.getContextPath() %>/general?action=requestExpertise&consultationId=<%= consultation.getId() %>"
                                           class="flex-1 bg-orange-500 text-white font-semibold py-3 rounded-lg hover:bg-orange-600 transition text-center leading-[3rem]">
                                            Request Specialist
                                        </a>
                                    </div>
                                </form>
                            <% } else { %>
                                <div class="border-t pt-4">
                                    <div class="mb-4">
                                        <h3 class="font-semibold text-gray-800 mb-2">Diagnostic</h3>
                                        <p class="text-gray-700"><%= consultation.getDiagnostic() %></p>
                                    </div>
                                    <div>
                                        <h3 class="font-semibold text-gray-800 mb-2">Prescription</h3>
                                        <p class="text-gray-700"><%= consultation.getPrescription() != null ? consultation.getPrescription() : "N/A" %></p>
                                    </div>
                                </div>
                            <% } %>
                        </div>
                    </div>

                <% } else if ("myConsultations".equals(viewMode)) { %>
                    <!-- My Consultations List -->
                    <div class="bg-white rounded-xl shadow-md p-6">
                        <h2 class="text-2xl font-bold text-gray-800 mb-6">My Consultations</h2>

                        <div class="mb-4 flex space-x-2">
                            <a href="<%= request.getContextPath() %>/general?action=myConsultations&status=ALL"
                               class="px-4 py-2 rounded <%= (status == null || "ALL".equals(status)) ? "bg-green-600 text-white" : "bg-gray-200 text-gray-700" %>">
                                All
                            </a>
                            <a href="<%= request.getContextPath() %>/general?action=myConsultations&status=EN_COURS"
                               class="px-4 py-2 rounded <%= "EN_COURS".equals(status) ? "bg-green-600 text-white" : "bg-gray-200 text-gray-700" %>">
                                In Progress
                            </a>
                            <a href="<%= request.getContextPath() %>/general?action=myConsultations&status=EN_ATTENTE_AVIS_SPECIALISTE"
                               class="px-4 py-2 rounded <%= "EN_ATTENTE_AVIS_SPECIALISTE".equals(status) ? "bg-green-600 text-white" : "bg-gray-200 text-gray-700" %>">
                                Awaiting Specialist
                            </a>
                            <a href="<%= request.getContextPath() %>/general?action=myConsultations&status=TERMINEE"
                               class="px-4 py-2 rounded <%= "TERMINEE".equals(status) ? "bg-green-600 text-white" : "bg-gray-200 text-gray-700" %>">
                                Closed
                            </a>
                        </div>

                        <div class="space-y-3">
                            <% if (consultations != null && !consultations.isEmpty()) { %>
                                <% for (Consultation consult : consultations) { %>
                                    <div class="border border-gray-200 rounded-lg p-4 hover:bg-gray-50 transition">
                                        <div class="flex justify-between items-start mb-2">
                                            <div>
                                                <h3 class="font-semibold text-gray-800"><%= consult.getPatient().getFullName() %></h3>
                                                <p class="text-sm text-gray-600"><%= consult.getMotif() %></p>
                                            </div>
                                            <span class="text-xs px-3 py-1 rounded-full
                                                <%= consult.getStatus().name().equals("TERMINEE") ? "bg-gray-200 text-gray-700" :
                                                    consult.getStatus().name().equals("EN_ATTENTE_AVIS_SPECIALISTE") ? "bg-orange-200 text-orange-700" :
                                                    "bg-blue-200 text-blue-700" %>">
                                                <%= consult.getStatus().getDisplayName() %>
                                            </span>
                                        </div>
                                        <div class="flex justify-between items-center mt-3">
                                            <span class="text-xs text-gray-500">
                                                <%= consult.getCreatedAt().format(dateFormatter) %>
                                            </span>
                                            <a href="<%= request.getContextPath() %>/general?action=viewConsultation&id=<%= consult.getId() %>"
                                               class="text-green-600 hover:text-green-700 text-sm font-semibold">
                                                View Details →
                                            </a>
                                        </div>
                                    </div>
                                <% } %>
                            <% } else { %>
                                <div class="text-center py-12 text-gray-500">
                                    <p>No consultations found</p>
                                </div>
                            <% } %>
                        </div>
                    </div>

                <% } else { %>
                    <!-- Default Dashboard View -->
                    <div class="bg-white rounded-xl shadow-md p-6">
                        <h2 class="text-2xl font-bold text-gray-800 mb-6">Recent Consultations</h2>

                        <% if (recentConsultations != null && !recentConsultations.isEmpty()) { %>
                            <div class="space-y-3">
                                <% for (Consultation consult : recentConsultations) { %>
                                    <div class="border border-gray-200 rounded-lg p-4 hover:bg-gray-50 transition">
                                        <div class="flex justify-between items-start">
                                            <div class="flex-1">
                                                <h3 class="font-semibold text-gray-800"><%= consult.getPatient().getFullName() %></h3>
                                                <p class="text-sm text-gray-600 mt-1"><%= consult.getMotif() %></p>
                                                <p class="text-xs text-gray-500 mt-2">
                                                    <%= consult.getCreatedAt().format(dateFormatter) %>
                                                </p>
                                            </div>
                                            <div class="flex flex-col items-end space-y-2">
                                                <span class="text-xs px-3 py-1 rounded-full
                                                    <%= consult.getStatus().name().equals("TERMINEE") ? "bg-gray-200 text-gray-700" :
                                                        consult.getStatus().name().equals("EN_ATTENTE_AVIS_SPECIALISTE") ? "bg-orange-200 text-orange-700" :
                                                        "bg-blue-200 text-blue-700" %>">
                                                    <%= consult.getStatus().getDisplayName() %>
                                                </span>
                                                <a href="<%= request.getContextPath() %>/general?action=viewConsultation&id=<%= consult.getId() %>"
                                                   class="text-green-600 hover:text-green-700 text-sm font-semibold">
                                                    View →
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                <% } %>
                            </div>
                        <% } else { %>
                            <div class="text-center py-12 text-gray-500">
                                <svg class="w-20 h-20 mx-auto mb-4 text-gray-300" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                                </svg>
                                <p>No consultations yet</p>
                                <p class="text-sm mt-2">Start by selecting a patient from the waiting queue</p>
                            </div>
                        <% } %>
                    </div>
                <% } %>
            </div>
        </div>
    </div>
</body>
</html>
