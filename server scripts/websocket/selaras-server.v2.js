// server.js
// Sementara belum dengan group maupun muthawif
// Sudah ditambahkan jika PING-PONG untuk heartbeat
const WebSocket = require('ws');

const server = new WebSocket.Server({ port: 3002 });

// Array untuk menyimpan semua koneksi WebSocket yang aktif
const clients = new Map();

server.on('connection', (socket) => {
  let messageString;

  const ts = new Date().toLocaleString();
  console.log(`${ts}: Client connected`);

  // Event listener untuk menerima pesan dari klien
  socket.on('message', (message) => {
    // Mengonversi pesan menjadi string jika bukan string
    if (typeof message === 'string') {
      messageString = message;
    } else if (message instanceof Buffer) {
      // Jika pesan adalah Buffer, konversi menjadi string
      messageString = message.toString('utf-8');
    } else if (message instanceof ArrayBuffer) {
      // Jika pesan adalah ArrayBuffer, konversi menjadi string
      const decoder = new TextDecoder('utf-8');
      messageString = decoder.decode(new Uint8Array(message));
    } else {
      // Jika pesan adalah objek JSON, konversi menjadi string
      messageString = JSON.stringify(message);
    }
    const tokens = messageString.split(":");   // command(C=connect|R=receive):ID:message
    if(tokens[0] == "C") {
       clients.set(tokens[1],socket);
       console.log(`${ts}: Connected client ID: ${tokens[1]}`);
    }
    else if(tokens[0] == "R") {
      console.log(`${ts}: ${tokens[1]} receive: ${tokens[2]}`);
    }
    else if(tokens[0] == "P") {
      clients.get(tokens[1]).send(`PONG`);
      console.log(`${ts}: PING from ${tokens[1]}`);
    }
    // Meneruskan pesan ke semua klien
    else clients.forEach((socketnya) => {
      if (socketnya !== socket && socketnya.readyState === WebSocket.OPEN) {
        // Memastikan untuk tidak mengirim pesan kepada pengirim asli
        clients.forEach((socket2,client2) => {
          if(socket == socket2) console.log(`${ts}: ${client2} send: ${message}`);
        });
        socketnya.send(`${message}`);
      }
    });
  });

  // Event listener untuk menangani penutupan koneksi
  socket.on('close', () => {
    clients.forEach((socketnya,clientnya) => {
      if(socketnya == socket) {
         console.log(`${ts}: ${clientnya} disconnected`);
         socket.close();
         clients.delete(clientnya);
      }
    });
  });
});