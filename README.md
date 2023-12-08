# selaras_v01

Selaras adalah aplikasi yang berfungsi membantu jamaah umroh dan haji dalam menjalaankan ibadah di tanah suci.

Selaras dibangun menggunakan flutter, didukung dengan API ke tiga layanan di cloud:
- Database service
- Websocket service
- Audio streaming service

Target platform aplikasi ini terutama adalah Android, yang diikuti dengan iOS sebegai prioritas kedua.

8 Desember 2023:

RENCANA PENGEMBANGAN
====================================================================================================
Mengenai websocket:
- Tiap group yang berjalan paralel akan menggunakan port yang berbeda-beda
- Nantinya akan disediakan sejumlah port yang akan di-assign oleh admin ke group tour tertentu
- Assignment itu bisa saja dilakukan secara otomatis oleh sistem menggunakan port yang masih tersedia
- Port akan dilepas lagi setelah tanggal tour group berakhir
- Service websocket di server akan dijalankan secara otomatis berdasarkan jadwal tour group,
- meenggunakan port yang sudah diassign ke tour group tersebut
- Pengelolaan port sebagai asset sebaiknya dilakukan di database dan bukan oleh websocket script
- Karena itu, sebaiknya database service dan websocket service berada di server yang sama
