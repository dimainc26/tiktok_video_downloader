package inc.dima.tikidown

import android.content.Intent
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "inc.dima.tikidown/intent"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getSharedText") {
                val sharedText = handleShareIntent()
                if (sharedText != null) {
                    result.success(sharedText)
                } else {
                    result.error("UNAVAILABLE", "Shared text not available.", null)
                }
            }
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // Autres initialisations si nécessaire
    }

    // Cette méthode vérifie l'intent de partage à la création de l'activité
    private fun handleShareIntent(): String? {
        val intent = intent
        val action = intent.action
        val type = intent.type
        if (Intent.ACTION_SEND == action && type != null) {
            if ("text/plain" == type) {
                return intent.getStringExtra(Intent.EXTRA_TEXT)
            }
        }
        return null
    }
}
