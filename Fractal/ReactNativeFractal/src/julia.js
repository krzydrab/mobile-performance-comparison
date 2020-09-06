export default `<html>
<head></head>
<body>
  <div id="cavas-container" style="flex: 1; justify-content: 'center'; align-items: 'center'">
    <div>
      <canvas id="julia" width="300" height="300"></canvas>
    </div>
  </div>

  <script>
    (function() {
      var canvas = document.querySelector('#julia');
      const startTime = Date.now();

      // Counting FPS
      let frames = 0;
      const increaseFrames = () => {
        frames += 1;
        const kOffset = (Date.now() - startTime) * 0.0005;
        drawJulia(canvas, kOffset);
        requestAnimationFrame(increaseFrames);
      }
      increaseFrames();
  
      setInterval(() => {
        window.ReactNativeWebView.postMessage(frames);
        frames = 0;
      }, 1000);

      function drawJulia(canvas, kOffset) {
        const ctx = canvas.getContext('2d');
        var imageData = ctx.createImageData(canvas.width, canvas.height);
        var data = imageData.data;
        var dataOffset = 0;

        const height = canvas.height;
        const width = canvas.width;

        const minRe = -2.0;
        const maxRe= 2.0;
        const minIm = -1.5;
        const maxIm = 1.5;

        const reFactor = (maxRe-minRe)/(width);
        const imFactor = (maxIm-minIm)/(height-1);

        const kRe =  0.0 + Math.sin(kOffset) * 0.4;
        const kIm = -0.5 + Math.cos(kOffset) * 0.4;
        const maxIterations = 30;

        for(var y = 0; y < height; ++y) {
          //// Map image coordinates to c on complex plane
          var cIm = maxIm - y*imFactor;
          var cRe = minRe;
          
          for(var x = 0; x < width; ++x, cRe += reFactor) {
            //// Z[0] = c
            var ZRe = cRe;
            var ZIm = cIm;
            
            var color = [0, 0, 0];

            for(var n = 0; n < maxIterations; ++n) {
              //// Z[n+1] = Z[n]^2 + K
              //// Z[n]^2 = (Z_re + Z_im*i)^2
              ////        = Z_re^2 + 2*Z_re*Z_im*i + (Z_im*i)^2
              ////        = Z_re^2 Z_im^2 + 2*Z_re*Z_im*i
              var ZRe2 = ZRe * ZRe;
              var ZIm2 = ZIm * ZIm;

              if(ZRe2 + ZIm2 > 4) {                 
                color = [60 + n * 10, 0, 0];
                break;
              }

              ZIm = 2*ZRe*ZIm + kIm;
              ZRe = ZRe2 - ZIm2 + kRe;
            }

            data[dataOffset]     = color[0];
            data[dataOffset + 1] = color[1];
            data[dataOffset + 2] = color[2]; 
            data[dataOffset + 3] = 255; 
            dataOffset += 4;
          }
        }

        ctx.putImageData(imageData, 0, 0);
      } // drawJulia
      
    }());
  </script>
</body>
</html>`;