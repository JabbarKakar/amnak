/// Generated file. Do not edit.
///
/// Original: lib/i18n
/// To regenerate, run: `dart run slang`
///
/// Locales: 2
/// Strings: 548 (274 per locale)
///
/// Built on 2025-07-06 at 18:32 UTC

// coverage:ignore-file
// ignore_for_file: type=lint

import 'package:flutter/widgets.dart';
import 'package:slang/builder/model/node.dart';
import 'package:slang_flutter/slang_flutter.dart';
export 'package:slang_flutter/slang_flutter.dart';

const AppLocale _baseLocale = AppLocale.en;

/// Supported locales, see extension methods below.
///
/// Usage:
/// - LocaleSettings.setLocale(AppLocale.en) // set locale
/// - Locale locale = AppLocale.en.flutterLocale // get flutter locale from enum
/// - if (LocaleSettings.currentLocale == AppLocale.en) // locale check
enum AppLocale with BaseAppLocale<AppLocale, Translations> {
	en(languageCode: 'en', build: Translations.build),
	ar(languageCode: 'ar', build: _StringsAr.build);

	const AppLocale({required this.languageCode, this.scriptCode, this.countryCode, required this.build}); // ignore: unused_element

	@override final String languageCode;
	@override final String? scriptCode;
	@override final String? countryCode;
	@override final TranslationBuilder<AppLocale, Translations> build;

	/// Gets current instance managed by [LocaleSettings].
	Translations get translations => LocaleSettings.instance.translationMap[this]!;
}

/// Method A: Simple
///
/// No rebuild after locale change.
/// Translation happens during initialization of the widget (call of t).
/// Configurable via 'translate_var'.
///
/// Usage:
/// String a = t.someKey.anotherKey;
/// String b = t['someKey.anotherKey']; // Only for edge cases!
Translations get t => LocaleSettings.instance.currentTranslations;

/// Method B: Advanced
///
/// All widgets using this method will trigger a rebuild when locale changes.
/// Use this if you have e.g. a settings page where the user can select the locale during runtime.
///
/// Step 1:
/// wrap your App with
/// TranslationProvider(
/// 	child: MyApp()
/// );
///
/// Step 2:
/// final t = Translations.of(context); // Get t variable.
/// String a = t.someKey.anotherKey; // Use t variable.
/// String b = t['someKey.anotherKey']; // Only for edge cases!
class TranslationProvider extends BaseTranslationProvider<AppLocale, Translations> {
	TranslationProvider({required super.child}) : super(settings: LocaleSettings.instance);

	static InheritedLocaleData<AppLocale, Translations> of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context);
}

/// Method B shorthand via [BuildContext] extension method.
/// Configurable via 'translate_var'.
///
/// Usage (e.g. in a widget's build method):
/// context.t.someKey.anotherKey
extension BuildContextTranslationsExtension on BuildContext {
	Translations get t => TranslationProvider.of(this).translations;
}

/// Manages all translation instances and the current locale
class LocaleSettings extends BaseFlutterLocaleSettings<AppLocale, Translations> {
	LocaleSettings._() : super(utils: AppLocaleUtils.instance);

	static final instance = LocaleSettings._();

