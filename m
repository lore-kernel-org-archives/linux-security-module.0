From: dhowells@redhat.com (David Howells)
Date: Tue, 26 Jun 2018 16:59:40 +0100
Subject: [PATCH 2/3] certs/blacklist: fix const confusion
In-Reply-To: <153002876741.31726.8580751276453556884.stgit@warthog.procyon.org.uk>
References: <153002876741.31726.8580751276453556884.stgit@warthog.procyon.org.uk>
Message-ID: <153002878055.31726.289273416003704588.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Nick Desaulniers <nick.desaulniers@gmail.com>

Fixes commit 2be04df5668d ("certs/blacklist_nohashes.c: fix const confusion
in certs blacklist")

Signed-off-by: Nick Desaulniers <nick.desaulniers@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 certs/blacklist.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/certs/blacklist.h b/certs/blacklist.h
index 150d82da8e99..1efd6fa0dc60 100644
--- a/certs/blacklist.h
+++ b/certs/blacklist.h
@@ -1,3 +1,3 @@
 #include <linux/kernel.h>
 
-extern const char __initdata *const blacklist_hashes[];
+extern const char __initconst *const blacklist_hashes[];

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
