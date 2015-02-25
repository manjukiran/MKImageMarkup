# MKImageMarkup

A wrapped around Inkpad's (https://github.com/sprang/Inkpad/) sourcecode. This can be used by other devs to use when required to annotate/markup images in their apps. Built on Steve Sprang's project that so many others contribute to. Thanks Steve for an incredible piece of code.

## How to Use

## Option A
### For people who want a plug and play solution 
  
  1) Download the repository. Copy-Paste the **"MKImageMarkup.framework"** file from **"MK ImageMarkup Example"** subfolder into     your project.  
  2)In your project's settings bar , select General and add the **"MKImageMarkup.framework"** as an **Embedded Binary** into your project
  3) In your project's Info.Plist file, add the following code
  
    <key>UTExportedTypeDeclarations</key>	
	<array>
		<dict>
			<key>UTTypeConformsTo</key>
			<array>
				<string>public.data</string>
			</array>
			<key>UTTypeDescription</key>
			<string>Inkpad Document</string>
			<key>UTTypeIdentifier</key>
			<string>com.taptrix.inkpad</string>
			<key>UTTypeTagSpecification</key>
			<dict>
				<key>public.filename-extension</key>
				<string>inkpad</string>
				<key>public.mime-type</key>
				<string>application/x-inkpad</string>
			</dict>
		</dict>
	</array>
	
  4) In your view controller : add #import <MKImageMarkup/MKImageMarkup.h>
  5) Set your ViewControler to be a delegate <MKImageMarkupDelegate>
  6) Add the delegate method
  
      -(void)didDismissMarkupSessionWithImage:(UIImage*)image imageEdited:(BOOL)imageEdited

  in the class you wish the callback method to be called. 
  
  7) Create a Strong property of type  MKImageMarkup
    
    @property (nonatomic, strong) MKImageMarkup *mkIM;
  
  8) From the buton you wish to ask the user the image for markup, add the following code to initiatlize and use the framework 
  
  Example: 
    
    - (IBAction)testButtonTouched:(id)sender {
    
    self.mkIM = [[MKImageMarkup alloc] initPopOverInViewController:self
                                                        fromButton:sender];
    self.mkIM.delegate = self;
    
    }
  
#####  Very Important : You need  the ViewController to have a UINavigationController that it is embedded in. 
  
## Option B
### For people who want a to play around with the code more
  
  1) Download the repository. This will have a folder in the repo called "Inkpad-develop-framework-project".
  
  2) Copy this folder to your project folder. 
  
  3) Add the Inkpad.xcodeproj file to your project workspace
  
  4) In your project's settings bar, selet "Build Phases", add the MKImageMarkup as one of the target dependencies
  
  5) In your project's settings bar , select "General" and add the **"MKImageMarkup.framework"** as an **Embedded Binary** into your project
  
   3) In your project's Info.Plist file, add the following code
  
    <key>UTExportedTypeDeclarations</key>	
	<array>
		<dict>
			<key>UTTypeConformsTo</key>
			<array>
				<string>public.data</string>
			</array>
			<key>UTTypeDescription</key>
			<string>Inkpad Document</string>
			<key>UTTypeIdentifier</key>
			<string>com.taptrix.inkpad</string>
			<key>UTTypeTagSpecification</key>
			<dict>
				<key>public.filename-extension</key>
				<string>inkpad</string>
				<key>public.mime-type</key>
				<string>application/x-inkpad</string>
			</dict>
		</dict>
	</array>
	
  4) In your view controller : add #import <MKImageMarkup/MKImageMarkup.h>
  
  5) Set your ViewControler to be a delegate <MKImageMarkupDelegate>
  
  6) Add the delegate method
  
  
      -(void)didDismissMarkupSessionWithImage:(UIImage*)image imageEdited:(BOOL)imageEdited

  in the class you wish the callback method to be called. 
  
  7) Create a Strong property of type  MKImageMarkup
    
    @property (nonatomic, strong) MKImageMarkup *mkIM;
  
  8) From the buton you wish to ask the user the image for markup, add the following code to initiatlize and use the framework 
  
  Example: 
    
    - (IBAction)testButtonTouched:(id)sender {
    
    self.mkIM = [[MKImageMarkup alloc] initPopOverInViewController:self
                                                        fromButton:sender];
    self.mkIM.delegate = self;
    
    }
  
#####  Very Important : You need  the ViewController to have a UINavigationController that it is embedded in. 
  
