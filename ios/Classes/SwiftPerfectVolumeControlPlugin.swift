import Flutter
import UIKit
import MediaPlayer
import AVFoundation

public class SwiftPerfectVolumeControlPlugin: NSObject, FlutterPlugin {
    /// 音量视图
    let volumeView = MPVolumeView();

    /// Flutter 消息通道
    var channel: FlutterMethodChannel?;

    override init() {
        super.init();
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
            self.getVolume(call, result: result);
            break;
        case "setVolume":
            self.setVolume(call, result: result);
            break;
        case "hideUI":
            self.hideUI(call, result: result);
            break;
        default:
            result(FlutterMethodNotImplemented);
        }

    }

    /// 获得系统当前音量
    public func getVolume(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        do {
            try AVAudioSession.sharedInstance().setActive(true)
            result(AVAudioSession.sharedInstance().outputVolume);
        } catch let error as NSError {
            result(FlutterError(code: String(error.code), message: "\(error.localizedDescription)", details: "\(error.localizedDescription)"));
        }
    }

    /// 设置音量
    public func setVolume(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let volume = ((call.arguments as! [String: Any])["volume"]) as! Double;
        var slider: UISlider?;
        for item in volumeView.subviews {
            if item is UISlider {
                slider = (item as! UISlider);
                break;
            }
        }

        if slider == nil {
            result(FlutterError(code: "-1", message: "Unable to get uislider", details: "Unable to get uislider"));
            return;
        }

        // 异步设置
        slider!.setValue((Float)(volume), animated: false)
        result(nil);
    }

    /// 隐藏UI
    public func hideUI(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let hide = ((call.arguments as! [String: Any])["hide"]) as! Bool;
        if hide {
            volumeView.frame = CGRect(x: -1000, y: -1000, width: 1, height: 1)
            volumeView.showsRouteButton = false
            UIApplication.shared.delegate!.window!?.rootViewController!.view.addSubview(volumeView);
        } else {
            volumeView.removeFromSuperview();
        }
        result(nil);
    }

    /// 绑定监听器
    public func bindListener() {
        do {
            try AVAudioSession.sharedInstance().setActive(true)
            AVAudioSession.sharedInstance().addObserver(self, forKeyPath: "outputVolume", options: [.new, .old], context: nil)
        } catch let error as NSError {
            print("\(error)")
        }

        // 绑定音量监听器
        NotificationCenter.default.addObserver(self, selector: #selector(self.volumeChangeListener), name: NSNotification.Name(rawValue: "AVSystemController_SystemVolumeDidChangeNotification"), object: nil)
        UIApplication.shared.beginReceivingRemoteControlEvents();
        
    }

    /// 音量监听
    @objc func volumeChangeListener(notification: NSNotification) {
        let volume = notification.userInfo!["AVSystemController_AudioVolumeNotificationParameter"] as! Float
        channel?.invokeMethod("volumeChangeListener", arguments: volume)
    }
    
    /// 音量监听(KVO方式)
    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        let volume = AVAudioSession.sharedInstance().outputVolume
        channel?.invokeMethod("volumeChangeListener", arguments: volume)
    }
}
