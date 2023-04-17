package com.example.fragmentbasics;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import androidx.fragment.app.Fragment;

public class NewsFragment extends Fragment {
    final static String ARG_POSITION = "position";
    int mCurrentPosition = -1;
    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        return inflater.inflate(R.layout.fragment_news, container, false);
    }
    // Inflate the layout for this fragment return inflater.inflate(R.layout.fragment_news, container, false);}
    @Override
    public void onStart() {
        super.onStart();
        // During startup, check if there are arguments passed to the fragment.
        // onStart is a good place to do this because the layout has already been
        // applied to the fragment at this point so we can safely call the method
        // below that sets the article text.
        Bundle args = getArguments();
        if (args!= null) {
            //Set article based on Argument passed in
            updateArticleView(args.getInt(ARG_POSITION));
        }
    }
    // During startup, check if there are arguments passed to the fragment.// onStart is a good place to do this because the layout has already been// applied to the fragment at this point so we can safely call the method// below that sets the article text.Bundle args = getArguments();if (args != null) {// Set article based on argument passed inupdateArticleView(args.getInt(ARG_POSITION));} else if (mCurrentPosition != -1) {// Set article based on saved instance state defined during onCreateViewupdateArticleView(mCurrentPosition);}}
    public void updateArticleView(int position) {
    TextView article = (TextView) getActivity().findViewById(R.id.news);
    article.setText(Ipsum.Articles[position]);mCurrentPosition = position;
    }
    @Override
    public void onSaveInstanceState(Bundle outState) {
        super.onSaveInstanceState(outState);
        // Save the current article selection in case we need to recreate the fragmentoutState.putInt(ARG_POSITION, mCurrentPosition);
        outState.putInt(ARG_POSITION, mCurrentPosition);
    }
}
