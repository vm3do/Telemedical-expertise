<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Telemedical Expertise</title>
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
<body class="bg-gradient-to-br from-medical-50 via-blue-50 to-cyan-50 min-h-screen">
    <div class="container mx-auto px-4 py-8">
        <div class="text-center mb-8">
            <a href="index.jsp" class="inline-flex items-center justify-center w-20 h-20 bg-gradient-to-br from-medical-500 to-cyan-500 rounded-2xl mb-4 shadow-lg hover:scale-105 transition duration-300">
                <svg class="w-10 h-10 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                </svg>
            </a>
            <h1 class="text-4xl font-bold bg-gradient-to-r from-medical-700 to-cyan-600 bg-clip-text text-transparent mb-2">Telemedical Expertise</h1>
            <p class="text-gray-600">Join our healthcare platform</p>
        </div>

        <div class="max-w-2xl mx-auto bg-white rounded-2xl shadow-xl p-8">
            <h2 class="text-3xl font-bold text-gray-800 mb-2">Create Account</h2>
            <p class="text-gray-600 mb-6">Register to access the telemedical system</p>

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
            
            <form action="register" method="post" class="space-y-6">
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div>
                        <label for="firstName" class="block text-sm font-semibold text-gray-700 mb-2">
                            First Name <span class="text-red-500">*</span>
                        </label>
                        <input type="text" id="firstName" name="firstName" required
                               class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-medical-500 focus:border-medical-500 transition">
                    </div>
                    <div>
                        <label for="lastName" class="block text-sm font-semibold text-gray-700 mb-2">
                            Last Name <span class="text-red-500">*</span>
                        </label>
                        <input type="text" id="lastName" name="lastName" required
                               class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-medical-500 focus:border-medical-500 transition">
                    </div>
                </div>
                
                <div>
                    <label for="email" class="block text-sm font-semibold text-gray-700 mb-2">
                        Email Address <span class="text-red-500">*</span>
                    </label>
                    <div class="relative">
                        <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                            <svg class="h-5 w-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 12a4 4 0 10-8 0 4 4 0 008 0zm0 0v1.5a2.5 2.5 0 005 0V12a9 9 0 10-9 9m4.5-1.206a8.959 8.959 0 01-4.5 1.207"/>
                            </svg>
                        </div>
                        <input type="email" id="email" name="email" required
                               class="w-full pl-10 pr-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-medical-500 focus:border-medical-500 transition">
                    </div>
                </div>
                
                <div>
                    <label for="password" class="block text-sm font-semibold text-gray-700 mb-2">
                        Password <span class="text-red-500">*</span>
                    </label>
                    <div class="relative">
                        <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                            <svg class="h-5 w-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"/>
                        </div>
                        <input type="password" id="password" name="password" required minlength="6"
                               class="w-full pl-10 pr-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-medical-500 focus:border-medical-500 transition">
                    </div>
                    <p class="mt-1 text-sm text-gray-500">Minimum 6 characters</p>
                </div>

                <div>
                    <label for="role" class="block text-sm font-semibold text-gray-700 mb-2">
                        Professional Role <span class="text-red-500">*</span>
                    </label>
                    <select id="role" name="role" required onchange="toggleSpecialtyField()"
                            class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-medical-500 focus:border-medical-500 transition">
                        <option value="">Select your role</option>
                        <option value="NURSE">Nurse</option>
                        <option value="GENERAL_PRACTITIONER">General Practitioner</option>
                        <option value="SPECIALIST">Specialist</option>
                    </select>
                </div>
                
                <div id="specialtyField" class="hidden">
                    <label for="specialty" class="block text-sm font-semibold text-gray-700 mb-2">
                        Medical Specialty <span class="text-red-500">*</span>
                    </label>
                    <select id="specialty" name="specialty"
                            class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-medical-500 focus:border-medical-500 transition">
                        <option value="">Select your specialty</option>
                        <option value="CARDIOLOGY">Cardiology - Heart and blood vessel diseases</option>
                        <option value="PNEUMOLOGY">Pneumology - Respiratory and pulmonary diseases</option>
                        <option value="NEUROLOGY">Neurology - Nervous system disorders</option>
                        <option value="GASTROENTEROLOGY">Gastroenterology - Digestive system diseases</option>
                        <option value="ENDOCRINOLOGY">Endocrinology - Hormonal and metabolic disorders</option>
                        <option value="DERMATOLOGY">Dermatology - Skin diseases</option>
                        <option value="RHEUMATOLOGY">Rheumatology - Joint, bone and muscle diseases</option>
                        <option value="PSYCHIATRY">Psychiatry - Mental and psychological disorders</option>
                        <option value="NEPHROLOGY">Nephrology - Kidney diseases</option>
                        <option value="ORTHOPEDICS">Orthopedics - Bone, joint and muscle trauma</option>
                    </select>
                </div>

                <button type="submit"
                        class="w-full bg-gradient-to-r from-medical-600 to-cyan-600 text-white font-semibold py-3 px-6 rounded-lg hover:from-medical-700 hover:to-cyan-700 focus:outline-none focus:ring-2 focus:ring-medical-500 focus:ring-offset-2 transition transform hover:scale-[1.02]">
                    Create Account
                </button>
            </form>
            
            <div class="mt-6 text-center">
                <p class="text-gray-600">
                    Already have an account?
                    <a href="login" class="text-medical-600 font-semibold hover:text-medical-700 transition">Sign in</a>
                </p>
            </div>
        </div>
    </div>

    <script>
        function toggleSpecialtyField() {
            const role = document.getElementById('role').value;
            const specialtyField = document.getElementById('specialtyField');
            const specialtySelect = document.getElementById('specialty');

            if (role === 'SPECIALIST') {
                specialtyField.classList.remove('hidden');
                specialtySelect.required = true;
            } else {
                specialtyField.classList.add('hidden');
                specialtySelect.required = false;
                specialtySelect.value = '';
            }
        }
    </script>
</body>
</html>