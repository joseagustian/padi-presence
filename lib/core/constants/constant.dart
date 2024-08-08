
const CAPTCHA_TIMER = 15000;
const CAPTCHA_UPDATE_INTERVAL = 100;
const TILE_MAP_URL = 'https://tile.openstreetmap.org/{z}/{x}/{y}.png';
const CHAR = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
const SUBMISSION_TYPE_MAP = {
  'PERMIT': 'Izin',
  'LEAVE': 'Cuti Tahunan',
  'SICK': 'Sakit',
  'OUTOFTOWN': 'Dinas Luar Kota'
};