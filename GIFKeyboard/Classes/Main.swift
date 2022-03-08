public class GIFKeyboard{
    
    public init() {
        
    }
    
    public func getGIFModalDefault(view:UIView) -> UIViewController {
        return GIFModal.newInstanceDefault(customView: view)
    }

    public func getGIFModalCustom(view:UIView, searchBar:UITextField, collection:UICollectionView, layout:UICollectionViewFlowLayout, backgroundColor:UIColor) -> UIViewController {
        return GIFModal.newInstanceCustom(customView: view, searchBar: searchBar, collectionView: collection, collectionViewLayout: layout, backgroundColor: backgroundColor)
    }

    public func displayGIFFromURL(viewToAppendTo:UIView, url:String) -> Void {
        let imageURL = UIImage.gifImageWithURL(url)
        let imageView = UIImageView(image: imageURL)
        imageView.frame = CGRect(x: 0, y: 0, width: viewToAppendTo.frame.width, height: viewToAppendTo.frame.height)
        viewToAppendTo.addSubview(imageView)
    }

}
