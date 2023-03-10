/// 数据库创建表相关
class CreateTableSqls {
  //商品表语句
  static const String createTableSqlCommodity = '''
    CREATE TABLE IF NOT EXISTS commodity (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE, 
    nsrsbh TEXT NOT NULL,
    loginPhone TEXT NOT NULL,
    spmc TEXT NOT NULL, 
    bmxxSpmc TEXT NOT NULL, 
    bmxxSpbmjc TEXT NOT NULL, 
    spbm TEXT NOT NULL, 
    pid TEXT NOT NULL, 
    ggxh TEXT, 
    dw TEXT, 
    hsdj TEXT NOT NULL, 
    dj TEXT, 
    spsl TEXT NOT NULL,
    spslList TEXT NOT NULL,
    mslx TEXT NOT NULL,
    yhzc TEXT NOT NULL,
    letter TEXT NOT NULL,
    isFavourite INTEGER);
    ''';

  //客户表语句
  static const String createTableSqlCustomer = '''
    CREATE TABLE IF NOT EXISTS customer (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE, 
    nsrsbh TEXT NOT NULL,
    loginPhone TEXT NOT NULL,
    khmc TEXT NOT NULL, 
    khdm TEXT, 
    sjhm TEXT, 
    email TEXT, 
    bankName TEXT, 
    bankAccount TEXT, 
    address TEXT, 
    phone TEXT, 
    addressAndPhone TEXT,
    bankNameAndAccount TEXT,
    letter TEXT NOT NULL,
    isFavourite INTEGER);
    ''';

  /// 本地发票数据表（仅存储需要的信息）
  ///   String fpdm; // 发票代码
  ///   String fphm; // 发票号码
  ///   String xsfsbh; // 销售方识别号
  ///   String xsfmc; // 销售方名称
  ///   String gmfmc; // 购买方名称
  ///   String sbbh; // 开票员登录账号
  ///   String je; // 合计金额
  ///   String se; // 合计税额
  ///   String jshj; // 价税合计
  ///   String fpztbz; // 发票开具类型：0 正常票  1 红冲  2新发票的作废发票  3正常发票的作废发票  4已开退票的作废发票
  ///   String tqm; // 提取码(8位长度)
  ///   String kprq; // 开票日期
  ///   String fpkjzt; // 发票开具状态：0 开具成功； 1 已赋码未签名、2 已签名未确认、3 确认结果失败
  ///   String gmfEmail; // 购买方邮箱
  static const String createTableSqlLocalInvoice = '''
    CREATE TABLE IF NOT EXISTS local_invoice (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE, 
    fpdm TEXT,
    fphm TEXT,
    fplxdm TEXT,
    yfpdm TEXT,
    yfphm TEXT,
    xsfsbh TEXT,
    xsfmc TEXT,
    gmfmc TEXT,
    sbbh TEXT,
    je TEXT,
    se TEXT,
    jshj TEXT,
    fpztbz TEXT,
    tqm TEXT,
    kprq TEXT,
    fpkjzt TEXT,
    gmfEmail TEXT,
    previewUrl TEXT);
    ''';

  /// 上传中台失败的发票表
  static const String createTableSqlUploadFailedInvoice = '''
    CREATE TABLE IF NOT EXISTS upload_failed_invoice (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE, 
    userId TEXT,
    fpqqlsh TEXT,
    kprq TEXT,
    kpsj TEXT,
    fpdm TEXT,
    fphm TEXT,
    skm TEXT,
    jym TEXT,
    kjzt TEXT,
    zxkpsbbh TEXT,
    fplxdm TEXT,
    kplx TEXT,
    xhdwsbh TEXT,
    xhdwmc TEXT,
    xhdwdzdh TEXT,
    xhdwyhmczh TEXT,
    ghdwsbh TEXT,
    ghdwmc TEXT,
    ghdwdzdh TEXT,
    ghdwyhmczh TEXT,
    zsfs TEXT,
    hjje TEXT,
    hjse TEXT,
    jshj TEXT,
    bz TEXT,
    skr TEXT,
    fhr TEXT,
    kpr TEXT,
    yfpdm TEXT,
    yfphm TEXT,
    tqm TEXT,
    gmfEmail TEXT,
    invoiceStatus TEXT,
    eleInvoicePreviewUrl TEXT,
    bmbbbh TEXT);
    ''';

  /// 上传中台失败的发票明细表
  static const String createTableSqlUploadFailedInvoiceMxInfo = '''
    CREATE TABLE IF NOT EXISTS upload_failed_invoice_mx_info (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE, 
    invokedInvoiceId TEXT,
    spmc TEXT,
    ggxh TEXT,
    dw TEXT,
    spsl TEXT,
    dj TEXT,
    je TEXT,
    sl TEXT,
    se TEXT,
    hsbz TEXT,
    spbm TEXT,
    yhzcbs TEXT,
    slbs TEXT,
    zzstsgl TEXT,
    hs TEXT,
    fphxz TEXT,
    spsm TEXT,
    zxbm TEXT,
    hsDj TEXT,
    hsJe TEXT);
    ''';

  Map<String, String> getAllTables() {
    Map<String, String> map = <String, String>{};
    map['commodity'] = createTableSqlCommodity;
    map['customer'] = createTableSqlCustomer;
    map['local_invoice'] = createTableSqlLocalInvoice;
    map['upload_failed_invoice'] = createTableSqlUploadFailedInvoice;
    map['upload_failed_invoice_mx_info'] = createTableSqlUploadFailedInvoiceMxInfo;
    return map;
  }
}
