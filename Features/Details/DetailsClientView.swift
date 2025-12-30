//
//  Cliente.swift
//  MiTiendita
//
//  Created by luisr on 06/12/25.
//

import SwiftUI


struct ClienteDetalleView: View {
    @State private var cliente: Persona
    @State private var isEditMode = false
    @State private var mostrarNuevoPrestamo = false
    @State private var showDeleteConfirmation = false
    @Environment(\.dismiss) private var dismiss
    
    // Estados para edición
    @State private var editNombre: String
    @State private var editTelefono: String
    @State private var editDireccion: String
    @State private var editCorreo: String
    @State private var editLimiteCredito: String
    
    init(cliente: Persona) {
        _cliente = State(initialValue: cliente)
        _editNombre = State(initialValue: cliente.nombreCompleto)
        _editTelefono = State(initialValue: cliente.telefono)
        _editDireccion = State(initialValue: cliente.direccion)
        _editCorreo = State(initialValue: cliente.correo)
        _editLimiteCredito = State(initialValue: String(cliente.limiteCredito))
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Header con foto
                headerSection
                
                // Información personal
                informacionPersonalSection
                
                // Información de crédito
                creditoSection
                
                // Préstamos
                prestamosSection
                
                // Botón eliminar (solo en modo edición)
                if isEditMode {
                    deleteButton
                }
                
                Spacer(minLength: 100)
            }
            .padding(.vertical)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle(isEditMode ? "Editar Cliente" : cliente.nombreCompleto)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(isEditMode ? "Guardar" : "Editar") {
                    if isEditMode {
                        saveChanges()
                    } else {
                        isEditMode = true
                    }
                }
            }
            
            if isEditMode {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancelar") {
                        cancelChanges()
                    }
                }
            }
        }
        .alert("¿Eliminar cliente?", isPresented: $showDeleteConfirmation) {
            Button("Cancelar", role: .cancel) {}
            Button("Eliminar", role: .destructive) {
                deleteCliente()
            }
        } message: {
            Text("Esta acción no se puede deshacer")
        }
        //.sheet(isPresented: $mostrarNuevoPrestamo) {
          //  NuevoPrestamoView(cliente: cliente)
       // }
    }
    
    // MARK: - Header Section
    
    private var headerSection: some View {
        VStack(spacing: 16) {
            // Foto del cliente
            ZStack(alignment: .bottomTrailing) {
                if let fotoData = cliente.fotoPersonaURL,
                   let uiImage = UIImage(data: fotoData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(Color.blue, lineWidth: 3)
                        )
                } else {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .foregroundColor(.gray)
                        .frame(width: 120, height: 120)
                }
                
                // Indicador de préstamo activo
                if cliente.prestamoActivo == true {
                    Circle()
                        .fill(Color.red)
                        .frame(width: 20, height: 20)
                        .overlay(
                            Circle()
                                .stroke(Color.white, lineWidth: 2)
                        )
                        .offset(x: -5, y: -5)
                }
            }
            
            if !isEditMode {
                // Nombre (solo en modo lectura)
                Text(cliente.nombreCompleto)
                    .font(.title2.bold())
                
                // Estado del préstamo
                if cliente.prestamoActivo == true {
                    HStack {
                        Image(systemName: "exclamationmark.circle.fill")
                            .foregroundColor(.orange)
                        Text("Préstamo activo")
                            .font(.subheadline)
                            .foregroundColor(.orange)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color.orange.opacity(0.1))
                    .cornerRadius(20)
                }
            }
        }
        .padding(.horizontal)
    }
    
    // MARK: - Información Personal Section
    
    private var informacionPersonalSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            SectionHeader(title: "Información Personal", icon: "person.fill")
            
            if isEditMode {
                // Modo edición
                VStack(spacing: 12) {
                    EditableField(
                        label: "Nombre Completo",
                        text: $editNombre,
                        icon: "person.fill"
                    )
                    
                    EditableField(
                        label: "Teléfono",
                        text: $editTelefono,
                        icon: "phone.fill",
                        keyboard: .phonePad
                    )
                    
                    EditableField(
                        label: "Correo",
                        text: $editCorreo,
                        icon: "envelope.fill",
                        keyboard: .emailAddress
                    )
                    
                    EditableField(
                        label: "Dirección",
                        text: $editDireccion,
                        icon: "mappin.and.ellipse"
                    )
                }
            } else {
                // Modo lectura
                VStack(spacing: 12) {
                    DetailRow(
                        icon: "person.fill",
                        label: "Nombre",
                        value: cliente.nombreCompleto
                    )
                    
                    DetailRow(
                        icon: "phone.fill",
                        label: "Teléfono",
                        value: cliente.telefono,
                        isLink: true
                    )
                    
                    DetailRow(
                        icon: "envelope.fill",
                        label: "Correo",
                        value: cliente.correo.isEmpty ? "No especificado" : cliente.correo,
                        isLink: !cliente.correo.isEmpty
                    )
                    
                    DetailRow(
                        icon: "mappin.and.ellipse",
                        label: "Dirección",
                        value: cliente.direccion.isEmpty ? "No especificada" : cliente.direccion
                    )
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
        .padding(.horizontal)
    }
    
    // MARK: - Crédito Section
    
    private var creditoSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            SectionHeader(title: "Información de Crédito", icon: "creditcard.fill")
            
            if isEditMode {
                EditableField(
                    label: "Límite de Crédito",
                    text: $editLimiteCredito,
                    icon: "dollarsign.circle.fill",
                    keyboard: .decimalPad
                )
            } else {
                VStack(spacing: 12) {
                    DetailRow(
                        icon: "dollarsign.circle.fill",
                        label: "Límite de Crédito",
                        value: "$\(cliente.limiteCredito)"
                    )
                    
                    if let montoActual = cliente.montoPrestamoActual, montoActual > 0 {
                        DetailRow(
                            icon: "banknote.fill",
                            label: "Préstamo Actual",
                            value: "$\(montoActual)"
                        )
                        
                        // Barra de progreso
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Crédito Utilizado")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            GeometryReader { geometry in
                                ZStack(alignment: .leading) {
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(Color.gray.opacity(0.2))
                                        .frame(height: 8)
                                    
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(progressColor)
                                        .frame(
                                            width: geometry.size.width * min(montoActual / cliente.limiteCredito, 1.0),
                                            height: 8
                                        )
                                }
                            }
                            .frame(height: 8)
                            
                            HStack {
                                Text("\(Int((montoActual / cliente.limiteCredito) * 100))% utilizado")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Spacer()
                                Text("Disponible: $\(cliente.limiteCredito - montoActual, specifier: "%.2f")")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    
                    if let haPagado = cliente.haPagado {
                        DetailRow(
                            icon: haPagado ? "checkmark.circle.fill" : "clock.fill",
                            label: "Estado",
                            value: haPagado ? "Pagado" : "Pendiente",
                            valueColor: haPagado ? .green : .orange
                        )
                    }
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
        .padding(.horizontal)
    }
    
    // MARK: - Préstamos Section
    
    private var prestamosSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                HStack {
                    Image(systemName: "list.bullet.circle.fill")
                        .foregroundColor(.blue)
                    Text("Préstamos")
                        .font(.headline)
                }
                
                Spacer()
                
                if !(cliente.haPagado ?? false) {
                    Button(action: { mostrarNuevoPrestamo = true }) {
                        HStack(spacing: 4) {
                            Image(systemName: "plus.circle.fill")
                           Text("Nueva")
                                
                        }
                        .font(.subheadline.weight(.semibold))
                        .disabled(true)
                    }
                }
            }
            
            if cliente.prestamoActivo == true {
                PrestamoActiveCard(cliente: cliente)
            } else {
                //EmptyPrestamoView()
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
        .padding(.horizontal)
    }
    
    // MARK: - Delete Button
    
    private var deleteButton: some View {
        Button(action: {
            showDeleteConfirmation = true
        }) {
            HStack {
                Image(systemName: "trash.fill")
                Text("Eliminar Cliente")
            }
            .font(.headline)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.red)
            .cornerRadius(12)
        }
        .padding(.horizontal)
        .padding(.top, 20)
    }
    
    // MARK: - Computed Properties
    
    private var progressColor: Color {
        guard let montoActual = cliente.montoPrestamoActual else { return .blue }
        let percentage = montoActual / cliente.limiteCredito
        
        if percentage >= 0.9 {
            return .red
        } else if percentage >= 0.7 {
            return .orange
        } else {
            return .green
        }
    }
    
    // MARK: - Actions
    
    private func saveChanges() {
        // Validar
        guard !editNombre.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        
        // Actualizar cliente
        cliente.nombreCompleto = editNombre
        cliente.telefono = editTelefono
        cliente.correo = editCorreo
        cliente.direccion = editDireccion
        cliente.limiteCredito = Double(editLimiteCredito) ?? cliente.limiteCredito
        
        // Aquí guardarías en Core Data
        // CoreDataManager.shared.update(cliente)
        
        isEditMode = false
        print("✅ Cliente actualizado")
    }
    
    private func cancelChanges() {
        // Restaurar valores originales
        editNombre = cliente.nombreCompleto
        editTelefono = cliente.telefono
        editDireccion = cliente.direccion
        editCorreo = cliente.correo
        editLimiteCredito = String(cliente.limiteCredito)
        
        isEditMode = false
    }
    
    private func deleteCliente() {
        // Aquí eliminarías en Core Data
        // CoreDataManager.shared.delete(cliente)
        dismiss()
    }
}

