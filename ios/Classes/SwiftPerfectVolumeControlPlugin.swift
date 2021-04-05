import Flutter
import UIKit
import MediaPlayer

public class SwiftPerfectVolumeControlPlugin: NSObject, FlutterPlugin {
    /// 音量视图
    let volumeView = MPVolumeView();

    /// Flutter 消息通道
    var channel: FlutterMethodChannel?;

    override init() {
        super.init();

        // 绑定音量监听器
        NotificationCenter.default.addObserver(self, selector: #selector(self.volumeChangeListener), name: NSNotification.Name(rawValue: "AVSystemController_SystemVolumeDidChangeNotification"), object: nil)
        UIApplication.shared.beginReceivingRemoteControlEvents();
    }

    public static func register(with registrar: FlutterPluginRegistrar) {
        let instance = SwiftPerfectVolumeControlPlugin()
        instance.channel = FlutterMethodChannel(name: "perfect_volume_control", binaryMessenger: registrar.messenger())
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
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01) {
            slider!.value = (Float)(volume);
            result(nil);
        }
    }

    /// 隐藏UI
    public func hideUI(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let hide = ((call.arguments as! [String: Any])["hide"]) as! Bool;
        if hide {
            volumeView.isHidden = false;
            volumeView.frame(forAlignmentRect: CGRect(x: -100, y: -100, width: 40, height: 40));
            UIApplication.shared.delegate!.window!?.rootViewController!.view.addSubview(volumeView);
        } else {
            volumeView.removeFromSuperview();
        }
        result(nil);
    }

    /// 绑定监听器
    public func bindListener(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        do {
            try AVAudioSession.sharedInstance().setActive(true)
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
}