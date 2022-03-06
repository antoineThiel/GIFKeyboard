public func start(view:UIView) {
    let controller:GIFModal = GIFModal()
    view.addSubview(controller.view)
}

public func getGIFModal() -> UIViewController {
    let modal:GIFModal = GIFModal()
    return modal
}

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        return true
}




