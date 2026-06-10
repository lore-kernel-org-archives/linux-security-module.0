Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292EB392824
	for <linux-security-module@vger.kernel.org>; Wed, 10 Jun 2026 09:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781083410; cv=none; b=F1965cMqaXu3B3wjCFgIDfQC0Y7oQP01ECbkQxAaLGt1LZgH+ZOZep5RAlFO084BBKMT/v79NX/+wtCDUGfM55TrrOXAG8dj/x8PKpvfKk0DeQn/KhNMyNbanZBZZtESoiu8y4c26N4Rv3sfkTepdZOCD8sCyuI/zzHKt9vOFIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781083410; c=relaxed/simple;
	bh=cs9ADQpJrE1vHrOe+Fnn2LjBklh9nDRGBZLzmQbAvv8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TCGpHEbzuXYSqMAVd58SpA3R8cNyicD2MtVy9y39cER549PZ5Wp4CqxBTkn78qgZYc26yU3S41iFeYDbcqCy53BmNrLr93KijjDoXDy45BH0vDX9Aw8Nz4fg0xYSPMLzHqKNgklj7fZjHrHyoWhHljZI9GhCYeYfVMSlgfb1De8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dOqZm2jX; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dOqZm2jX"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-490b79e6b94so48397465e9.2
        for <linux-security-module@vger.kernel.org>; Wed, 10 Jun 2026 02:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781083407; x=1781688207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jtBfzRHHB5JXBU/h8EsdiTp9Dx832mXvODgxpMsAEU8=;
        b=dOqZm2jXVqL/lT+3S2ovLhtqiNSKLsj/RRf63TaStQfWE27hZ7mXe7M/kUW9OEcj/Y
         elNSEmBNuIqmxpS9noE5kXe7qARxXxeGVnaY9NCJdyzDqkXb6iT7S+mSMA1ngV+XSQ2V
         hJmeICg0OAdMAI3YUR25jGrPmRUMTXo+IdzNhwGmnN25taufGBT4z5jA1qBuKRJVRZ1n
         jMr0IhHf/ae88CcaCEVZ1YUJF6JXsyKUQMQJfHuLvaemfmeoIB9Z8esAOJL5T1eOmVKB
         MJqzs2oX5fjmmMNR6GXcGeJmUOMa9MKSIfM737gXujMP6I8gK+W/THcXuhN7xGcCe53P
         WHtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781083407; x=1781688207;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jtBfzRHHB5JXBU/h8EsdiTp9Dx832mXvODgxpMsAEU8=;
        b=HjIWfAZtTBamKkrXas/tDPO7kJXntLhHU+G59g/+oNX0A82LeLh4UbyLN2M1Mvyh2K
         6lxj6UaVyvRL2TDx124iOWZc4ypo4XG3XaDoQmQGr8inmZAV/7r7JB/nl7Z9dCLaPA+C
         Ox2dMQS4FogrgGmpSBHi8AVe+ePssiWATSnQnKpEKlYt/JQ89zInijSnB5U0ptgYSTOJ
         dG1WmZMqsuy2SgLdHpbsuKWl/S0EmW/ioIbaFpAhnahPWzJgpR3g+AAhVSuTOpNAUoli
         ZFNAz0kL6AVcoL0cmLzXtxQAgiNwlP+IaWJBxSnmSrqYUMXVJi01QkyiD94WQl5JuT4w
         ycbw==
X-Gm-Message-State: AOJu0YyMyFFnD6pslSJsvvy48OhWEQK2yv9utBUo7OpJuC41U5o0YYwO
	FNBSyJpzbKT5gtclbTdnpqtXMS8+wx1AkPV9qzwBAJAf2+vWusKzv34m1BJCg+9R3Jj8TwrSn19
	jUEx/sA==
X-Received: from wmhn18.prod.google.com ([2002:a05:600c:3052:b0:490:b37b:a4d8])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3b08:b0:490:44eb:c1e0
 with SMTP id 5b1f17b1804b1-490d72241bamr86098965e9.21.1781083407309; Wed, 10
 Jun 2026 02:23:27 -0700 (PDT)
Date: Wed, 10 Jun 2026 11:23:17 +0200
In-Reply-To: <20260610092318.3868884-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260610092318.3868884-1-gnoack@google.com>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260610092318.3868884-3-gnoack@google.com>
Subject: [PATCH v3 2/3] selftests/landlock: Add test for RENAME_WHITEOUT denial
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, Christian Brauner <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, Serge Hallyn <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Add a test to check that renames with RENAME_WHITEOUT are guarded by
LANDLOCK_ACCESS_FS_MAKE_WHITEOUT.

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 tools/testing/selftests/landlock/fs_test.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index 53d1b659849f..bdad92195f62 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -2248,6 +2248,19 @@ TEST_F_FORK(layout1, rename_file)
 			       RENAME_EXCHANGE));
 }
=20
+TEST_F_FORK(layout1, rename_whiteout_denied)
+{
+	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_MAKE_WHITEOUT, NULL);
+
+	/*
+	 * Try to rename a file with RENAME_WHITEOUT.
+	 * file1_s3d3 is in dir_s3d2 (tmpfs), so it supports RENAME_WHITEOUT.
+	 */
+	EXPECT_EQ(-1, renameat2(AT_FDCWD, file1_s3d3, AT_FDCWD,
+				TMP_DIR "/s3d1/s3d2/s3d3/f2", RENAME_WHITEOUT));
+	EXPECT_EQ(EACCES, errno);
+}
+
 TEST_F_FORK(layout1, rename_dir)
 {
 	const struct rule rules[] =3D {
@@ -6950,6 +6963,7 @@ TEST_F_FORK(layout2_overlay, same_content_different_f=
ile)
 	}
 }
=20
+
 FIXTURE(layout3_fs)
 {
 	bool has_created_dir;
--=20
2.54.0.1099.g489fc7bff1-goog

