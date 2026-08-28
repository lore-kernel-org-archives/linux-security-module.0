Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B818840B6F9
	for <linux-security-module@vger.kernel.org>; Fri, 28 Aug 2026 12:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787919237; cv=none; b=XpS1TFIBD/ZUYr7LSYN11QRamxe4q652UqrydfRX5WHDfq+amNx+ycakaMexEjSkBuFfPBfehoL5LZnRMDTnzPZ+ZD4MuvJSVDfu/HDCwQQqKfDQeObhPZFsl+be9kVhTg2NndEU78Sr8MEjFROJ5Vh6m5FEh8trjk0M7vhD3Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787919237; c=relaxed/simple;
	bh=v4pnkqvdHm9QD9jNEhWv4ptrTvQfeqdiliV0fANY8/M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jvKSB3xZ0mviKKd505Eebn0EF7We14FUjvqDx3qFTj2zfx+jb8LQRVaefIWx5lCC4wkbmPUxaETM+i2aGZhHSMfiLqDcwZp9w1f5b+/UEDwNaXAcE1Qyg/9nGBJHOgFwcmbhnFszU838icatmacSOSrOGkQ2z22d+Bl9qKHTY2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGoCsR+K; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGoCsR+K"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-39266382df6so1000866a91.3
        for <linux-security-module@vger.kernel.org>; Fri, 28 Aug 2026 05:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787919220; x=1788524020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hlABrd1SCkhQYY7SNMNayd0uvaXGvcufVaXw6AHl0rs=;
        b=kGoCsR+K9rUXqrhLbPQSSpIirQMUUhWf1MpMVWyG/0EmvhcSZTtqJ29ZaSrT2xYntG
         AI0vdjPWylKM3LGL0EePB46Hu7b2Nuu5oNrETs3H/ORZljD1FrItmPJwp+lBdMdh5SwR
         nHsb+QFK8CZfRpssvcrUDwqm5QzKV0+aMgHPstMFCXpEAdOA6y/bv45x9+D+NJfESqRI
         kIvDUE8Fnny1EOOV+jcP2xyEnOXCXVu/BTZ2L+ycMZGLVboUZbXWiyC1n8nTGJAZkods
         HC67OkiREM/zUVl+UUkL7vP43JNesV3v8L/nbI3NFOPVPCxsfA5eKMn+OUZbHkrBErT7
         28PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787919220; x=1788524020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hlABrd1SCkhQYY7SNMNayd0uvaXGvcufVaXw6AHl0rs=;
        b=JdIy8X4n/85YXeiLwnOkFRhDPRw2v+UbTGNDt8yMQFWwMDo4/kuqr2tJWdljTw/BEv
         iQDg5rhoNDqsyLtCOoSonQfa10ODoylcK8IgVZhmN2lGCRPxW+fGpcrz/eiY27aHDMN3
         Zm4XksB2wrbiEsV7TXl0p3HQeBQ7tpIjaxbeJnYIG+xjSRzLXOINAhsFxghNhqkZYRsR
         TnH05KlN/ne2XIUwDUELQtBOnZIsU6b9bf5Yia7eEl6rfwoJw+4m5YR2hvhH9QecQwdh
         xbpcZglSib5WIOQ/GXVbvYvZhXSGMyitfdjolxtVV8Arqou3QWUIqxN4jPtC9FmVniaT
         NliQ==
X-Gm-Message-State: AFuF++l5pEVzfu/65NQLKUrR0ffMK9HGo2nQHnRI2KZ7Wt8IxTWLQKte
	iTBjII6Oy4GCBl6MwlSFP7cZFVbSZLPJ+x96JYZr3l35KcLFRtqmiUAyYAJSkP44
X-Gm-Gg: AR+sD12s3inJnavuqKqIIurO40yukC/PLESZzcduqPCpr1qomllWllXP4Oh8mR+Qwkp
	5zGDzsKb8KCIxoeaULZLRmD+tmD4Cbq0ySuXK0Csuyr7ZWbP0x38wHTVtTKmw02AL6ovZCO2MVo
	dL3zjcWm3MSXYIqngliHOKdxnBmrU1xpuTERJXmTkPi+etzAc8Lr7uskUNB7RmCZQ46eaDZymFL
	GN9OhEqFWvJuV1/ntrUQwckjkPFn0o6GJU4V/Y7Ksh8L0ZYSWMEDMjIvTDn37PrFMJ1nYZm5io/
	yk0/i8vA3GoswI7oS8xMhGwjT7N01G5mSUAhwicHwk+TaQpxYXFNdndK1UbPT2gwZTyk8y+XyGn
	1AaQTsoknO78RW4Jk92Jf+UVAdbK0cMHXWyCTqTj5lWqdQhIOroDJt9cF60rDX/a3qyhmbUS3NE
	ztLiMSjk+TzDax8hMtxvcvc0dGJpRPpnffyRqc92y+VhQbZhZcDqAv+tTXl5I63idcETrScaRNN
	fiJLDwjT+hxdfJcI4aBqp4b6optXtN8
