
/*
 *  Constants.h
 *  JPI
 *
 *  Created by Gan Jianping on 25 Aug 2013
 *
 *  Copyright 2011 Gan Jianping. All rights reserved.
 *
 */

// SEARCH BY
typedef enum {
    SearchByCategory = 0,
    SearchByKeyword = 1,
    SearchByPoints = 2
} SearchBy;

// REQUEST TYPES
typedef enum {
    RequestTypeGET = 0,
    RequestTypePOST = 1
} RequestType;

// SORTING
typedef enum {
    SortCriteriaByPoints = 0,
    SortCriteriaByAlphabetic = 1,
    SortCriteriaNone = 2
} SortCriteria;

// FORM INPUT VALIDATION
typedef enum {
    TextInputValidationStatusOk = 0,
    TextInputValidationStatusBlank = 1,
    TextInputValidationStatusNotNumeric = 2,
    TextInputValidationStatusNonValidCreditCardNo = 3,
    TextInputValidationStatusNonValidChars = 4
} TextInputValidationStatus;
 

#define TXT_OK                                          @"OK"
#define TXT_CANCEL                                      @"Cancel"
#define NEARBY                                          @"Nearby"
#define VIEW_SITE                                       @"View Website"
#define TXT_BACK                                        @"Back"
#define TXT_TNC                                         @"Terms & Conditions"

// SINGAPORE LATITUDE, LONGITUDE 
#define SG_LAT                                          1.3667
#define SG_LONG                                         103.8

// GOOGLE GEOCODING
#define GOOGLE_GEOCODE_OK_STATUS                        @"OK"
#define GOOGLE_API_SUCCESS_CODE                         200
#define RESULTS_PER_PAGE                                10

#ifdef CLEAN_URL
    // CLEAN URL
    #define URL_GOOGLE_GEOCODE                              @"http://maps.googleapis.com/maps/api/geocode/json?"
#else
    // DIRTY URL
    #define URL_GOOGLE_GEOCODE                              @"http://maps.googleapis.com/maps/api/geocode/json?"
#endif
#define URL_APP_VERSION_CHECK                               @""

// MESSAGES
#define MSG_WHAT_REQUIRED                               @"Please enter a valid search field in What?"
#define MSG_WHERE_REQUIRED                              @"Please enter a valid search in Where?"
#define MSG_EMAIL_FAILURE                               @"Your device is not configured for sending email"
#define MSG_SMS_ERROR                                   @"Unable to send SMS"
#define MSG_FEEDBACK_SENT                               @"Thank you for your Feedback"
#define MSG_FAVORITES_ADDED                             @"Successfully added to your favourites"
#define MSG_FAVORITES_ERROR                             @"This reward has already been in your Favourites"
#define MSG_FEEDBACK_SEND_ERROR                         @"Feedback not sent. Please try again."
#define MSG_NO_INTERNET_CONNECTION                      @"The internet connection is not available"
#define MSG_API_SERVER_UNAVAILABLE                      @"Service is currently unavailable, please try again"
#define MSG_API_SERVER_ERROR                            @"Service is currently unavailable, please try again"
#define MSG_ASK_ADD_TO_FAVORITES                        @"Add to favorites?"
#define MSG_NO_ITEM_SELECTED                            @"Please select at least 1 item"
#define MSG_ASK_DIAL_NUMBER                             @"Call"
#define MSG_CANNOT_FIND_LOCATION                        @"Location not found, please try again"
#define MSG_REQUIRES_GPS                                @"GPS is not activated, please active it in the settings"
#define MSG_CANNOT_ROUTE                                @"Direction is not available, please contact merchant"
#define MSG_FEEDBACK_VALIDATION                         @"Please enter Name and Email"
#define MSG_TO_ACTIVATE_LOCATION_SERVICE                @"Turn on Location Services on your device to allow \"JPI\" to determine your location"
#define MSG_ASK_TO_ENTER_CURRENT_LOCATION               @"Location Services is not enabled, please enter your current location:"
#define MSG_GEOCODE_ERROR                               @"Sorry, we are unable to determine the location from your input"
#define MSG_CONFIRM_LOGOUT                              @"Do you want to log out?"
#define MSG_SIGNIN_CREDENTIAL_FAILED                    @"NRIC or card number entered wrongly. Please try again."
#define MSG_SIGNIN_DOUBLE                               @"You already signed in another mobile device, please sign out."
#define MSG_BLANK_NRIC_OR_CARDNUMBER                    @"Please enter NRIC and Card Number"
#define MSG_NONVALID_CREDITCARD                         @"Please enter a proper credit card number"
#define MSG_NONVALID_CHARACTERS                         @"Please enter a valid ID number"
#define MSG_CANNOT_CALL                                 @"Sorry, unable to make a call"
#define MSG_CART_ADDED                                  @"Successfully added to your Cart"
#define MSG_ALERT_USER_SESSION                          @"You will be signed-out if there is no online activity for the next 5 minutes"

// REQUEST TIMEOUT (SECONDS) - 60 ON DEPLOYMENT
#define REQUEST_TIMEOUT  60

// AUTO SIGN-OUT ON ONLINE INACTIVITY (SECONDS) - 300, 600 ON DEPLOYMENT
#define TIMER_SESSION_ALERT_INTERVAL    300 
#define TIMER_SESSION_END_INTERVAL      600

// LOGIN ATTEMPTS AND TIME TO ALLOW TO RE-LOGIN
#define MAX_LOGIN_FAILED_ATTEMPTS   3
#define TIME_INTERVAL_AFTER_3_FAILED_LOGIN_ATTEMPTS    600

