package dev.wanghl.flutter_dev_template.utils;

import android.util.Log;

import io.flutter.BuildConfig;


/**
 * <pre>
 *     author : WangHL
 *     e-mail : 574400391@qq.com
 *     time   : 2020/12/17
 *     desc   : 日志打印
 * </pre>
 */
public class LogUtil {
    private static final String _TAG = "LogUtil";
    private static final boolean debug = BuildConfig.DEBUG;

    public static void i(String msg) {
        if (debug) {
            i(_TAG, msg);
        }
    }

    public static void i(String TAG, String msg) {
        if (debug) {
            int p = 2048;
            long length = msg.length();
            if (length >= p && length != p) {
                while (msg.length() > p) {
                    String log = msg.substring(0, p);
                    msg = msg.replace(log, "");
                    Log.i(TAG, log);
                }
            }
            Log.i(TAG, msg);
        }
    }
}