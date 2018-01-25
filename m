From: takondra@cisco.com (Taras Kondratiuk)
Date: Thu, 25 Jan 2018 03:27:43 +0000
Subject: [PATCH v2 03/15] initramfs: store file name in name_buf
In-Reply-To: <1516850875-25066-1-git-send-email-takondra@cisco.com>
References: <1516850875-25066-1-git-send-email-takondra@cisco.com>
Message-ID: <1516850875-25066-4-git-send-email-takondra@cisco.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

There is already name_buf buffer pre-allocated for a file name. No need
to allocate vcollected for every file. More over a name can be already
stored in name_buf by read_info() function.

Add memcpy_optional() function to handle such case.

Signed-off-by: Taras Kondratiuk <takondra@cisco.com>
---
 init/initramfs.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 49cd2681a26f..b6ee675e5cdb 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -210,7 +210,6 @@ static inline void __init eat(unsigned n)
 	byte_count -= n;
 }
 
-static __initdata char *vcollected;
 static __initdata char *collected;
 static long remains __initdata;
 static __initdata char *collect;
@@ -324,6 +323,13 @@ static void __init clean_path(char *path, umode_t fmode)
 	}
 }
 
+static void *memcpy_optional(void *dest, const void *src, size_t n)
+{
+	if (dest != src)
+		return memcpy(dest, src, n);
+	return dest;
+}
+
 static __initdata int wfd;
 
 static int __init do_name(void)
@@ -348,7 +354,8 @@ static int __init do_name(void)
 				sys_fchmod(wfd, mode);
 				if (body_len)
 					sys_ftruncate(wfd, body_len);
-				vcollected = kstrdup(collected, GFP_KERNEL);
+				memcpy_optional(name_buf, collected,
+						N_ALIGN(name_len));
 				state = do_copy;
 			}
 		}
@@ -375,8 +382,7 @@ static int __init do_copy(void)
 		if (xwrite(wfd, victim, body_len) != body_len)
 			error("write error");
 		sys_close(wfd);
-		do_utime(vcollected, mtime);
-		kfree(vcollected);
+		do_utime(name_buf, mtime);
 		eat(body_len);
 		state = do_skip;
 		return 0;
-- 
2.10.3.dirty

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
