<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.telemedicalexpertise.model.User" %>
<%@ page import="com.example.telemedicalexpertise.model.Specialist" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login");
        return;
    }
    Specialist specialist = (Specialist) user;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Specialist Dashboard - Telemedical Expertise</title>
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
<body class="bg-gradient-to-br from-purple-50 to-indigo-100 min-h-screen">
    <!-- Header -->
    <header class="bg-white shadow-lg">
        <div class="container mx-auto px-4 py-4">
            <div class="flex justify-between items-center">
                <div class="flex items-center space-x-3">
                    <div class="w-12 h-12 bg-purple-600 rounded-full flex items-center justify-center">
                        <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z"/>
                        </svg>
                    </div>
                    <div>
                        <h1 class="text-2xl font-bold text-gray-800">Specialist Dashboard</h1>
                        <p class="text-sm text-gray-600">Telemedical Expertise & Consultation</p>
                    </div>
                </div>
                <div class="flex items-center space-x-4">
                    <div class="text-right">
                        <p class="text-sm font-semibold text-gray-800">Dr. <%= user.getFirstName() %> <%= user.getLastName() %></p>
                        <p class="text-xs text-purple-600">
                            <%= specialist.getSpecialty() != null ? specialist.getSpecialty().getDisplayName() : "Specialist" %>
                        </p>
                    </div>
                    <a href="logout" class="bg-red-500 hover:bg-red-600 text-white px-4 py-2 rounded-lg transition">
                        Logout
                    </a>
                </div>
            </div>
        </div>
    </header>

    <div class="container mx-auto px-4 py-8">
        <!-- Stats Cards -->
        <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">
            <div class="bg-white rounded-xl shadow-md p-6">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-gray-500 text-sm">Pending Requests</p>
                        <p class="text-3xl font-bold text-orange-600">0</p>
                    </div>
                    <div class="bg-orange-100 rounded-full p-3">
                        <svg class="w-8 h-8 text-orange-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"/>
                        </svg>
                    </div>
                </div>
            </div>

            <div class="bg-white rounded-xl shadow-md p-6">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-gray-500 text-sm">Completed Today</p>
                        <p class="text-3xl font-bold text-green-600">0</p>
                    </div>
                    <div class="bg-green-100 rounded-full p-3">
                        <svg class="w-8 h-8 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                        </svg>
                    </div>
                </div>
            </div>

            <div class="bg-white rounded-xl shadow-md p-6">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-gray-500 text-sm">Available Slots</p>
                        <p class="text-3xl font-bold text-blue-600">12</p>
                    </div>
                    <div class="bg-blue-100 rounded-full p-3">
                        <svg class="w-8 h-8 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"/>
                        </svg>
                    </div>
                </div>
            </div>

            <div class="bg-white rounded-xl shadow-md p-6">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-gray-500 text-sm">Consultation Fee</p>
                        <p class="text-3xl font-bold text-purple-600">
                            <%= specialist.getConsultationTariff() != null ? specialist.getConsultationTariff().intValue() : "—" %> DH
                        </p>
                    </div>
                    <div class="bg-purple-100 rounded-full p-3">
                        <svg class="w-8 h-8 text-purple-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
                        </svg>
                    </div>
                </div>
            </div>
        </div>

        <!-- Main Content -->
        <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
            <!-- Profile & Schedule -->
            <div class="lg:col-span-1 space-y-6">
                <!-- Profile Configuration -->
                <div class="bg-white rounded-xl shadow-md p-6">
                    <h2 class="text-xl font-bold text-gray-800 mb-4 flex items-center">
                        <svg class="w-5 h-5 mr-2 text-purple-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/>
                        </svg>
                        Profile Configuration
                    </h2>

                    <form action="specialist/profile" method="post" class="space-y-4">
                        <div>
                            <label class="block text-sm font-semibold text-gray-700 mb-2">Specialty</label>
                            <select name="specialty" class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500">
                                <option value="">Select specialty...</option>
                                <option value="CARDIOLOGY" <%= specialist.getSpecialty() != null && specialist.getSpecialty().name().equals("CARDIOLOGY") ? "selected" : "" %>>Cardiology</option>
                                <option value="PNEUMOLOGY" <%= specialist.getSpecialty() != null && specialist.getSpecialty().name().equals("PNEUMOLOGY") ? "selected" : "" %>>Pneumology</option>
                                <option value="NEUROLOGY" <%= specialist.getSpecialty() != null && specialist.getSpecialty().name().equals("NEUROLOGY") ? "selected" : "" %>>Neurology</option>
                                <option value="GASTROENTEROLOGY" <%= specialist.getSpecialty() != null && specialist.getSpecialty().name().equals("GASTROENTEROLOGY") ? "selected" : "" %>>Gastroenterology</option>
                                <option value="ENDOCRINOLOGY" <%= specialist.getSpecialty() != null && specialist.getSpecialty().name().equals("ENDOCRINOLOGY") ? "selected" : "" %>>Endocrinology</option>
                                <option value="DERMATOLOGY" <%= specialist.getSpecialty() != null && specialist.getSpecialty().name().equals("DERMATOLOGY") ? "selected" : "" %>>Dermatology</option>
                                <option value="RHEUMATOLOGY" <%= specialist.getSpecialty() != null && specialist.getSpecialty().name().equals("RHEUMATOLOGY") ? "selected" : "" %>>Rheumatology</option>
                                <option value="PSYCHIATRY" <%= specialist.getSpecialty() != null && specialist.getSpecialty().name().equals("PSYCHIATRY") ? "selected" : "" %>>Psychiatry</option>
                                <option value="NEPHROLOGY" <%= specialist.getSpecialty() != null && specialist.getSpecialty().name().equals("NEPHROLOGY") ? "selected" : "" %>>Nephrology</option>
                                <option value="ORTHOPEDICS" <%= specialist.getSpecialty() != null && specialist.getSpecialty().name().equals("ORTHOPEDICS") ? "selected" : "" %>>Orthopedics</option>
                            </select>
                        </div>

                        <div>
                            <label class="block text-sm font-semibold text-gray-700 mb-2">Consultation Tariff (DH)</label>
                            <input type="number" name="tariff" value="<%= specialist.getConsultationTariff() != null ? specialist.getConsultationTariff() : "" %>"
                                   placeholder="e.g., 300" class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500">
                        </div>

                        <div>
                            <label class="block text-sm font-semibold text-gray-700 mb-2">Session Duration (min)</label>
                            <input type="number" name="duration" value="<%= specialist.getConsultationDuration() %>"
                                   class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500" readonly>
                            <p class="text-xs text-gray-500 mt-1">Fixed at 30 minutes</p>
                        </div>

                        <button type="submit" class="w-full bg-gradient-to-r from-purple-600 to-indigo-600 text-white font-semibold py-2 rounded-lg hover:from-purple-700 hover:to-indigo-700 transition">
                            Update Profile
                        </button>
                    </form>
                </div>

                <!-- Today's Schedule -->
                <div class="bg-white rounded-xl shadow-md p-6">
                    <h2 class="text-xl font-bold text-gray-800 mb-4 flex items-center">
                        <svg class="w-5 h-5 mr-2 text-purple-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"/>
                        </svg>
                        Today's Schedule
                    </h2>

                    <div class="space-y-2 max-h-64 overflow-y-auto">
                        <div class="flex items-center justify-between p-2 bg-green-50 border border-green-200 rounded">
                            <span class="text-sm font-medium text-gray-700">09:00 - 09:30</span>
                            <span class="text-xs bg-green-500 text-white px-2 py-1 rounded">Available</span>
                        </div>
                        <div class="flex items-center justify-between p-2 bg-green-50 border border-green-200 rounded">
                            <span class="text-sm font-medium text-gray-700">09:30 - 10:00</span>
                            <span class="text-xs bg-green-500 text-white px-2 py-1 rounded">Available</span>
                        </div>
                        <div class="flex items-center justify-between p-2 bg-green-50 border border-green-200 rounded">
                            <span class="text-sm font-medium text-gray-700">10:00 - 10:30</span>
                            <span class="text-xs bg-green-500 text-white px-2 py-1 rounded">Available</span>
                        </div>
                        <div class="flex items-center justify-between p-2 bg-green-50 border border-green-200 rounded">
                            <span class="text-sm font-medium text-gray-700">10:30 - 11:00</span>
                            <span class="text-xs bg-green-500 text-white px-2 py-1 rounded">Available</span>
                        </div>
                        <div class="flex items-center justify-between p-2 bg-green-50 border border-green-200 rounded">
                            <span class="text-sm font-medium text-gray-700">11:00 - 11:30</span>
                            <span class="text-xs bg-green-500 text-white px-2 py-1 rounded">Available</span>
                        </div>
                        <div class="flex items-center justify-between p-2 bg-green-50 border border-green-200 rounded">
                            <span class="text-sm font-medium text-gray-700">11:30 - 12:00</span>
                            <span class="text-xs bg-green-500 text-white px-2 py-1 rounded">Available</span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Expertise Requests -->
            <div class="lg:col-span-2 space-y-6">
                <!-- Filter Tabs -->
                <div class="bg-white rounded-xl shadow-md p-6">
                    <div class="flex items-center justify-between mb-6">
                        <h2 class="text-2xl font-bold text-gray-800 flex items-center">
                            <svg class="w-6 h-6 mr-2 text-purple-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-6 9l2 2 4-4"/>
                            </svg>
                            Expertise Requests
                        </h2>

                        <div class="flex space-x-2">
                            <button onclick="filterRequests('all')" class="px-4 py-2 bg-purple-100 text-purple-700 rounded-lg hover:bg-purple-200 transition text-sm font-medium">
                                All
                            </button>
                            <button onclick="filterRequests('pending')" class="px-4 py-2 bg-gray-100 text-gray-700 rounded-lg hover:bg-gray-200 transition text-sm font-medium">
                                Pending
                            </button>
                            <button onclick="filterRequests('urgent')" class="px-4 py-2 bg-red-100 text-red-700 rounded-lg hover:bg-red-200 transition text-sm font-medium">
                                Urgent
                            </button>
                        </div>
                    </div>

                    <!-- Request List -->
                    <div class="space-y-4">
                        <!-- Empty State -->
                        <div class="text-center py-12 text-gray-500">
                            <svg class="w-20 h-20 mx-auto mb-4 text-gray-300" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 13V6a2 2 0 00-2-2H6a2 2 0 00-2 2v7m16 0v5a2 2 0 01-2 2H6a2 2 0 01-2-2v-5m16 0h-2.586a1 1 0 00-.707.293l-2.414 2.414a1 1 0 01-.707.293h-3.172a1 1 0 01-.707-.293l-2.414-2.414A1 1 0 006.586 13H4"/>
                            </svg>
                            <p class="text-lg font-medium">No expertise requests yet</p>
                            <p class="text-sm mt-2">Requests from general practitioners will appear here</p>
                        </div>
                    </div>
                </div>

                <!-- Respond to Request Modal (Example) -->
                <div id="responseModal" class="hidden bg-white rounded-xl shadow-md p-6 border-2 border-purple-200">
                    <h3 class="text-xl font-bold text-gray-800 mb-4 flex items-center">
                        <svg class="w-5 h-5 mr-2 text-purple-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"/>
                        </svg>
                        Provide Medical Opinion
                    </h3>

                    <form action="specialist/respond" method="post" class="space-y-4">
                        <input type="hidden" name="requestId" id="requestId">

                        <div class="bg-gray-50 p-4 rounded-lg mb-4">
                            <h4 class="font-semibold text-gray-700 mb-2">Patient Case Summary</h4>
                            <p class="text-sm text-gray-600" id="caseSummary">Case details will appear here...</p>
                        </div>

                        <div>
                            <label class="block text-sm font-semibold text-gray-700 mb-2">Medical Opinion</label>
                            <textarea name="opinion" rows="4" required placeholder="Your professional assessment and diagnosis..."
                                      class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500"></textarea>
                        </div>

                        <div>
                            <label class="block text-sm font-semibold text-gray-700 mb-2">Recommendations</label>
                            <textarea name="recommendations" rows="4" required placeholder="Treatment plan, tests, or follow-up recommendations..."
                                      class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500"></textarea>
                        </div>

                        <div class="grid grid-cols-2 gap-4">
                            <button type="button" onclick="hideResponseModal()"
                                    class="border-2 border-gray-300 text-gray-700 font-semibold py-3 rounded-lg hover:bg-gray-100 transition">
                                Cancel
                            </button>
                            <button type="submit"
                                    class="bg-gradient-to-r from-purple-600 to-indigo-600 text-white font-semibold py-3 rounded-lg hover:from-purple-700 hover:to-indigo-700 transition">
                                Submit Response
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script>
        function filterRequests(filter) {
            // In production, this would filter the requests list
            console.log('Filtering by:', filter);
        }

        function showResponseModal(requestId) {
            document.getElementById('requestId').value = requestId;
            document.getElementById('responseModal').classList.remove('hidden');
            document.getElementById('responseModal').scrollIntoView({ behavior: 'smooth' });
        }

        function hideResponseModal() {
            document.getElementById('responseModal').classList.add('hidden');
        }
    </script>
</body>
</html>