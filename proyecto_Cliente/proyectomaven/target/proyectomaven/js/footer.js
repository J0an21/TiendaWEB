class MiFooter extends HTMLElement {
    constructor() {
        super();

        this.innerHTML = `
            <footer class="footer">
                <div class="container">
                    <div>
                        <a href="https://www.instagram.com/" class="me-3"><i class="bi bi-instagram"></i></a>
                        <a href="https://www.twitter.com/" class="me-3"><i class="bi bi-twitter"></i></a>
                        <a href="https://www.facebook.com/"><i class="bi bi-facebook"></i></a>
                    </div>
                    <p class="mt-3">Tienda de Juegos</p>
                </div>
            </footer>
        `;
    }
}
customElements.define("mi-footer", MiFooter);
