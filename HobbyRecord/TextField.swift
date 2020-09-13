//
//  TextField.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/13.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation
import SwiftUI

final class _TextFieldCoordinator: NSObject {
    var control: _TextField

    init(_ control: _TextField) {
        self.control = control
        super.init()
        control.textField.addTarget(self, action: #selector(textFieldEditingDidBegin(_:)), for: .editingDidBegin)
        control.textField.addTarget(self, action: #selector(textFieldEditingDidEnd(_:)), for: .editingDidEnd)
        control.textField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        control.textField.addTarget(self, action: #selector(textFieldEditingDidEndOnExit(_:)), for: .editingDidEndOnExit)
    }

    @objc private func textFieldEditingDidBegin(_ textField: UITextField) {
        control.onEditingChanged(true)
    }

    @objc private func textFieldEditingDidEnd(_ textField: UITextField) {
        control.onEditingChanged(false)
    }

    @objc private func textFieldEditingChanged(_ textField: UITextField) {
        control.text = textField.text ?? ""
    }

    @objc private func textFieldEditingDidEndOnExit(_ textField: UITextField) {
        control.onCommit()
    }
}

struct _TextField: UIViewRepresentable {

    private let title: String?
    @Binding var text: String
    let onEditingChanged: (Bool) -> Void
    let onCommit: () -> Void

    let textField = UITextField()

    init(title: String?, text: Binding<String>, onEditingChanged: @escaping (Bool) -> Void = { _ in }, onCommit: @escaping () -> Void = {}) {
        self.title = title
        self._text = text
        self.onEditingChanged = onEditingChanged
        self.onCommit = onCommit
    }

    func makeCoordinator() -> _TextFieldCoordinator {
        _TextFieldCoordinator(self)
    }

    func makeUIView(context: Context) -> UITextField {
        textField.placeholder = title
        textField.delegate = context.coordinator as? UITextFieldDelegate
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
    }
}
