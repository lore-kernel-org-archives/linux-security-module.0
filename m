Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFEA27C154
	for <linux-security-module@vger.kernel.org>; Wed,  9 Apr 2025 18:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224823; cv=none; b=cNJ3f7mWFhuOJOyVR8wgkn+i2BAyanbi0cM0FN+PnrL+LR55a53et2D4Hm2qg/0hlQMZtfShf6BoLl/SB9iM5jRfhuNoVQLq6UaZT0ZlZNW21y8G6/U0h5mBg3g6TFQ094Of06IApWe2KjBCr7fSU+RYMGw3WpOU3AbSlFHs4Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224823; c=relaxed/simple;
	bh=578od+KOKp0Zt5/G5juxhdeXYFulKkNW5mxLTRLFSTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gymwx+vOU9sXuJWAk3goryKrkik//CpFzpn9ib666IrZkd0m1uV11lH3P4UMvNUjBZ7nXlD02Nxk1AqULJPeKKf1N8M8wikqDWKhXtY8Sz+NQXk9uGaYi9+dHRtwgh6RWpEQsR3ItcBvDn2OxDIXnlKBcclVFDUelF9NCW/GCSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=N7tekTIm; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="N7tekTIm"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4775ccf3e56so12199361cf.0
        for <linux-security-module@vger.kernel.org>; Wed, 09 Apr 2025 11:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744224820; x=1744829620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fM+bz3BaSY4cr5+X5vDEIDHe3dga52xK7vJorYPABfU=;
        b=N7tekTIm/VpWkeqBUSW2G5hY2qUH7PpvqZ6DPRLxqJrbD+HJZ+GAh1QUEdl/ozZwB5
         oY9OvYASHq9VQS0DpWok3OQLvNA+uKavJSB8mmuRlZU/uik4l5BPk2mWGGQuvGPOOtFH
         aRvU0wbufVjm3ccu2YLSCvRoiE/+HGxmE8RwUya1buTh766UI0TM/0FkX+YBkLGuXKIW
         8nvjrvq/bRq8aYacU/QBvIuLSHRI+Uz4eApZonyotbs90/PdgjD0b3XuBjF+VkShu941
         fA7aokSmGN0A9vY8yOtFU2WC5UYhpmZpAk05ypUYvG+JUT+eJ9+QIpxIfrtBp7TrE+Lr
         cZDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744224820; x=1744829620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fM+bz3BaSY4cr5+X5vDEIDHe3dga52xK7vJorYPABfU=;
        b=SlAkWKNDa2xuBG7KFUuSmCG9IU5ZE9Kn/ZBqZelolp2fdsP0SDRedX+wqQEh+MeUQ0
         r4AwkV0AOWJU85tDrHkMJJcelTjeFHo6EBx5PJoiSpwA6/P0hJeMae0Z/F7npwTiCnCp
         nGreRH8dHhuuWZMSOpGg0iOrYZOAUA0368++1na/6izlxGEjylxkkcMib1Kj39ViNtZU
         XfXtmB3d3aarM8B1HRsYdW0v7oLP0QNbujA6aBO+jh6qAEzzvfcS1FyzLr8EmLJsgClG
         qHx28fP7ymy6yHxqzWbQE58wp5yB/uzp9a+OpKYWXfHgJXBrQud+7mZhc3BKMEArtEmQ
         e3bw==
X-Gm-Message-State: AOJu0YztyAU17rdXkLN1CyN322LikAYpKc3L2FW2TLpL8o3MItQyANLc
	lM0Jgs6iCGPJBpliDpYKqgpvNS90SqgneFjI/Rl8n0uQnS5OWxBK8N0Z5RnVLvtEIdy/bKqyiPs
	=
X-Gm-Gg: ASbGncvvN2APZ6EWDTXHukApnU+K5hmAZb0pISXFfTaMcH4fnsu9Ms8Mvjf0TD0UBw9
	qZdz2CjpdcLh0gibw0H0bjMCWB3Wi5rPYtYn2RdYk2Ux7cA3KnmT9F6zXT6xlgVGplOAm60bHPm
	HHEYMqqOfpoo2Il5aBM5m1X7qeenyoX6loBiGmAbNuoPswVWEHjs6jvHRC/3q0+BpMEIJJKNtWR
	/DRPpwxrS9ujDiQU6ysx1UKXX49uxSpYAf8wwGUENU4MULpF0hjNu2T5feTOG26/BWVUG11V6Pu
	c7gvQNA1hGCseAMEgPkln55zBqQC+hT0loOte+cfpJVkpJIm1MeJavcTxmDFVJiahs7lMbnhDee
	YRDGwxn4I3w==
