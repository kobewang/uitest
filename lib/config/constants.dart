class Constants {
  static final String TYPE_SEARCH_HISTORY = 'type_search_history';
  static const int PAGE_SIZE = 20; //默认分页
  static const int PLATID = 3; //jbiao平台 2:vmsapp
  static const String URL_PUBLISH_RULE='https://www.www.cn'; //发布协议
  static const String DEFAULT_HEAD_IMG="https://img.yms.cn/upload/head/ic_avatar_default.png";//默认头像
  static const String APP_LOGO='https://img.yms.cn/upload/public/vmslogo.png'; //APPlogo
  static const String APP_PACKAGE_NAME='cn.yms';//app包名
  static const String COMPANY_NAME='微毛衫'; //公司名
  static const String COMPANY_PHONE=''; //官方电话
  static const String COMPANY_QQ=''; //官方QQ
  static const String COMPANY_WECHAT='weimaoshan5'; //官方微信
  static const String COMPANY_WECHAT_QRIMG='https://img.yms.cn/upload/public/vms_daren5.jpg'; //官方微信二维
  static const String APP_VERSION_IOS='v1.0.0'; //ios版本号
  static const String APP_VERSION_ANDROID='v1.0.0'; //安卓版本名称
  static const int APP_VERSION_ANDROID_CODE=99; //安卓版本号


  ///商圈分类
  static List areaList = [
    {"Id": 1, "City": "桐乡濮院", "Sort": 0},
    {"Id": 2, "City": "嘉兴洪合", "Sort": 1},
    {"Id": 4, "City": "东莞大朗", "Sort": 3},
    {"Id": 3, "City": "汕头澄海", "Sort": 2},
    {"Id": 5, "City": "吴江横扇", "Sort": 4},
    {"Id": 13, "City": "其它", "Sort": 4},
    {"Id": 6, "City": "广东广州", "Sort": 5},
    {"Id": 7, "City": "河北清河", "Sort": 6},
    {"Id": 8, "City": "泉州南安", "Sort": 7},
    {"Id": 9, "City": "山东海阳", "Sort": 8},
    {"Id": 10, "City": "鄂尔多斯", "Sort": 9},
    {"Id": 11, "City": "宁夏领舞", "Sort": 10},
    {"Id": 12, "City": "张家港塘桥", "Sort": 11}
  ];

  ///信息分类
  static List typeList = [
    {
      "Id": 1,
      "Name": "成衣供求",
      "Sort": 0,
      "IconName": "menu-chengyi.png",
      "Father": true,
      "Child": [
        {"Id": 8, "Name": "找款式", "Sort": 0},
        {"Id": 9, "Name": "供应女装", "Sort": 0},
        {"Id": 10, "Name": "供应男装", "Sort": 0},
        {"Id": 11, "Name": "供应童装", "Sort": 0},
        {"Id": 12, "Name": "找成衣", "Sort": 0},
        {"Id": 13, "Name": "代卖", "Sort": 0}
      ]
    },
    {
      "Id": 8,
      "Name": "找款式",
      "IconName": "menu-zhaokuan.png",
      "Father": false,
      "Sort": 0,
      "Child": []
    },
    {
      "Id": 6,
      "Name": "原辅料",
      "IconName": "menu-yuanliao.png",
      "Father": true,
      "Sort": 0,
      "Child": [
        {"Id": 49, "Name": "供原辅料", "Sort": 0},
        {"Id": 48, "Name": "找原辅料", "Sort": 0}
      ]
    },
    {
      "Id": 2,
      "Name": "生产加工",
      "IconName": "menu-jiagong.png",
      "Father": true,
      "Sort": 0,
      "Child": [
        {"Id": 14, "Name": "接横机加工", "Sort": 0},
        {"Id": 15, "Name": "承接印花加工", "Sort": 0},
        {"Id": 16, "Name": "承接套口加工", "Sort": 0},
        {"Id": 17, "Name": "承接带子加工", "Sort": 0},
        {"Id": 18, "Name": "承接平车加工", "Sort": 0},
        {"Id": 19, "Name": "承接拷边加工", "Sort": 0},
        {"Id": 20, "Name": "承接整烫加工", "Sort": 0},
        {"Id": 21, "Name": "承接横机加工", "Sort": 0},
        {"Id": 22, "Name": "承接绣花加工", "Sort": 0},
        {"Id": 23, "Name": "承接倒毛", "Sort": 0},
        {"Id": 24, "Name": "承接维修", "Sort": 0}
      ]
    },
    {
      "Id": 3,
      "Name": "出租转让",
      "IconName": "menu-fangwuchuzu.png",
      "Father": true,
      "Sort": 0,
      "Child": [
        {"Id": 55, "Name": "出租房屋", "Sort": 0},
        {"Id": 25, "Name": "出售机器", "Sort": 0},
        {"Id": 26, "Name": "转让机器", "Sort": 0},
        {"Id": 27, "Name": "购买机器", "Sort": 0},
        {"Id": 28, "Name": "出租机器", "Sort": 0},
        {"Id": 29, "Name": "出租店面", "Sort": 0},
        {"Id": 30, "Name": "求租店面", "Sort": 0},
        {"Id": 31, "Name": "求购店面", "Sort": 0},
        {"Id": 32, "Name": "转租店面", "Sort": 0},
        {"Id": 33, "Name": "其他", "Sort": 0}
      ]
    },
    {
      "Id": 5,
      "Name": "尾货市场",
      "IconName": "menu-weihuo.png",
      "Father": true,
      "Sort": 0,
      "Child": [
        {"Id": 46, "Name": "供应尾货", "Sort": 0},
        {"Id": 47, "Name": "求购尾货", "Sort": 0}
      ]
    },
    {
      "Id": 4,
      "Name": "招聘求职",
      "IconName": "menu-zhaopin.png",
      "Father": true,
      "Sort": 0,
      "Child": [
        {"Id": 35, "Name": "招套口", "Sort": 0},
        {"Id": 36, "Name": "招平车", "Sort": 0},
        {"Id": 37, "Name": "招操作工", "Sort": 0},
        {"Id": 38, "Name": "招机修", "Sort": 0},
        {"Id": 39, "Name": "招横机", "Sort": 0},
        {"Id": 40, "Name": "招绣花", "Sort": 0},
        {"Id": 41, "Name": "招临时工", "Sort": 0},
        {"Id": 42, "Name": "招保姆", "Sort": 0},
        {"Id": 43, "Name": "招服务员", "Sort": 0},
        {"Id": 34, "Name": "找工作", "Sort": 0},
        {"Id": 44, "Name": "求助", "Sort": 0},
        {"Id": 45, "Name": "其他", "Sort": 0}
      ]
    },
    {
      "Id": 7,
      "Name": "餐饮住宿",
      "IconName": "menu-hotel.png",
      "Father": true,
      "Sort": 0,
      "Child": [
        {"Id": 50, "Name": "美食", "Sort": 0},
        {"Id": 51, "Name": "酒店", "Sort": 0},
        {"Id": 52, "Name": "足浴", "Sort": 0},
        {"Id": 53, "Name": "洗车", "Sort": 0},
        {"Id": 54, "Name": "其它", "Sort": 0}
      ]
    }
  ];
}

