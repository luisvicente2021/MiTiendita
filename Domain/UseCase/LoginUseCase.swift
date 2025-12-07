struct LoginUseCase {
    private let repository: PersonaRepositoryProtocol

    init(repository: PersonaRepositoryProtocol) {
        self.repository = repository
    }

    func execute(email: String, password: String) async throws {
        try await repository.login(email: email, password: password)
    }
}
