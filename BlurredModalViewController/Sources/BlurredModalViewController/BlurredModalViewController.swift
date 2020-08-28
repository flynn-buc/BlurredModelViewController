import UIKit

class BlurredVC: UIViewController, UIAdaptivePresentationControllerDelegate {
    
    
    private var blurView: UIVisualEffectView!
    private var vcToDisplay: UIViewController?
    var style: UIBlurEffect.Style = .dark
    var constraints: [NSLayoutConstraint]?
    var delay: TimeInterval = 0
    var duration: TimeInterval = 0.5
    var options : UIView.AnimationOptions =  [.allowUserInteraction]
        
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: style)
        blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        
        let defaultConstraints = [blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
                                  blurView.widthAnchor.constraint(equalTo: view.widthAnchor)]
        
        view.insertSubview(blurView, at: 0)
        NSLayoutConstraint.activate(constraints ?? defaultConstraints)
        self.view.alpha = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let vcToDisplay = vcToDisplay{
            self.present(vcToDisplay, animated: true, completion: nil)
        }
        self.blur()
    }
    
    func setViewControllerToDisplay(_ viewController: UIViewController){
        vcToDisplay = viewController
    }
    
    func blur(alpha: CGFloat = 1, dismiss: Bool = false){
        DispatchQueue.main.async {
            UIView.animate(withDuration: self.duration, delay: self.delay, options: self.options, animations: {self.view.alpha = alpha}, completion: nil)
            if dismiss{
                self.dismiss(animated: false, completion: nil)
            }
        }
    }
    
    func presentationControllerShouldDismiss(_ presentationController: UIPresentationController) -> Bool {
        blur(alpha: 0, dismiss: true)
        return true;
    }
}