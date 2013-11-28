//
//  JpConst.h
//  JOne
//
//  Created by Johnny on 26/10/13.
//  Copyright (c) 2013 ganjp. All rights reserved.
//

#import <Foundation/Foundation.h>

//Url
#define URL_GANJP_WEBSITE @"http://www.ganjianping.com"
//extern NSString * const URL_GANJP_WEBSITE;

//Sample
#define IOS_SAMPLES_DIC @{@"Basic" : @"Form,Property List Table,Core Data Table,Collection View,Bottom Tab Bar", @"Network" : @"Web View"};

//Left Menu
#define ARTICLES_CATEGORIES @"Home,Programming,Application,Hardware"
#define SAMPLE_CATEGORIES @"iOS,jQuery Mobile,Sencha Touch"
#define SETTINGS @"About"
#define LEFT_MENU_TITLES @"News,Samples,Settings"
#define ARTICLES @{@"Home" : @"ANDROID,iOS,MOBILE APP,PHONE,TABLET", @"Programming" : @"ANDROID,iOS,JAVA,HTML,Javascript", @"Application" : @"MOBILE APP,WEBSITE,WINDOW APP,MAC APP,UI DESIGN", @"Hardware" : @"PHONE,TABLET,WATCH"};

//JWeb
#define KEY_JWEB @"jweb"
#define KEY_CM_PHOTO_LAST_TIME @"cmPhotoLastTime"
#define KEY_CM_ARTICLE_LAST_TIME @"cmArticleLastTime"
#define KEY_BM_CONFIG_LAST_TIME @"cmConfigLastTime"
#define KEY_LAST_TIME @"lastTime"
#define KEY_START_DATE @"startDate"
#define KEY_FILE_URL @"fileUrl"
#define KEY_VIDEO_URL @"videoUrl"
#define KEY_AUDIO_URL @"audioUrl"
#define KEY_IMAGE_URL @"imageUrl"
#define KEY_FILE_URL @"fileUrl"

//DB
#define DB_NAME @"jone.sqlite"

#define TABLE_BM_CONFIG @"bm_config"
#define COLUMN_CONFIG_ID @"configId"
#define COLUMN_CONFIG_CD @"configCd"
#define COLUMN_CONFIG_NAME @"configName"
#define COLUMN_CONFIG_VALUE @"configValue"

#define TABLE_CM_ARTICLE @"cm_article"
#define COLUMN_ARTICLE_ID @"articleId"
#define COLUMN_ARTICLE_CD @"articleCd"
#define COLUMN_SUMMARY @"summary"
#define COLUMN_CONTENT @"content"
#define COLUMN_AUTHORE @"author"
#define COLUMN_IMAGE_URL @"imageUrl"

#define TABLE_CM_PHOTO @"cm_photo"
#define COLUMN_PHOTO_ID @"photoId"
#define COLUMN_PHOTO_NAME @"photoName"
#define COLUMN_REF_ARTICLE_ID @"refArticleId"
#define COLUMN_THUMB_URL @"thumbUrl"
#define COLUMN_URL @"url"

#define COLUMN_ORIGIN_URL @"originUrl"
#define COLUMN_TITLE @"title"
#define COLUMN_REMARK @"remark"
#define COLUMN_DESCRIPTION @"description"
#define COLUMN_TAG @"tag"
#define COLUMN_DISPLAY_NO @"displayNo"
#define COLUMN_ROLE_IDS @"roleIds"
#define COLUMN_OPERATOR_ID @"operatorId"
#define COLUMN_OPERATOR_NAME @"operatorName"
#define COLUMN_LANG @"lang"
#define COLUMN_CREATE_DATE_TIME @"createDateTime"
#define COLUMN_MODIFY_TIMESTAMP @"modifyTimestamp"
#define COLUMN_DATA_STATE @"dataState"
#define COLUMN_QUERY_FILTERS @"queryFilters"




