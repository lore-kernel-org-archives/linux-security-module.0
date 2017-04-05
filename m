From: dhowells@redhat.com (David Howells)
Date: Wed, 05 Apr 2017 18:10:29 +0100
Subject: [PATCH 04/24] Enforce module signatures if the kernel is locked down
In-Reply-To: <149141219387.31282.6648284836568938717.stgit@warthog.procyon.org.uk>
References: <149141219387.31282.6648284836568938717.stgit@warthog.procyon.org.uk>
Message-ID: <149141222925.31282.2184675566737091098.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

If the kernel is locked down, require that all modules have valid
signatures that we can verify.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 kernel/module.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/module.c b/kernel/module.c
index 7eba6dea4f41..3331f2eb9b93 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2756,7 +2756,7 @@ static int module_sig_check(struct load_info *info, int flags)
 	}
 
 	/* Not having a signature is only an error if we're strict. */
-	if (err == -ENOKEY && !sig_enforce)
+	if (err == -ENOKEY && !sig_enforce && !kernel_is_locked_down())
 		err = 0;
 
 	return err;

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
