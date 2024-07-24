//
//  ErrorView.swift
//
//
//  Created by Aymen Bokri on 24/07/2024.
//

import Foundation
import UIKit

final public class ErrorView: UIView {
    
    // MARK: - Properties
    
    private var titleLabel: UILabel
    private var subtitleLabel: UILabel
    private var callToAction: UIButton
    
    private weak var delegate: ErrorViewDelegate?
    
    // MARK: - Constructors
    
    public init() {
        self.titleLabel = UILabel(frame: .zero)
        self.subtitleLabel = UILabel(frame: .zero)
        self.callToAction = UIButton()
        
        super.init(frame: .zero)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    public func setupDelegate(delegate: ErrorViewDelegate?) {
        self.delegate = delegate
    }
    
    // MARK: - Private Methods
    
    private func setupViews() {
        backgroundColor = UIColor(resource: .background)
        titleLabel.textColor = UIColor(resource: .foreground)
        titleLabel.font = Fonts.boldL
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.text = String(localized: .localizable(.genericErrorTitle))
        
        subtitleLabel.textColor = UIColor(resource: .foreground)
        subtitleLabel.font = Fonts.regularM
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textAlignment = .center
        subtitleLabel.text = String(localized: .localizable(.genericErrorDescription))
        
        callToAction.setTitle(String(localized: .localizable(.retryCta)), for: .normal)
        callToAction.layer.cornerRadius = Dimens.cornerRadius
        callToAction.setBackgroundColor(color: UIColor(resource: .foreground), forState: .normal)
        callToAction.setBackgroundColor(color: UIColor(resource: .foreground).withAlphaComponent(0.2), forState: .highlighted)
        callToAction.setTitleColor(UIColor(resource: .background), for: .normal)
        callToAction.addTarget(self, action: #selector(self.errorButtonTouchUp), for: .touchUpInside)
        
        translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        callToAction.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(self.titleLabel)
        addSubview(self.subtitleLabel)
        addSubview(self.callToAction)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Dimens.paddingXL),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Dimens.paddingM),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Dimens.paddingM),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Dimens.paddingL),
            subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Dimens.paddingM),
            subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Dimens.paddingM),
            
            callToAction.topAnchor.constraint(greaterThanOrEqualTo: subtitleLabel.bottomAnchor, constant: Dimens.paddingL),
            callToAction.leadingAnchor.constraint(equalTo: subtitleLabel.leadingAnchor),
            callToAction.trailingAnchor.constraint(equalTo: subtitleLabel.trailingAnchor),
            callToAction.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -Dimens.paddingXL),
            callToAction.heightAnchor.constraint(equalToConstant: Dimens.buttonHeight),
        ])
    }
    
    @objc private func errorButtonTouchUp() {
        Task {
            await self.delegate?.errorButtonTouchUp()
        }
    }
}
