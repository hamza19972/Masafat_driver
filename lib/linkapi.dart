class AppLink { 

static const String server = "";
static const String imageststatic = "";

//========================== Image ============================
  static const String imagestCategories = "$imageststatic/categories";
  static const String imagestItems = "$imageststatic/items";
// =============================================================
//
  static const String test = "$server/test.php";
  static const String tripsview = "$server/driver/instructions.php";
  static const String updatename = "$server/update_name.php";

  static const String notification = "$server/notification.php";

// ================================= Auth ========================== //

  static const String signUp = "$server/auth/signup.php";
  // static const String login = "$server/auth/login.php";
  static const String welcome= "$server/driver/auth/login.php";
  static const String otpcode = "$server/driver/auth/otpcode.php";
  static const String resend = "$server/driver/auth/resend.php";

  // ================================= Map ========================== //

  static const String riderequest = "$server/ride_est/add.php";
  static const String deleteride = "$server/ride_est/delete.php";
  static const String mytrip = "$server/ride_est/mytrip.php";
  static const String tripdetalis = "$server/ride_est/viewdetalies.php";
  static const String cancel = "$server/ride_est/cancel.php";
  static const String viewroutes = "$server/driver/viewroutes.php";
  static const String submittrip = "$server/driver/addroutes.php";

// ================================= Wallet ========================== //

    static const String walletView = "$server/wallet/view.php";
    static const String sendfund = "$server/wallet/send.php";
    static const String transaction= "$server/wallet/viewtran.php";
    static const String buytrip= "$server/wallet/buytrip.php";
// ================================ver.b================================//
    static const String fullTrip= "$server/driver/tripfull.php";
    static const String viewpasstrip= "$server/driver/viewBookings.php";
    static const String canceleTrip= "$server/driver/driverCanceled.php";
    static const String mytripsv2= "$server/driver/viewtripsV2.php";
    static const String checkBalance= "$server/driver/checkbalance.php";
    static const String token= "$server/driver/token.php";
    static const String buyPass="$server/driver/buypass.php";
    static const String driverResponse= "$server/ride_est/driverResponse.php";


// Home

// items

// Favorite

 
  // Cart
  
  // Address

 
  // Coupon 

  static const String checkcoupon  = "$server/coupon/checkcoupon.php";
  
  // Checkout 

  
}
