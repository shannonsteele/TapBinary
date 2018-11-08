# TapBinary
TapBinary is a Processing sketch that converts audio input from tap dancing into binary then translates it to English.

# Tap Dancing Suggestions for Users
The best way to use TapBinary is by doing eight count crawls becuase they produce one byte (8 bits or one English character) worth of sound. Visual output box is displayed on the screen to show the tap dancer what the sketch is reading each sound as. 
To tap a 1 do a single toe with the working foot (visual output will go black)
To tap a 0 do a rapid toe-heel, with the toe on the working foot and the heel on the standing foot (the visual output box will go white) 
A small pause must be left between tapped bits

A crawl consisting of just toes will produce 00000000. A crawl with heels will produce 11111111. By combinning just toes and toe-heels in your crawl you can produce a byte that can be translated to a int then a character. 

For visual demonstration visit: https://devonkay223.github.io/cs/2018/11/07/devon-frost-TapBin.html

# Running Sketch 
1) Follow Set Up directions below for set up in your enviroment and tap shoes. 
2) Press play (upper left corner), gray visual output box will pop up. 
3) Begin tapping, visual output will display what your sounds are being read as (black = 1, white = 0)
4) When you're done click in the visual output box to end, sketch will output binary and translate it to English if possible in the console. 


# Set Up
1) To run this sketch you will need to download Processing and have a functional microphone. 
    - Processing: https://processing.org/
    - Processing Downlaod: https://processing.org/download/
2) The variables AmpMid must be adjusted for your enviroment and tap shoes. 
    - Play sketch, tap a full bit of 0s, end sketch.
    - Look at the data output by the sketch after each sound ("total:   ") the lower end of this range is where AmpMid should be set.
    - Check AmpMid is correct by playing sketch, tapping a full bit of 0s, then a full bit of 1s. They should all come out with the correct value (you can also watch the visual output, if you notice sounds aren't reading correctly stop and readjust AmpMid). It might take some fine tunning for your tap shoes, floor, and room. 


