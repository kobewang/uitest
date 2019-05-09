class Constants {
  static final String TYPE_SEARCH_HISTORY = 'type_search_history';
  static const int PAGE_SIZE = 20;
  static const int PLATID = 2;
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
