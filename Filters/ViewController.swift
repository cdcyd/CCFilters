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
        table.frame.size.height = UIScreen.main.bounds.height - UINavigationController().navigationBar.frame.height - UIApplication.shared.statusBarFrame.height
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
                               "CIZoomBlur-变焦模糊-" + NSStringFromClass(CIZoomBlur.self),
                               "CIMotionBlur-动感模糊-" + NSStringFromClass(CIMotionBlur.self),
                               "CIDiscBlur-环形卷积模糊-" + NSStringFromClass(CIDiscBlur.self),
                               "CIGaussianBlur-高斯模糊-" + NSStringFromClass(CIGaussianBlur.self),
                               "CIMedianFilter-中值模糊-" + NSStringFromClass(CIMedianFilter.self),
                               "CIMaskedVariableBlur-蒙版模糊-" + NSStringFromClass(CIMaskedVariableBlur.self),
                               "CINoiseReduction-减少杂色-" + NSStringFromClass(CINoiseReduction.self)],
                              ["CIColorClamp-" + NSStringFromClass(CIColorClamp.self),
                               "CIColorControls-" + NSStringFromClass(CIColorControls.self),
                               "CIColorMatrix-" + NSStringFromClass(CIColorMatrix.self),
                               "CIColorPolynomial-" + NSStringFromClass(CIColorPolynomial.self),
                               "CIExposureAdjust-" + NSStringFromClass(CIExposureAdjust.self),
                               "CIGammaAdjust-" + NSStringFromClass(CIGammaAdjust.self),
                               "CIHueAdjust-" + NSStringFromClass(CIHueAdjust.self),
                               "CILinearToSRGBToneCurve-" + NSStringFromClass(CILinearToSRGBToneCurve.self),
                               "CISRGBToneCurveToLinear-" + NSStringFromClass(CISRGBToneCurveToLinear.self),
                               "CITemperatureAndTint-" + NSStringFromClass(CITemperatureAndTint.self),
                               "CIToneCurve-" + NSStringFromClass(CIToneCurve.self),
                               "CIVibrance-" + NSStringFromClass(CIVibrance.self),
                               "CIWhitePointAdjust-" + NSStringFromClass(CIWhitePointAdjust.self)],
                              ["CIColorCrossPolynomial-" + NSStringFromClass(CIColorCrossPolynomial.self),
                               "CIColorCube-" + NSStringFromClass(CIColorCube.self),
                               "CIColorCubeWithColorSpace-" + NSStringFromClass(CIColorCubeWithColorSpace.self),
                               "CIColorInvert-" + NSStringFromClass(CIColorInvert.self),
                               "CIColorMap-" + NSStringFromClass(CIColorMap.self),
                               "CIColorMonochrome-" + NSStringFromClass(CIColorMonochrome.self),
                               "CIColorPosterize-" + NSStringFromClass(CIColorPosterize.self),
                               "CIFalseColor-" + NSStringFromClass(CIFalseColor.self),
                               "CIMaskToAlpha-" + NSStringFromClass(CIMaskToAlpha.self),
                               "CIMaximumComponent-" + NSStringFromClass(CIMaximumComponent.self),
                               "CIMinimumComponent-" + NSStringFromClass(CIMinimumComponent.self),
                               "CIPhotoEffectChrome-" + NSStringFromClass(CIPhotoEffectChrome.self),
                               "CIPhotoEffectFade-" + NSStringFromClass(CIPhotoEffectFade.self),
                               "CIPhotoEffectInstant-" + NSStringFromClass(CIPhotoEffectInstant.self),
                               "CIPhotoEffectMono-" + NSStringFromClass(CIPhotoEffectMono.self),
                               "CIPhotoEffectNoir-" + NSStringFromClass(CIPhotoEffectNoir.self),
                               "CIPhotoEffectProcess-" + NSStringFromClass(CIPhotoEffectProcess.self),
                               "CIPhotoEffectTonal-" + NSStringFromClass(CIPhotoEffectTonal.self),
                               "CIPhotoEffectTransfer-" + NSStringFromClass(CIPhotoEffectTransfer.self),
                               "CISepiaTone-" + NSStringFromClass(CISepiaTone.self),
                               "CIVignette-" + NSStringFromClass(CIVignette.self),
                               "CIVignetteEffect-" + NSStringFromClass(CIVignetteEffect.self)],
                              ["CIAdditionCompositing-" + NSStringFromClass(CIAdditionCompositing.self),
                               "CIColorBlendMode-" + NSStringFromClass(CIColorBlendMode.self),
                               "CIColorBurnBlendMode-" + NSStringFromClass(CIColorBurnBlendMode.self),
                               "CIColorDodgeBlendMode-" + NSStringFromClass(CIColorDodgeBlendMode.self),
                               "CIDarkenBlendMode-" + NSStringFromClass(CIDarkenBlendMode.self),
                               "CIDifferenceBlendMode-" + NSStringFromClass(CIDifferenceBlendMode.self),
                               "CIDivideBlendMode-" + NSStringFromClass(CIDivideBlendMode.self),
                               "CIExclusionBlendMode-" + NSStringFromClass(CIExclusionBlendMode.self),
                               "CIHardLightBlendMode-" + NSStringFromClass(CIHardLightBlendMode.self),
                               "CIHueBlendMode-" + NSStringFromClass(CIHueBlendMode.self),
                               "CILightenBlendMode-" + NSStringFromClass(CILightenBlendMode.self),
                               "CILinearBurnBlendMode-" + NSStringFromClass(CILinearBurnBlendMode.self),
                               "CILinearDodgeBlendMode-" + NSStringFromClass(CILinearDodgeBlendMode.self),
                               "CILuminosityBlendMode-" + NSStringFromClass(CILuminosityBlendMode.self),
                               "CIMaximumCompositing-" + NSStringFromClass(CIMaximumCompositing.self),
                               "CIMinimumCompositing-" + NSStringFromClass(CIMinimumCompositing.self),
                               "CIMultiplyBlendMode-" + NSStringFromClass(CIMultiplyBlendMode.self),
                               "CIMultiplyCompositing-" + NSStringFromClass(CIMultiplyCompositing.self),
                               "CIOverlayBlendMode-" + NSStringFromClass(CIOverlayBlendMode.self),
                               "CIPinLightBlendMode-" + NSStringFromClass(CIPinLightBlendMode.self),
                               "CISaturationBlendMode-" + NSStringFromClass(CISaturationBlendMode.self),
                               "CIScreenBlendMode-" + NSStringFromClass(CIScreenBlendMode.self),
                               "CISoftLightBlendMode-" + NSStringFromClass(CISoftLightBlendMode.self),
                               "CISourceAtopCompositing-" + NSStringFromClass(CISourceAtopCompositing.self),
                               "CISourceInCompositing-" + NSStringFromClass(CISourceInCompositing.self),
                               "CISourceOutCompositing-" + NSStringFromClass(CISourceOutCompositing.self),
                               "CISourceOverCompositing-" + NSStringFromClass(CISourceOverCompositing.self),
                               "CISubtractBlendMode-" + NSStringFromClass(CISubtractBlendMode.self)],
                              ["CIBumpDistortion-" + NSStringFromClass(CIBumpDistortion.self),
                               "CIBumpDistortionLinear-" + NSStringFromClass(CIBumpDistortionLinear.self),
                               "CICircleSplashDistortion-" + NSStringFromClass(CICircleSplashDistortion.self),
                               "CICircularWrap-" + NSStringFromClass(CICircularWrap.self),
                               "CIDroste-" + NSStringFromClass(CIDroste.self),
                               "CIDisplacementDistortion-" + NSStringFromClass(CIDisplacementDistortion.self),
                               "CIGlassDistortion-" + NSStringFromClass(CIGlassDistortion.self),
                               "CIGlassLozenge-" + NSStringFromClass(CIGlassLozenge.self),
                               "CIHoleDistortion-" + NSStringFromClass(CIHoleDistortion.self),
                               "CILightTunnel-" + NSStringFromClass(CILightTunnel.self),
                               "CIPinchDistortion-" + NSStringFromClass(CIPinchDistortion.self),
                               "CIStretchCrop-" + NSStringFromClass(CIStretchCrop.self),
                               "CITorusLensDistortion-" + NSStringFromClass(CITorusLensDistortion.self),
                               "CITwirlDistortion-" + NSStringFromClass(CITwirlDistortion.self),
                               "CIVortexDistortion-" + NSStringFromClass(CIVortexDistortion.self)],
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

