plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.booquest.app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.booquest.app"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = 23  
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        create("release") {
            keyAlias = "booquest"  // 키스토어에서 설정한 alias
            keyPassword = "booquest55"  // 실제 키 비밀번호
            storeFile = file("../../booquest-release-key.jks")  // 키스토어 파일 경로 (프로젝트 루트)
            storePassword = "booquest55"  // 실제 스토어 비밀번호
        }
    }

    buildTypes {
        debug {
            signingConfig = signingConfigs.getByName("debug")
        }
        release {
            signingConfig = signingConfigs.getByName("release")  // release 키 사용
            
            // ProGuard 및 리소스 축소 비활성화 (네이버 로그인 문제 해결을 위해 임시)
            isMinifyEnabled = false
            isShrinkResources = false
            // proguardFiles(
            //     getDefaultProguardFile("proguard-android.txt"),
            //     "proguard-rules.pro"
            // )
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // Kakao SDK 의존성 추가
    implementation("com.kakao.sdk:v2-user:2.20.1")
    implementation("com.kakao.sdk:v2-auth:2.20.1")
    
    // 네이버 로그인 SDK 의존성 추가
    implementation("com.navercorp.nid:oauth:5.9.1")

    //Admob 의존성 추가
    implementation("com.google.android.gms:play-services-ads:22.6.0")
}