// MARK: - Supporting Views

struct SectionHeader: View {
    let title: String
    let icon: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.blue)
            Text(title)
                .font(.headline)
        }
    }
}

struct DetailRow: View {
    let icon: String
    let label: String
    let value: String
    var isLink: Bool = false
    var valueColor: Color = .primary
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.gray)
                .frame(width: 20)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(label)
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                if isLink {
                    Button(action: {
                        // Acción de link (llamar, email)
                        if label == "Teléfono", let url = URL(string: "tel://\(value)") {
                            UIApplication.shared.open(url)
                        } else if label == "Correo", let url = URL(string: "mailto:\(value)") {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        Text(value)
                            .font(.body)
                            .foregroundColor(.blue)
                            .underline()
                    }
                } else {
                    Text(value)
                        .font(.body)
                        .foregroundColor(valueColor)
                }
            }
            
            Spacer()
        }
    }
}

struct EditableField: View {
    let label: String
    @Binding var text: String
    let icon: String
    var keyboard: UIKeyboardType = .default
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)
            
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.gray)
                    .frame(width: 20)
                
                TextField(label, text: $text)
                    .keyboardType(keyboard)
                    .textInputAutocapitalization(keyboard == .emailAddress ? .never : .words)
            }
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(8)
        }
    }
}

