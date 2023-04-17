package com.tajourharris.lab3;

import androidx.annotation.RequiresApi;
import androidx.appcompat.app.AppCompatActivity;

import android.annotation.SuppressLint;
import android.hardware.Camera;
import android.media.CamcorderProfile;
import android.media.MediaRecorder;
import android.os.Build;
import android.os.Bundle;
import android.os.Environment;
import android.text.Editable;
import android.util.Log;
import android.view.TextureView;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

public class MainActivity extends AppCompatActivity {

    private Camera nCamera;
    private TextureView nPreview;
    private MediaRecorder nMediaRecorder;
    private File nOutputFile;

    private boolean isRecording = false;
    private static final String TAG = "Recorder";
    private Button captureButton;

    private EditText editText;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        nPreview = findViewById(R.id.surface_view);
        captureButton = findViewById(R.id.button_capture);
        editText = findViewById(R.id.video_name);

        String[] perms = {"android.permission.WRITE_EXTERNAL_STORAGE",
        "android.permission.RECORD_AUDIO", "android.permission.CAMERA"};

        int permsRequestCode = 200;
        if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
            requestPermissions(perms, permsRequestCode);
        }
    }

    @RequiresApi(api = Build.VERSION_CODES.O)
    public void onCaptureClick(View view) {
        if(isRecording) {
            try {
                nMediaRecorder.setOnErrorListener(null);
                nMediaRecorder.setOnInfoListener(null);
                nMediaRecorder.setPreviewDisplay(null);

                nMediaRecorder.stop(); // stop the recording
            } catch (RuntimeException e) {
                // RuntimeException is thrown when stop() is called immediately after start()
                Log.d(TAG, "RuntimeException: stop() is called immediately after start()");
                nOutputFile.delete();
            }
            releaseMediaRecorder();
            nCamera.lock(); //take camera access back from MediaRecorder
            setCaptureButtonText("START");
            isRecording = false;
            releaseCamera();
        } else {
            if(prepareVideoRecorder()) {
                // Camera available and unlocked, MediaRecorder is prepared
                // can now start recording
                nMediaRecorder.start();
                setCaptureButtonText("STOP");
                isRecording = true;
            } else {
                releaseMediaRecorder();
            }
        }
    }

    private void setCaptureButtonText(String title) {
        captureButton.setText(title);
    }

    @Override
    protected void onPause() {
        super.onPause();
        // If using media recorder, release it first
        releaseMediaRecorder();
        // release camera immediately on pause event
        releaseCamera();
    }

    private void releaseMediaRecorder() {
        if(nMediaRecorder != null) {
            // clear recorder configuration
            nMediaRecorder.reset();
            // release recorder object
            nMediaRecorder.release();
            nMediaRecorder = null;
            // Lock camera for later use, i.e. taking it back from MediaRecorderS;
            nCamera.lock();
        }
    }

    private void releaseCamera() {
        if(nCamera != null) {
            nCamera.release();
            nCamera = null;
        }
    }

    @RequiresApi(api = Build.VERSION_CODES.O)
    private boolean prepareVideoRecorder() {
        nCamera = Camera.open();
        Camera.Parameters parameters = nCamera.getParameters();

        List<Camera.Size> mSupportedPreviewSizes = parameters.getSupportedPreviewSizes();

        nCamera.setParameters(parameters);
        try {
            nCamera.setPreviewTexture(nPreview.getSurfaceTexture());
        } catch (IOException e) {
            Log.e(TAG, "Surface texture is unavailable or unsuitable" + e.getMessage());
            return false;
        }

        nMediaRecorder = new MediaRecorder();

        // Step 1: Unlock and set camera to MediaRecorder
        nCamera.unlock();
        nMediaRecorder.setCamera(nCamera);

        // Step 2: Set sources
        nMediaRecorder.setAudioSource(MediaRecorder.AudioSource.MIC);
        nMediaRecorder.setVideoSource(MediaRecorder.VideoSource.CAMERA);
        // Use the same size for recording profile
        CamcorderProfile profile = CamcorderProfile.get(CamcorderProfile.QUALITY_HIGH);

        // Step 3: set CamcorderProfile (API 8 or higher needed)
        nMediaRecorder.setMaxDuration(60000); //60 second limit

        nMediaRecorder.setProfile(profile);

        //Step 4: Set output file
        nOutputFile = getOutputMediaFile();
        if(nOutputFile == null) {
            return false;
        }

        nMediaRecorder.setOutputFile(nOutputFile.getAbsolutePath());

        // Step 5: Prepare configured MediaRecorder
        try {
            nMediaRecorder.prepare();
        } catch (IllegalStateException e) {
            Log.d(TAG,"IllegalStateException preparing MediaRecorder: " + e.getMessage());
            releaseMediaRecorder();
            return false;
        } catch (IOException e) {
            Log.d(TAG,"IOException preparing MediaRecorder: " + e.getMessage());
            releaseMediaRecorder();
            return false;
        }
        return true;
    }

    public File getOutputMediaFile() {
        if (!Environment.getExternalStorageState().equalsIgnoreCase(Environment.MEDIA_MOUNTED)) {
            return null;
        }
        @SuppressLint("SdCardPath") File mediaStorageDir = new File("/sdcard/Lab3_Recordings");

        if(! mediaStorageDir.exists()) {
            if(! mediaStorageDir.mkdirs()) {
                Log.d("Lab3_Recordings", "Failed to create directory");
                return null;
            }
        }

        // Create media file name
        String timeStamp = new SimpleDateFormat("yyyy-MM-dd_HHmmss", Locale.US).format(new Date());
        File mediaFile;

        Editable video_name=editText.getText();

        mediaFile = new File(mediaStorageDir, video_name.toString()+"_"+ timeStamp + ".mp4");

        return mediaFile;
    }
}