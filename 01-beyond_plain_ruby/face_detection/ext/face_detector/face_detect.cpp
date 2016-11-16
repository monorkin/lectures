#include <opencv2/opencv.hpp>
#include <opencv2/core/core.hpp>
#include <opencv2/ml/ml.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/objdetect/objdetect.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <iostream>
#include <vector>
#include <stdio.h>
#include "rice/Class.hpp"
#include "rice/Module.hpp"
#include "rice/String.hpp"
#include "rice/Array.hpp"
#include "rice/Hash.hpp"
#include "rice/Exception.hpp"

using namespace std;
using namespace cv;
using namespace Rice;

Object method_detect_faces(Rice::String image_path, Rice::String cascade_path) {
	Mat img = imread(image_path.c_str(), 0);

	if(!img.data)
  {
		throw Rice::Exception(rb_eIOError, "Could not open or find image file.");
  }

	equalizeHist(img, img);
	Size s = img.size();

  CascadeClassifier cascade;
  if (!cascade.load(cascade_path.c_str())) {
		throw Rice::Exception(rb_eIOError, "Could not open or find cascade file.");
	}

  std::vector<cv::Rect> faces;
	cascade.detectMultiScale(
		img, faces,
		1.05, 4,
		0 | CV_HAAR_SCALE_IMAGE,
		cvSize(10, 10), cvSize(30, 30)
	);

  Array result;
  for (size_t i = 0; i < faces.size(); i++)
  {
		Rect_<int> r = faces[i];
    Hash hash;
    hash[Symbol('x')] =      to_ruby((double)(r.x / s.width));
    hash[Symbol('y')] =      to_ruby((double)(r.y / s.height));
    hash[Symbol("width")] =  to_ruby((double)(r.width / s.width));
    hash[Symbol("height")] = to_ruby((double)(r.height / s.height));
    result.push(hash);
  }

	img.release();

  return result;
}

extern "C"
void Init_FaceDetector() {
  Module rb_mFaceDetector = define_module("FaceDetector");
	rb_mFaceDetector.define_method("detect_faces", &method_detect_faces);
}
