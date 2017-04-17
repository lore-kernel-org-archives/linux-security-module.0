From: matt@nmatt.com (Matt Brown)
Date: Mon, 17 Apr 2017 02:07:04 -0400
Subject: [PATCH 2/4] add tiocsti_restrict variable
In-Reply-To: <20170417060706.28674-1-matt@nmatt.com>
References: <20170417060706.28674-1-matt@nmatt.com>
Message-ID: <20170417060706.28674-3-matt@nmatt.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

adding extern variable tiocsti_restrict to allow it to be included
in sysctl

Signed-off-by: Matt Brown <matt@nmatt.com>
---
 include/linux/tty.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/tty.h b/include/linux/tty.h
index 1017e904..7011102 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -342,6 +342,8 @@ struct tty_file_private {
 	struct list_head list;
 };
 
+extern int tiocsti_restrict;
+
 /* tty magic number */
 #define TTY_MAGIC		0x5401
 
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
