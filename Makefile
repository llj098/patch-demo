old:
	gradle clean
	gradle assembleDebug
	mkdir -p apk
	mv app/build/bakApk/*.apk apk/old.apk
	mv  app/build/bakApk/*.txt apk/old-R.txt

patch:
	gradle clean
	gradle tinkerPatchDebug -POLD_APK=./apk/old.apk -PAPPLY_RESOURCE=./apk/old-R.txt
	mv app/build/outputs/tinkerPatch/debug/patch_signed_7zip.apk apk/patch.apk

sd:
	adb push apk/patch.apk /sdcard/

deploy:
	scp apk/patch.apk root@gfw.rongju.im:tmp/
