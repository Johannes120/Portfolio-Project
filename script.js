// Contact Form Validation
// This script validates the contact form fields and sends email via EmailJS

(function () {
    'use strict';

    const form = document.getElementById('contactForm');

    if (!form) {
        return; // Exit if form does not exist
    }

    // ✅ 1. Initialize EmailJS (ADD HERE)
    emailjs.init('2b4IRkdEXEiXc0LVD');

    const nameInput = document.getElementById('name');
    const emailInput = document.getElementById('email');
    const messageInput = document.getElementById('message');

    form.addEventListener('submit', function (event) {
        event.preventDefault();

        let isFormValid = true;
        clearErrors();

        // Name validation
        if (nameInput.value.trim() === '') {
            showError(nameInput, 'Please enter your full name.');
            isFormValid = false;
        }

        // Email validation
        if (!isValidEmail(emailInput.value)) {
            showError(emailInput, 'Please enter a valid email address.');
            isFormValid = false;
        }

        // Message validation
        if (messageInput.value.trim().length < 10) {
            showError(messageInput, 'Message must be at least 10 characters long.');
            isFormValid = false;
        }

        // ✅ 2. Send email ONLY if form is valid
        if (isFormValid) {
            emailjs.send(
                'service_rg4183j',
                'template_94hdfn5',
                {
                    name: nameInput.value,
                    email: emailInput.value,
                    message: messageInput.value
                }
            )
            .then(function () {
                alert('Thank you! Your message has been sent successfully.');
                form.reset();
            })
            .catch(function () {
                alert('Sorry, something went wrong. Please try again later.');
            });
        }
    });

    function showError(inputElement, message) {
        const errorMessage = inputElement.parentElement.querySelector('.error-message');
        if (errorMessage) {
            errorMessage.textContent = message;
        }
        inputElement.setAttribute('aria-invalid', 'true');
    }

    function clearErrors() {
        const errorMessages = document.querySelectorAll('.error-message');
        errorMessages.forEach(function (msg) {
            msg.textContent = '';
        });

        const inputs = form.querySelectorAll('input, textarea');
        inputs.forEach(function (input) {
            input.removeAttribute('aria-invalid');
        });
    }

    function isValidEmail(email) {
        const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return emailPattern.test(email.trim());
    }
})();

/* Header: mobile menu toggle + theme toggle (light implementation) */
(function () {
    'use strict';

    const menuToggle = document.getElementById('menuToggle');
    const navLinks = document.getElementById('navLinks');
    const themeToggle = document.getElementById('themeToggle');

    if (menuToggle && navLinks) {
        menuToggle.addEventListener('click', function () {
            const isOpen = navLinks.classList.toggle('open');
            menuToggle.setAttribute('aria-expanded', isOpen);
            // close on outside click
            if (isOpen) {
                setTimeout(() => {
                    const onDocClick = (e) => {
                        if (!navLinks.contains(e.target) && e.target !== menuToggle) {
                            navLinks.classList.remove('open');
                            menuToggle.setAttribute('aria-expanded', 'false');
                            document.removeEventListener('click', onDocClick);
                        }
                    };
                    document.addEventListener('click', onDocClick);
                }, 10);
            }
        });
    }

    if (themeToggle) {
        // initialize from saved preference
        const saved = localStorage.getItem('theme');
        const prefersDark = window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches;
        if (saved) document.documentElement.setAttribute('data-theme', saved);
        else if (prefersDark) document.documentElement.setAttribute('data-theme', 'dark');

        // reflect initial icon
        const current = document.documentElement.getAttribute('data-theme');
        themeToggle.textContent = current === 'dark' ? '☀️' : '🌙';
        themeToggle.setAttribute('aria-pressed', current === 'dark');

        themeToggle.addEventListener('click', function () {
            const now = document.documentElement.getAttribute('data-theme') === 'dark' ? 'light' : 'dark';
            document.documentElement.setAttribute('data-theme', now);
            localStorage.setItem('theme', now);
            themeToggle.textContent = now === 'dark' ? '☀️' : '🌙';
            themeToggle.setAttribute('aria-pressed', now === 'dark');
        });
    }

})();

/* Scroll-direction header behavior: add .solid when scrolling up */
(function () {
    'use strict';

    const header = document.querySelector('.main-header');
    if (!header) return;

    let lastScroll = window.scrollY || 0;
    let ticking = false;

    function onScroll() {
        const current = window.scrollY || 0;

        if (!ticking) {
            window.requestAnimationFrame(() => {
                if (current < lastScroll && current > 30) {
                    // scrolling up and not at very top
                    header.classList.add('solid');
                } else if (current <= 30) {
                    // near top: remove solid
                    header.classList.remove('solid');
                } else if (current > lastScroll) {
                    // scrolling down
                    header.classList.remove('solid');
                }

                lastScroll = current;
                ticking = false;
            });
            ticking = true;
        }
    }

    window.addEventListener('scroll', onScroll, { passive: true });

})();