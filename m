Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C66DC433ED
	for <linux-security-module@archiver.kernel.org>; Thu,  8 Apr 2021 23:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DB4061159
	for <linux-security-module@archiver.kernel.org>; Thu,  8 Apr 2021 23:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbhDHX30 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 8 Apr 2021 19:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232967AbhDHX3Y (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 8 Apr 2021 19:29:24 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8808C061760
        for <linux-security-module@vger.kernel.org>; Thu,  8 Apr 2021 16:29:11 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id f29so2487825pgm.8
        for <linux-security-module@vger.kernel.org>; Thu, 08 Apr 2021 16:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aMEgyuur9qC8Rpemjb7G4PaSGh4YNOC/aXAMpJX/sQg=;
        b=mCre33MgGBGuuoUA3U1XFRwvbYQ1cjbLlg1oojueIhPjQeDIpLgWToJZX7QfnBG8sp
         0AAV96diXVHmifVsJ0xnJ1O+0874DngKv73kxBfkJ4JZM65el80pTq8QwO10QEX39E7g
         E8C+uCwQwPHbC2Dr4DQnWHhz7t7eVd4vdMbw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aMEgyuur9qC8Rpemjb7G4PaSGh4YNOC/aXAMpJX/sQg=;
        b=kxBrfNebSdkmPOIvaJOV1qQCfVAKxYNF67IF8dNHbMwTjeXjiUS5RA+6Nx8q9B5qfB
         N4Xodfwkm6wSTFfoxYgwyYHCAlUcv5Uq+7BWabm+Mh11bV6XCZNrWZwEqDGTjmWwnzNJ
         EY0zjaewlqX3Kdyz7AyqpbUrLd1cBRyziJmec2Akftn6vT03wtsYgCr8kvElDlE/C+/I
         kQV9ih0g6cJJTGS2dn6BhQ6urnn9fIfrdt3j4KeVQW7iQf52kI1LnCNKwTtUXdvi3xMb
         gS0wLz8uCLUThI6zzPi8Qp9IWeLAmD/QhdfsFLLOwVYrkukcdF75TGDIJnb2BveucFxw
         5zdg==
X-Gm-Message-State: AOAM533ogxok9FI69bEOe4e8IfCVS47BB9vbEieUfHBjK38NiU/i/fBk
        GW85msbk1rVxlWpr0n+Fzn4svQ==
X-Google-Smtp-Source: ABdhPJxfxrXHnC7s9Dd5yQRxqTHtOygKm0XPxiKdxhHqnqL/8cjon8l6fDVbMaa5Ysd/w3lIEkxAjA==
X-Received: by 2002:a65:4887:: with SMTP id n7mr10262449pgs.14.1617924551162;
        Thu, 08 Apr 2021 16:29:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y66sm371293pgb.78.2021.04.08.16.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 16:29:10 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>
Subject: [PATCH] LoadPin: Allow filesystem switch when not enforcing
Date:   Thu,  8 Apr 2021 16:28:56 -0700
Message-Id: <20210408232856.1697972-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=cf21ff2cc7c5321481efd2844f5f4803d595e358; i=sxtRD1DI+VktMwvXHDndmH3YdUWEJvGf0n/4AbnGWps=; m=+T8NnhTQZYd8XijaeBTdeSfRIfOyyyvOS4LtXhzFv14=; p=9MtPpY5fBp9Rp++zHuqEJ21QZAkxT32nZNDagWooTnI=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmBvkbcACgkQiXL039xtwCYtjw//Zn/ xaXVaWZZJpxY949nsIEkdYF6guogXEqil86vhni3qrJltJPYEKbwvdNGz2+JfXHcDg8JrduVPzHOD p3b6JPVkIBBUIKxPRCwozR21B2DQLS8C9JtwV4itRSbI/fxZdtIm2q2AcSnSEUt27JlwiY8IHRnoD ku5C4VJyzpwnGga2toqOVyDsvhAhyRa/oiI6I7/6vvuchpqHVvIIOMZwBOgZ3UBQS5HzkZRxVGDCy xezaPtWOn7sQYaxFFWVPruhJgKWpvkBLz3tVsqfEM33mev0Hmy4ITrEeotKaRkF5J3hSu25gHdusk MDV5k7y0zD0Zj+hVPKu27OEGSvRaPbWJ9LQJ4EThd5/ivHdIpzcS0ZMDq/7dwa7B4hgt2xKaTpR9C DTuo75/fJ0tTR8RJCkq+l21wEzthGN9oPKNObSO0j35SeDQetCllqUehVBF2rx6H6igABHDDaKAwE fa4Wy9Cw5ii1huAO0iZLueAeEnAvYxRT6hP3raSKKlnITKMcrV+4OWZLi0WfFbBuLwBuLCSS2bA8S j4CNvuHP54AsKkZGVLW/jj1TEu7UJmD169hyB2vh5tszto54a8pX4MBoPQA48AfuUIWC+n58sPFF9 IU5inleFTFnHD2bpJxpraoqWo+nFMhUcZTMdTVoQ0O/PkkCAAPk7NT9jbcp9+Nj4=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

For LoadPin to be used at all in a classic distro environment, it needs
to allow for switching filesystems (from the initramfs to the "real"
root filesystem). If the "enforce" mode is not set, reset the pinned
filesystem tracking when the pinned filesystem gets unmounted.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/loadpin/loadpin.c | 110 +++++++++++++++++++++----------------
 1 file changed, 63 insertions(+), 47 deletions(-)

diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index b12f7d986b1e..ca1bbfe4a44b 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -45,7 +45,6 @@ static struct super_block *pinned_root;
 static DEFINE_SPINLOCK(pinned_root_spinlock);
 
 #ifdef CONFIG_SYSCTL
-
 static struct ctl_path loadpin_sysctl_path[] = {
 	{ .procname = "kernel", },
 	{ .procname = "loadpin", },
@@ -59,69 +58,81 @@ static struct ctl_table loadpin_sysctl_table[] = {
 		.maxlen         = sizeof(int),
 		.mode           = 0644,
 		.proc_handler   = proc_dointvec_minmax,
-		.extra1         = SYSCTL_ZERO,
+		.extra1         = SYSCTL_ONE,
 		.extra2         = SYSCTL_ONE,
 	},
 	{ }
 };
 
-/*
- * This must be called after early kernel init, since then the rootdev
- * is available.
- */
-static void check_pinning_enforcement(struct super_block *mnt_sb)
+static void set_sysctl(bool is_writable)
 {
-	bool ro = false;
-
 	/*
 	 * If load pinning is not enforced via a read-only block
 	 * device, allow sysctl to change modes for testing.
 	 */
-	if (mnt_sb->s_bdev) {
-		char bdev[BDEVNAME_SIZE];
-
-		ro = bdev_read_only(mnt_sb->s_bdev);
-		bdevname(mnt_sb->s_bdev, bdev);
-		pr_info("%s (%u:%u): %s\n", bdev,
-			MAJOR(mnt_sb->s_bdev->bd_dev),
-			MINOR(mnt_sb->s_bdev->bd_dev),
-			ro ? "read-only" : "writable");
-	} else
-		pr_info("mnt_sb lacks block device, treating as: writable\n");
-
-	if (!ro) {
-		if (!register_sysctl_paths(loadpin_sysctl_path,
-					   loadpin_sysctl_table))
-			pr_notice("sysctl registration failed!\n");
-		else
-			pr_info("enforcement can be disabled.\n");
-	} else
-		pr_info("load pinning engaged.\n");
+	if (is_writable)
+		loadpin_sysctl_table[0].extra1 = SYSCTL_ZERO;
+	else
+		loadpin_sysctl_table[0].extra1 = SYSCTL_ONE;
 }
 #else
-static void check_pinning_enforcement(struct super_block *mnt_sb)
+static bool set_sysctl(bool is_writable) { }
+#endif
+
+/*
+ * This must be called after early kernel init, since then the rootdev
+ * is available.
+ */
+static bool sb_is_writable(struct super_block *mnt_sb, struct block_device **bdev)
+{
+	bool writable = true;
+
+	*bdev = mnt_sb->s_bdev;
+	if (*bdev)
+		writable = !bdev_read_only(*bdev);
+
+	return writable;
+}
+
+static void report_writable(struct block_device *bdev)
 {
-	pr_info("load pinning engaged.\n");
+	if (bdev) {
+		char name[BDEVNAME_SIZE];
+
+		bdevname(bdev, name);
+		pr_info("%s (%u:%u): %s\n", name,
+			MAJOR(bdev->bd_dev),
+			MINOR(bdev->bd_dev),
+			load_root_writable ? "writable" : "read-only");
+	} else {
+		pr_info("pinned filesystem lacks block device, treating as: writable\n");
+	}
 }
-#endif
 
 static void loadpin_sb_free_security(struct super_block *mnt_sb)
 {
 	/*
 	 * When unmounting the filesystem we were using for load
 	 * pinning, we acknowledge the superblock release, but make sure
-	 * no other modules or firmware can be loaded.
+	 * no other modules or firmware can be loaded when we are in
+	 * enforcing mode. Otherwise, allow the root to be reestablished.
 	 */
 	if (!IS_ERR_OR_NULL(pinned_root) && mnt_sb == pinned_root) {
-		pinned_root = ERR_PTR(-EIO);
-		pr_info("umount pinned fs: refusing further loads\n");
+		if (enforced) {
+			pinned_root = ERR_PTR(-EIO);
+			pr_info("umount pinned fs: refusing further loads\n");
+		} else {
+			pinned_root = NULL;
+		}
 	}
 }
 
 static int loadpin_read_file(struct file *file, enum kernel_read_file_id id,
 			     bool contents)
 {
+	struct block_device *bdev = NULL;
 	struct super_block *load_root;
+	bool load_root_writable, first_root_pin, sysctl_needed;
 	const char *origin = kernel_read_file_id_str(id);
 
 	/*
@@ -152,26 +163,27 @@ static int loadpin_read_file(struct file *file, enum kernel_read_file_id id,
 	}
 
 	load_root = file->f_path.mnt->mnt_sb;
+	load_root_writable = sb_is_writable(load_root, &bdev);
+	sysctl_needed = false;
+	first_root_pin = false;
 
 	/* First loaded module/firmware defines the root for all others. */
 	spin_lock(&pinned_root_spinlock);
 	/*
-	 * pinned_root is only NULL at startup. Otherwise, it is either
-	 * a valid reference, or an ERR_PTR.
+	 * pinned_root is only NULL at startup or when the pinned root has
+	 * been unmounted while we are not in enforcing mode. Otherwise, it
+	 * is either a valid reference, or an ERR_PTR.
 	 */
 	if (!pinned_root) {
 		pinned_root = load_root;
-		/*
-		 * Unlock now since it's only pinned_root we care about.
-		 * In the worst case, we will (correctly) report pinning
-		 * failures before we have announced that pinning is
-		 * enforcing. This would be purely cosmetic.
-		 */
-		spin_unlock(&pinned_root_spinlock);
-		check_pinning_enforcement(pinned_root);
+		first_root_pin = true;
+	}
+	spin_unlock(&pinned_root_spinlock);
+
+	if (first_root_pin) {
+		report_writable(bdev);
+		set_sysctl(load_root_writable);
 		report_load(origin, file, "pinned");
-	} else {
-		spin_unlock(&pinned_root_spinlock);
 	}
 
 	if (IS_ERR_OR_NULL(pinned_root) || load_root != pinned_root) {
@@ -239,6 +251,10 @@ static int __init loadpin_init(void)
 	pr_info("ready to pin (currently %senforcing)\n",
 		enforce ? "" : "not ");
 	parse_exclude();
+#ifdef CONFIG_SYSCTL
+	if (!register_sysctl_paths(loadpin_sysctl_path, loadpin_sysctl_table))
+		pr_notice("sysctl registration failed!\n");
+#endif
 	security_add_hooks(loadpin_hooks, ARRAY_SIZE(loadpin_hooks), "loadpin");
 	return 0;
 }
-- 
2.25.1

