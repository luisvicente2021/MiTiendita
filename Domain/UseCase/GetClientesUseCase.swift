struct GetClientesUseCase {
    private let repository: PersonaRepositoryProtocol

    init(repository: PersonaRepositoryProtocol) {
        self.repository = repository
    }

    func execute() async throws -> [Persona] {
        try await repository.fetchClientes()
    }
}
