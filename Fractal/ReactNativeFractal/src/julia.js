export default `<html>
<head></head>
<body>
  <div id="cavas-container" style="flex: 1; justify-content: 'center'; align-items: 'center'">
    <div>
      <canvas id="julia" width="900" height="900"></canvas>
    </div>
  </div>

  <script>
    (function() {
      var canvas = document.querySelector('#julia');
      const startTime = Date.now();

      setInterval(function() {
        const kOffset = Math.sin((Date.now() - startTime) / 10000.0);
        const t0 = Date.now();
        drawJulia(canvas, kOffset);
        const t1 = Date.now();
        window.ReactNativeWebView.postMessage("Render time: " + ((t1 - t0) / 1000) + "s")
      }, 100);

      function drawJulia(canvas, kOffset) {
        const ctx = canvas.getContext('2d');
        var imageData = ctx.createImageData(canvas.width, canvas.height);
        var data = imageData.data;
        var dataOffset = 0;

        const height = canvas.height;
        const width = canvas.width;

        const minRe = -2.0;
        const maxRe= 1.0;
        const minIm = -1.2;
        const maxIm = 1.2;

        const reFactor = (maxRe-minRe)/(width);
        const imFactor = (maxIm-minIm)/(height-1);

        const kRe = 0.353 + kOffset;
        const kIm = 0.288 + kOffset;
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
                color = [n * 8, 0, 0];
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