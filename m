From: deepa.kernel@gmail.com (Deepa Dinamani)
Date: Fri,  7 Apr 2017 17:57:09 -0700
Subject: [PATCH 11/12] time: Delete CURRENT_TIME_SEC and CURRENT_TIME
In-Reply-To: <1491613030-11599-1-git-send-email-deepa.kernel@gmail.com>
References: <1491613030-11599-1-git-send-email-deepa.kernel@gmail.com>
Message-ID: <1491613030-11599-12-git-send-email-deepa.kernel@gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

All uses of CURRENT_TIME_SEC and CURRENT_TIME macros have
been replaced by other time functions. These macros are
also not y2038 safe.
And, all their use cases can be fulfilled by y2038 safe
ktime_get_* variants.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Acked-by: John Stultz <john.stultz@linaro.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/time.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/time.h b/include/linux/time.h
index 23f0f5c..c0543f5 100644
--- a/include/linux/time.h
+++ b/include/linux/time.h
@@ -151,9 +151,6 @@ static inline bool timespec_inject_offset_valid(const struct timespec *ts)
 	return true;
 }
 
-#define CURRENT_TIME		(current_kernel_time())
-#define CURRENT_TIME_SEC	((struct timespec) { get_seconds(), 0 })
-
 /* Some architectures do not supply their own clocksource.
  * This is mainly the case in architectures that get their
  * inter-tick times by reading the counter on their interval
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
