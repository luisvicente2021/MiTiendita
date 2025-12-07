import Foundation
import Combine
import Supabase

@MainActor
class LoginViewModel: ObservableObject {
    // MARK: - Propiedades publicadas
    @Published var clientes: [Persona] = []
    @Published var isLoggedIn: Bool = false
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var currentUser: Persona? = nil
    
    // MARK: - Supabase
    private let client: SupabaseClient
    
    // Singleton opcional (para compartir el mismo estado en varias vistas)
    static let shared = LoginViewModel()
    
    // MARK: - Init
    init() {
        self.client = SupabaseClient(
            supabaseURL: URL(string: "https://zuidwmfjesjwamehecgv.supabase.co")!,
            supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inp1aWR3bWZqZXNqd2FtZWhlY2d2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTk5NjU3MDAsImV4cCI6MjA3NTU0MTcwMH0.wRuWuk47fjb8xmljOj9a-Z0r7KhZEjvJPIKItr2LYoY"
        )
    }
    
    // MARK: - Métodos públicos
    
    /// Inicia sesión con Supabase
    func login(email: String, password: String) {
        Task {
            await performLogin(email: email, password: password)
        }
    }
    
    /// Carga clientes desde Supabase
    func fetchClientes() async {
        do {
            let response = try await client
                .from("clientes")
                .select("*")
                .execute()
            
            let data = response.data
            
            // 👀 Debug: imprime lo que llega realmente
            if let jsonString = String(data: data, encoding: .utf8) {
                print("📦 JSON recibido de Supabase:")
                print(jsonString)
            }
            
            let decoder = JSONDecoder()
            let clientes = try decoder.decode([Persona].self, from: data)
            
            DispatchQueue.main.async {
                self.clientes = clientes
            }
            
            print("✅ Clientes decodificados: \(clientes.count)")
            
        } catch {
            print("❌ Error al decodificar clientes:", error)
            DispatchQueue.main.async {
                self.errorMessage = "Error al obtener clientes"
            }
        }
    }
    
    // MARK: - Funciones privadas
    
    private func performLogin(email: String, password: String) async {
        isLoading = true
        errorMessage = nil
        
        do {
            // 🔐 Intentar autenticación
            let _ = try await client.auth.signIn(email: email, password: password)
            
            // ✅ Login exitoso
            isLoggedIn = true
            print("✅ Usuario logueado correctamente.")
            
            // 📦 Traer clientes después del login
            await fetchClientes()
            
        } catch {
            print("❌ Error en login: \(error)")
            errorMessage = "Credenciales inválidas o error de conexión"
            isLoggedIn = false
        }
        
        isLoading = false
    }
}
