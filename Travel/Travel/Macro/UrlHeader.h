//
//  UrlHeader.h
//  Travel
//
//  Created by lanou on 15/9/18.
//  Copyright (c) 2015年 TeamThree. All rights reserved.
//

#ifndef Travel_UrlHeader_h
#define Travel_UrlHeader_h

// 每日推荐
#define kEverydayUrl @"http://api.breadtrip.com/v5/index"

// 更多精彩故事
#define kMoreWonderfulStory @"http://api.breadtrip.com/v2/new_trip/spot/hot/list/?start=%ld"

// 精彩故事详情
#define kWonderfulUrl @"http://api.breadtrip.com/v2/new_trip/spot/?spot_id=%@"

// 精彩游记
#define kJounaryUrl @"http://api.breadtrip.com/trips/%@/waypoints/?gallery_mode=1&sign=a4d6a98d84562c66533a3eb834500ee1"

// 下拉刷新游记
#define kRefreshJounaryUrl @"http://api.breadtrip.com/v5/index/?lat=30.28275878622556&lng=120.1101822501681&next_start=%@&sign=b5c6a9c6260e3e4f8c954fa7306835c3"

// 搜索
#define kSearchResultUrl @"http://api.breadtrip.com/search/?key=%@&start=%ld&count=20&source=search&sign=0"
#define kSearchSight @"http://api.breadtrip.com/search/?key=%@&start=0&count=20&source=search&sign=0"

//目的地界面接口
#define kDetination @"http://api.breadtrip.com/destination/v3/"

//更多欧洲国家接口
#define kMoreCountry @"http://api.breadtrip.com/destination/index_places/3/"

//更多亚洲国家接口
#define kMoreYCountry @"http://api.breadtrip.com/destination/index_places/6/"

//更多国内城市接口
#define kMoreLcity @"http://api.breadtrip.com/destination/index_places/8/"

//最新攻略
#define kNewStrategy @"http://app6.117go.com/demo27/php/interestAction.php?start=&length=12&submit=getDiscoverDir&pid=9927&v=i6.4.2&vc=AppStore&vd=b3c1b4cf8b498fb8&lang=zh-Hans&verify=f448fd13669fbd2e6df0ff7ac1e1356d"

//热门
#define kHotStrategy @"http://app6.117go.com/demo27/php/interestAction.php?start=&length=12&submit=getDiscoverDir&pid=17431&v=i6.4.2&vc=AppStore&vd=b3c1b4cf8b498fb8&lang=zh-Hans&verify=70167f27a9e8c78482cd40b158643394"

//亚洲
#define kAsian @"http://app6.117go.com/demo27/php/interestAction.php?start=&length=12&submit=getDiscoverDir&pid=23213&v=i6.4.2&vc=AppStore&vd=b3c1b4cf8b498fb8&lang=zh-Hans&verify=13bb1c5771fc2b1a97bc31402b6afd88"

//欧洲
#define kEurope @"http://app6.117go.com/demo27/php/interestAction.php?start=&length=12&submit=getDiscoverDir&pid=23423&v=i6.4.2&vc=AppStore&vd=b3c1b4cf8b498fb8&lang=zh-Hans&verify=1cb0345d6bee388e565af00571b3f71a"

//大洋洲
#define kOceania @"http://app6.117go.com/demo27/php/interestAction.php?start=&length=12&submit=getDiscoverDir&pid=23339&v=i6.4.2&vc=AppStore&vd=b3c1b4cf8b498fb8&lang=zh-Hans&verify=95a73c75f1b83fb2b66a17dde471b7ca"

//美洲
#define kAmerica @"http://app6.117go.com/demo27/php/interestAction.php?start=&length=12&submit=getDiscoverDir&pid=23647&v=i6.4.2&vc=AppStore&vd=b3c1b4cf8b498fb8&lang=zh-Hans&verify=a3a627ca7c167a09e420889c5fcb2abf"

//非洲
#define kAfrica @"http://app6.117go.com/demo27/php/interestAction.php?start=&length=12&submit=getDiscoverDir&pid=23549&v=i6.4.2&vc=AppStore&vd=b3c1b4cf8b498fb8&lang=zh-Hans&verify=761bdfadd0a6c09f7552bdaf09d4ac11"

//最新攻略下拉
#define kNewStrategyP @"http://app6.117go.com/demo27/php/interestAction.php?start=%@&length=12&submit=getDiscoverDir&pid=9927&v=i6.4.2&vc=AppStore&vd=b3c1b4cf8b498fb8&lang=zh-Hans&verify=f448fd13669fbd2e6df0ff7ac1e1356d"


#define kLocationUrl @"http://app6.117go.com/demo27/php/stickerAction.php?start=&length=12&submit=getSceneryHome&sceneryid=%@&v=i6.4.2&vc=AppStore&vd=b3c1b4cf8b498fb8&lang=zh-Hans&verify=024bb6753df57af7ba6df739621ae0a0"

#define kLocationCountry @"http://app6.117go.com/demo27/php/discoverAction.php?start=&length=12&submit=localityHome6_2&locid=%@&v=i6.4.2&vc=AppStore&vd=b3c1b4cf8b498fb8&lang=zh-Hans&verify=144629fa99d7f149d9082d1f6a747eff"


#define kStrategyUrl @"http://app6.117go.com/demo27/php/discoverAction.php?start=&subtype=-1&length=12&submit=getSceneryTours&sceneryid=%@&v=i6.4.2&vc=AppStore&vd=b3c1b4cf8b498fb8&lang=zh-Hans&verify=26e23ba17852e6f38a9db4dcc5db0801"

#define kStrategy2Url @"http://app6.117go.com/demo27/php/discoverAction.php?start=&subtype=-1&length=12&submit=getLocalityTours&locid=%@&v=i6.4.2&vc=AppStore&vd=b3c1b4cf8b498fb8&lang=zh-Hans&verify=1352e105ccabb70fee0447c786660da0"

#define kStrategyUrlP @"http://app6.117go.com/demo27/php/discoverAction.php?start=%@&subtype=-1&length=12&submit=getSceneryTours&sceneryid=%@&v=i6.4.2&vc=AppStore&vd=b3c1b4cf8b498fb8&lang=zh-Hans&verify=26e23ba17852e6f38a9db4dcc5db0801"

#define kStrategy2UrlP @"http://app6.117go.com/demo27/php/discoverAction.php?start=%@&subtype=-1&length=12&submit=getLocalityTours&locid=%@&v=i6.4.2&vc=AppStore&vd=b3c1b4cf8b498fb8&lang=zh-Hans&verify=1352e105ccabb70fee0447c786660da0"

#define kDetailUrl @"http://app6.117go.com/demo27/php/formAction.php?recType=0&id1=%@&id2=1&submit=getATour2&tourid=%@&v=i6.4.2&vc=AppStore&vd=b3c1b4cf8b498fb8&lang=zh-Hans&verify=70b2429e21d1a72d46a3d799872525fd"



#endif
