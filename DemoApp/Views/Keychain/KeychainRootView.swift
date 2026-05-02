//
//  KeychainRootView.swift
//  DemoApp
//
//  Created by 黄磊 on 2026/5/2.
//

import SwiftUI
import KeychainWrapper

private struct TestUser: Codable, Sendable {
    let id: String
    let name: String
}

struct KeychainRootView: View {

    @State private var statusMessage: String = "等待操作..."
    @State private var accountIndex: Int = 1

    private var nextAccount: String { "user\(accountIndex)" }
    private static let passwordChars = Array("abcdefghijklmnopqrstuvwxyz0123456789")
    private func randomPassword() -> String {
        String((0..<8).map { _ in Self.passwordChars.randomElement()! })
    }

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 16) {
                    GroupBox("字符串操作") {
                        VStack(spacing: 8) {
                            Button("保存字符串") {
                                let result = KeychainWrapper.set("hello_keychain", for: "testKey")
                                statusMessage = result ? "✅ 保存成功: \"hello_keychain\" -> testKey" : "❌ 保存失败"
                            }
                            Button("读取字符串") {
                                if let value = KeychainWrapper.string(for: "testKey") {
                                    statusMessage = "✅ 读取成功: \"\(value)\""
                                } else {
                                    statusMessage = "⚠️ 无数据（key: testKey）"
                                }
                            }
                            Button("删除字符串") {
                                KeychainWrapper.delete(valueFor: "testKey")
                                statusMessage = "🗑️ 已删除 testKey"
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }

                    GroupBox("对象操作 (Codable)") {
                        VStack(spacing: 8) {
                            Button("保存对象") {
                                let user = TestUser(id: "42", name: "Tom")
                                let result = KeychainWrapper.set(user, for: "userKey")
                                statusMessage = result ? "✅ 保存成功: TestUser(id: 42, name: Tom)" : "❌ 保存失败"
                            }
                            Button("读取对象") {
                                if let user: TestUser = KeychainWrapper.object(for: "userKey", as: TestUser.self) {
                                    statusMessage = "✅ 读取成功: id=\(user.id), name=\(user.name)"
                                } else {
                                    statusMessage = "⚠️ 无数据（key: userKey）"
                                }
                            }
                            Button("删除对象") {
                                KeychainWrapper.delete(valueFor: "userKey")
                                statusMessage = "🗑️ 已删除 userKey"
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }

                    GroupBox("账号密码") {
                        VStack(spacing: 8) {
                            Button("添加账号") {
                                let account = nextAccount
                                let password = randomPassword()
                                KeychainWrapper.add(account: account, with: password, encryptKey: nil)
                                statusMessage = "✅ 已添加账号: \(account) / \(password)"
                                accountIndex += 1
                            }
                            Button("查询账号列表") {
                                let accounts = KeychainWrapper.accountList(encryptKey: nil)
                                if accounts.isEmpty {
                                    statusMessage = "⚠️ 暂无账号"
                                } else {
                                    statusMessage = "✅ 账号数量: \(accounts.count)，列表: \(accounts.joined(separator: ", "))"
                                }
                            }
                            Button("读取最新账号密码") {
                                let target = "user\(accountIndex - 1)"
                                if accountIndex <= 1 {
                                    statusMessage = "⚠️ 还没有添加过账号"
                                } else if let pwd = KeychainWrapper.password(for: target, encryptKey: nil) {
                                    statusMessage = "✅ \(target) 密码: \(pwd)"
                                } else {
                                    statusMessage = "⚠️ 未找到 \(target) 的密码"
                                }
                            }
                            Button("删除最新账号") {
                                if accountIndex <= 1 {
                                    statusMessage = "⚠️ 还没有添加过账号"
                                    return
                                }
                                let target = "user\(accountIndex - 1)"
                                KeychainWrapper.delete(account: target)
                                statusMessage = "🗑️ 已删除账号 \(target)"
                                accountIndex -= 1
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }

                    GroupBox("清理") {
                        VStack(spacing: 8) {
                            Button("清空普通数据") {
                                KeychainWrapper.wipeDatas()
                                statusMessage = "🗑️ 已清空所有普通数据（不含账号）"
                            }
                            Button("清空账号数据") {
                                KeychainWrapper.wipeAccounts()
                                accountIndex = 1
                                statusMessage = "🗑️ 已清空所有账号数据"
                            }
                            Button("清空所有数据") {
                                KeychainWrapper.wipeAll()
                                accountIndex = 1
                                statusMessage = "🗑️ 已清空所有数据（含账号）"
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                .padding()
            }

            Divider()
            GroupBox {
                Text(statusMessage)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
        }
    }
}

struct KeychainRootView_Previews: PreviewProvider {
    static var previews: some View {
        KeychainRootView()
    }
}
