package dev.wanghl.flutter_dev_template;

import org.jetbrains.annotations.NotNull;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import dev.wanghl.flutter_dev_template.utils.LogUtil;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;

public class MainActivity extends FlutterActivity {

    private static final String TAG = "MainActivity";
    private Pigeon.NativeApi nativeApi;
    private final ExecutorService mCachedThreadPool = Executors.newCachedThreadPool();

    @Override
    public void configureFlutterEngine(@NotNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        // 加载Pigeon定义的双向通讯接口
        Pigeon.Api.setup(flutterEngine.getDartExecutor().getBinaryMessenger(), new FlutterApi());
        nativeApi = new Pigeon.NativeApi(flutterEngine.getDartExecutor().getBinaryMessenger());
    }

    private class FlutterApi implements Pigeon.Api {

        @Override
        public void doSomethingNoParam() {
            // Flutter层调用doSomethingNoParam()，在这里可以同步或异步进行一些任务处理
            LogUtil.i(TAG, "doSomethingNoParam()");
            mCachedThreadPool.execute(() -> new Thread(new Runnable() {
                @Override
                public void run() {
                    try {
                        // 模拟耗时任务，等待3s后由Native层将任务处理结果返回给Flutter层
                        Thread.sleep(3000);
                        runOnUiThread(new Runnable() {
                            @Override
                            public void run() {
                                Pigeon.Message msgResult = new Pigeon.Message();
                                msgResult.setType(1L);
                                msgResult.setMessage("Android端处理成功");
                                nativeApi.doSomethingResult(msgResult, reply -> {});
                            }
                        });
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                }
            }).start());
        }

        @Override
        public void doSomethingWithParam(Pigeon.Message msg) {
            // Flutter层调用doSomethingWithParam()，在这里可以同步或异步进行一些任务处理
            LogUtil.i(TAG, "doSomethingWithParam()");
            if (msg != null) {
                LogUtil.i(TAG, "doSomethingWithParam -- type=" + translateEmptyString(msg.getType().toString()) + ", msg=" + translateEmptyString(msg.getMessage()));
            }
            mCachedThreadPool.execute(() -> new Thread(new Runnable() {
                @Override
                public void run() {
                    try {
                        // 模拟耗时任务，等待3s后由Native层将任务处理结果返回给Flutter层
                        Thread.sleep(3000);
                        runOnUiThread(new Runnable() {
                            @Override
                            public void run() {
                                Pigeon.Message msgResult = new Pigeon.Message();
                                msgResult.setType(2L);
                                msgResult.setMessage("Android端处理成功");
                                nativeApi.doSomethingResult(msgResult, reply -> {});
                            }
                        });
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                }
            }).start());
        }
    }

    private String translateEmptyString(String msg) {
        if (msg == null) {
            return "";
        }
        return msg;
    }
}
