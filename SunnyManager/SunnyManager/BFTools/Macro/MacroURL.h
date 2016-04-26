//
//  MacroURL.h
//  SunnyManager
//
//  Created by mfwl on 16/4/22.
//  Copyright © 2016年 bf. All rights reserved.
//

#ifndef MacroURL_h
#define MacroURL_h

#define BASEURL @"http://123.56.182.21:8080/SunnyLifeInterface/businessHandler!"

/**
 *                                  登录
 */

#define login_action @"Businesslogin.action"//用户登录，并查询用户信息

/**
 *                                  排队
 */

#define sure_queue @"ConfirmTablenum.action"// 排队
#define unuser_desk @"UnUseTable.action"
#define get_queue_list @"LineupList.action"
#define queue_passnum @"LineUpPassNum.action" // 过号
#define k_url_get_pushinfo @"actionname=Businesslogin&loginname=18746042175&pwd=123456Businesslogin&loginname=18746042175&pwd=123456"


/**
 *                                  预约
 */
#define booking_list @"BookingList.action"
#define book_appoint @"BookConfirmTab.action" // 接受预约
#define undistribute_table  @"GetUnuseTablenum.action" //获取可以分配给预约人的桌位
#define appoint_refuse @"RefuseBooking.action" // 拒绝预约
#define appoint_reach  @"ConfirmToShop.action" //确认到店
/**
 *                                  呼叫
 */
#define call_list @"CallList.action"// 呼叫
#define call_reply @"CallAnswer.action"// 呼叫确认
#define call_record_list @"CallRecordList.action" //呼叫记录 //获取商家已经应答的呼叫服务列表（当天）


/**
 *                                  订单
 */
#define get_order_list        @"ShopOrderList.action"      //点击订单进入订单列表（默认为到店就餐，获取当天的订单）
#define order_details               @"ShopOrderDetail.action"         //点击订单查看订单详情
#define order_preparefood      @"PreparationProduct.action"   //对订单中没有备菜的菜品进行备菜操作




/**
 *                                  更多
 */

#define shopfeedback @"ShopFeedback.action" //反馈
#define queryversion @"QueryShopVersion.action"// 版本更新




/**
 *                                  后厨
 */

#define k_url_kitchen_get_nodoinfo          @"UnServingList.action?actionname=UnServingList&shopid=1"    //获取未上菜菜品列表（排序按照菜品，时间）
#define k_url_kitchen_get_alreadyinfo       @"ProductRecordList.action?actionname=ProductRecordList&shopid=1" //获取菜品记录包括以上才和撤销菜品（排序按照菜品，时间）
#define k_url_kitchen_undo            @"RecordProduct.action?actionname=RecordProduct&menuid=11&producttype=1"	      //撤销菜品
#define k_url_kitchen_make          @"MakeProduct.action?actionname=MakeProduct&menuid=12&producttype=1"    //制作菜品
#define k_url_kitchen_serving            @"ServingProduct.action?actionname=ServingProduct&menuid=12&producttype=1"      //上菜


/**
 *                                  账单
 */

#define get_bill             @"BillList.action"	
//查询当前日账单，周账单，月账单列表
#define day_bill      @"DayBillList.action" //根据日期，商家id获取日账单

#define month_bill   @"MonthBillList.action" //根据日期，商家id获取月账单






/**
  *                                消息
  */
#define k_url_message_list          @"Businesslogin.action?actionname=Businesslogin&loginname=18746042175&pwd=123456Businesslogin&loginname=18746042175&pwd=123456" //消息列表接口


#endif /* MacroURL_h */
