
import CoreImage
import CoreImage.CIFilterBuiltins
import PhotosUI
import StoreKit
import SwiftUI


struct ContentView: View {
    @State private var processedImage: Image?
    
    @State private var filterIntensity = 0.5
    @State private var filterRadius = 0.4
    @State private var filterScale=0.5
    
    @State private var selectedItem: PhotosPickerItem?
    @State private var showingFilters = false
    
    @AppStorage("filterCount") var filterCount = 0
    @Environment(\.requestReview) var requestReview
    
    @State private var currentFilter : CIFilter = CIFilter.sepiaTone()
    
    let context=CIContext()
    
    
    var body: some View {
        NavigationStack{
            VStack {
                Spacer()
                
                PhotosPicker(selection:$selectedItem){
                    if let processedImage{
                        processedImage
                            .resizable()
                            .scaledToFit()
                    }
                    else{
                        ContentUnavailableView("No picture", systemImage: "photo.badge.plus",
                                               description: Text("Tap to import photo"))
                    }
                }
                .buttonStyle(.plain)
                .onChange(of: selectedItem, loadImage)
                
                Spacer()
                //challange 1
                if let processedImage{
                    
                    let inputKeys = currentFilter.inputKeys
                    //challange 2
                    if inputKeys.contains(kCIInputIntensityKey){
                        HStack{
                            Text("Intensity")
                            Slider(value: $filterIntensity)
                                .onChange(of: filterIntensity, applyProcessing)
                        }
                    }
                    if inputKeys.contains(kCIInputRadiusKey){
                        HStack{
                            Text("Radius")
                            Slider(value: $filterRadius)
                                .onChange(of: filterRadius, applyProcessing)
                        }
                    }
                    if inputKeys.contains(kCIInputScaleKey){
                        HStack{
                            Text("Scale")
                            Slider(value: $filterScale)
                                .onChange(of: filterScale, applyProcessing)
                        }
                    }
                    
                    HStack{
                        Button("Change filter",action:changeFilter)
                        
                        Spacer()
                        
                        ShareLink(item: processedImage, preview: SharePreview("InstaFilter",image:processedImage))
                        
                    }
                }
            }
            .padding([.horizontal,.bottom])
            .navigationTitle("Instafilter")
            .confirmationDialog("Select a filter", isPresented: $showingFilters){
                Button("Crystalize"){
                    setFilter(CIFilter.crystallize())
                }
                Button("Edges"){
                    setFilter(CIFilter.edges())
                }
                Button("Gaussian Blur"){
                    setFilter(CIFilter.gaussianBlur())
                }
                Button("Pixellate"){
                    setFilter(CIFilter.pixellate())
                }
                Button("Sepia Tone"){
                    setFilter(CIFilter.sepiaTone())
                }
                Button("Unsharp Mask"){
                    setFilter(CIFilter.unsharpMask())
                }
                Button("Vignette"){
                    setFilter(CIFilter.vignette())
                }
                Button("Bloom"){
                    setFilter(CIFilter.bloom())
                }
                //challange 3
                Button("gaborGradients"){
                    setFilter(CIFilter.gaborGradients())
                }
                Button("Gloom"){
                    setFilter(CIFilter.gloom())
                }
                Button("Invert Colors"){
                    setFilter(CIFilter.colorInvert())
                }
                Button("Cancel",role:.cancel){
                }
            }
            
        }
    }
    func changeFilter(){
        showingFilters=true
    }
    
    func loadImage(){
        Task{
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else {return}
            guard let inputImage = UIImage(data: imageData) else {return}
            
            let beginImage=CIImage(image: inputImage)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            applyProcessing()
        }
        
    }
    
    func applyProcessing(){

        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey){
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        }
        if inputKeys.contains(kCIInputRadiusKey){
            currentFilter.setValue(filterRadius*10, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey){
            currentFilter.setValue(filterScale*10, forKey: kCIInputScaleKey)
        }
        
        guard let outputImage=currentFilter.outputImage else {return}
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else {return}
                
        let uiImage = UIImage(cgImage: cgImage)
        processedImage=Image(uiImage: uiImage)
    }
    
    @MainActor func setFilter(_ filter: CIFilter){
        currentFilter=filter
        loadImage()
        
        filterCount+=1
        
        if filterCount >= 3 {
            filterCount = 0
            requestReview()
        }
    }
}

#Preview {
    ContentView()
}
