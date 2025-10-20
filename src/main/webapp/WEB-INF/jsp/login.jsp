<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Telemedical Expertise</title>
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
<body class="bg-gradient-to-br from-medical-50 via-blue-50 to-cyan-50 min-h-screen flex items-center justify-center">
    <div class="container mx-auto px-4 py-8">
        <!-- Header -->
        <div class="text-center mb-8">
            <a href="index.jsp" class="inline-flex items-center justify-center w-20 h-20 bg-gradient-to-br from-medical-500 to-cyan-500 rounded-2xl mb-4 shadow-lg hover:scale-105 transition duration-300">
                <svg class="w-10 h-10 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z"/>
                </svg>
            </a>
            <h1 class="text-4xl font-bold bg-gradient-to-r from-medical-700 to-cyan-600 bg-clip-text text-transparent mb-2">Telemedical Expertise</h1>
            <p class="text-gray-600">Healthcare coordination platform</p>
        </div>

        <!-- Login Form -->
        <div class="max-w-md mx-auto bg-white rounded-2xl shadow-xl p-8">
            <h2 class="text-3xl font-bold text-gray-800 mb-2">Welcome Back</h2>
            <p class="text-gray-600 mb-6">Sign in to access your dashboard</p>

            <% if (request.getAttribute("error") != null) { %>
                <div class="bg-red-50 border-l-4 border-red-500 p-4 mb-6 rounded animate-pulse">
                    <div class="flex items-center">
                        <svg class="w-5 h-5 text-red-500 mr-2" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd"/>
                        </svg>
                        <p class="text-red-700 font-medium"><%= request.getAttribute("error") %></p>
                    </div>
                </div>
            <% } %>
            
            <% if (request.getParameter("success") != null) { %>
                <div class="bg-green-50 border-l-4 border-green-500 p-4 mb-6 rounded">
                    <div class="flex items-center">
                        <svg class="w-5 h-5 text-green-500 mr-2" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/>
                        </svg>
                        <p class="text-green-700 font-medium">Registration successful! Please login.</p>
                    </div>
                </div>
            <% } %>
            
            <form action="login" method="post" class="space-y-6">
                <!-- Email -->
                <div>
                    <label for="email" class="block text-sm font-semibold text-gray-700 mb-2">
                        Email Address
                    </label>
                    <div class="relative">
                        <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                            <svg class="h-5 w-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 12a4 4 0 10-8 0 4 4 0 008 0zm0 0v1.5a2.5 2.5 0 005 0V12a9 9 0 10-9 9m4.5-1.206a8.959 8.959 0 01-4.5 1.207"/>
                        </div>
                        <input type="email" id="email" name="email" required
                               class="w-full pl-10 pr-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-medical-500 focus:border-medical-500 transition"
                               placeholder="your.email@example.com">
                    </div>
                </div>
                
                <!-- Password -->
                <div>
                    <label for="password" class="block text-sm font-semibold text-gray-700 mb-2">
                        Password
                    </label>
                    <div class="relative">
                        <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                            <svg class="h-5 w-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"/>
                        </div>
                        <input type="password" id="password" name="password" required
                               class="w-full pl-10 pr-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-medical-500 focus:border-medical-500 transition"
                               placeholder="Enter your password">
                    </div>
                </div>

                <!-- Submit Button -->
                <button type="submit"
                        class="w-full bg-gradient-to-r from-medical-600 to-cyan-600 text-white font-semibold py-3 px-6 rounded-lg hover:from-medical-700 hover:to-cyan-700 focus:outline-none focus:ring-2 focus:ring-medical-500 focus:ring-offset-2 transition transform hover:scale-[1.02] shadow-lg">
                    <span class="flex items-center justify-center">
                        <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 16l-4-4m0 0l4-4m-4 4h14m-5 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h7a3 3 0 013 3v1"/>
                        </svg>
                        Sign In
                    </span>
                </button>
            </form>
            
            <!-- Footer -->
            <div class="mt-6 text-center">
                <p class="text-gray-600">
                    Don't have an account?
                    <a href="register" class="text-medical-600 font-semibold hover:text-medical-700 transition">Create one</a>
                </p>
            </div>

            <!-- Role Info -->
            <div class="mt-8 pt-6 border-t border-gray-200">
                <p class="text-xs text-gray-500 text-center mb-3">Quick Access for:</p>
                <div class="flex justify-center space-x-4 text-xs">
                    <div class="flex items-center text-gray-600">
                        <span class="w-2 h-2 bg-blue-500 rounded-full mr-1"></span>
                        Nurses
                    </div>
                    <div class="flex items-center text-gray-600">
                        <span class="w-2 h-2 bg-green-500 rounded-full mr-1"></span>
                        Practitioners
                    </div>
                    <div class="flex items-center text-gray-600">
                        <span class="w-2 h-2 bg-purple-500 rounded-full mr-1"></span>
                        Specialists
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>