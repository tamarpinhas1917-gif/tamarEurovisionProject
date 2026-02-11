/**
 * Eurovision User Authentication System
 * Handles user login state across all preview pages
 */

// Initialize user display on page load
function initUserDisplay() {
    const userName = localStorage.getItem('euroUserName');
    const userDisplay = document.getElementById('userDisplay');
    
    if (!userDisplay) return;
    
    if (userName) {
        // User is logged in
        userDisplay.innerHTML = `
            <span class="logout-btn" onclick="euroLogout()">[יציאה]</span>
            שלום, <span style="color: var(--euro-pink);">${userName}</span>
        `;
    } else {
        // User is not logged in
        userDisplay.innerHTML = `<a href="login-preview.html">הרשמה / התחברות</a>`;
    }
}

// Logout function
function euroLogout() {
    if (confirm('האם אתה בטוח שברצונך להתנתק?')) {
        localStorage.removeItem('euroUserName');
        localStorage.removeItem('euroUserEmail');
        location.reload();
    }
}

// Auto-initialize when DOM is ready
if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initUserDisplay);
} else {
    initUserDisplay();
}
