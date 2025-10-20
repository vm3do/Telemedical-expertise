<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.telemedicalexpertise.model.User" %>
<%@ page import="com.example.telemedicalexpertise.model.Patient" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login");
        return;
    }

    List<Patient> todayPatients = (List<Patient>) request.getAttribute("todayPatients");
    List<Patient> waitingQueue = (List<Patient>) request.getAttribute("waitingQueue");
    Integer todayCount = (Integer) request.getAttribute("todayCount");
    Integer queueCount = (Integer) request.getAttribute("queueCount");
    Integer totalCount = (Integer) request.getAttribute("totalCount");
    Patient foundPatient = (Patient) request.getAttribute("foundPatient");

    if (todayCount == null) todayCount = 0;
    if (queueCount == null) queueCount = 0;
    if (totalCount == null) totalCount = 0;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nurse Dashboard - Telemedical Expertise</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        medical: {
                            50: '#f0f9ff',
                            100: '#e0f2fe',
                            200: '#bae6fd',
                            300: '#7dd3fc',
                            400: '#38bdf8',
                            500: '#0ea5e9',
                            600: '#0284c7',
                            700: '#0369a1',
                            800: '#075985',
                            900: '#0c4a6e',
                        }
                    }
                }
            }
        }
    </script>
</head>
<body class="bg-gradient-to-br from-blue-50 to-medical-100 min-h-screen">
    <!-- Header -->
    <header class="bg-white shadow-lg">
        <div class="container mx-auto px-4 py-4">
            <div class="flex justify-between items-center">
                <div class="flex items-center space-x-3">
                    <div class="w-12 h-12 bg-blue-600 rounded-full flex items-center justify-center">
                        <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                        </svg>
                    </div>
                    <div>
                        <h1 class="text-2xl font-bold text-gray-800">Nurse Dashboard</h1>
                        <p class="text-sm text-gray-600">Patient Registration & Management</p>
                    </div>
                </div>
                <div class="flex items-center space-x-4">
                    <div class="text-right">
                        <p class="text-sm font-semibold text-gray-800"><%= user.getFirstName() %> <%= user.getLastName() %></p>
                        <p class="text-xs text-blue-600">Nurse</p>
                    </div>
                    <a href="logout" class="bg-red-500 hover:bg-red-600 text-white px-4 py-2 rounded-lg transition">
                        Logout
                    </a>
                </div>
            </div>
        </div>
    </header>

    <div class="container mx-auto px-4 py-8">
        <!-- Success/Error Messages -->
        <% if (request.getParameter("success") != null) { %>
            <div class="bg-green-50 border-l-4 border-green-500 p-4 mb-6 rounded">
                <div class="flex items-center">
                    <svg class="w-5 h-5 text-green-500 mr-2" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/>
                    </svg>
                    <p class="text-green-700 font-medium"><%= request.getParameter("success") %></p>
                </div>
            </div>
        <% } %>

        <% if (request.getAttribute("error") != null) { %>
            <div class="bg-red-50 border-l-4 border-red-500 p-4 mb-6 rounded">
                <div class="flex items-center">
                    <svg class="w-5 h-5 text-red-500 mr-2" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd"/>
                    </svg>
                    <p class="text-red-700 font-medium"><%= request.getAttribute("error") %></p>
                </div>
            </div>
        <% } %>

        <!-- Stats Cards -->
        <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
            <div class="bg-white rounded-xl shadow-md p-6">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-gray-500 text-sm">Patients Today</p>
                        <p class="text-3xl font-bold text-blue-600"><%= todayCount %></p>
                    </div>
                    <div class="bg-blue-100 rounded-full p-3">
                        <svg class="w-8 h-8 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z"/>
                        </svg>
                    </div>
                </div>
            </div>

            <div class="bg-white rounded-xl shadow-md p-6">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-gray-500 text-sm">In Waiting Queue</p>
                        <p class="text-3xl font-bold text-green-600"><%= queueCount %></p>
                    </div>
                    <div class="bg-green-100 rounded-full p-3">
                        <svg class="w-8 h-8 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"/>
                        </svg>
                    </div>
                </div>
            </div>

            <div class="bg-white rounded-xl shadow-md p-6">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-gray-500 text-sm">Total Registered</p>
                        <p class="text-3xl font-bold text-purple-600"><%= totalCount %></p>
                    </div>
                    <div class="bg-purple-100 rounded-full p-3">
                        <svg class="w-8 h-8 text-purple-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                        </svg>
                    </div>
                </div>
            </div>
        </div>

        <!-- Main Content -->
        <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
            <!-- Patient Search & Update -->
            <div class="bg-white rounded-xl shadow-md p-6">
                <h2 class="text-2xl font-bold text-gray-800 mb-6 flex items-center">
                    <svg class="w-6 h-6 mr-2 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
                    </svg>
                    Search Existing Patient
                </h2>

                <form action="patient" method="get" class="mb-6">
                    <input type="hidden" name="action" value="search">
                    <div class="flex gap-2">
                        <input type="text" name="ssn" placeholder="Enter Social Security Number" required
                               class="flex-1 px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500">
                        <button type="submit" class="bg-blue-600 text-white px-6 py-2 rounded-lg hover:bg-blue-700 transition">
                            Search
                        </button>
                    </div>
                </form>

                <% if (foundPatient != null) { %>
                    <div class="bg-blue-50 border border-blue-200 rounded-lg p-4 mb-4">
                        <h3 class="font-semibold text-gray-800 mb-2">Patient Found</h3>
                        <p class="text-sm text-gray-700"><strong>Name:</strong> <%= foundPatient.getFullName() %></p>
                        <p class="text-sm text-gray-700"><strong>SSN:</strong> <%= foundPatient.getSocialSecurityNumber() %></p>
                        <p class="text-sm text-gray-700"><strong>Phone:</strong> <%= foundPatient.getPhone() %></p>
                        <button onclick="showUpdateForm(<%= foundPatient.getId() %>, '<%= foundPatient.getFullName() %>')"
                                class="mt-3 bg-green-600 text-white px-4 py-2 rounded-lg hover:bg-green-700 transition text-sm">
                            Update Vital Signs & Add to Queue
                        </button>
                    </div>
                <% } else if (request.getAttribute("searchError") != null) { %>
                    <div class="bg-yellow-50 border border-yellow-200 rounded-lg p-4">
                        <p class="text-yellow-700"><%= request.getAttribute("searchError") %></p>
                    </div>
                <% } %>

                <div id="updateFormContainer" class="hidden mt-4 bg-gray-50 rounded-lg p-4">
                    <h3 class="font-semibold text-gray-800 mb-4">Update Vital Signs</h3>
                    <form action="patient" method="post">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="patientId" id="updatePatientId">

                        <div class="grid grid-cols-2 gap-4 mb-4">
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-1">Blood Pressure</label>
                                <input type="text" name="bloodPressure" placeholder="120/80" class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500">
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-1">Heart Rate (bpm)</label>
                                <input type="number" name="heartRate" placeholder="75" class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500">
                            </div>
                        </div>

                        <div class="grid grid-cols-3 gap-4 mb-4">
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-1">Temperature (°C)</label>
                                <input type="number" step="0.1" name="temperature" placeholder="37.0" class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500">
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-1">Resp. Rate</label>
                                <input type="number" name="respiratoryRate" placeholder="16" class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500">
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-1">Weight (kg)</label>
                                <input type="number" step="0.1" name="weight" placeholder="70" class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500">
                            </div>
                        </div>

                        <div class="flex gap-2">
                            <button type="submit" class="flex-1 bg-blue-600 text-white py-2 rounded-lg hover:bg-blue-700 transition">
                                Update & Add to Queue
                            </button>
                            <button type="button" onclick="hideUpdateForm()" class="px-4 bg-gray-300 text-gray-700 rounded-lg hover:bg-gray-400 transition">
                                Cancel
                            </button>
                        </div>
                    </form>
                </div>

                <hr class="my-6">

                <!-- Patient Registration Form -->
                <h2 class="text-2xl font-bold text-gray-800 mb-6 flex items-center">
                    <svg class="w-6 h-6 mr-2 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M18 9v3m0 0v3m0-3h3m-3 0h-3m-2-5a4 4 0 11-8 0 4 4 0 018 0zM3 20a6 6 0 0112 0v1H3v-1z"/>
                    </svg>
                    Register New Patient
                </h2>

                <form action="patient" method="post" class="space-y-4">
                    <input type="hidden" name="action" value="register">

                    <!-- Personal Info -->
                    <div class="border-b pb-4">
                        <h3 class="font-semibold text-gray-700 mb-3">Personal Information</h3>
                        <div class="grid grid-cols-2 gap-4">
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-1">First Name *</label>
                                <input type="text" name="firstName" required class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500">
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-1">Last Name *</label>
                                <input type="text" name="lastName" required class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500">
                            </div>
                        </div>
                        <div class="grid grid-cols-2 gap-4 mt-3">
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-1">Date of Birth *</label>
                                <input type="date" name="dateOfBirth" required class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500">
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-1">Social Security #</label>
                                <input type="text" name="socialSecurityNumber" class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500">
                            </div>
                        </div>
                        <div class="grid grid-cols-2 gap-4 mt-3">
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-1">Phone</label>
                                <input type="tel" name="phone" class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500">
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-1">Insurance</label>
                                <input type="text" name="insurance" class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500">
                            </div>
                        </div>
                        <div class="mt-3">
                            <label class="block text-sm font-medium text-gray-700 mb-1">Address</label>
                            <input type="text" name="address" class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500">
                        </div>
                    </div>

                    <!-- Vital Signs -->
                    <div class="border-b pb-4">
                        <h3 class="font-semibold text-gray-700 mb-3 flex items-center">
                            <svg class="w-5 h-5 mr-2 text-red-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z"/>
                            </svg>
                            Vital Signs
                        </h3>
                        <div class="grid grid-cols-2 gap-4">
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-1">Blood Pressure</label>
                                <input type="text" name="bloodPressure" placeholder="120/80" class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500">
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-1">Heart Rate (bpm)</label>
                                <input type="number" name="heartRate" placeholder="75" class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500">
                            </div>
                        </div>
                        <div class="grid grid-cols-3 gap-4 mt-3">
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-1">Temperature (°C)</label>
                                <input type="number" step="0.1" name="temperature" placeholder="37.0" class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500">
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-1">Resp. Rate</label>
                                <input type="number" name="respiratoryRate" placeholder="16" class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500">
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-1">Weight (kg)</label>
                                <input type="number" step="0.1" name="weight" placeholder="70" class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500">
                            </div>
                        </div>
                        <div class="mt-3">
                            <label class="block text-sm font-medium text-gray-700 mb-1">Height (cm)</label>
                            <input type="number" step="0.1" name="height" placeholder="170" class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500">
                        </div>
                    </div>

                    <!-- Medical History -->
                    <div>
                        <h3 class="font-semibold text-gray-700 mb-3">Medical Information</h3>
                        <div class="space-y-3">
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-1">Medical History</label>
                                <textarea name="medicalHistory" rows="2" placeholder="Previous conditions, surgeries, etc." class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500"></textarea>
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-1">Allergies</label>
                                <textarea name="allergies" rows="2" placeholder="Known allergies" class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500"></textarea>
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-1">Current Treatments</label>
                                <textarea name="currentTreatments" rows="2" placeholder="Ongoing medications or treatments" class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500"></textarea>
                            </div>
                        </div>
                    </div>

                    <button type="submit" class="w-full bg-gradient-to-r from-blue-600 to-cyan-600 text-white font-semibold py-3 rounded-lg hover:from-blue-700 hover:to-cyan-700 transition transform hover:scale-[1.02]">
                        Register Patient & Add to Queue
                    </button>
                </form>
            </div>

            <!-- Registered Patients List -->
            <div class="bg-white rounded-xl shadow-md p-6">
                <h2 class="text-2xl font-bold text-gray-800 mb-6 flex items-center justify-between">
                    <span class="flex items-center">
                        <svg class="w-6 h-6 mr-2 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2"/>
                        </svg>
                        Today's Patients
                    </span>
                    <a href="nurse" class="text-sm bg-blue-100 text-blue-600 px-3 py-1 rounded-lg hover:bg-blue-200">Refresh</a>
                </h2>

                <div class="space-y-3 overflow-y-auto max-h-[600px]">
                    <% if (todayPatients != null && !todayPatients.isEmpty()) {
                        DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");
                        for (Patient patient : todayPatients) { %>
                        <div class="border border-gray-200 rounded-lg p-4 hover:shadow-md transition">
                            <div class="flex justify-between items-start">
                                <div class="flex-1">
                                    <h3 class="font-semibold text-gray-800"><%= patient.getFullName() %></h3>
                                    <p class="text-sm text-gray-600 mt-1">
                                        <span class="font-medium">Registered:</span>
                                        <%= patient.getRegisteredAt() != null ? patient.getRegisteredAt().format(timeFormatter) : "N/A" %>
                                    </p>
                                    <% if (patient.getSocialSecurityNumber() != null) { %>
                                        <p class="text-sm text-gray-600">
                                            <span class="font-medium">SSN:</span> <%= patient.getSocialSecurityNumber() %>
                                        </p>
                                    <% } %>
                                    <div class="mt-2 flex flex-wrap gap-2">
                                        <% if (patient.getBloodPressure() != null) { %>
                                            <span class="text-xs bg-red-100 text-red-700 px-2 py-1 rounded">BP: <%= patient.getBloodPressure() %></span>
                                        <% } %>
                                        <% if (patient.getHeartRate() != null) { %>
                                            <span class="text-xs bg-pink-100 text-pink-700 px-2 py-1 rounded">HR: <%= patient.getHeartRate() %> bpm</span>
                                        <% } %>
                                        <% if (patient.getTemperature() != null) { %>
                                            <span class="text-xs bg-orange-100 text-orange-700 px-2 py-1 rounded">Temp: <%= patient.getTemperature() %>°C</span>
                                        <% } %>
                                    </div>
                                </div>
                                <% if (patient.getInWaitingQueue()) { %>
                                    <span class="bg-green-100 text-green-700 text-xs px-3 py-1 rounded-full font-medium">In Queue</span>
                                <% } else { %>
                                    <span class="bg-gray-100 text-gray-700 text-xs px-3 py-1 rounded-full font-medium">Completed</span>
                                <% } %>
                            </div>
                        </div>
                    <% }
                    } else { %>
                        <div class="border border-gray-200 rounded-lg p-4 hover:shadow-md transition">
                            <div class="flex justify-between items-start">
                                <div class="flex-1">
                                    <h3 class="font-semibold text-gray-800">No patients registered yet</h3>
                                    <p class="text-sm text-gray-500 mt-1">Start by registering a new patient</p>
                                </div>
                            </div>
                        </div>
                    <% } %>
                </div>
            </div>
        </div>
    </div>

    <script>
        function showUpdateForm(patientId, patientName) {
            document.getElementById('updatePatientId').value = patientId;
            document.getElementById('updateFormContainer').classList.remove('hidden');
        }

        function hideUpdateForm() {
            document.getElementById('updateFormContainer').classList.add('hidden');
        }
    </script>
</body>
</html>