	// static aliases (checkout base methods for documentation)
	static AppLocale get currentLocale => instance.currentLocale;
	static Stream<AppLocale> getLocaleStream() => instance.getLocaleStream();
	static AppLocale setLocale(AppLocale locale, {bool? listenToDeviceLocale = false}) => instance.setLocale(locale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale setLocaleRaw(String rawLocale, {bool? listenToDeviceLocale = false}) => instance.setLocaleRaw(rawLocale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale useDeviceLocale() => instance.useDeviceLocale();
	@Deprecated('Use [AppLocaleUtils.supportedLocales]') static List<Locale> get supportedLocales => instance.supportedLocales;
	@Deprecated('Use [AppLocaleUtils.supportedLocalesRaw]') static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
	static void setPluralResolver({String? language, AppLocale? locale, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver}) => instance.setPluralResolver(
		language: language,
		locale: locale,
		cardinalResolver: cardinalResolver,
		ordinalResolver: ordinalResolver,
	);
}

/// Provides utility functions without any side effects.
class AppLocaleUtils extends BaseAppLocaleUtils<AppLocale, Translations> {
	AppLocaleUtils._() : super(baseLocale: _baseLocale, locales: AppLocale.values);

	static final instance = AppLocaleUtils._();

	// static aliases (checkout base methods for documentation)
	static AppLocale parse(String rawLocale) => instance.parse(rawLocale);
	static AppLocale parseLocaleParts({required String languageCode, String? scriptCode, String? countryCode}) => instance.parseLocaleParts(languageCode: languageCode, scriptCode: scriptCode, countryCode: countryCode);
	static AppLocale findDeviceLocale() => instance.findDeviceLocale();
	static List<Locale> get supportedLocales => instance.supportedLocales;
	static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
}

// translations

// Path: <root>
class Translations implements BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	// Translations
	String get language => 'English';
	String get welcome => 'Welcome';
	String get passwordUpdated => 'Password has been updated successfully';
	String get confairmData => 'Please check your details';
	String get conectApp => 'Check your connection';
	String get email => 'email';
	String get id => 'id';
	String get project => 'Project';
	String get title => 'Title';
	String get message => 'Message';
	String get courses => 'Courses';
	String get lectures => 'Lectures';
	String get loginByEmail => 'Login by email';
	String get loginByPhone => 'Login by phone';
	String get loginByIdentifier => 'Login by identifier';
	String get reportType => 'Report Type';
	String get priority => 'Priority';
	String get numberOfExperienceYears => 'Number of Experience Years';
	String get verificationCode => 'Verification Code';
	String get success => 'Success';
	String get noData => 'No Data';
	String get carNumber => 'Car Number';
	String get startCall => 'Start Call';
	String get companyName => 'Company Name';
	String get haveNiceCall => 'Have a nice call';
	String get qualifications => 'Qualifications';
	String get terms => 'Terms And Conditions';
	String get login => 'login';
	String get remember => 'remember';
	String get password => 'password';
	String get passwordConf => 'password confirmation';
	String get confirmCode => 'investigation code';
	String get save => 'Save';
	String get instructions => 'Instructions';
	String get conversations => 'Conversations';
	String get persons => 'Persons';
	String get confairmMsEmail => 'Please check your email to enter the password reset code';
	String get msNoEmail => 'No accounts were found with this email address';
	String get msErrorEmail => 'Please enter the correct email';
	String get enterEmail => 'Please enter your email';
	String get enterCode => 'The verification code has been sent, please check your email';
	String get send => 'Send';
	String get loading => 'Loading...';
	String get firstName => 'First Name';
	String get middleName => 'Middle Name';
	String get lastName => 'Last Name';
	String get idNumber => 'ID Number';
	String get idImage => 'ID Image';
	String get enterWeight => 'Enter Weight';
	String get enterGender => 'Enter Gender';
	String get male => 'Male';
	String get female => 'Female';
	String get callAmbulance => 'Call Ambulance';
	String get report => 'Report';
	String get projects => 'Projects';
	String get visitors => 'Visitors';
	String get enterLength => 'Enter Length';
	String get companyId => 'Company Id';
	String get completFiled => 'Complete all fields';
	String get goSingIn => 'go to sign up with name';
	String get singIn => 'sign in';
	String get singInNew => 'Log in';
	String get forgetPass => 'Did you forget your password ?';
	String get register => ' Register an account';
	String get doyouRegister => 'Do you want to create a new account?';
	String get doHaveAccount => 'Do you have an account?';
	String get completedData => 'Complete your information';
	String get registerNew => 'Create a new account';
	String get name => 'Full Name';
	String get phone => 'Mobile number';
	String get create => 'Create';
	String get compleateOrder => 'Complete the order';
	String get infPerson => 'personal information';
	String get change => 'change';
	String get namePerson => 'ahmed khattab';
	String get phonePerson => '00201552344879';
	String get cityPerson => 'Riyadh';
	String get addressPerson => 'current address';
	String get addressPrsonName => 'Riyadh city street';
	String get payingFrom => 'Pay through';
	String get banking => 'Bank transfer';
	String get stc => 'stc';
	String get mada => 'Midi Card';
	String get whenYouTake => 'upon receipt';
	String get makeProcce => 'Execution of the request';
	String get orderNumber => 'order number';
	String get cartEmpty => 'Cart is empty';
	String get subtotal => 'Subtotal';
	String get taxFee => 'tax fee';
	String get total => 'Total';
	String get conOrder => 'Confirmation';
	String get price => 'price';
	String get maiQuantity => 'Minimum Quantity available for you is';
	String get maxQuantity => 'Maximum Quantity available for you is';
	String get available => 'items available in stock';
	String get only => 'only :';
	String get takeOrderSuc => 'Your request has been successfully received';
	String get thanks => 'Thank you, you can continue your order now';
	String get takeorder => 'Your request has been received ';
	String get charged => 'charged ';
	String get numbertraking => 'tracking number';
	String get deliverySuccess => 'Delivered Successfully';
	String get backHome => 'Back to the home ';
	String get seeds => 'seeds';
	String get vitals => 'vitals';
	String get cucumber => 'cucumber';
	String get classification => 'classification';
	String get noProduct => 'There are no products';
	String get discount => 'Discount';
	String get trayAgain => 'Try again';
	String get search => 'search for.';
	String get notLaunch => 'Could not launch www.eradco.com';
	String get vistLink => 'You can visit the following link';
	String get inStock => 'In stock :';
	String get notAvilabal => 'Currently unavailable!';
	String get minOrder => 'Minimum order :';
	String get maxOrder => 'Maximum order:';
	String get payFromOnly => 'Selling through branches only';
	String get video => 'Product video';
	String get downloadPDF => 'Download the newsletter';
	String get aboutProduct => 'About the product';
	String get addToCart => 'add to cart';
	String get addToFavo => 'Item has been added to favourites';
	String get cart => 'Cart';
	String get myFavorites => 'My FmFavorites';
	String get branches => 'Branches';
	String get picturesAndSend => 'Pictures And Send';
	String get profile => 'Profile';
	String get delivery => ' Shipping and delivery';
	String get infopay => ' payment information';
	String get privacy => 'Privacy policy';
	String get callUs => 'call us';
	String get logOut => 'sign out';
	String get cautionaryMessage => 'Cautionary Message';
	String get cautionaryContain => 'Do you want to remove the product from your favourites';
	String get yes => 'Yes';
	String get no => 'No';
	String get delete => 'Delete';
	String get noResults => 'No Results';
	String get searchAbout => 'Search for';
	String get noArticles => 'There are no articles';
	String get media => 'media';
	String get photo => 'photos';
	String get articles => 'articles';
	String get videos => 'Videos';
	String get releases => 'releases';
	String get noImage => 'There are no Images';
	String get noReleases => 'There are no Releases';
	String get noVideos => 'There are no Videos';
	String get properties => 'Properties';
	String get selectedLocation => 'Selected Location';
	String get youCurrentLocation => 'Your Current Location';
	String get loadYourSite => 'Getting Location';
	String get locationDisabled => 'Location services are disabled.';
	String get locationDenied => 'Location permissions are denied';
	String get locationPermissions => 'Location permissions are permanently denied, we cannot request permissions.';
	String get region => 'Region';
	String get nameStreet => 'Street name';
	String get nearestPlace => 'Nearest Place';
	String get saveAddress => 'save address';
	String get addNewAddress => 'Add a new title';
	String get orderDetails => 'Order Details';
	String get followOrder => 'follow up with the order';
	String get approvedOrder => 'Application No. has been approved';
	String get requestProgress => 'Your request is in progress';
	String get quantity => 'Quantity';
	String get paymentMethod => 'Payment Method';
	String get deliveryOptions => 'Delivery Options';
	String get shippingAddress => 'Shipping Address';
	String get myInfo => 'Information';
	String get myOrders => 'Orders';
	String get myNotification => 'Notification';
	String get myAddress => 'Address';
	String get changePassword => 'Change Password';
	String get passwordChangeFailed => 'Old Password wrong';
	String get passwordChanged => 'Password changed';
	String get oldPassword => 'Old Password';
	String get newPassword => 'New Password';
	String get newPasswordConf => 'Confirm the new password';
	String get close => 'close';
	String get noProductFavorite => 'There are no favourites';
	String get confirmation => 'confirmation';
	String get updateProfile => 'Update profile';
	String get addedToCart => 'Item Added Successfully';
	String get home => 'Home';
	String get offers => 'Offers';
	String get all => 'all';
	String get protected => 'protected';
	String get public => 'public';
	String get logInFirst => 'You should Login First';
	String get checkout => 'Checkout';
	String get selectAddress => 'Select Address';
	String get noAddresses => 'You don\'t have any Addresses yet..';
	String get orderIsSuccessful => 'Your Order has been Successfully Received';
	String get failedToPay => 'Payment Failed';
	String get cancelOrder => 'Cancel Order';
	String get newPasswordInForget => 'Please enter the new password';
	String get add => 'Add';
	String get needCommercialApproved => 'Please wait for the ID you submitted to be approved';
	String get addCommercial => 'This product requires a commercial registration or national identity';
	String get back => 'Back';
	String get welcomeOnTheBiggestReadingSociety => 'Welcome on the biggest reading society';
	String get emailOrPhone => 'Email or phone number';
	String get orLoginWith => 'Or login with';
	String get loginToYourAccount => 'Login to your account';
	String get completeCreatingYourAccount => 'Complete creating your account';
	String get dontWorryYourPersonalData => 'Don\'t worry, your personal data';
	String get NoOneSeesItExceptYou => 'No one sees it except you';
	String get birthDate => 'Birth Date';
	String get updateAccount => 'Update Account';
	String get required => 'please fill in this field';
	String get address => 'Address';
	String get bio => 'Bio';
	String get publisher_management => 'Publisher Management';
	String get authors_management => 'Authors Management';
	String get books_management => 'Books Management';
	String get ads_management => 'Ads Management';
	String get notifications => 'Notifications';
	String get my_books => 'My Books';
	String get my_followings => 'My Followings';
	String get my_quotes => 'My Quotes';
	String get personal_info => 'Personal Info';
	String get following => 'Followings';
	String get reading => 'Reading';
	String get finished => 'Finished';
	String get read => 'Read';
	String get delete_account => 'Delete Account';
	String get settings => 'Settings';
	String get theme => 'Theme';
	String get authors => 'Authors';
	String get WelcomeIn => 'Welcome In';
	String get biggestSocietyForPublishersAndAuthors => 'The biggest society for publishers and authors';
	String get AndCreativesAndReadingEnthusiastsInMiddleEast => 'And Creatives And Reading Enthusiasts In The Middle East';
	String get iHaveAnAccount => 'I have an account';
	String get publishers => 'Publishers';
	String get enterValidPass => 'Please enter a valid password';
	String get passwordShouldBe6Char => 'Password should be at least 6 characters';
	String get guest => 'Guest';
	String get employeeEvaluation => 'Employee Evaluation';
	String get evaluationDetails => 'Evaluation Details';
	String get evaluationSummary => 'Evaluation Summary';
	String get evaluationItems => 'Evaluation Items';
	String get totalScore => 'Total Score';
	String get averageScore => 'Average Score';
	String get numberOfItems => 'Number of Items';
	String get evaluationDate => 'Evaluation Date';
	String get evaluationTitle => 'Evaluation Title';
	String get evaluationItem => 'Evaluation Item';
	String get score => 'Score';
	String get noEvaluationsAvailable => 'No evaluations available';
	String get retry => 'Retry';
	String get errorLoadingEvaluations => 'Error loading evaluations';
	String get errorLoadingDetails => 'Error loading details';
	String get noInternetConnection => 'No internet connection';
	String get failedToLoadEvaluations => 'Failed to load evaluations';
	String get failedToLoadDetails => 'Failed to load details';
	String get noDetailsAvailable => 'No details available';
	String get date => 'Date';
	String get undefined => 'Undefined';
	String get employeePermissions => 'Employee Permissions';
	String get permissionDetails => 'Permission Details';
	String get permissionInformation => 'Permission Information';
	String get permissionType => 'Permission Type';
	String get permissionDate => 'Permission Date';
	String get permissionId => 'Permission ID';
	String get permissionImage => 'Permission Image';
	String get noPermissionsAvailable => 'No permissions available';
	String get imageNotAvailable => 'Image not available';
	String get makePersonalRequest => 'Make a Personal Request';
	String get myPersonalRequest => 'My Personal Requests';
	String get personalRequestDetails => 'Personal Request Details';
	String get safetyCheckDetails => 'Safety Check Details';
	String get safetyCheckStore => 'Safety Check Store';
	String get safetyCheckProjectDetails => 'Safety Check Project Details';
}

// Path: <root>
class _StringsAr implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_StringsAr.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.ar,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <ar>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	@override late final _StringsAr _root = this; // ignore: unused_field