X-Received: by 2002:a17:90b:2d82:b0:393:194d:5366 with SMTP id 98e67ed59e1d1-396d0f6f8bfmr14131375a91.10.1787919219186;
        Fri, 28 Aug 2026 05:13:39 -0700 (PDT)
Received: from FLYINGPENG-MC2.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b186807bsm7266895a91.12.2026.08.28.05.13.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 28 Aug 2026 05:13:38 -0700 (PDT)
From: Peng Hao <flyingpenghao@gmail.com>
X-Google-Original-From: Peng Hao <flyingpeng@tencent.com>
To: mic@digikod.net,
	gnoack@google.com
Cc: linux-security-module@vger.kernel.org
Subject: [PATCH] selftests/landlock: prevent mount propagation from test namespaces
Date: Fri, 28 Aug 2026 20:13:34 +0800
Message-ID: <20260828121334.26804-1-flyingpeng@tencent.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The filesystem fixtures create TMP_DIR, unshare the mount namespace, and
then mount a temporary filesystem.  A new mount namespace inherits the
parent's propagation state, so on systems with a shared mount tree the
new mount can propagate back into the parent namespace before TMP_DIR is
made private.

The parent teardown can then find TMP_DIR still mounted and return EBUSY.
Its ASSERT_EQ() stops cleanup before remove_path(), leaving stale state
that makes later tests fail with EEXIST.

Make the complete mount tree recursively private immediately after
unshare(), before creating the fixture mount.  If propagation setup
fails, remove TMP_DIR because fixture teardown will not run.

Also make teardown continue after an unexpected unmount result.  Report
anything other than the expected EINVAL as a test failure, but lazily
detach an EBUSY mount and always attempt to remove TMP_DIR so one failure
does not cascade into later tests.

Fixes: e1199815b47b ("selftests/landlock: Add user space tests")
Signed-off-by: Peng Hao <flyingpeng@tencent.com>
---
 tools/testing/selftests/landlock/fs_test.c | 28 ++++++++++++++++++----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 86e08aa6e0a7..72c2a8bef146 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -305,6 +305,16 @@ static void prepare_layout_opt(struct __test_metadata *const _metadata,
 	 */
 	set_cap(_metadata, CAP_SYS_ADMIN);
 	ASSERT_EQ(0, unshare(CLONE_NEWNS | CLONE_NEWCGROUP));
+	/*
+	 * A new mount namespace inherits its parent's propagation state.  Make
+	 * the whole tree private before creating mounts below TMP_DIR so none
+	 * of them can propagate back to the parent namespace.
+	 */
+	ASSERT_EQ(0, mount(NULL, "/", NULL, MS_PRIVATE | MS_REC, NULL))
+	{
+		clear_cap(_metadata, CAP_SYS_ADMIN);
+		remove_path(TMP_DIR);
+	}
 	ASSERT_EQ(0, mount_opt(mnt, TMP_DIR))
 	{
 		TH_LOG("Failed to mount the %s filesystem: %s", mnt->type,
@@ -330,13 +340,21 @@ static void cleanup_layout(struct __test_metadata *const _metadata)
 {
 	set_cap(_metadata, CAP_SYS_ADMIN);
 	if (umount(TMP_DIR)) {
+		int err = errno;
+
 		/*
-		 * According to the test environment, the mount point of the
-		 * current directory may be shared or not, which changes the
-		 * visibility of the nested TMP_DIR mount point for the test's
-		 * parent process doing this cleanup.
+		 * The child normally owns the TMP_DIR mount in its private mount
+		 * namespace, so the parent teardown should only see EINVAL.  If a
+		 * mount is unexpectedly still visible, report the failure but
+		 * detach it so one broken test cannot cascade into later tests.
 		 */
-		ASSERT_EQ(EINVAL, errno);
+		EXPECT_EQ(EINVAL, err)
+		{
+			TH_LOG("Unexpected umount errno=%d (%s)", err,
+			       strerror(err));
+		}
+		if (err == EBUSY)
+			EXPECT_EQ(0, umount2(TMP_DIR, MNT_DETACH));
 	}
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 	EXPECT_EQ(0, remove_path(TMP_DIR));
-- 
2.43.7

