<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.telemedicalexpertise.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>General Practitioner Dashboard - Telemedical Expertise</title>
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
                        <p class="text-sm text-gray-600">Patient Consultation & Specialist Referral</p>
                    </div>
                </div>
                <div class="flex items-center space-x-4">
                    <div class="text-right">
                        <p class="text-sm font-semibold text-gray-800">Dr. <%= user.getFirstName() %> <%= user.getLastName() %></p>
                        <p class="text-xs text-green-600">General Practitioner</p>
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
                        <p class="text-gray-500 text-sm">Waiting Queue</p>
                        <p class="text-3xl font-bold text-green-600">0</p>
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
                        <p class="text-gray-500 text-sm">Today's Consultations</p>
                        <p class="text-3xl font-bold text-blue-600">0</p>
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
                        <p class="text-gray-500 text-sm">Pending Referrals</p>
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
                        <p class="text-gray-500 text-sm">Base Fee (DH)</p>
                        <p class="text-3xl font-bold text-purple-600">150</p>
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
            <!-- Patient Queue -->
            <div class="lg:col-span-1">
                <div class="bg-white rounded-xl shadow-md p-6 sticky top-4">
                    <h2 class="text-xl font-bold text-gray-800 mb-4 flex items-center">
                        <svg class="w-5 h-5 mr-2 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"/>
                        </svg>
                        Patient Queue
                    </h2>

                    <div class="space-y-3 max-h-[600px] overflow-y-auto">
                        <div class="text-center py-8 text-gray-500">
                            <svg class="w-16 h-16 mx-auto mb-3 text-gray-300" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z"/>
                            </svg>
                            <p class="text-sm">No patients in queue</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Consultation Panel -->
            <div class="lg:col-span-2 space-y-6">
                <!-- New Consultation Form -->
                <div class="bg-white rounded-xl shadow-md p-6">
                    <h2 class="text-2xl font-bold text-gray-800 mb-6 flex items-center">
                        <svg class="w-6 h-6 mr-2 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                        </svg>
                        New Consultation
                    </h2>

                    <form action="consultation/create" method="post" class="space-y-4">
                        <div>
                            <label class="block text-sm font-semibold text-gray-700 mb-2">Select Patient</label>
                            <select name="patientId" required class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-green-500">
                                <option value="">Choose from queue...</option>
                                <!-- Patients will be loaded dynamically -->
                            </select>
                        </div>

                        <div>
                            <label class="block text-sm font-semibold text-gray-700 mb-2">Chief Complaint</label>
                            <textarea name="complaint" rows="3" required placeholder="Patient's main concern..."
                                      class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-green-500"></textarea>
                        </div>

                        <div>
                            <label class="block text-sm font-semibold text-gray-700 mb-2">Clinical Examination</label>
                            <textarea name="examination" rows="4" required placeholder="Physical examination findings..."
                                      class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-green-500"></textarea>
                        </div>

                        <div>
                            <label class="block text-sm font-semibold text-gray-700 mb-2">Observations</label>
                            <textarea name="observations" rows="3" placeholder="Additional notes and observations..."
                                      class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-green-500"></textarea>
                        </div>

                        <div class="grid grid-cols-2 gap-4">
                            <button type="submit" name="action" value="direct"
                                    class="bg-gradient-to-r from-green-600 to-emerald-600 text-white font-semibold py-3 rounded-lg hover:from-green-700 hover:to-emerald-700 transition">
                                Diagnose & Prescribe
                            </button>
                            <button type="button" onclick="showReferralModal()"
                                    class="bg-gradient-to-r from-orange-500 to-red-500 text-white font-semibold py-3 rounded-lg hover:from-orange-600 hover:to-red-600 transition">
                                Request Specialist
                            </button>
                        </div>
                    </form>
                </div>

                <!-- Specialist Referral Section (Initially Hidden) -->
                <div id="referralModal" class="hidden bg-white rounded-xl shadow-md p-6 border-2 border-orange-200">
                    <h3 class="text-xl font-bold text-gray-800 mb-4 flex items-center">
                        <svg class="w-5 h-5 mr-2 text-orange-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"/>
                        </svg>
                        Specialist Referral
                    </h3>

                    <form action="consultation/refer" method="post" class="space-y-4">
                        <div>
                            <label class="block text-sm font-semibold text-gray-700 mb-2">Medical Specialty Required</label>
                            <select name="specialty" required onchange="loadSpecialists(this.value)"
                                    class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-orange-500">
                                <option value="">Select specialty...</option>
                                <option value="CARDIOLOGY">Cardiology - Heart and blood vessels</option>
                                <option value="PNEUMOLOGY">Pneumology - Respiratory system</option>
                                <option value="NEUROLOGY">Neurology - Nervous system</option>
                                <option value="GASTROENTEROLOGY">Gastroenterology - Digestive system</option>
                                <option value="ENDOCRINOLOGY">Endocrinology - Hormonal disorders</option>
                                <option value="DERMATOLOGY">Dermatology - Skin diseases</option>
                                <option value="RHEUMATOLOGY">Rheumatology - Joints and bones</option>
                                <option value="PSYCHIATRY">Psychiatry - Mental health</option>
                                <option value="NEPHROLOGY">Nephrology - Kidney diseases</option>
                                <option value="ORTHOPEDICS">Orthopedics - Bone trauma</option>
                            </select>
                        </div>

                        <div id="specialistList" class="hidden">
                            <label class="block text-sm font-semibold text-gray-700 mb-2">Available Specialists</label>
                            <div class="space-y-2 max-h-48 overflow-y-auto border rounded-lg p-3">
                                <!-- Specialists will be loaded dynamically -->
                                <p class="text-sm text-gray-500">Select a specialty to view available specialists</p>
                            </div>
                        </div>

                        <div>
                            <label class="block text-sm font-semibold text-gray-700 mb-2">Priority Level</label>
                            <select name="priority" required class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-orange-500">
                                <option value="NORMAL">Normal</option>
                                <option value="URGENT">Urgent</option>
                                <option value="CRITICAL">Critical</option>
                            </select>
                        </div>

                        <div>
                            <label class="block text-sm font-semibold text-gray-700 mb-2">Question for Specialist</label>
                            <textarea name="question" rows="3" required placeholder="Describe the clinical question..."
                                      class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-orange-500"></textarea>
                        </div>

                        <div class="grid grid-cols-2 gap-4">
                            <button type="button" onclick="hideReferralModal()"
                                    class="border-2 border-gray-300 text-gray-700 font-semibold py-3 rounded-lg hover:bg-gray-100 transition">
                                Cancel
                            </button>
                            <button type="submit"
                                    class="bg-gradient-to-r from-orange-500 to-red-500 text-white font-semibold py-3 rounded-lg hover:from-orange-600 hover:to-red-600 transition">
                                Send Referral
                            </button>
                        </div>
                    </form>
                </div>

                <!-- Active Consultations -->
                <div class="bg-white rounded-xl shadow-md p-6">
                    <h2 class="text-xl font-bold text-gray-800 mb-4 flex items-center justify-between">
                        <span class="flex items-center">
                            <svg class="w-5 h-5 mr-2 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2"/>
                            </svg>
                            Active Consultations
                        </span>
                        <span class="text-sm bg-green-100 text-green-700 px-3 py-1 rounded-full">0 Active</span>
                    </h2>

                    <div class="text-center py-8 text-gray-500">
                        <svg class="w-16 h-16 mx-auto mb-3 text-gray-300" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                        </svg>
                        <p class="text-sm">No active consultations</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        function showReferralModal() {
            document.getElementById('referralModal').classList.remove('hidden');
            document.getElementById('referralModal').scrollIntoView({ behavior: 'smooth' });
        }

        function hideReferralModal() {
            document.getElementById('referralModal').classList.add('hidden');
        }

        function loadSpecialists(specialty) {
            const listDiv = document.getElementById('specialistList');
            if (specialty) {
                listDiv.classList.remove('hidden');
                // In production, this would load specialists via AJAX
            } else {
                listDiv.classList.add('hidden');
            }
        }
    </script>
</body>
</html>