	// Translations
	@override String get language => 'العربية';
	@override String get welcome => 'مرحبا';
	@override String get passwordUpdated => 'تم تحديث كلمة المرور بنجاح';
	@override String get confairmData => 'من فضلك تأكد من بياناتك';
	@override String get conectApp => 'تاكد من اتصالك';
	@override String get email => 'البريد الالكتروني';
	@override String get id => 'الرقم التعريفي';
	@override String get password => 'كلمة السر';
	@override String get passwordConf => 'تأكيد كلمة السر';
	@override String get confirmCode => 'كود التحقيق';
	@override String get save => 'حفظ';
	@override String get login => 'تسجيل الدخول';
	@override String get courses => 'دورات';
	@override String get lectures => 'محاضرات';
	@override String get project => 'مشروع';
	@override String get title => 'عنوان';
	@override String get terms => 'الشروط والاحكام';
	@override String get qualifications => 'المؤهلات';
	@override String get success => 'تم بنجاح';
	@override String get message => 'رسالة';
	@override String get reportType => 'نوع التقرير';
	@override String get loginByEmail => 'تسجيل الدخول عبر البريد الإلكتروني';
	@override String get loginByPhone => 'تسجيل الدخول عبر الهاتف';
	@override String get loginByIdentifier => 'تسجيل الدخول عن طريق المعرف';
	@override String get numberOfExperienceYears => 'عدد سنوات الخبرة';
	@override String get priority => 'أولوية';
	@override String get remember => 'يتذكر';
	@override String get instructions => 'التعليمات';
	@override String get conversations => 'المحادثات';
	@override String get persons => 'الأشخاص';
	@override String get firstName => 'الاسم الأول';
	@override String get middleName => 'الاسم الأوسط';
	@override String get lastName => 'اسم العائلة';
	@override String get noData => 'لا يوجد بيانات';
	@override String get haveNiceCall => 'اتمنى لك مكالمة جيدة';
	@override String get idNumber => 'رقم الهوية';
	@override String get verificationCode => 'رمز التحقق';
	@override String get idImage => 'صورة بطاقة الهوية';
	@override String get enterWeight => 'ادخل الوزن';
	@override String get callAmbulance => 'اتصل بالطوارئ';
	@override String get report => 'تقديم بلاغ';
	@override String get carNumber => 'رقم السيارة';
	@override String get companyName => 'اسم الشركة';
	@override String get startCall => 'بدء المكالمة';
	@override String get projects => 'المشاريع';
	@override String get visitors => 'الزوار';
	@override String get enterLength => 'ادخل الطول';
	@override String get enterGender => 'ادخل الجنس';
	@override String get male => 'ذكر';
	@override String get female => 'انثى';
	@override String get companyId => 'رقم الشركة';
	@override String get confairmMsEmail => 'من فضلك تأكد من بريدك الالكتروني  لأدخال كود اعادة كلمة المرور';
	@override String get msNoEmail => 'لم يتم العثور على أيّ حسابٍ بهذا العنوان الإلكتروني';
	@override String get msErrorEmail => 'من فضلك أدخل الايميل الصحيح';
	@override String get enterEmail => 'من فضلك ادخل بريدك الالكتروني';
	@override String get enterValidPass => 'من فضلك ادخل كلمة سر صحيحة';
	@override String get passwordShouldBe6Char => 'كلمة المرور يجب ان تكون 6 حروف على الاقل';
	@override String get enterCode => 'تم ارسال كود التحقيق من فضلك افحص بريدك الالكتروني ';
	@override String get send => 'ارسال';
	@override String get loading => 'جار التحميل';
	@override String get completFiled => 'اكمل جميع الحقول';
	@override String get goSingIn => 'اذهب للتسجيل بالاسم';
	@override String get singIn => 'تسجيل الدخول';
	@override String get singInNew => 'سجل دخول';
	@override String get forgetPass => 'هل نسيت كلمة المرور ؟';
	@override String get register => 'إنشاء حساب جديد';
	@override String get doyouRegister => 'هل تريد انشاء حساب جديد ؟';
	@override String get doHaveAccount => 'هل تمتلك حساب ؟';
	@override String get completedData => 'أكمل بياناتك';
	@override String get registerNew => 'انشاء حساب جديد';
	@override String get name => 'الاسم كامل';
	@override String get phone => 'رقم الجوال';
	@override String get create => 'انشاء';
	@override String get compleateOrder => 'اتمام الطلب';
	@override String get infPerson => 'المعلومات الشخصية';
	@override String get change => 'تغير';
	@override String get namePerson => 'أحمد خطاب';
	@override String get phonePerson => '00201552344879';
	@override String get cityPerson => 'الرياض';
	@override String get addressPerson => 'العنوان الحالي';
	@override String get addressPrsonName => 'الرياض شارع المدينه';
	@override String get payingFrom => 'الدفع من خلال ';
	@override String get banking => 'التحويل البنكي';
	@override String get stc => 'stc';
	@override String get mada => 'مدي';
	@override String get whenYouTake => 'عند الاستلام';
	@override String get makeProcce => 'تنفيذ الطلب';
	@override String get orderNumber => ' رقم الطلب';
	@override String get cartEmpty => 'السلة فارغة';
	@override String get subtotal => 'المجموع الفرعي';
	@override String get taxFee => ' رسوم الضريبة';
	@override String get total => 'الاجمالي';
	@override String get conOrder => 'تأكيد الطلب';
	@override String get price => 'السعر';
	@override String get maiQuantity => 'أقل كمية متاحة لك هي';
	@override String get maxQuantity => 'الكمية القصوى المتاحة لك هي';
	@override String get available => 'العناصر المتوفرة في المخزون';
	@override String get only => 'فقط :';
	@override String get takeOrderSuc => 'تم استلام طلبك بنجاج';
	@override String get thanks => 'شكرا لك يمكنك متابعة طلبك الأن';
	@override String get takeorder => 'تم استلام طلبك ';
	@override String get charged => 'تم الشحن';
	@override String get numbertraking => 'رقم التتبع';
	@override String get deliverySuccess => 'تم التسليم';
	@override String get backHome => ' الرجوع الي الصفحة الرئيسية';
	@override String get seeds => 'البذور';
	@override String get vitals => 'فيتالس';
	@override String get cucumber => 'خيار';
	@override String get classification => 'تصنيف';
	@override String get noProduct => 'لا توجد منتجات';
	@override String get discount => 'خصم';
	@override String get trayAgain => 'حاول مجدداً';
	@override String get search => 'يبحث';
	@override String get notLaunch => 'تعذر الإطلاق الي';
	@override String get vistLink => 'يمكنك زيارة الرابط التالي';
	@override String get inStock => 'متوفر بالمخزون :';
	@override String get notAvilabal => 'غير متاح حاليا !';
	@override String get minOrder => 'الحد الأدني للطلب :';
	@override String get maxOrder => 'الحد الأقصي للطلب : ';
	@override String get payFromOnly => 'البيع من خلال الفروع فقط';
	@override String get video => 'فيديو للمنتج';
	@override String get downloadPDF => 'تحميل النشرة';
	@override String get aboutProduct => 'نبذة عن المنتج';
	@override String get addToCart => 'اضافة الي السلة';
	@override String get addToFavo => 'تم اضافة العنصر الي المفضلة';
	@override String get cart => 'السلة';
	@override String get myFavorites => 'مفضلاتي';
	@override String get branches => 'الفروع';
	@override String get picturesAndSend => ' صور وارسل';
	@override String get profile => 'الملف الشخصي';
	@override String get delivery => ' الشحن و التوصيل';
	@override String get infopay => ' معلومات الدفع';
	@override String get privacy => 'سياسة الخصوصية';
	@override String get callUs => 'اتصل بنا';
	@override String get logOut => 'تسجيل الخروج';
	@override String get cautionaryMessage => 'رسالة تحزيرية';
	@override String get cautionaryContain => 'هل تريد حذف المنتج من المفضلة';
	@override String get yes => 'نعم';
	@override String get no => 'لا';
	@override String get delete => 'حذف';
	@override String get noResults => 'لا توجد نتائج';
	@override String get searchAbout => 'ابحث عن ( منتجات / مقالات / نشرات طبية)';
	@override String get noArticles => 'لا توجد مقالات';
	@override String get media => 'الوسائط';
	@override String get photo => 'الصور';
	@override String get articles => 'المقالات';
	@override String get videos => 'الفيديوهات';
	@override String get releases => 'النشرات';
	@override String get noImage => 'لا توجد  صور';
	@override String get noReleases => 'لا توجد نشرات';
	@override String get noVideos => 'لا توجد فيديوهات';
	@override String get properties => 'الخصائص';
	@override String get selectedLocation => 'اختار موقعك';
	@override String get youCurrentLocation => 'موقعك الحالي';
	@override String get loadYourSite => 'تحميل موقعك';
	@override String get locationDisabled => 'خدمات الموقع معطلة.';
	@override String get locationDenied => 'تم رفض أذونات الموقع';
	@override String get locationPermissions => 'أذونات الموقع مرفوضة بشكل دائم ، ولا يمكننا طلب أذونات.';
	@override String get region => 'المنطقة';
	@override String get nameStreet => 'اسم الشارع';
	@override String get nearestPlace => 'أقرب معلم';
	@override String get saveAddress => 'حفظ العنوان';
	@override String get addNewAddress => 'اضافة عنوان جديد';
	@override String get orderDetails => 'تفاصيل الطلب';
	@override String get followOrder => 'متابعة الطلب';
	@override String get approvedOrder => 'تمت الموافقة علي الطلب رقم';
	@override String get requestProgress => 'طلبك قيد التنفيذ';
	@override String get quantity => 'الكمية';
	@override String get paymentMethod => 'طريقة الدفع';
	@override String get deliveryOptions => 'خيارات التوصيل';
	@override String get shippingAddress => 'عنوان الشحن';
	@override String get myInfo => 'معلوماتي';
	@override String get myOrders => 'طلباتي';
	@override String get myNotification => 'اشعاراتي';
	@override String get myAddress => 'عناويني';
	@override String get changePassword => 'تغيير كلمة السر';
	@override String get passwordChangeFailed => 'كلمة السر القديمة غير صحيحة';
	@override String get passwordChanged => 'تم تغير كلمة السر بنجاح';
	@override String get oldPassword => 'كلمة السر القديمة';
	@override String get newPassword => 'كلمة السر الجديدة';
	@override String get newPasswordConf => 'تأكيد كلمة السر الجديدة';
	@override String get close => 'الغاء';
	@override String get noProductFavorite => 'لايوجد منتجات مفضلة';
	@override String get confirmation => 'تـأكيد';
	@override String get updateProfile => 'تحديث بياناتي';
	@override String get addedToCart => 'تمت اضافة المنتج';
	@override String get home => 'الرئيسية';
	@override String get offers => 'العروض';
	@override String get all => 'الكل';
	@override String get protected => 'محمي';
	@override String get public => 'مكشوف';
	@override String get logInFirst => 'يجب تسجيل الدخول اولا';
	@override String get checkout => 'تنفيذ الطلب';
	@override String get selectAddress => 'حدد العنوان';
	@override String get noAddresses => 'ليس لديك عناوين حتي الآن..';
	@override String get orderIsSuccessful => 'تم استلام طلبك بنجاح';
	@override String get failedToPay => 'فشل الدفع';
	@override String get cancelOrder => 'الغاء الطلب';
	@override String get add => 'اضافة';
	@override String get needCommercialApproved => 'برجاء انتظار الموافقة علي الهوية التي قمت بتقديمها';
	@override String get addCommercial => 'هذا المنتج يتطلب سجل تجاري او هوية وطنية';
	@override String get newPasswordInForget => 'من فضلك أدخل كلمة السر الجديدة';
	@override String get back => 'رجوع';
	@override String get loginToYourAccount => 'الدخول لحسابك';
	@override String get welcomeOnTheBiggestReadingSociety => 'مرحبا بك في اكبر مجتمع للقراءة';
	@override String get emailOrPhone => 'البريد الإلكتروني أو رقم الهاتف';
	@override String get orLoginWith => 'أو الدخول بواسطة';
	@override String get completeCreatingYourAccount => 'أكمل إنشاء حسابك';
	@override String get dontWorryYourPersonalData => 'لا تقلق جميع بياناتك الشخصية';
	@override String get NoOneSeesItExceptYou => 'لا أحد يراها إلا أنت';
	@override String get birthDate => 'تاريخ الميلاد';
	@override String get required => 'الحقل مطلوب';
	@override String get address => 'عنوان';
	@override String get publisher_management => 'ادارة دار النشر';
	@override String get authors_management => 'ادارة المؤلفين';
	@override String get books_management => 'ادارة الكتب';
	@override String get ads_management => 'ادارة التسويق';
	@override String get notifications => 'التنبيهات';
	@override String get my_books => 'كتبي';
	@override String get my_followings => 'متابعاتي';
	@override String get my_quotes => 'اقتباساتي';
	@override String get personal_info => 'المعلومات الشخصية';
	@override String get following => 'متابعة';
	@override String get reading => 'القراءة';
	@override String get finished => 'انتهيت';
	@override String get read => 'تقرأ';
	@override String get authors => 'مؤلفين';
	@override String get publishers => 'دور النشر';
	@override String get bio => 'السيرة الذاتية';
	@override String get delete_account => 'حذف الحساب';
	@override String get settings => 'الاعدادات';
	@override String get theme => 'الوضع';
	@override String get updateAccount => 'تحديث الحساب';
	@override String get WelcomeIn => 'مرحبًا في';
	@override String get biggestSocietyForPublishersAndAuthors => 'أكبر مجتمع للناشرين والمؤلفين';
	@override String get AndCreativesAndReadingEnthusiastsInMiddleEast => ' والمبدعين وعشاق القراءة في الشرق الأوسط';
	@override String get iHaveAnAccount => 'لدي حساب';
	@override String get guest => 'زائر';
	@override String get employeeEvaluation => 'تقييم الموظفين';
	@override String get evaluationDetails => 'تفاصيل التقييم';
	@override String get evaluationSummary => 'ملخص التقييم';
	@override String get evaluationItems => 'عناصر التقييم';
	@override String get totalScore => 'المجموع الكلي';
	@override String get averageScore => 'المتوسط';
	@override String get numberOfItems => 'عدد العناصر';
	@override String get evaluationDate => 'تاريخ التقييم';
	@override String get evaluationTitle => 'عنوان التقييم';
	@override String get evaluationItem => 'عنصر التقييم';
	@override String get score => 'الدرجة';
	@override String get noEvaluationsAvailable => 'لا توجد تقييمات متاحة';
	@override String get retry => 'إعادة المحاولة';
	@override String get errorLoadingEvaluations => 'خطأ في تحميل التقييمات';
	@override String get errorLoadingDetails => 'خطأ في تحميل التفاصيل';
	@override String get noInternetConnection => 'لا يوجد اتصال بالإنترنت';
	@override String get failedToLoadEvaluations => 'فشل في تحميل التقييمات';
	@override String get failedToLoadDetails => 'فشل في تحميل التفاصيل';
	@override String get noDetailsAvailable => 'لا توجد تفاصيل متاحة';
	@override String get date => 'التاريخ';
	@override String get undefined => 'غير محدد';
	@override String get employeePermissions => 'تصاريح الموظفين';
	@override String get permissionDetails => 'تفاصيل التصريح';
	@override String get permissionInformation => 'معلومات التصريح';
	@override String get permissionType => 'نوع التصريح';
	@override String get permissionDate => 'تاريخ التصريح';
	@override String get permissionId => 'رقم التصريح';
	@override String get permissionImage => 'صورة التصريح';
	@override String get noPermissionsAvailable => 'لا توجد تصاريح متاحة';
	@override String get imageNotAvailable => 'الصورة غير متاحة';
	@override String get makePersonalRequest => 'تقديم طلب شخصي';
	@override String get myPersonalRequest => 'طلباتي الشخصية';
	@override String get personalRequestDetails => 'تفاصيل الطلب الشخصي';
	@override String get safetyCheckDetails => 'تفاصيل التحقق من السلامة';
	@override String get safetyCheckStore => 'متجر فحص السلامة';
	@override String get safetyCheckProjectDetails => 'تفاصيل مشروع التحقق من السلامة';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.

extension on Translations {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'language': return 'English';
			case 'welcome': return 'Welcome';
			case 'passwordUpdated': return 'Password has been updated successfully';
			case 'confairmData': return 'Please check your details';
			case 'conectApp': return 'Check your connection';
			case 'email': return 'email';
			case 'id': return 'id';
			case 'project': return 'Project';
			case 'title': return 'Title';
			case 'message': return 'Message';
			case 'courses': return 'Courses';
			case 'lectures': return 'Lectures';
			case 'loginByEmail': return 'Login by email';
			case 'loginByPhone': return 'Login by phone';
			case 'loginByIdentifier': return 'Login by identifier';
			case 'reportType': return 'Report Type';
			case 'priority': return 'Priority';
			case 'numberOfExperienceYears': return 'Number of Experience Years';
			case 'verificationCode': return 'Verification Code';
			case 'success': return 'Success';
			case 'noData': return 'No Data';
			case 'carNumber': return 'Car Number';
			case 'startCall': return 'Start Call';
			case 'companyName': return 'Company Name';
			case 'haveNiceCall': return 'Have a nice call';
			case 'qualifications': return 'Qualifications';
			case 'terms': return 'Terms And Conditions';
			case 'login': return 'login';
			case 'remember': return 'remember';
			case 'password': return 'password';
			case 'passwordConf': return 'password confirmation';
			case 'confirmCode': return 'investigation code';
			case 'save': return 'Save';
			case 'instructions': return 'Instructions';
			case 'conversations': return 'Conversations';
			case 'persons': return 'Persons';
			case 'confairmMsEmail': return 'Please check your email to enter the password reset code';
			case 'msNoEmail': return 'No accounts were found with this email address';
			case 'msErrorEmail': return 'Please enter the correct email';
			case 'enterEmail': return 'Please enter your email';
			case 'enterCode': return 'The verification code has been sent, please check your email';
			case 'send': return 'Send';
			case 'loading': return 'Loading...';
			case 'firstName': return 'First Name';
			case 'middleName': return 'Middle Name';
			case 'lastName': return 'Last Name';
			case 'idNumber': return 'ID Number';
			case 'idImage': return 'ID Image';
			case 'enterWeight': return 'Enter Weight';
			case 'enterGender': return 'Enter Gender';
			case 'male': return 'Male';
			case 'female': return 'Female';
			case 'callAmbulance': return 'Call Ambulance';
			case 'report': return 'Report';
			case 'projects': return 'Projects';
			case 'visitors': return 'Visitors';
			case 'enterLength': return 'Enter Length';
			case 'companyId': return 'Company Id';
			case 'completFiled': return 'Complete all fields';
			case 'goSingIn': return 'go to sign up with name';
			case 'singIn': return 'sign in';
			case 'singInNew': return 'Log in';
			case 'forgetPass': return 'Did you forget your password ?';
			case 'register': return ' Register an account';
			case 'doyouRegister': return 'Do you want to create a new account?';
			case 'doHaveAccount': return 'Do you have an account?';
			case 'completedData': return 'Complete your information';
			case 'registerNew': return 'Create a new account';
			case 'name': return 'Full Name';
			case 'phone': return 'Mobile number';
			case 'create': return 'Create';
			case 'compleateOrder': return 'Complete the order';
			case 'infPerson': return 'personal information';
			case 'change': return 'change';
			case 'namePerson': return 'ahmed khattab';
			case 'phonePerson': return '00201552344879';
			case 'cityPerson': return 'Riyadh';
			case 'addressPerson': return 'current address';
			case 'addressPrsonName': return 'Riyadh city street';
			case 'payingFrom': return 'Pay through';
			case 'banking': return 'Bank transfer';
			case 'stc': return 'stc';
			case 'mada': return 'Midi Card';
			case 'whenYouTake': return 'upon receipt';
			case 'makeProcce': return 'Execution of the request';
			case 'orderNumber': return 'order number';
			case 'cartEmpty': return 'Cart is empty';
			case 'subtotal': return 'Subtotal';
			case 'taxFee': return 'tax fee';
			case 'total': return 'Total';
			case 'conOrder': return 'Confirmation';
			case 'price': return 'price';
			case 'maiQuantity': return 'Minimum Quantity available for you is';
			case 'maxQuantity': return 'Maximum Quantity available for you is';
			case 'available': return 'items available in stock';
			case 'only': return 'only :';
			case 'takeOrderSuc': return 'Your request has been successfully received';
			case 'thanks': return 'Thank you, you can continue your order now';
			case 'takeorder': return 'Your request has been received ';
			case 'charged': return 'charged ';
			case 'numbertraking': return 'tracking number';
			case 'deliverySuccess': return 'Delivered Successfully';
			case 'backHome': return 'Back to the home ';
			case 'seeds': return 'seeds';
			case 'vitals': return 'vitals';
			case 'cucumber': return 'cucumber';
			case 'classification': return 'classification';
			case 'noProduct': return 'There are no products';
			case 'discount': return 'Discount';
			case 'trayAgain': return 'Try again';
			case 'search': return 'search for.';
			case 'notLaunch': return 'Could not launch www.eradco.com';
			case 'vistLink': return 'You can visit the following link';
			case 'inStock': return 'In stock :';
			case 'notAvilabal': return 'Currently unavailable!';
			case 'minOrder': return 'Minimum order :';
			case 'maxOrder': return 'Maximum order:';
			case 'payFromOnly': return 'Selling through branches only';
			case 'video': return 'Product video';
			case 'downloadPDF': return 'Download the newsletter';
			case 'aboutProduct': return 'About the product';
			case 'addToCart': return 'add to cart';
			case 'addToFavo': return 'Item has been added to favourites';
			case 'cart': return 'Cart';
			case 'myFavorites': return 'My FmFavorites';
			case 'branches': return 'Branches';
			case 'picturesAndSend': return 'Pictures And Send';
			case 'profile': return 'Profile';
			case 'delivery': return ' Shipping and delivery';
			case 'infopay': return ' payment information';
			case 'privacy': return 'Privacy policy';
			case 'callUs': return 'call us';
			case 'logOut': return 'sign out';
			case 'cautionaryMessage': return 'Cautionary Message';
			case 'cautionaryContain': return 'Do you want to remove the product from your favourites';
			case 'yes': return 'Yes';
			case 'no': return 'No';
			case 'delete': return 'Delete';
			case 'noResults': return 'No Results';
			case 'searchAbout': return 'Search for';
			case 'noArticles': return 'There are no articles';
			case 'media': return 'media';
			case 'photo': return 'photos';
			case 'articles': return 'articles';
			case 'videos': return 'Videos';
			case 'releases': return 'releases';
			case 'noImage': return 'There are no Images';
			case 'noReleases': return 'There are no Releases';
			case 'noVideos': return 'There are no Videos';
			case 'properties': return 'Properties';
			case 'selectedLocation': return 'Selected Location';
			case 'youCurrentLocation': return 'Your Current Location';
			case 'loadYourSite': return 'Getting Location';
			case 'locationDisabled': return 'Location services are disabled.';
			case 'locationDenied': return 'Location permissions are denied';
			case 'locationPermissions': return 'Location permissions are permanently denied, we cannot request permissions.';
			case 'region': return 'Region';
			case 'nameStreet': return 'Street name';
			case 'nearestPlace': return 'Nearest Place';
			case 'saveAddress': return 'save address';
			case 'addNewAddress': return 'Add a new title';
			case 'orderDetails': return 'Order Details';
			case 'followOrder': return 'follow up with the order';
			case 'approvedOrder': return 'Application No. has been approved';
			case 'requestProgress': return 'Your request is in progress';
			case 'quantity': return 'Quantity';
			case 'paymentMethod': return 'Payment Method';
			case 'deliveryOptions': return 'Delivery Options';
			case 'shippingAddress': return 'Shipping Address';
			case 'myInfo': return 'Information';
			case 'myOrders': return 'Orders';
			case 'myNotification': return 'Notification';
			case 'myAddress': return 'Address';
			case 'changePassword': return 'Change Password';
			case 'passwordChangeFailed': return 'Old Password wrong';
			case 'passwordChanged': return 'Password changed';
			case 'oldPassword': return 'Old Password';
			case 'newPassword': return 'New Password';
			case 'newPasswordConf': return 'Confirm the new password';
			case 'close': return 'close';
			case 'noProductFavorite': return 'There are no favourites';
			case 'confirmation': return 'confirmation';
			case 'updateProfile': return 'Update profile';
			case 'addedToCart': return 'Item Added Successfully';
			case 'home': return 'Home';
			case 'offers': return 'Offers';
			case 'all': return 'all';
			case 'protected': return 'protected';
			case 'public': return 'public';
			case 'logInFirst': return 'You should Login First';
			case 'checkout': return 'Checkout';
			case 'selectAddress': return 'Select Address';
			case 'noAddresses': return 'You don\'t have any Addresses yet..';
			case 'orderIsSuccessful': return 'Your Order has been Successfully Received';
			case 'failedToPay': return 'Payment Failed';
			case 'cancelOrder': return 'Cancel Order';
			case 'newPasswordInForget': return 'Please enter the new password';
			case 'add': return 'Add';
			case 'needCommercialApproved': return 'Please wait for the ID you submitted to be approved';
			case 'addCommercial': return 'This product requires a commercial registration or national identity';
			case 'back': return 'Back';
			case 'welcomeOnTheBiggestReadingSociety': return 'Welcome on the biggest reading society';
			case 'emailOrPhone': return 'Email or phone number';
			case 'orLoginWith': return 'Or login with';
			case 'loginToYourAccount': return 'Login to your account';
			case 'completeCreatingYourAccount': return 'Complete creating your account';
			case 'dontWorryYourPersonalData': return 'Don\'t worry, your personal data';
			case 'NoOneSeesItExceptYou': return 'No one sees it except you';
			case 'birthDate': return 'Birth Date';
			case 'updateAccount': return 'Update Account';
			case 'required': return 'please fill in this field';
			case 'address': return 'Address';
			case 'bio': return 'Bio';
			case 'publisher_management': return 'Publisher Management';
			case 'authors_management': return 'Authors Management';
			case 'books_management': return 'Books Management';
			case 'ads_management': return 'Ads Management';
			case 'notifications': return 'Notifications';
			case 'my_books': return 'My Books';
			case 'my_followings': return 'My Followings';
			case 'my_quotes': return 'My Quotes';
			case 'personal_info': return 'Personal Info';
			case 'following': return 'Followings';
			case 'reading': return 'Reading';
			case 'finished': return 'Finished';
			case 'read': return 'Read';
			case 'delete_account': return 'Delete Account';
			case 'settings': return 'Settings';
			case 'theme': return 'Theme';
			case 'authors': return 'Authors';
			case 'WelcomeIn': return 'Welcome In';
			case 'biggestSocietyForPublishersAndAuthors': return 'The biggest society for publishers and authors';
			case 'AndCreativesAndReadingEnthusiastsInMiddleEast': return 'And Creatives And Reading Enthusiasts In The Middle East';
			case 'iHaveAnAccount': return 'I have an account';
			case 'publishers': return 'Publishers';
			case 'enterValidPass': return 'Please enter a valid password';
			case 'passwordShouldBe6Char': return 'Password should be at least 6 characters';
			case 'guest': return 'Guest';
			case 'employeeEvaluation': return 'Employee Evaluation';
			case 'evaluationDetails': return 'Evaluation Details';
			case 'evaluationSummary': return 'Evaluation Summary';
			case 'evaluationItems': return 'Evaluation Items';
			case 'totalScore': return 'Total Score';
			case 'averageScore': return 'Average Score';
			case 'numberOfItems': return 'Number of Items';
			case 'evaluationDate': return 'Evaluation Date';
			case 'evaluationTitle': return 'Evaluation Title';
			case 'evaluationItem': return 'Evaluation Item';
			case 'score': return 'Score';
			case 'noEvaluationsAvailable': return 'No evaluations available';
			case 'retry': return 'Retry';
			case 'errorLoadingEvaluations': return 'Error loading evaluations';
			case 'errorLoadingDetails': return 'Error loading details';
			case 'noInternetConnection': return 'No internet connection';
			case 'failedToLoadEvaluations': return 'Failed to load evaluations';
			case 'failedToLoadDetails': return 'Failed to load details';
			case 'noDetailsAvailable': return 'No details available';
			case 'date': return 'Date';
			case 'undefined': return 'Undefined';
			case 'employeePermissions': return 'Employee Permissions';
			case 'permissionDetails': return 'Permission Details';
			case 'permissionInformation': return 'Permission Information';
			case 'permissionType': return 'Permission Type';
			case 'permissionDate': return 'Permission Date';
			case 'permissionId': return 'Permission ID';
			case 'permissionImage': return 'Permission Image';
			case 'noPermissionsAvailable': return 'No permissions available';
			case 'imageNotAvailable': return 'Image not available';
			case 'makePersonalRequest': return 'Make a Personal Request';
			case 'myPersonalRequest': return 'My Personal Requests';
			case 'personalRequestDetails': return 'Personal Request Details';
			case 'safetyCheckDetails': return 'Safety Check Details';
			case 'safetyCheckStore': return 'Safety Check Store';
			case 'safetyCheckProjectDetails': return 'Safety Check Project Details';
			default: return null;
		}
	}
}