struct PrestamoActiveCard: View {
    let cliente: Persona
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Préstamo Activo")
                        .font(.subheadline.bold())
                    Text("$\(cliente.montoPrestamoActual ?? 0, specifier: "%.2f")")
                        .font(.title2.bold())
                        .foregroundColor(.blue)
                }
                
                Spacer()
                
                // Estado
                HStack(spacing: 4) {
                    Image(systemName: cliente.haPagado == true ? "checkmark.circle.fill" : "clock.fill")
                    Text(cliente.haPagado == true ? "Pagado" : "Pendiente")
                        .font(.caption.bold())
                }
                .foregroundColor(cliente.haPagado == true ? .green : .orange)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background((cliente.haPagado == true ? Color.green : Color.orange).opacity(0.1))
                .cornerRadius(12)
            }
            
            Divider()
            
            HStack {
              
                Button(action: {
                    // Registrar pago
                }) {
                    HStack(spacing: 4) {
                        Image(systemName: "plus.circle.fill")
                        Text("Registrar Pago")
                    }
                    .font(.subheadline.bold())
                    .foregroundColor(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color.blue)
                    .cornerRadius(8)
                }
            }
        }
        .padding()
        .background(Color(.tertiarySystemBackground))
        .cornerRadius(8)
    }
}



// MARK: - Preview

#Preview {
    NavigationStack {
        ClienteDetalleView(cliente: Persona(
            id: UUID(),
            nombreCompleto: "Juan Pérez García",
            telefono: "5551234567",
            direccion: "Av. Principal #123, Col. Centro",
            correo: "juan@example.com",
            limiteCredito: 5000,
            fotoPersonaURL: nil,
            fotoINEURL: nil,
            prestamoActivo: true,
            montoPrestamoActual: 3500,
            haPagado: false
        ))
    }
}
