From: dhowells@redhat.com (David Howells)
Date: Thu, 22 Feb 2018 13:07:57 +0000
Subject: [PATCH 04/30] Enforce module signatures if the kernel is locked
	down
In-Reply-To: <151024866805.28329.10437019941463042267.stgit@warthog.procyon.org.uk>
References: <151024866805.28329.10437019941463042267.stgit@warthog.procyon.org.uk>
	<151024863544.28329.2436580122759221600.stgit@warthog.procyon.org.uk>
Message-ID: <30284.1519304877@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

I'm considering folding the attached changes into this patch.

It adjusts the errors generated:

 (1) If there's no signature (ENODATA) or we can't check it (ENOPKG, ENOKEY),
     then:

     (a) If signatures are enforced then EKEYREJECTED is returned.

     (b) If IMA will have validated the image, return 0 (okay).

     (c) If there's no signature or we can't check it, but the kernel is
	 locked down then EPERM is returned (this is then consistent with
	 other lockdown cases).

 (2) If the signature is unparseable (EBADMSG, EINVAL), the signature fails
     the check (EKEYREJECTED) or a system error occurs (eg. ENOMEM), we return
     the error we got.

Note that the X.509 code doesn't check for key expiry as the RTC might not be
valid or might not have been transferred to the kernel's clock yet.

David
---
diff --git a/kernel/module.c b/kernel/module.c
index 1eb06a0ccbfb..62419cf48ef6 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2769,8 +2769,9 @@ static inline void kmemleak_load_module(const struct module *mod,
 static int module_sig_check(struct load_info *info, int flags,
 			    bool can_do_ima_check)
 {
-	int err = -ENOKEY;
+	int err = -ENODATA;
 	const unsigned long markerlen = sizeof(MODULE_SIG_STRING) - 1;
+	const char *reason;
 	const void *mod = info->hdr;
 
 	/*
@@ -2785,18 +2786,42 @@ static int module_sig_check(struct load_info *info, int flags,
 		err = mod_verify_sig(mod, &info->len);
 	}
 
-	if (!err) {
+	switch (err) {
+	case 0:
 		info->sig_ok = true;
 		return 0;
-	}
 
-	/* Not having a signature is only an error if we're strict. */
-	if (err == -ENOKEY && !sig_enforce &&
-	    (!can_do_ima_check || !is_ima_appraise_enabled()) &&
-	    !kernel_is_locked_down("Loading of unsigned modules"))
-		err = 0;
+		/* We don't permit modules to be loaded into trusted kernels
+		 * without a valid signature on them, but if we're not
+		 * enforcing, certain errors are non-fatal.
+		 */
+	case -ENODATA:
+		reason = "Loading of unsigned module";
+		goto decide;
+	case -ENOPKG:
+		reason = "Loading of module with unsupported crypto";
+		goto decide;
+	case -ENOKEY:
+		reason = "Loading of module with unavailable key";
+	decide:
+		if (sig_enforce) {
+			pr_notice("%s is rejected\n", reason);
+			return -EKEYREJECTED;
+		}
 
-	return err;
+		if (can_do_ima_check && is_ima_appraise_enabled())
+			return 0;
+		if (kernel_is_locked_down(reason))
+			return -EPERM;
+		return 0;
+
+		/* All other errors are fatal, including nomem, unparseable
+		 * signatures and signature check failures - even if signatures
+		 * aren't required.
+		 */
+	default:
+		return err;
+	}
 }
 #else /* !CONFIG_MODULE_SIG */
 static int module_sig_check(struct load_info *info, int flags,
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
