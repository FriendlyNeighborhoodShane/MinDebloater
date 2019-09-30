# MinDebloater script
# To cleanup leftover google

state="$1";
root="$2";
magisk="$3";

ps | grep zygote | grep -v grep >/dev/null && bootmode=true || bootmode=false;
$bootmode || ps -A 2>/dev/null | grep zygote | grep -v grep >/dev/null && bootmode=true;

ui_print() { echo "$1"; }
log() { echo "$1"; }

cleanup() {

  ui_print " ";
  ui_print "SCRIPT: Cleaning...";
  if [ "$bootmode" != "true" ]; then
    # Kanged from NanoDroid
    # Thanks Setialpha
    cleanup_folders="BlankStore GmsCore GmsCore_update GmsCoreSetupPrebuilt GoogleServicesFramework GsfProxy Phonesky PlayStore PrebuiltGmsCorePi PrebuiltGmsCorePix PrebuiltGmsCore Vending";
    for app in $cleanup_folders; do
      for file in /data/dalvik-cache/*/system"@priv-app@${app}"[@\.]*@classes.* /data/dalvik-cache/*/system"@app@${app}"[@\.]*@classes.*; do
        [ -e "$file" ] && { log "SCRIPT: Removing $file"; rm -rf "$file"; }
      done;
    done;
    cleanup_packages="com.android.vending com.google.android.feedback com.google.android.gms com.google.android.gsf com.google.android.gsf.login com.mgoogle.android.gms";
    for app in $cleanup_packages; do
      for file in /data/data/${app} /data/user/*/${app} /data/user_de/*/${app} /data/app/${app}-* /mnt/asec/${app}-* /data/media/0/Android/data/${app}; do
        [ -e "$file" ] && { log "SCRIPT: Removing $file"; rm -rf "$file"; }
      done;
    done;
    for file in /data/system/users/*/runtime-permissions.xml; do
      [ -e "$file" ] && { log "SCRIPT: Removing $file"; rm -rf "$file"; }
    done;
    if [ -f /data/system/packages.list ]; then
      for app in $cleanup_packages; do
        if [ "$(grep "$app" /data/system/packages.list)" ]; then
          log "SCRIPT: de-registering app: $app";
          sed -i "s/.*${app}.*//g" /data/system/packages.list;
        fi;
      done;
    else
      log "SCRIPT: This is a clean flash";
    fi;
    if [ "$(which sqlite3)" ]; then
      find /data/system* -type f -name "accounts*db" 2>/dev/null | while read database; do
        log "SCRIPT: deleting Google Accounts from $database";
        sqlite3 "$database" "DELETE FROM accounts WHERE type='com.google';";
      done
    else
      log "SCRIPT: sqlite3 not found";
    fi;
  fi;

}

case "$state" in
  predebloat) ;;
  postdebloat) cleanup ;;
  prerestore) ;;
  postrestore) ;;
esac;