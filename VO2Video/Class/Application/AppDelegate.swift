import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator!

    // Single source of truth, should not be initialized anywhere else,
    // inject any mock service here
    private let engine = Engine()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        appCoordinator = AppCoordinator(engine: engine, launchOptions: launchOptions)
        configureNavigationBarAppearance()
        return true
    }
        
    func applicationDidBecomeActive(_ application: UIApplication) {}
    
    func applicationWillResignActive(_ application: UIApplication) {}
    
    func applicationDidEnterBackground(_ application: UIApplication) {}
    
    func applicationWillEnterForeground(_ application: UIApplication) {}
}


extension AppDelegate {
    /// Configure Navigation bar general appearance
    func configureNavigationBarAppearance(color: UIColor = .black) {
        let navBarAppearance = UINavigationBar.appearance()
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = color
        appearance.titleTextAttributes = [
            .font: UIFont.boldSystemFont(ofSize: 18.0),
            .foregroundColor: UIColor.systemRed
        ]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        navBarAppearance.standardAppearance = appearance
        navBarAppearance.scrollEdgeAppearance = appearance
        navBarAppearance.tintColor = .white
    }
}
