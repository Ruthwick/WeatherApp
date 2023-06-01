//
//  ViewController.swift
//  WeatherAPP
//
//  Created by Ruthwick S Rai on 31/05/23.
//

import UIKit
import Lottie


class ViewController: UIViewController {
    
    //MARK: - IBOutlets
    
    //MARK: - vars/lets
    private var animationView: LottieAnimationView?
    private var viewModel = LandingViewModel()
    
    //MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad() 
        LoadingIndicator.shared.setupLoadingWindowIfNeeded()
        bind()
        animationView = .init(name: "sunLoad")
        animationView!.frame = view.bounds
        animationView!.contentMode = .scaleAspectFit
        animationView!.loopMode = .loop
        animationView!.animationSpeed = 2
        view.addSubview(animationView!)
    }

    //MARK: - flow func
    private func bind() {
        viewModel.showLoading = {
            DispatchQueue.main.async {
                self.animationView!.play()
            }
        }
        viewModel.hideLoading = {
            DispatchQueue.main.async {
                self.animationView!.stop()
            }
        }
        
        viewModel.showError = {
            let alert = UIAlertController(title: "No internet connection", message: "Internet access is required for correct display of data.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
                self.viewModel.loadWeatherController?()
            }))
            self.present(alert, animated: true, completion: nil)
        }
        // Would like to call the navigation code some where in the navigation controller or in some other place.
        viewModel.loadStartController = {
            guard let controller = self.storyboard?.instantiateViewController(withIdentifier: APPConstants.startViewController) as? StartViewController else { return }
            self.navigationController?.pushViewController(controller, animated: false)
        }
        
        viewModel.loadWeatherController = {
            guard let controller = self.storyboard?.instantiateViewController(withIdentifier: APPConstants.weatherViewController) as? WeatherViewController else { return }
            controller.viewModel.weather = self.viewModel.weather

            self.navigationController?.pushViewController(controller, animated: true)
        }
        
        viewModel.checkFirstStart()
    }
}
