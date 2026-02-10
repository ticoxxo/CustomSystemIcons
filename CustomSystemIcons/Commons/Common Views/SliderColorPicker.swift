//
//  SliderColorPicker.swift
//  MochicCraft
//
//  Created by Alberto Almeida on 09/02/26.
//

import SwiftUI

/// A custom color picker using sliders for color component adjustment.
///
/// This view provides two modes:
/// - RGB: Red, Green, Blue sliders (0-255)
/// - HSB: Hue, Saturation, Brightness sliders
struct SliderColorPicker: View {
    @Binding var selectedColor: Color
    
    enum ColorMode {
        case rgb
        case hsb
    }
    
    @State private var mode: ColorMode = .rgb
    
    // RGB Components (0-255)
    @State private var red: Double = 0
    @State private var green: Double = 0
    @State private var blue: Double = 0
    
    // HSB Components
    @State private var hue: Double = 0
    @State private var saturation: Double = 1
    @State private var brightness: Double = 1
    
    // Opacity
    @State private var opacity: Double = 1
    
    var body: some View {
        VStack(spacing: 20) {
            // Color Preview
            RoundedRectangle(cornerRadius: 12)
                .fill(selectedColor)
                .frame(height: 100)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
            
            // Mode Picker
            Picker("Color Mode", selection: $mode) {
                Text("RGB").tag(ColorMode.rgb)
                Text("HSB").tag(ColorMode.hsb)
            }
            .pickerStyle(.segmented)
            
            // Sliders based on mode
            if mode == .rgb {
                rgbSliders
            } else {
                hsbSliders
            }
            
            // Opacity Slider
            opacitySlider
        }
        .padding()
        .onAppear {
            let components = UIColor(selectedColor).rgbaComponents
            red = components.red * 255
            green = components.green * 255
            blue = components.blue * 255
            opacity = components.alpha
            
            updateHSBFromRGB()
        }
    }
    
    // MARK: - RGB Sliders
    
    private var rgbSliders: some View {
        VStack(spacing: 16) {
            // Red Slider
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("Red")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Spacer()
                    Text("\(Int(red))")
                        .font(.subheadline)
                        .monospacedDigit()
                        .foregroundColor(.secondary)
                }
                
                Slider(value: $red, in: 0...255, step: 1)
                    .tint(.red)
                    .onChange(of: red) { _, _ in
                        updateColorFromRGB()
                        updateHSBFromRGB()
                    }
            }
            
            // Green Slider
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("Green")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Spacer()
                    Text("\(Int(green))")
                        .font(.subheadline)
                        .monospacedDigit()
                        .foregroundColor(.secondary)
                }
                
                Slider(value: $green, in: 0...255, step: 1)
                    .tint(.green)
                    .onChange(of: green) { _, _ in
                        updateColorFromRGB()
                        updateHSBFromRGB()
                    }
            }
            
            // Blue Slider
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("Blue")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Spacer()
                    Text("\(Int(blue))")
                        .font(.subheadline)
                        .monospacedDigit()
                        .foregroundColor(.secondary)
                }
                
                Slider(value: $blue, in: 0...255, step: 1)
                    .tint(.blue)
                    .onChange(of: blue) { _, _ in
                        updateColorFromRGB()
                        updateHSBFromRGB()
                    }
            }
        }
    }
    
    // MARK: - HSB Sliders
    
    private var hsbSliders: some View {
        VStack(spacing: 16) {
            // Hue Slider
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("Hue")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Spacer()
                    Text("\(Int(hue * 360))°")
                        .font(.subheadline)
                        .monospacedDigit()
                        .foregroundColor(.secondary)
                }
                
                Slider(value: $hue, in: 0...1)
                    .tint(
                        LinearGradient(
                            colors: [.red, .yellow, .green, .cyan, .blue, MyColor.magenta.value, .red],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .onChange(of: hue) { _, _ in
                        updateColorFromHSB()
                        updateRGBFromHSB()
                    }
            }
            
            // Saturation Slider
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("Saturation")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Spacer()
                    Text("\(Int(saturation * 100))%")
                        .font(.subheadline)
                        .monospacedDigit()
                        .foregroundColor(.secondary)
                }
                
                Slider(value: $saturation, in: 0...1)
                    .tint(
                        LinearGradient(
                            colors: [
                                Color(hue: hue, saturation: 0, brightness: brightness),
                                Color(hue: hue, saturation: 1, brightness: brightness)
                            ],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .onChange(of: saturation) { _, _ in
                        updateColorFromHSB()
                        updateRGBFromHSB()
                    }
            }
            
            // Brightness Slider
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("Brightness")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Spacer()
                    Text("\(Int(brightness * 100))%")
                        .font(.subheadline)
                        .monospacedDigit()
                        .foregroundColor(.secondary)
                }
                
                Slider(value: $brightness, in: 0...1)
                    .tint(
                        LinearGradient(
                            colors: [
                                Color(hue: hue, saturation: saturation, brightness: 0),
                                Color(hue: hue, saturation: saturation, brightness: 1)
                            ],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .onChange(of: brightness) { _, _ in
                        updateColorFromHSB()
                        updateRGBFromHSB()
                    }
            }
        }
    }
    
    // MARK: - Opacity Slider
    
    private var opacitySlider: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("Opacity")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Spacer()
                Text("\(Int(opacity * 100))%")
                    .font(.subheadline)
                    .monospacedDigit()
                    .foregroundColor(.secondary)
            }
            
            Slider(value: $opacity, in: 0...1)
                .tint(.gray)
                .onChange(of: opacity) { _, _ in
                    if mode == .rgb {
                        updateColorFromRGB()
                    } else {
                        updateColorFromHSB()
                    }
                }
        }
    }
    
    // MARK: - Color Update Functions
    
    private func updateColorFromRGB() {
        selectedColor = Color(
            red: red / 255,
            green: green / 255,
            blue: blue / 255,
            opacity: opacity
        )
    }
    
    private func updateColorFromHSB() {
        selectedColor = Color(
            hue: hue,
            saturation: saturation,
            brightness: brightness,
            opacity: opacity
        )
    }
    
    private func updateHSBFromRGB() {
        let color = UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: opacity)
        var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        color.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        hue = h
        saturation = s
        brightness = b
    }
    
    private func updateRGBFromHSB() {
        let color = UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: opacity)
        let components = color.rgbaComponents
        red = components.red * 255
        green = components.green * 255
        blue = components.blue * 255
    }
}

