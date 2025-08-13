import SwiftUI

struct ContentView: View {
    @State private var counter = 0
    @State private var inputText = ""
    @State private var displayText = "输入的文本将显示在这里"
    @State private var backgroundColor = Color(.systemBackground)
    @State private var isAnimating = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("SwiftUI 演示")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.primary)
                
                // 计数器部分
                VStack(spacing: 15) {
                    Text("计数器: \(counter)")
                        .font(.title2)
                        .bold()
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .scaleEffect(isAnimating ? 1.1 : 1.0)
                        .animation(.spring(response: 0.3), value: counter)
                    
                    HStack(spacing: 20) {
                        Button("增加") {
                            withAnimation(.spring()) {
                                counter += 1
                                triggerAnimation()
                            }
                        }
                        .buttonStyle(CustomButtonStyle(color: .blue))
                        
                        Button("减少") {
                            withAnimation(.spring()) {
                                counter -= 1
                                triggerAnimation()
                            }
                        }
                        .buttonStyle(CustomButtonStyle(color: .red))
                    }
                }
                
                // 文本输入部分
                VStack(spacing: 15) {
                    TextField("请输入文本...", text: $inputText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .font(.system(size: 16))
                    
                    Button("提交文本") {
                        withAnimation(.easeInOut) {
                            if inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                                displayText = "请输入一些文本"
                            } else {
                                displayText = "您输入的文本是：\n\(inputText)"
                            }
                        }
                        hideKeyboard()
                    }
                    .buttonStyle(CustomButtonStyle(color: .green))
                    
                    Text(displayText)
                        .font(.system(size: 16))
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(maxWidth: .infinity, minHeight: 60)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .animation(.easeInOut, value: displayText)
                }
                
                // 颜色和动画部分
                VStack(spacing: 15) {
                    Button("切换背景颜色") {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            backgroundColor = [
                                Color(.systemBackground),
                                Color(.systemGray6),
                                Color.blue.opacity(0.1),
                                Color.green.opacity(0.1),
                                Color.purple.opacity(0.1)
                            ].randomElement() ?? Color(.systemBackground)
                        }
                    }
                    .buttonStyle(CustomButtonStyle(color: .purple))
                    
                    Button("动画效果") {
                        withAnimation(.spring(response: 0.6, dampingFraction: 0.3)) {
                            isAnimating.toggle()
                        }
                    }
                    .buttonStyle(CustomButtonStyle(color: .orange))
                }
                
                // SwiftUI特性展示
                VStack(spacing: 15) {
                    Text("SwiftUI 特性")
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 10) {
                        FeatureCard(title: "声明式UI", icon: "doc.text", color: .blue)
                        FeatureCard(title: "响应式更新", icon: "arrow.triangle.2.circlepath", color: .green)
                        FeatureCard(title: "现代Swift", icon: "swift", color: .orange)
                        FeatureCard(title: "跨平台", icon: "laptopcomputer.and.iphone", color: .purple)
                    }
                }
                
                Spacer(minLength: 20)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
        }
        .background(backgroundColor)
        .onTapGesture {
            hideKeyboard()
        }
    }
    
    private func triggerAnimation() {
        isAnimating = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            isAnimating = false
        }
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct CustomButtonStyle: ButtonStyle {
    let color: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 16, weight: .semibold))
            .foregroundColor(.white)
            .padding(.vertical, 12)
            .padding(.horizontal, 24)
            .frame(maxWidth: .infinity)
            .background(color)
            .cornerRadius(8)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

struct FeatureCard: View {
    let title: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
            
            Text(title)
                .font(.caption)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 80)
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(color.opacity(0.3), lineWidth: 1)
        )
    }
}

#Preview {
    ContentView()
}