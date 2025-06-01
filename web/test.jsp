<%-- 
    Document   : test
    Created on : Jun 1, 2025, 8:42:09 AM
    Author     : UwAngelique
--%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Countdown with Sound</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background: #f8f8f8;
      text-align: center;
      margin-top: 100px;
    }
    .countdown-box {
      font-size: 2em;
      background: #fff;
      padding: 20px;
      display: inline-block;
      border-radius: 8px;
      box-shadow: 0 0 10px rgba(0,0,0,0.2);
    }
    .finished {
      color: red;
      font-weight: bold;
    }
  </style>
</head>
<body>

  <h1>Countdown Example</h1>
  <div class="countdown-box" id="countdown">Loading...</div>
  <br><br>
  <button onclick="startCountdown()">Start Countdown</button>

  <!-- Sound Alert -->
  <audio id="alertSound" src="https://www.soundjay.com/button/beep-07.wav" preload="auto"></audio>

  <script>
    let countdownInterval;

    function startCountdown() {
      const duration = 10; // countdown from 10 seconds
      let remainingTime = duration;

      updateDisplay(remainingTime);

      countdownInterval = setInterval(() => {
        remainingTime--;
        updateDisplay(remainingTime);

        if (remainingTime <= 0) {
          clearInterval(countdownInterval);
          playSound();
        }
      }, 1000);
    }

    function updateDisplay(seconds) {
      const el = document.getElementById("countdown");
      if (seconds <= 0) {
        el.innerHTML = "<span class='finished'>Time's Up!</span>";
      } else {
        const mins = String(Math.floor(seconds / 60)).padStart(2, '0');
        const secs = String(seconds % 60).padStart(2, '0');
        el.textContent = `${mins}:${secs}`;
      }
    }

    function playSound() {
      const sound = document.getElementById("alertSound");
      if (sound) {
        sound.play();
      }
    }
  </script>

</body>
</html>