// MARK: - UIColor Extension

extension UIColor {
    var rgbaComponents: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        return (r, g, b, a)
    }
}

// MARK: - Compact Version

struct CompactSliderColorPicker: View {
    @Binding var selectedColor: Color
    @State private var red: Double = 0
    @State private var green: Double = 0
    @State private var blue: Double = 0
    @State private var opacity: Double = 1
    @State private var isUpdatingFromSlider = false
    
    var body: some View {
        HStack(spacing: 16) {
            
            VStack(spacing: 12) {
                sliderRow(label: "R", value: $red, color: .red)
                sliderRow(label: "G", value: $green, color: .green)
                sliderRow(label: "B", value: $blue, color: .blue)
                sliderRow(label: "A", value: $opacity, color: .gray, range: 0...1)
            }
        }
        .padding()
        .onAppear {
            updateSlidersFromColor()
        }
        .onChange(of: selectedColor) { _, newColor in
            // Solo actualizar si el cambio viene del ColorPicker (no de los sliders)
            if !isUpdatingFromSlider {
                updateSlidersFromColor()
            }
        }
    }
    
    private func sliderRow(label: String, value: Binding<Double>, color: Color, range: ClosedRange<Double> = 0...255) -> some View {
        HStack(spacing: 8) {
            Text(label).font(.caption).fontWeight(.medium).foregroundColor(.secondary).frame(width: 15)
            Slider(value: value, in: range, step: range == 0...1 ? 0.01 : 1)
                .tint(color)
                .onChange(of: value.wrappedValue) { _, _ in updateColor() }
            Text(range == 0...1 ? String(format: "%.0f%%", value.wrappedValue * 100) : "\(Int(value.wrappedValue))")
                .font(.caption).monospacedDigit().foregroundColor(.secondary).frame(width: 35, alignment: .trailing)
        }
    }
    
    private func updateColor() {
        isUpdatingFromSlider = true
        selectedColor = Color(red: red / 255, green: green / 255, blue: blue / 255, opacity: opacity)
        isUpdatingFromSlider = false
    }
    
    private func updateSlidersFromColor() {
        let components = UIColor(selectedColor).rgbaComponents
        red = components.red * 255
        green = components.green * 255
        blue = components.blue * 255
        opacity = components.alpha
    }
}

// MARK: - Preview

#Preview("Full") {
    @Previewable @State var color = Color.blue
    SliderColorPicker(selectedColor: $color)
}

#Preview("Compact") {
    @Previewable @State var color = Color.purple
    CompactSliderColorPicker(selectedColor: $color)
}
