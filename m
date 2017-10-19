From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 19 Oct 2017 11:53:40 +0200
Subject: [PATCH] tomoyo: fix timestamping for y2038
Message-ID: <20171019095405.689783-1-arnd@arndb.de>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Tomoyo uses an open-coded version of time_to_tm() to create a timestamp
from the current time as read by get_seconds(). This will overflow and
give wrong results on 32-bit systems in 2038.

To correct this, this changes the code to use ktime_get_real_seconds()
and the generic time64_to_tm() function that are both y2038-safe.
Using the library function avoids adding an expensive 64-bit division
in this code and can benefit from any optimizations we do in common
code.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 security/tomoyo/audit.c  |  2 +-
 security/tomoyo/common.c |  4 ++--
 security/tomoyo/common.h |  2 +-
 security/tomoyo/util.c   | 39 +++++++++------------------------------
 4 files changed, 13 insertions(+), 34 deletions(-)

diff --git a/security/tomoyo/audit.c b/security/tomoyo/audit.c
index 3ffa4f5509d8..a51edfbe593b 100644
--- a/security/tomoyo/audit.c
+++ b/security/tomoyo/audit.c
@@ -156,7 +156,7 @@ static char *tomoyo_print_header(struct tomoyo_request_info *r)
 	if (!buffer)
 		return NULL;
 
-	tomoyo_convert_time(get_seconds(), &stamp);
+	tomoyo_convert_time(ktime_get_real_seconds(), &stamp);
 
 	pos = snprintf(buffer, tomoyo_buffer_len - 1,
 		       "#%04u/%02u/%02u %02u:%02u:%02u# profile=%u mode=%s "
diff --git a/security/tomoyo/common.c b/security/tomoyo/common.c
index e0fb75052550..c19970db89c4 100644
--- a/security/tomoyo/common.c
+++ b/security/tomoyo/common.c
@@ -2256,7 +2256,7 @@ static const char * const tomoyo_memory_headers[TOMOYO_MAX_MEMORY_STAT] = {
 /* Timestamp counter for last updated. */
 static unsigned int tomoyo_stat_updated[TOMOYO_MAX_POLICY_STAT];
 /* Counter for number of updates. */
-static unsigned int tomoyo_stat_modified[TOMOYO_MAX_POLICY_STAT];
+static time64_t tomoyo_stat_modified[TOMOYO_MAX_POLICY_STAT];
 
 /**
  * tomoyo_update_stat - Update statistic counters.
@@ -2271,7 +2271,7 @@ void tomoyo_update_stat(const u8 index)
 	 * I don't use atomic operations because race condition is not fatal.
 	 */
 	tomoyo_stat_updated[index]++;
-	tomoyo_stat_modified[index] = get_seconds();
+	tomoyo_stat_modified[index] = ktime_get_real_seconds();
 }
 
 /**
diff --git a/security/tomoyo/common.h b/security/tomoyo/common.h
index 361e7a284699..d9628d1635b2 100644
--- a/security/tomoyo/common.h
+++ b/security/tomoyo/common.h
@@ -1036,7 +1036,7 @@ void tomoyo_check_acl(struct tomoyo_request_info *r,
 		      bool (*check_entry) (struct tomoyo_request_info *,
 					   const struct tomoyo_acl_info *));
 void tomoyo_check_profile(void);
-void tomoyo_convert_time(time_t time, struct tomoyo_time *stamp);
+void tomoyo_convert_time(time64_t time, struct tomoyo_time *stamp);
 void tomoyo_del_condition(struct list_head *element);
 void tomoyo_fill_path_info(struct tomoyo_path_info *ptr);
 void tomoyo_get_attributes(struct tomoyo_obj_info *obj);
diff --git a/security/tomoyo/util.c b/security/tomoyo/util.c
index 848317fea704..db7a978ab4a4 100644
--- a/security/tomoyo/util.c
+++ b/security/tomoyo/util.c
@@ -86,38 +86,17 @@ const u8 tomoyo_index2category[TOMOYO_MAX_MAC_INDEX] = {
  * @stamp: Pointer to "struct tomoyo_time".
  *
  * Returns nothing.
- *
- * This function does not handle Y2038 problem.
  */
-void tomoyo_convert_time(time_t time, struct tomoyo_time *stamp)
+void tomoyo_convert_time(time64_t time64, struct tomoyo_time *stamp)
 {
-	static const u16 tomoyo_eom[2][12] = {
-		{ 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334, 365 },
-		{ 31, 60, 91, 121, 152, 182, 213, 244, 274, 305, 335, 366 }
-	};
-	u16 y;
-	u8 m;
-	bool r;
-	stamp->sec = time % 60;
-	time /= 60;
-	stamp->min = time % 60;
-	time /= 60;
-	stamp->hour = time % 24;
-	time /= 24;
-	for (y = 1970; ; y++) {
-		const unsigned short days = (y & 3) ? 365 : 366;
-		if (time < days)
-			break;
-		time -= days;
-	}
-	r = (y & 3) == 0;
-	for (m = 0; m < 11 && time >= tomoyo_eom[r][m]; m++)
-		;
-	if (m)
-		time -= tomoyo_eom[r][m - 1];
-	stamp->year = y;
-	stamp->month = ++m;
-	stamp->day = ++time;
+	struct tm tm;
+	time64_to_tm(time64, 0, &tm);
+	stamp->sec = tm.tm_sec;
+	stamp->min = tm.tm_min;
+	stamp->hour = tm.tm_hour;
+	stamp->day = tm.tm_mday;
+	stamp->month = tm.tm_mon + 1;
+	stamp->year = tm.tm_year - (1970 - 1900);
 }
 
 /**
-- 
2.9.0

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
