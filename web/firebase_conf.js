function initFirebase() {
    var firebaseConfig = {
        apiKey: "AIzaSyA-T2mem4_Wi3VneSFBEHZqLxpvukBrEJM",
        authDomain: "mi-libro-vecino-dev.firebaseapp.com",
        projectId: "mi-libro-vecino-dev",
        storageBucket: "mi-libro-vecino-dev.appspot.com",
        messagingSenderId: "473660728666",
        appId: "1:473660728666:web:e5b5f7f76698c38997ff63",
        measurementId: "G-881XWYQWWR",
    };

    // Initialize Firebase
    firebase.initializeApp(firebaseConfig);
}