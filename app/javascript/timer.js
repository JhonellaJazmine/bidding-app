// app/javascript/timer.js

document.querySelectorAll('.timer').forEach(timer => {
    const expirationTime = new Date(timer.dataset.expirationTime).getTime();
  
    const interval = setInterval(() => {
      const now = new Date().getTime();
      const distance = expirationTime - now;
  
      if (distance < 0) {
        timer.innerHTML = "Expired";
        clearInterval(interval);
      } else {
        const days = Math.floor(distance / (1000 * 60 * 60 * 24));
        const hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
        const minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
        const seconds = Math.floor((distance % (1000 * 60)) / 1000);
  
        timer.innerHTML = `${days}d ${hours}h ${minutes}m ${seconds}s`;
      }
    }, 1000);
  });

