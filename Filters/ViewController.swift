//
//  ViewController.swift
//  Filters
//
//  Created by 佰道聚合 on 2017/9/15.
//  Copyright © 2017年 cyd. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    lazy private var table:UITableView = {
        let table = UITableView(frame: self.view.bounds, style: .grouped)
        table.delegate = self
        table.dataSource = self
        table.estimatedSectionFooterHeight = 0.0
        table.estimatedSectionHeaderHeight = 0.0
        return table
    }()
    
    private let sectionTitles = ["CICategoryBlur",
                                 "CICategoryColorAdjustment",
                                 "CICategoryColorEffect",
                                 "CICategoryCompositeOperation",
                                 "CICategoryDistortionEffect",
                                 "CICategoryGenerator",
                                 "CICategoryGeometryAdjustment",
                                 "CICategoryGradient",
                                 "CICategoryHalftoneEffect",
                                 "CICategoryReduction",
                                 "CICategorySharpen",
                                 "CICategoryStylize",
                                 "CICategoryTileEffect",
                                 "CICategoryTransition"]

    private let dataSource = [["CIBoxBlur-均值模糊-" + NSStringFromClass(CIBoxBlur.self),
                               "CIDiscBlur-环形卷积模糊-" + NSStringFromClass(CIDiscBlur.self),
                               "CIGaussianBlur-高斯模糊-" + NSStringFromClass(CIGaussianBlur.self),
                               "CIMaskedVariableBlur-" + NSStringFromClass(CIMaskedVariableBlur.self),
                               "CIMedianFilter-中值模糊-" + NSStringFromClass(CIMedianFilter.self),
                               "CIMotionBlur-运动模糊-" + NSStringFromClass(CIMotionBlur.self),
                               "CINoiseReduction-" + NSStringFromClass(CINoiseReduction.self),
                               "CIZoomBlur-变焦模糊-" + NSStringFromClass(CIZoomBlur.self)],
                              ["CIColorClamp" + NSStringFromClass(CIColorClamp.self),
                               "CIColorControls",
                               "CIColorMatrix",
                               "CIColorPolynomial",
                               "CIExposureAdjust",
                               "CIGammaAdjust",
                               "CIHueAdjust",
                               "CILinearToSRGBToneCurve",
                               "CISRGBToneCurveToLinear",
                               "CITemperatureAndTint",
                               "CIToneCurve",
                               "CIVibrance",
                               "CIWhitePointAdjust"],
                              ["CIColorCrossPolynomial",
                               "CIColorCube",
                               "CIColorCubeWithColorSpace",
                               "CIColorInvert",
                               "CIColorMap",
                               "CIColorMonochrome",
                               "CIColorPosterize",
                               "CIFalseColor",
                               "CIMaskToAlpha",
                               "CIMaximumComponent",
                               "CIMinimumComponent",
                               "CIPhotoEffectChrome",
                               "CIPhotoEffectFade",
                               "CIPhotoEffectInstant",
                               "CIPhotoEffectMono",
                               "CIPhotoEffectNoir",
                               "CIPhotoEffectProcess",
                               "CIPhotoEffectTonal",
                               "CIPhotoEffectTransfer",
                               "CISepiaTone",
                               "CIVignette",
                               "CIVignetteEffect"],
                              ["CIAdditionCompositing",
                               "CIColorBlendMode",
                               "CIColorBurnBlendMode",
                               "CIColorDodgeBlendMode",
                               "CIDarkenBlendMode",
                               "CIDifferenceBlendMode",
                               "CIDivideBlendMode",
                               "CIExclusionBlendMode",
                               "CIHardLightBlendMode",
                               "CIHueBlendMode",
                               "CILightenBlendMode",
                               "CILinearBurnBlendMode",
                               "CILinearDodgeBlendMode",
                               "CILuminosityBlendMode",
                               "CIMaximumCompositing",
                               "CIMinimumCompositing",
                               "CIMultiplyBlendMode",
                               "CIMultiplyCompositing",
                               "CIOverlayBlendMode",
                               "CIPinLightBlendMode",
                               "CISaturationBlendMode",
                               "CIScreenBlendMode",
                               "CISoftLightBlendMode",
                               "CISourceAtopCompositing",
                               "CISourceInCompositing",
                               "CISourceOutCompositing",
                               "CISourceOverCompositing",
                               "CISubtractBlendMode"],
                              ["CIBumpDistortion",
                               "CIBumpDistortionLinear",
                               "CICircleSplashDistortion",
                               "CICircularWrap",
                               "CIDroste",
                               "CIDisplacementDistortion",
                               "CIGlassDistortion",
                               "CIGlassLozenge",
                               "CIHoleDistortion",
                               "CILightTunnel",
                               "CIPinchDistortion",
                               "CIStretchCrop",
                               "CITorusLensDistortion",
                               "CITwirlDistortion",
                               "CIVortexDistortion"],
                              ["CIAztecCodeGenerator",
                               "CICheckerboardGenerator",
                               "CICode128BarcodeGenerator",
                               "CIConstantColorGenerator",
                               "CILenticularHaloGenerator",
                               "CIPDF417BarcodeGenerator",
                               "CIQRCodeGenerator",
                               "CIRandomGenerator",
                               "CIStarShineGenerator",
                               "CIStripesGenerator",
                               "CISunbeamsGenerator"],
                              ["CIAffineTransform",
                               "CICrop",
                               "CILanczosScaleTransform",
                               "CIPerspectiveCorrection",
                               "CIPerspectiveTransform",
                               "CIPerspectiveTransformWithExtent",
                               "CIStraightenFilter"],
                              ["CIGaussianGradient",
                               "CILinearGradient",
                               "CIRadialGradient",
                               "CISmoothLinearGradient"],
                              ["CICircularScreen",
                               "CICMYKHalftone",
                               "CIDotScreen",
                               "CIHatchedScreen",
                               "CILineScreen"],
                              ["CIAreaAverage",
                               "CIAreaHistogram",
                               "CIRowAverage",
                               "CIColumnAverage",
                               "CIHistogramDisplayFilter",
                               "CIAreaMaximum",
                               "CIAreaMinimum",
                               "CIAreaMaximumAlpha",
                               "CIAreaMinimumAlpha"],
                              ["CISharpenLuminance",
                               "CIUnsharpMask"],
                              ["CIBlendWithAlphaMask",
                               "CIBlendWithMask",
                               "CIBloom",
                               "CIComicEffect",
                               "CIConvolution3X3",
                               "CIConvolution5X5",
                               "CIConvolution7X7",
                               "CIConvolution9Horizontal",
                               "CIConvolution9Vertical",
                               "CICrystallize",
                               "CIDepthOfField",
                               "CIEdges",
                               "CIEdgeWork",
                               "CIGloom",
                               "CIHeightFieldFromMask",
                               "CIHexagonalPixellate",
                               "CIHighlightShadowAdjust",
                               "CILineOverlay",
                               "CIPixellate",
                               "CIPointillize",
                               "CIShadedMaterial",
                               "CISpotColor",
                               "CISpotLight"],
                              ["CIAffineClamp",
                               "CIAffineTile",
                               "CIEightfoldReflectedTile",
                               "CIFourfoldReflectedTile",
                               "CIFourfoldRotatedTile",
                               "CIFourfoldTranslatedTile",
                               "CIGlideReflectedTile",
                               "CIKaleidoscope",
                               "CIOpTile",
                               "CIParallelogramTile",
                               "CIPerspectiveTile",
                               "CISixfoldReflectedTile",
                               "CISixfoldRotatedTile",
                               "CITriangleKaleidoscope",
                               "CITriangleTile",
                               "CITwelvefoldReflectedTile"],
                              ["CIAccordionFoldTransition",
                               "CIBarsSwipeTransition",
                               "CICopyMachineTransition",
                               "CIDisintegrateWithMaskTransition",
                               "CIDissolveTransition",
                               "CIFlashTransition",
                               "CIModTransition",
                               "CIPageCurlTransition",
                               "CIPageCurlWithShadowTransition",
                               "CIRippleTransition",
                               "CISwipeTransition"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = .all
        self.title = "滤镜"
        self.view.addSubview(table)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            cell?.textLabel?.font = UIFont.systemFont(ofSize: 14)
        }
        let array = dataSource[indexPath.section][indexPath.row].components(separatedBy: "-")
        cell?.textLabel?.text = array.count == 3 ? "\(array[0])(\(array[1]))" : "\(array[0])"
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let title = dataSource[indexPath.section][indexPath.row].components(separatedBy: "-").first
        let className = dataSource[indexPath.section][indexPath.row].components(separatedBy: "-").last

        guard let clas = NSClassFromString(className!) as? UIViewController.Type else {
            return
        }
        let vc = clas.init()
        vc.title = title
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

