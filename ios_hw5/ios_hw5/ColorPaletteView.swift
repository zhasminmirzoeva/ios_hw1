//
//  ColorPaletteView.swift
//  ios_hw5
//
//  Created by Zhasmin Mirzoeva on 27.11.2022.
//

import UIKit

final class ColorPaletteView :UIControl {
    var delegate: Delegate?
    private let stackView = UIStackView()
    private(set) var chosemColor: UIColor = .systemGray6
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        let redControl = ColorSliderView(
            colorname: "R",
            value: Float(chosemColor.rgba.red))
        let greenControl = ColorSliderView(
            colorname: "G",
            value: Float(chosemColor.rgba.green))
        let blueControl = ColorSliderView(
            colorname: "B",
            value: Float(chosemColor.rgba.blue))
        redControl.tag = 0
        greenControl.tag = 1
        blueControl.tag = 2
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubview(redControl)
        stackView.addArrangedSubview(greenControl)
        stackView.addArrangedSubview(blueControl)
        stackView.backgroundColor = .white
        stackView.layer.cornerRadius = 12
        [redControl, greenControl, blueControl].forEach {
            $0.addTarget(self, action: #selector(sliderMoved(slider:)),
                         for: .touchDragInside)
        }
        addSubview(stackView)
        stackView.pin(to: self, [.left, .right])
    }
    
    @objc
    private func sliderMoved(slider: ColorSliderView) {
        switch slider.tag {
        case 0:
            self.chosemColor = UIColor(
                red: CGFloat(slider.value),
                green: chosemColor.rgba.green,
                blue: chosemColor.rgba.blue,
                alpha: chosemColor.rgba.alpha
            )
        case 1:
            self.chosemColor = UIColor(
                red: chosemColor.rgba.red,
                green: CGFloat(slider.value),
                blue: chosemColor.rgba.blue,
                alpha: chosemColor.rgba.alpha
            )
        default:
            self.chosemColor = UIColor(
                red: chosemColor.rgba.red,
                green: chosemColor.rgba.green,
                blue: CGFloat(slider.value),
                alpha: chosemColor.rgba.alpha
            )
    }
        delegate?.changeColor(self)
        sendActions(for: .touchDragInside)
        
    }
}
extension ColorPaletteView {
        private final class ColorSliderView: UIControl {
            private let slider = UISlider()
            private let colorLabel = UILabel()
            private(set) var value: Float
            
            init(colorname: String, value: Float) {
                self.value = value
                super.init(frame: .zero)
                slider.value = value
                colorLabel.text = colorname
                setupView()
                slider.addTarget(self, action: #selector(sliderMoved(_:)), for: .touchDragInside)
            }
            
            @available(*, unavailable)
            required init?(coder: NSCoder) {
                fatalError("init(coder:) has not been implemented")
            }
            
            private func setupView() {
                let stackView = UIStackView(arrangedSubviews: [colorLabel, slider])
                stackView.axis = .horizontal
                stackView.spacing = 5
                addSubview(stackView)
                stackView.pinLeft(to: self, 12)
                stackView.pinRight(to: self, 12)
                stackView.pinTop(to: self, 12)
                stackView.pinBottom(to: self, 12)
            }
            
            @objc
            private func sliderMoved(_ slider: UISlider) {
                self.value = slider.value
                sendActions(for: .touchDragInside)
            }
        }
    
}

extension UIColor {
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return (red, green, blue, alpha)
    }
}