X-Google-Smtp-Source: AGHT+IE/UP+Tgrhv8CukewwDsH4njav3pf0K/xuBK7KpANvlk9kvTIrqyL/7jPJ/3dgc4O2SlpA4Bg==
X-Received: by 2002:ac8:5841:0:b0:471:fc73:b656 with SMTP id d75a77b69052e-4796b95122dmr10953001cf.12.1744224820071;
        Wed, 09 Apr 2025 11:53:40 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-47964ef607fsm10303201cf.75.2025.04.09.11.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 11:53:39 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Fan Wu <wufan@kernel.org>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Kees Cook <kees@kernel.org>,
	Micah Morton <mortonm@chromium.org>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [RFC PATCH 11/29] lsm: cleanup initialize_lsm() and rename to lsm_init_single()
Date: Wed,  9 Apr 2025 14:49:56 -0400
Message-ID: <20250409185019.238841-42-paul@paul-moore.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250409185019.238841-31-paul@paul-moore.com>
References: <20250409185019.238841-31-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1717; i=paul@paul-moore.com; h=from:subject; bh=578od+KOKp0Zt5/G5juxhdeXYFulKkNW5mxLTRLFSTE=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBn9sGs6dlM6SxnBucmXuaDFaCMCCh8i2n8VNoWz hFMonzWXF2JAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZ/bBrAAKCRDqIPLalzeJ c/5wD/sEmeiG2IGjN6YHPlgEIeL7I2ozz5bYdjZvFV8W0QPGA7e6OK1nRE3/kTYeQEZh5y90zIp qPSBV7+sa8V8hFyCgfgOF4viD6qKVdT1dZAV8WPYFyPSBHT6wsplyk+r+y72tyJE3moVJWj1hP4 0/SszWMhwYuedWR7/50VGMMiUMpG7B0ZXhARQV4+j10a3dcluMccLUiltXYu20QoKjhjHhReD/C w9ClkTa7e7DZUUBzwYK4wU8hfwpQa7E2ERPgkvYI6HttbSBA3mdAgG8zRISn7kktxdkuSwVUQUr g1wcJFNgyXQXHRAbFovnvMyhFCg0R3k6/VffjSTrclZLATFZd4dfjkdHEi5S/1bwbgx4TcREhcp HP0j1Golz13++5m7zTjtxRSCYqnZ7z6PsfVM4+VKGk7p1sUkjIeWRv7oAJmEIv3aLYi7/FIiJcD CnwHFmEC6mQxVOzGqepqGARFT7W35I9JHiWtahZ3kDjt8/ZBzrnp7qBYNo/WaV6W4lJW3DGS5zr z2QWWn0GlJJXUJ319zzDbMoMzRzPA0TvwVYPzVKtrCB95NoARwm4aKI/xdxZZi/lxWAzRs+pdfq tdveGfZTSgThrpBEyNsimTnKg383hT7t2cBWBca4WUp6hSS09bX6wFy1wyYEBMaRI+l4DTRAlPQ XR4vGI2bKza/IIw==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

One part of a larger effort to cleanup the LSM framework initialization
code.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index 9bb4b4fc9888..163fc2a1a952 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -214,16 +214,20 @@ static void __init lsm_prep_single(struct lsm_info *lsm)
 	lsm_blob_size_update(&blobs->lbs_bdev, &blob_sizes.lbs_bdev);
 }
 
-/* Initialize a given LSM, if it is enabled. */
-static void __init initialize_lsm(struct lsm_info *lsm)
+/**
+ * lsm_init_single - Initialize a given LSM
+ * @lsm: LSM definition
+ */
+static void __init lsm_init_single(struct lsm_info *lsm)
 {
-	if (lsm_is_enabled(lsm)) {
-		int ret;
+	int ret;
 
-		init_debug("initializing %s\n", lsm->id->name);
-		ret = lsm->init();
-		WARN(ret, "%s failed to initialize: %d\n", lsm->id->name, ret);
-	}
+	if (!lsm_is_enabled(lsm))
+		return;
+
+	init_debug("initializing %s\n", lsm->id->name);
+	ret = lsm->init();
+	WARN(ret, "%s failed to initialize: %d\n", lsm->id->name, ret);
 }
 
 /* Populate ordered LSMs list from comma-separated LSM name list. */
@@ -374,7 +378,7 @@ static void __init lsm_init_ordered(void)
 		panic("%s: early task alloc failed.\n", __func__);
 
 	lsm_order_for_each(lsm) {
-		initialize_lsm(*lsm);
+		lsm_init_single(*lsm);
 	}
 }
 
@@ -423,7 +427,7 @@ int __init early_security_init(void)
 	lsm_early_for_each_raw(lsm) {
 		lsm_enabled_set(lsm, true);
 		lsm_prep_single(lsm);
-		initialize_lsm(lsm);
+		lsm_init_single(lsm);
 	}
 
 	return 0;
-- 
2.49.0

