<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Telemedical Expertise System</title>
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
    <header class="bg-white shadow-lg sticky top-0 z-50 border-b border-medical-100">
        <div class="container mx-auto px-6 py-5">
            <div class="flex justify-between items-center">
                <div class="flex items-center space-x-4">
                    <div class="relative">
                        <div class="w-14 h-14 bg-gradient-to-br from-medical-500 to-cyan-500 rounded-2xl flex items-center justify-center shadow-lg transform hover:scale-105 transition duration-300">
                            <svg class="w-8 h-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z"/>
                            </svg>
                        </div>
                        <div class="absolute -top-1 -right-1 w-4 h-4 bg-green-400 rounded-full border-2 border-white"></div>
                    </div>
                    <div>
                        <h1 class="text-2xl font-bold bg-gradient-to-r from-medical-700 to-cyan-600 bg-clip-text text-transparent">
                            Telemedical Expertise
                        </h1>
                        <p class="text-xs text-gray-500 font-medium">Healthcare Coordination Platform</p>
                    </div>
                </div>
                <div class="flex items-center space-x-3">
                    <a href="login" class="text-gray-700 hover:text-medical-600 font-semibold px-4 py-2 rounded-lg hover:bg-medical-50 transition duration-300">
                        Sign In
                    </a>
                    <a href="register" class="bg-gradient-to-r from-medical-600 to-cyan-600 text-white px-6 py-2.5 rounded-xl font-semibold hover:from-medical-700 hover:to-cyan-700 transition duration-300 shadow-lg hover:shadow-xl transform hover:scale-105">
                        Get Started
                    </a>
                </div>
            </div>
        </div>
    </header>

    <section class="container mx-auto px-6 py-16">
        <div class="grid grid-cols-1 lg:grid-cols-2 gap-12 items-center max-w-7xl mx-auto">
            <div class="space-y-8">
                <div class="inline-block">
                    <span class="bg-medical-100 text-medical-700 px-4 py-2 rounded-full text-sm font-semibold">
                        ✨ Advanced Healthcare Platform
                    </span>
                </div>
                <h1 class="text-5xl md:text-6xl font-bold text-gray-900 leading-tight">
                    Connecting
                    <span class="block text-transparent bg-clip-text bg-gradient-to-r from-medical-600 to-cyan-600">
                        Healthcare Professionals
                    </span>
                </h1>
                <p class="text-xl text-gray-600 leading-relaxed">
                    Streamline patient care through seamless coordination between nurses, general practitioners, and medical specialists. Optimize diagnosis, treatment, and expertise sharing.
                </p>
                <div class="flex flex-col sm:flex-row gap-4">
                    <a href="register" class="group bg-gradient-to-r from-medical-600 to-cyan-600 text-white px-8 py-4 rounded-xl font-semibold hover:from-medical-700 hover:to-cyan-700 transition duration-300 shadow-xl hover:shadow-2xl transform hover:scale-105 flex items-center justify-center">
                        <span>Get Started Now</span>
                        <svg class="w-5 h-5 ml-2 group-hover:translate-x-1 transition-transform" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 7l5 5m0 0l-5 5m5-5H6"/>
                        </svg>
                    </a>
                    <a href="login" class="border-2 border-medical-600 text-medical-600 px-8 py-4 rounded-xl font-semibold hover:bg-medical-50 transition duration-300 flex items-center justify-center">
                        Sign In
                    </a>
                </div>
                <div class="flex items-center gap-8 pt-4">
                    <div class="flex items-center gap-2">
                        <svg class="w-6 h-6 text-green-500" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/>
                        </svg>
                        <span class="text-gray-600 font-medium">Secure Platform</span>
                    </div>
                    <div class="flex items-center gap-2">
                        <svg class="w-6 h-6 text-green-500" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/>
                        </svg>
                        <span class="text-gray-600 font-medium">Real-time Updates</span>
                    </div>
                </div>
            </div>

            <div class="relative">
                <div class="absolute inset-0 bg-gradient-to-r from-medical-400 to-cyan-400 rounded-3xl transform rotate-3 opacity-20"></div>
                <div class="relative bg-white rounded-3xl shadow-2xl p-2 transform hover:scale-105 transition duration-500">
                    <img src="https://images.unsplash.com/photo-1559839734-2b71ea197ec2?q=80&w=1200&auto=format&fit=crop"
                         alt="Medical Professional"
                         class="rounded-2xl w-full h-auto object-cover"
                         onerror="this.src='https://via.placeholder.com/600x700/0284c7/ffffff?text=Medical+Professional'">
                </div>
                <div class="absolute -bottom-6 -left-6 bg-white rounded-2xl shadow-xl p-4 border-2 border-medical-100">
                    <div class="flex items-center gap-3">
                        <div class="w-12 h-12 bg-gradient-to-br from-green-400 to-emerald-500 rounded-xl flex items-center justify-center">
                            <svg class="w-7 h-7 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                            </svg>
                        </div>
                        <div>
                            <p class="text-2xl font-bold text-gray-900">24/7</p>
                            <p class="text-sm text-gray-600">Available</p>
                        </div>
                    </div>
                </div>
                <div class="absolute -top-6 -right-6 bg-white rounded-2xl shadow-xl p-4 border-2 border-medical-100">
                    <div class="flex items-center gap-3">
                        <div class="w-12 h-12 bg-gradient-to-br from-medical-500 to-cyan-500 rounded-xl flex items-center justify-center">
                            <svg class="w-7 h-7 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z"/>
                            </svg>
                        </div>
                        <div>
                            <p class="text-2xl font-bold text-gray-900">100+</p>
                            <p class="text-sm text-gray-600">Specialists</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="container mx-auto px-6 py-20">
        <div class="text-center mb-16">
            <h2 class="text-4xl font-bold text-gray-900 mb-4">How It Works</h2>
            <p class="text-xl text-gray-600">Three simple steps to better healthcare coordination</p>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-3 gap-8 max-w-6xl mx-auto">
            <div class="group bg-white rounded-3xl shadow-lg hover:shadow-2xl p-8 transition duration-300 transform hover:-translate-y-2 border-2 border-transparent hover:border-blue-200">
                <div class="relative mb-6">
                    <div class="w-20 h-20 bg-gradient-to-br from-blue-500 to-blue-600 rounded-2xl flex items-center justify-center mx-auto shadow-lg group-hover:scale-110 transition duration-300">
                        <svg class="w-10 h-10 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                        </svg>
                    </div>
                    <div class="absolute -top-2 -right-2 w-8 h-8 bg-blue-100 rounded-full flex items-center justify-center">
                        <span class="text-blue-600 font-bold text-sm">1</span>
                    </div>
                </div>
                <h3 class="text-2xl font-bold text-gray-900 mb-3 text-center">Nurses</h3>
                <p class="text-gray-600 mb-6 text-center leading-relaxed">
                    Register patients, record vital signs, and manage the waiting queue efficiently
                </p>
                <div class="space-y-3">
                    <div class="flex items-start gap-3">
                        <svg class="w-5 h-5 text-green-500 mt-0.5 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/>
                        </svg>
                        <span class="text-gray-700">Patient Registration</span>
                    </div>
                    <div class="flex items-start gap-3">
                        <svg class="w-5 h-5 text-green-500 mt-0.5 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/>
                        </svg>
                        <span class="text-gray-700">Vital Signs Tracking</span>
                    </div>
                    <div class="flex items-start gap-3">
                        <svg class="w-5 h-5 text-green-500 mt-0.5 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/>
                        </svg>
                        <span class="text-gray-700">Queue Management</span>
                    </div>
                </div>
            </div>

            <div class="group bg-white rounded-3xl shadow-lg hover:shadow-2xl p-8 transition duration-300 transform hover:-translate-y-2 border-2 border-transparent hover:border-green-200">
                <div class="relative mb-6">
                    <div class="w-20 h-20 bg-gradient-to-br from-green-500 to-green-600 rounded-2xl flex items-center justify-center mx-auto shadow-lg group-hover:scale-110 transition duration-300">
                        <svg class="w-10 h-10 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-6 9l2 2 4-4"/>
                        </svg>
                    </div>
                    <div class="absolute -top-2 -right-2 w-8 h-8 bg-green-100 rounded-full flex items-center justify-center">
                        <span class="text-green-600 font-bold text-sm">2</span>
                    </div>
                </div>
                <h3 class="text-2xl font-bold text-gray-900 mb-3 text-center">General Practitioners</h3>
                <p class="text-gray-600 mb-6 text-center leading-relaxed">
                    Conduct consultations and request specialist expertise when needed
                </p>
                <div class="space-y-3">
                    <div class="flex items-start gap-3">
                        <svg class="w-5 h-5 text-green-500 mt-0.5 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/>
                        </svg>
                        <span class="text-gray-700">Patient Consultations</span>
                    </div>
                    <div class="flex items-start gap-3">
                        <svg class="w-5 h-5 text-green-500 mt-0.5 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/>
                        </svg>
                        <span class="text-gray-700">Specialist Referrals</span>
                    </div>
                    <div class="flex items-start gap-3">
                        <svg class="w-5 h-5 text-green-500 mt-0.5 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/>
                        </svg>
                        <span class="text-gray-700">Diagnosis & Treatment</span>
                    </div>
                </div>
            </div>

            <div class="group bg-white rounded-3xl shadow-lg hover:shadow-2xl p-8 transition duration-300 transform hover:-translate-y-2 border-2 border-transparent hover:border-purple-200">
                <div class="relative mb-6">
                    <div class="w-20 h-20 bg-gradient-to-br from-purple-500 to-purple-600 rounded-2xl flex items-center justify-center mx-auto shadow-lg group-hover:scale-110 transition duration-300">
                        <svg class="w-10 h-10 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z"/>
                        </svg>
                    </div>
                    <div class="absolute -top-2 -right-2 w-8 h-8 bg-purple-100 rounded-full flex items-center justify-center">
                        <span class="text-purple-600 font-bold text-sm">3</span>
                    </div>
                </div>
                <h3 class="text-2xl font-bold text-gray-900 mb-3 text-center">Specialists</h3>
                <p class="text-gray-600 mb-6 text-center leading-relaxed">
                    Provide expert medical opinions and recommendations for complex cases
                </p>
                <div class="space-y-3">
                    <div class="flex items-start gap-3">
                        <svg class="w-5 h-5 text-green-500 mt-0.5 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/>
                        </svg>
                        <span class="text-gray-700">Expert Consultations</span>
                    </div>
                    <div class="flex items-start gap-3">
                        <svg class="w-5 h-5 text-green-500 mt-0.5 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/>
                        </svg>
                        <span class="text-gray-700">Schedule Management</span>
                    </div>
                    <div class="flex items-start gap-3">
                        <svg class="w-5 h-5 text-green-500 mt-0.5 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/>
                        </svg>
                        <span class="text-gray-700">Medical Opinions</span>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="container mx-auto px-6 py-20">
        <div class="bg-gradient-to-br from-medical-50 to-cyan-50 rounded-3xl p-12 border-2 border-medical-100">
            <div class="text-center mb-12">
                <h2 class="text-4xl font-bold text-gray-900 mb-4">Medical Specialties</h2>
                <p class="text-xl text-gray-600">Comprehensive coverage across all major medical fields</p>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-4 gap-6 max-w-5xl mx-auto">
                <div class="bg-white rounded-2xl shadow-lg hover:shadow-xl p-6 transition duration-300 transform hover:-translate-y-1">
                    <div class="w-16 h-16 bg-gradient-to-br from-red-500 to-pink-500 rounded-2xl flex items-center justify-center mx-auto mb-4">
                        <svg class="w-8 h-8 text-white" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M3.172 5.172a4 4 0 015.656 0L10 6.343l1.172-1.171a4 4 0 115.656 5.656L10 17.657l-6.828-6.829a4 4 0 010-5.656z" clip-rule="evenodd"/>
                        </svg>
                    </div>
                    <h3 class="text-lg font-bold text-gray-900 text-center mb-2">Cardiology</h3>
                    <p class="text-sm text-gray-600 text-center">Heart & vascular diseases</p>
                </div>

                <div class="bg-white rounded-2xl shadow-lg hover:shadow-xl p-6 transition duration-300 transform hover:-translate-y-1">
                    <div class="w-16 h-16 bg-gradient-to-br from-blue-500 to-cyan-500 rounded-2xl flex items-center justify-center mx-auto mb-4">
                        <svg class="w-8 h-8 text-white" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M3.172 5.172a4 4 0 015.656 0L10 6.343l1.172-1.171a4 4 0 115.656 5.656L10 17.657l-6.828-6.829a4 4 0 010-5.656z" clip-rule="evenodd"/>
                        </svg>
                    </div>
                    <h3 class="text-lg font-bold text-gray-900 text-center mb-2">Neurology</h3>
                    <p class="text-sm text-gray-600 text-center">Nervous system disorders</p>
                </div>

                <div class="bg-white rounded-2xl shadow-lg hover:shadow-xl p-6 transition duration-300 transform hover:-translate-y-1">
                    <div class="w-16 h-16 bg-gradient-to-br from-purple-500 to-indigo-500 rounded-2xl flex items-center justify-center mx-auto mb-4">
                        <svg class="w-8 h-8 text-white" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M3.172 5.172a4 4 0 015.656 0L10 6.343l1.172-1.171a4 4 0 115.656 5.656L10 17.657l-6.828-6.829a4 4 0 010-5.656z" clip-rule="evenodd"/>
                        </svg>
                    </div>
                    <h3 class="text-lg font-bold text-gray-900 text-center mb-2">Dermatology</h3>
                    <p class="text-sm text-gray-600 text-center">Skin conditions</p>
                </div>

                <div class="bg-gradient-to-br from-medical-500 to-cyan-500 rounded-2xl shadow-lg hover:shadow-xl p-6 transition duration-300 transform hover:-translate-y-1 text-white">
                    <div class="w-16 h-16 bg-white/20 backdrop-blur rounded-2xl flex items-center justify-center mx-auto mb-4">
                        <svg class="w-8 h-8 text-white" fill="currentColor" viewBox="0 0 20 20">
                            <path d="M10 3.5a1.5 1.5 0 013 0V4a1 1 0 001 1h3a1 1 0 011 1v3a1 1 0 01-1 1h-.5a1.5 1.5 0 000 3h.5a1 1 0 011 1v3a1 1 0 01-1 1h-3a1 1 0 01-1-1v-.5a1.5 1.5 0 00-3 0v.5a1 1 0 01-1 1H6a1 1 0 01-1-1v-3a1 1 0 00-1-1h-.5a1.5 1.5 0 010-3H4a1 1 0 001-1V6a1 1 0 011-1h3a1 1 0 001-1v-.5z"/>
                        </svg>
                    </div>
                    <h3 class="text-lg font-bold text-center mb-2">+7 More</h3>
                    <p class="text-sm text-center opacity-90">Comprehensive specialty coverage</p>
                </div>
            </div>
        </div>
    </section>

    <footer class="bg-gray-900 text-white py-12 mt-20">
        <div class="container mx-auto px-6">
            <div class="flex flex-col md:flex-row justify-between items-center">
                <div class="mb-6 md:mb-0">
                    <div class="flex items-center space-x-3 mb-3">
                        <div class="w-10 h-10 bg-gradient-to-br from-medical-500 to-cyan-500 rounded-xl flex items-center justify-center">
                            <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z"/>
                            </svg>
                        </div>
                        <span class="text-xl font-bold">Telemedical Expertise</span>
                    </div>
                    <p class="text-gray-400 text-sm">Optimizing patient care through coordination</p>
                </div>
                <div class="text-center md:text-right">
                    <p class="text-gray-400 text-sm">&copy; 2025 Telemedical Expertise System. All rights reserved.</p>
                </div>
            </div>
        </div>
    </footer>
</body>
</html>

