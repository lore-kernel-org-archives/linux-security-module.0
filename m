From: deepa.kernel@gmail.com (Deepa Dinamani)
Date: Fri,  7 Apr 2017 17:56:59 -0700
Subject: [PATCH 01/12] fs: f2fs: Use ktime_get_real_seconds for sit_info times
In-Reply-To: <1491613030-11599-1-git-send-email-deepa.kernel@gmail.com>
References: <1491613030-11599-1-git-send-email-deepa.kernel@gmail.com>
Message-ID: <1491613030-11599-2-git-send-email-deepa.kernel@gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

CURRENT_TIME_SEC is not y2038 safe.

Replace use of CURRENT_TIME_SEC with ktime_get_real_seconds
in segment timestamps used by GC algorithm including the
segment mtime timestamps.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/f2fs/segment.c | 2 +-
 fs/f2fs/segment.h | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 010324c..0531500 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2678,7 +2678,7 @@ static int build_sit_info(struct f2fs_sb_info *sbi)
 	sit_i->dirty_sentries = 0;
 	sit_i->sents_per_block = SIT_ENTRY_PER_BLOCK;
 	sit_i->elapsed_time = le64_to_cpu(sbi->ckpt->elapsed_time);
-	sit_i->mounted_time = CURRENT_TIME_SEC.tv_sec;
+	sit_i->mounted_time = ktime_get_real_seconds();
 	mutex_init(&sit_i->sentry_lock);
 	return 0;
 }
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 57e36c1..156afc3 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -692,8 +692,9 @@ static inline void set_to_next_sit(struct sit_info *sit_i, unsigned int start)
 static inline unsigned long long get_mtime(struct f2fs_sb_info *sbi)
 {
 	struct sit_info *sit_i = SIT_I(sbi);
-	return sit_i->elapsed_time + CURRENT_TIME_SEC.tv_sec -
-						sit_i->mounted_time;
+	time64_t now = ktime_get_real_seconds();
+
+	return sit_i->elapsed_time + now - sit_i->mounted_time;
 }
 
 static inline void set_summary(struct f2fs_summary *sum, nid_t nid,
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
