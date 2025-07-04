# Ignore missing annotation classes
-dontwarn javax.lang.model.element.**
-dontwarn com.google.errorprone.annotations.**
-dontwarn javax.annotation.**

# Keep Google Error Prone annotations
-keepclassmembers class com.google.errorprone.annotations.CanIgnoreReturnValue { *; }
-keepclassmembers class com.google.errorprone.annotations.CheckReturnValue { *; }
-keepclassmembers class com.google.errorprone.annotations.Immutable { *; }
-keepclassmembers class com.google.errorprone.annotations.RestrictedApi { *; }

# Keep javax annotations
-keepclassmembers class javax.annotation.Nullable { *; }
-keepclassmembers class javax.annotation.concurrent.GuardedBy { *; }

# Keep the entire annotation classes
-keep class com.google.errorprone.annotations.** { *; }
-keep class javax.annotation.** { *; }
-keep class javax.annotation.concurrent.** { *; }
-keep class javax.lang.model.** { *; }