extension on _StringsAr {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'language': return 'العربية';
			case 'welcome': return 'مرحبا';
			case 'passwordUpdated': return 'تم تحديث كلمة المرور بنجاح';
			case 'confairmData': return 'من فضلك تأكد من بياناتك';
			case 'conectApp': return 'تاكد من اتصالك';
			case 'email': return 'البريد الالكتروني';
			case 'id': return 'الرقم التعريفي';
			case 'password': return 'كلمة السر';
			case 'passwordConf': return 'تأكيد كلمة السر';
			case 'confirmCode': return 'كود التحقيق';
			case 'save': return 'حفظ';
			case 'login': return 'تسجيل الدخول';
			case 'courses': return 'دورات';
			case 'lectures': return 'محاضرات';
			case 'project': return 'مشروع';
			case 'title': return 'عنوان';
			case 'terms': return 'الشروط والاحكام';
			case 'qualifications': return 'المؤهلات';
			case 'success': return 'تم بنجاح';
			case 'message': return 'رسالة';
			case 'reportType': return 'نوع التقرير';
			case 'loginByEmail': return 'تسجيل الدخول عبر البريد الإلكتروني';
			case 'loginByPhone': return 'تسجيل الدخول عبر الهاتف';
			case 'loginByIdentifier': return 'تسجيل الدخول عن طريق المعرف';
			case 'numberOfExperienceYears': return 'عدد سنوات الخبرة';
			case 'priority': return 'أولوية';
			case 'remember': return 'يتذكر';
			case 'instructions': return 'التعليمات';
			case 'conversations': return 'المحادثات';
			case 'persons': return 'الأشخاص';
			case 'firstName': return 'الاسم الأول';
			case 'middleName': return 'الاسم الأوسط';
			case 'lastName': return 'اسم العائلة';
			case 'noData': return 'لا يوجد بيانات';
			case 'haveNiceCall': return 'اتمنى لك مكالمة جيدة';
			case 'idNumber': return 'رقم الهوية';
			case 'verificationCode': return 'رمز التحقق';
			case 'idImage': return 'صورة بطاقة الهوية';
			case 'enterWeight': return 'ادخل الوزن';
			case 'callAmbulance': return 'اتصل بالطوارئ';
			case 'report': return 'تقديم بلاغ';
			case 'carNumber': return 'رقم السيارة';
			case 'companyName': return 'اسم الشركة';
			case 'startCall': return 'بدء المكالمة';
			case 'projects': return 'المشاريع';
			case 'visitors': return 'الزوار';
			case 'enterLength': return 'ادخل الطول';
			case 'enterGender': return 'ادخل الجنس';
			case 'male': return 'ذكر';
			case 'female': return 'انثى';
			case 'companyId': return 'رقم الشركة';
			case 'confairmMsEmail': return 'من فضلك تأكد من بريدك الالكتروني  لأدخال كود اعادة كلمة المرور';
			case 'msNoEmail': return 'لم يتم العثور على أيّ حسابٍ بهذا العنوان الإلكتروني';
			case 'msErrorEmail': return 'من فضلك أدخل الايميل الصحيح';
			case 'enterEmail': return 'من فضلك ادخل بريدك الالكتروني';
			case 'enterValidPass': return 'من فضلك ادخل كلمة سر صحيحة';
			case 'passwordShouldBe6Char': return 'كلمة المرور يجب ان تكون 6 حروف على الاقل';
			case 'enterCode': return 'تم ارسال كود التحقيق من فضلك افحص بريدك الالكتروني ';
			case 'send': return 'ارسال';
			case 'loading': return 'جار التحميل';
			case 'completFiled': return 'اكمل جميع الحقول';
			case 'goSingIn': return 'اذهب للتسجيل بالاسم';
			case 'singIn': return 'تسجيل الدخول';
			case 'singInNew': return 'سجل دخول';
			case 'forgetPass': return 'هل نسيت كلمة المرور ؟';
			case 'register': return 'إنشاء حساب جديد';
			case 'doyouRegister': return 'هل تريد انشاء حساب جديد ؟';
			case 'doHaveAccount': return 'هل تمتلك حساب ؟';
			case 'completedData': return 'أكمل بياناتك';
			case 'registerNew': return 'انشاء حساب جديد';
			case 'name': return 'الاسم كامل';
			case 'phone': return 'رقم الجوال';
			case 'create': return 'انشاء';
			case 'compleateOrder': return 'اتمام الطلب';
			case 'infPerson': return 'المعلومات الشخصية';
			case 'change': return 'تغير';
			case 'namePerson': return 'أحمد خطاب';
			case 'phonePerson': return '00201552344879';
			case 'cityPerson': return 'الرياض';
			case 'addressPerson': return 'العنوان الحالي';
			case 'addressPrsonName': return 'الرياض شارع المدينه';
			case 'payingFrom': return 'الدفع من خلال ';
			case 'banking': return 'التحويل البنكي';
			case 'stc': return 'stc';
			case 'mada': return 'مدي';
			case 'whenYouTake': return 'عند الاستلام';
			case 'makeProcce': return 'تنفيذ الطلب';
			case 'orderNumber': return ' رقم الطلب';
			case 'cartEmpty': return 'السلة فارغة';
			case 'subtotal': return 'المجموع الفرعي';
			case 'taxFee': return ' رسوم الضريبة';
			case 'total': return 'الاجمالي';
			case 'conOrder': return 'تأكيد الطلب';
			case 'price': return 'السعر';
			case 'maiQuantity': return 'أقل كمية متاحة لك هي';
			case 'maxQuantity': return 'الكمية القصوى المتاحة لك هي';
			case 'available': return 'العناصر المتوفرة في المخزون';
			case 'only': return 'فقط :';
			case 'takeOrderSuc': return 'تم استلام طلبك بنجاج';
			case 'thanks': return 'شكرا لك يمكنك متابعة طلبك الأن';
			case 'takeorder': return 'تم استلام طلبك ';
			case 'charged': return 'تم الشحن';
			case 'numbertraking': return 'رقم التتبع';
			case 'deliverySuccess': return 'تم التسليم';
			case 'backHome': return ' الرجوع الي الصفحة الرئيسية';
			case 'seeds': return 'البذور';
			case 'vitals': return 'فيتالس';
			case 'cucumber': return 'خيار';
			case 'classification': return 'تصنيف';
			case 'noProduct': return 'لا توجد منتجات';
			case 'discount': return 'خصم';
			case 'trayAgain': return 'حاول مجدداً';
			case 'search': return 'يبحث';
			case 'notLaunch': return 'تعذر الإطلاق الي';
			case 'vistLink': return 'يمكنك زيارة الرابط التالي';
			case 'inStock': return 'متوفر بالمخزون :';
			case 'notAvilabal': return 'غير متاح حاليا !';
			case 'minOrder': return 'الحد الأدني للطلب :';
			case 'maxOrder': return 'الحد الأقصي للطلب : ';
			case 'payFromOnly': return 'البيع من خلال الفروع فقط';
			case 'video': return 'فيديو للمنتج';
			case 'downloadPDF': return 'تحميل النشرة';
			case 'aboutProduct': return 'نبذة عن المنتج';
			case 'addToCart': return 'اضافة الي السلة';
			case 'addToFavo': return 'تم اضافة العنصر الي المفضلة';
			case 'cart': return 'السلة';
			case 'myFavorites': return 'مفضلاتي';
			case 'branches': return 'الفروع';
			case 'picturesAndSend': return ' صور وارسل';
			case 'profile': return 'الملف الشخصي';
			case 'delivery': return ' الشحن و التوصيل';
			case 'infopay': return ' معلومات الدفع';
			case 'privacy': return 'سياسة الخصوصية';
			case 'callUs': return 'اتصل بنا';
			case 'logOut': return 'تسجيل الخروج';
			case 'cautionaryMessage': return 'رسالة تحزيرية';
			case 'cautionaryContain': return 'هل تريد حذف المنتج من المفضلة';
			case 'yes': return 'نعم';
			case 'no': return 'لا';
			case 'delete': return 'حذف';
			case 'noResults': return 'لا توجد نتائج';
			case 'searchAbout': return 'ابحث عن ( منتجات / مقالات / نشرات طبية)';
			case 'noArticles': return 'لا توجد مقالات';
			case 'media': return 'الوسائط';
			case 'photo': return 'الصور';
			case 'articles': return 'المقالات';
			case 'videos': return 'الفيديوهات';
			case 'releases': return 'النشرات';
			case 'noImage': return 'لا توجد  صور';
			case 'noReleases': return 'لا توجد نشرات';
			case 'noVideos': return 'لا توجد فيديوهات';
			case 'properties': return 'الخصائص';
			case 'selectedLocation': return 'اختار موقعك';
			case 'youCurrentLocation': return 'موقعك الحالي';
			case 'loadYourSite': return 'تحميل موقعك';
			case 'locationDisabled': return 'خدمات الموقع معطلة.';
			case 'locationDenied': return 'تم رفض أذونات الموقع';
			case 'locationPermissions': return 'أذونات الموقع مرفوضة بشكل دائم ، ولا يمكننا طلب أذونات.';
			case 'region': return 'المنطقة';
			case 'nameStreet': return 'اسم الشارع';
			case 'nearestPlace': return 'أقرب معلم';
			case 'saveAddress': return 'حفظ العنوان';
			case 'addNewAddress': return 'اضافة عنوان جديد';
			case 'orderDetails': return 'تفاصيل الطلب';
			case 'followOrder': return 'متابعة الطلب';
			case 'approvedOrder': return 'تمت الموافقة علي الطلب رقم';
			case 'requestProgress': return 'طلبك قيد التنفيذ';
			case 'quantity': return 'الكمية';
			case 'paymentMethod': return 'طريقة الدفع';
			case 'deliveryOptions': return 'خيارات التوصيل';
			case 'shippingAddress': return 'عنوان الشحن';
			case 'myInfo': return 'معلوماتي';
			case 'myOrders': return 'طلباتي';
			case 'myNotification': return 'اشعاراتي';
			case 'myAddress': return 'عناويني';
			case 'changePassword': return 'تغيير كلمة السر';
			case 'passwordChangeFailed': return 'كلمة السر القديمة غير صحيحة';
			case 'passwordChanged': return 'تم تغير كلمة السر بنجاح';
			case 'oldPassword': return 'كلمة السر القديمة';
			case 'newPassword': return 'كلمة السر الجديدة';
			case 'newPasswordConf': return 'تأكيد كلمة السر الجديدة';
			case 'close': return 'الغاء';
			case 'noProductFavorite': return 'لايوجد منتجات مفضلة';
			case 'confirmation': return 'تـأكيد';
			case 'updateProfile': return 'تحديث بياناتي';
			case 'addedToCart': return 'تمت اضافة المنتج';
			case 'home': return 'الرئيسية';
			case 'offers': return 'العروض';
			case 'all': return 'الكل';
			case 'protected': return 'محمي';
			case 'public': return 'مكشوف';
			case 'logInFirst': return 'يجب تسجيل الدخول اولا';
			case 'checkout': return 'تنفيذ الطلب';
			case 'selectAddress': return 'حدد العنوان';
			case 'noAddresses': return 'ليس لديك عناوين حتي الآن..';
			case 'orderIsSuccessful': return 'تم استلام طلبك بنجاح';
			case 'failedToPay': return 'فشل الدفع';
			case 'cancelOrder': return 'الغاء الطلب';
			case 'add': return 'اضافة';
			case 'needCommercialApproved': return 'برجاء انتظار الموافقة علي الهوية التي قمت بتقديمها';
			case 'addCommercial': return 'هذا المنتج يتطلب سجل تجاري او هوية وطنية';
			case 'newPasswordInForget': return 'من فضلك أدخل كلمة السر الجديدة';
			case 'back': return 'رجوع';
			case 'loginToYourAccount': return 'الدخول لحسابك';
			case 'welcomeOnTheBiggestReadingSociety': return 'مرحبا بك في اكبر مجتمع للقراءة';
			case 'emailOrPhone': return 'البريد الإلكتروني أو رقم الهاتف';
			case 'orLoginWith': return 'أو الدخول بواسطة';
			case 'completeCreatingYourAccount': return 'أكمل إنشاء حسابك';
			case 'dontWorryYourPersonalData': return 'لا تقلق جميع بياناتك الشخصية';
			case 'NoOneSeesItExceptYou': return 'لا أحد يراها إلا أنت';
			case 'birthDate': return 'تاريخ الميلاد';
			case 'required': return 'الحقل مطلوب';
			case 'address': return 'عنوان';
			case 'publisher_management': return 'ادارة دار النشر';
			case 'authors_management': return 'ادارة المؤلفين';
			case 'books_management': return 'ادارة الكتب';
			case 'ads_management': return 'ادارة التسويق';
			case 'notifications': return 'التنبيهات';
			case 'my_books': return 'كتبي';
			case 'my_followings': return 'متابعاتي';
			case 'my_quotes': return 'اقتباساتي';
			case 'personal_info': return 'المعلومات الشخصية';
			case 'following': return 'متابعة';
			case 'reading': return 'القراءة';
			case 'finished': return 'انتهيت';
			case 'read': return 'تقرأ';
			case 'authors': return 'مؤلفين';
			case 'publishers': return 'دور النشر';
			case 'bio': return 'السيرة الذاتية';
			case 'delete_account': return 'حذف الحساب';
			case 'settings': return 'الاعدادات';
			case 'theme': return 'الوضع';
			case 'updateAccount': return 'تحديث الحساب';
			case 'WelcomeIn': return 'مرحبًا في';
			case 'biggestSocietyForPublishersAndAuthors': return 'أكبر مجتمع للناشرين والمؤلفين';
			case 'AndCreativesAndReadingEnthusiastsInMiddleEast': return ' والمبدعين وعشاق القراءة في الشرق الأوسط';
			case 'iHaveAnAccount': return 'لدي حساب';
			case 'guest': return 'زائر';
			case 'employeeEvaluation': return 'تقييم الموظفين';
			case 'evaluationDetails': return 'تفاصيل التقييم';
			case 'evaluationSummary': return 'ملخص التقييم';
			case 'evaluationItems': return 'عناصر التقييم';
			case 'totalScore': return 'المجموع الكلي';
			case 'averageScore': return 'المتوسط';
			case 'numberOfItems': return 'عدد العناصر';
			case 'evaluationDate': return 'تاريخ التقييم';
			case 'evaluationTitle': return 'عنوان التقييم';
			case 'evaluationItem': return 'عنصر التقييم';
			case 'score': return 'الدرجة';
			case 'noEvaluationsAvailable': return 'لا توجد تقييمات متاحة';
			case 'retry': return 'إعادة المحاولة';
			case 'errorLoadingEvaluations': return 'خطأ في تحميل التقييمات';
			case 'errorLoadingDetails': return 'خطأ في تحميل التفاصيل';
			case 'noInternetConnection': return 'لا يوجد اتصال بالإنترنت';
			case 'failedToLoadEvaluations': return 'فشل في تحميل التقييمات';
			case 'failedToLoadDetails': return 'فشل في تحميل التفاصيل';
			case 'noDetailsAvailable': return 'لا توجد تفاصيل متاحة';
			case 'date': return 'التاريخ';
			case 'undefined': return 'غير محدد';
			case 'employeePermissions': return 'تصاريح الموظفين';
			case 'permissionDetails': return 'تفاصيل التصريح';
			case 'permissionInformation': return 'معلومات التصريح';
			case 'permissionType': return 'نوع التصريح';
			case 'permissionDate': return 'تاريخ التصريح';
			case 'permissionId': return 'رقم التصريح';
			case 'permissionImage': return 'صورة التصريح';
			case 'noPermissionsAvailable': return 'لا توجد تصاريح متاحة';
			case 'imageNotAvailable': return 'الصورة غير متاحة';
			case 'makePersonalRequest': return 'تقديم طلب شخصي';
			case 'myPersonalRequest': return 'طلباتي الشخصية';
			case 'personalRequestDetails': return 'تفاصيل الطلب الشخصي';
			case 'safetyCheckDetails': return 'تفاصيل التحقق من السلامة';
			case 'safetyCheckStore': return 'متجر فحص السلامة';
			case 'safetyCheckProjectDetails': return 'تفاصيل مشروع التحقق من السلامة';
			default: return null;
		}
	}
}
