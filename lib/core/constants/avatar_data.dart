class AvatarData {
  /// 预定义的 6 组本地 SVG 字符串，无需网络加载
  static const List<String> builtInSvgs = [
    // Felix
    '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect width="100" height="100" fill="#b6e3f4"/><circle cx="50" cy="40" r="25" fill="#fbd38d"/><path d="M25 75 q25 15 50 0 v25 h-50 z" fill="#fbd38d"/><circle cx="40" cy="35" r="3" fill="#4a3b2a"/><circle cx="60" cy="35" r="3" fill="#4a3b2a"/><path d="M45 50 q5 5 10 0" stroke="#4a3b2a" fill="transparent" stroke-width="2"/></svg>',
    // Zoe
    '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect width="100" height="100" fill="#ffd5dc"/><circle cx="50" cy="40" r="25" fill="#fbcfe8"/><path d="M25 75 q25 15 50 0 v25 h-50 z" fill="#fbcfe8"/><circle cx="40" cy="35" r="3" fill="#4a3b2a"/><circle cx="60" cy="35" r="3" fill="#4a3b2a"/><path d="M42 50 q8 8 16 0" stroke="#d6455d" fill="transparent" stroke-width="2"/></svg>',
    // Leo
    '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect width="100" height="100" fill="#c0aede"/><circle cx="50" cy="40" r="25" fill="#ffe0b2"/><path d="M25 75 q25 15 50 0 v25 h-50 z" fill="#ffe0b2"/><circle cx="40" cy="35" r="3" fill="#4a3b2a"/><circle cx="60" cy="35" r="3" fill="#4a3b2a"/><path d="M40 55 h20" stroke="#4a3b2a" fill="transparent" stroke-width="2"/></svg>',
    // Aneka
    '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect width="100" height="100" fill="#d1d4f9"/><circle cx="50" cy="40" r="25" fill="#e2e8f0"/><path d="M25 75 q25 15 50 0 v25 h-50 z" fill="#e2e8f0"/><circle cx="40" cy="35" r="3" fill="#4a3b2a"/><circle cx="60" cy="35" r="3" fill="#4a3b2a"/><path d="M45 55 l5 -5 l5 5" stroke="#4a3b2a" fill="transparent" stroke-width="2"/></svg>',
    // Milo
    '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect width="100" height="100" fill="#ffdfbf"/><circle cx="50" cy="40" r="25" fill="#fef3c7"/><path d="M25 75 q25 15 50 0 v25 h-50 z" fill="#fef3c7"/><circle cx="40" cy="35" r="3" fill="#4a3b2a"/><circle cx="60" cy="35" r="3" fill="#4a3b2a"/><path d="M45 52 q5 3 10 0" stroke="#4a3b2a" stroke-width="2" fill="none"/></svg>',
    // Lily
    '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect width="100" height="100" fill="#e2f3f5"/><circle cx="50" cy="40" r="25" fill="#fbcfe8"/><path d="M25 75 q25 15 50 0 v25 h-50 z" fill="#fbcfe8"/><circle cx="40" cy="35" r="3" fill="#4a3b2a"/><circle cx="60" cy="35" r="3" fill="#4a3b2a"/><path d="M40 50 q10 5 20 0" stroke="#d6455d" stroke-width="2" fill="none"/></svg>',
  ];
}
