package com.example.dapp

import io.flutter.embedding.android.FlutterActivity
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Bundle
import androidx.annotation.NonNull

import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val eventsChannel = "com.walletconnect.flutterdapp/events"
    private val methodsChannel = "com.walletconnect.flutterdapp/methods"

    private var initialLink: String? = null
    private var linksReceiver: BroadcastReceiver? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val intent: Intent? = intent
        initialLink = intent?.data?.toString()

        EventChannel(flutterEngine?.dartExecutor?.binaryMessenger, eventsChannel).setStreamHandler(
            object : EventChannel.StreamHandler {
                override fun onListen(args: Any?, events: EventChannel.EventSink) {
                    linksReceiver = createChangeReceiver(events)
                }
                override fun onCancel(args: Any?) {
                    linksReceiver = null
                }
            }
        )

        MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, methodsChannel).setMethodCallHandler { call, result ->
            if (call.method == "initialLink") {
                if (initialLink != null) {
                    result.success(initialLink)
                }
            }
        }
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        if (intent.action === Intent.ACTION_VIEW) {
            linksReceiver?.onReceive(this.applicationContext, intent)
        }
    }

    fun createChangeReceiver(events: EventChannel.EventSink): BroadcastReceiver? {
        return object : BroadcastReceiver() {
            override fun onReceive(context: Context, intent: Intent) {
                val dataString = intent.dataString ?:
                events.error("UNAVAILABLE", "Link unavailable", null)
                events.success(dataString)
            }
        }
    }
}
