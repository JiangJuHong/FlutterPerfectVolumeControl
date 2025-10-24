import Flutter
import UIKit
import MediaPlayer
import AVFoundation

public class SwiftPerfectVolumeControlPlugin: NSObject, FlutterPlugin {
    let volumeView = MPVolumeView()
    var channel: FlutterMethodChannel?
    
    private var volumeObserverContext = 0

    override init() {
        super.init()
    }
    
    deinit {
        AVAudioSession.sharedInstance().removeObserver(self, forKeyPath: "outputVolume", context: &volumeObserverContext)
        NotificationCenter.default.removeObserver(self)
    }
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let instance = SwiftPerfectVolumeControlPlugin()
        instance.channel = FlutterMethodChannel(name: "perfect_volume_control", binaryMessenger: registrar.messenger())
        instance.bindListener()
        registrar.addMethodCallDelegate(instance, channel: instance.channel!)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getVolume":
            self.getVolume(call, result: result)
        case "setVolume":
            self.setVolume(call, result: result)
        case "hideUI":
            self.hideUI(call, result: result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    public func getVolume(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        do {
            try AVAudioSession.sharedInstance().setActive(true)
            result(AVAudioSession.sharedInstance().outputVolume)
        } catch let error as NSError {
            result(FlutterError(code: String(error.code), message: error.localizedDescription, details: error.localizedDescription))
        }
    }
    
    public func setVolume(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let volume = ((call.arguments as! [String: Any])["volume"]) as! Double
        var slider: UISlider?
        for item in volumeView.subviews {
            if let s = item as? UISlider {
                slider = s
                break
            }
        }
        
        if let slider = slider {
            slider.setValue(Float(volume), animated: false)
        }
        
        result(nil)
    }
    
    public func hideUI(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let hide = ((call.arguments as! [String: Any])["hide"]) as! Bool
        if hide {
            volumeView.frame = CGRect(x: -1000, y: -1000, width: 1, height: 1)
            volumeView.showsRouteButton = false
            UIApplication.shared.delegate!.window!?.rootViewController!.view.addSubview(volumeView)
        } else {
            volumeView.removeFromSuperview()
        }
        result(nil)
    }
    
    public func bindListener() {
        do {
            try AVAudioSession.sharedInstance().setActive(true)
            AVAudioSession.sharedInstance().addObserver(self, forKeyPath: "outputVolume", options: [.new, .old], context: &volumeObserverContext)
        } catch let error as NSError {
            print("\(error)")
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.volumeChangeListener), name: NSNotification.Name(rawValue: "AVSystemController_SystemVolumeDidChangeNotification"), object: nil)
        UIApplication.shared.beginReceivingRemoteControlEvents()
    }
    
    @objc func volumeChangeListener(notification: NSNotification) {
        if let volume = notification.userInfo?["AVSystemController_AudioVolumeNotificationParameter"] as? Float {
            channel?.invokeMethod("volumeChangeListener", arguments: volume)
        }
    }
    
    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if context == &volumeObserverContext && keyPath == "outputVolume" {
            let volume = AVAudioSession.sharedInstance().outputVolume
            channel?.invokeMethod("volumeChangeListener", arguments: volume)
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
}