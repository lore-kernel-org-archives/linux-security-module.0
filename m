Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1358E27C170
	for <linux-security-module@vger.kernel.org>; Wed,  9 Apr 2025 18:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224827; cv=none; b=PnP/IgDihJkBCNyPVk6Hwt/JfYKTRaeEx4FX5sqrtSb2JB+EO4eemVgf8qZyw67LpPTCKtViOJpop1P1Cg+rZrldVWBdUF6tmPHqD7qrMgB6tq7x+KUEWOdXYp4okE9qJLfTvzTlYhbuoEWaPvnEKy9LVTB29qervrOrjlQ8V2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224827; c=relaxed/simple;
	bh=m5SDi/Ws99YGf4fQxXOcnXDyD5cqe3LLHIxu36oK/q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bVR/V4RRqb7Hqbp8Icbi7085scgiaR7JqrjD2P5+QDQAidpQHCh8g3eZtHg3aZ+06WZvRFbkusQYxO+xa2z6sYsUS8t0iT7vaUotOO6FRVT42sBrXRkQ1GzzU2lfP1oixFmOBjv8f5+g+lAyIbxTRTZMpZvT/xw1T5PtXuXM0kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Y8IJAB+D; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Y8IJAB+D"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6ecfa716ec1so70027016d6.2
        for <linux-security-module@vger.kernel.org>; Wed, 09 Apr 2025 11:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744224825; x=1744829625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3LwGa6v7K37aPAxJoM9V/ORkpt6P9aeqeyafgjS7XL0=;
        b=Y8IJAB+DJZ7BbDLN9TdbqpfWx1mdqevwHgaRphZ12fi004z5LiCVzGuWcgPDJfmMcc
         P6uF8la97ulU+xU6k16KSXX2Qdp+uvElfQjn5Zvy61bor5pCEkmVo6Bn3auMuSPoxU3z
         9dE+WAEkYV5eUDOK1e3eE9ljdGQaZG5ZFcVrZI1tzC433P8Bik2ACxIIVbijLAwP+x9t
         zkNDM8Y+WYjvqkPBaOVvp+x2ooJTgvSpyOXDGFU3kY4GxCK1lL3hsf+VPy5XgOWOxgEs
         cOJJCUC1TaMioI0Dh3oRzHIWza6noFdXrtb+I4/P7VoBKpdCKrhf6qtKDz3pxt9Uwz19
         OPLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744224825; x=1744829625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3LwGa6v7K37aPAxJoM9V/ORkpt6P9aeqeyafgjS7XL0=;
        b=lDLG4gMrwbVVKNiN3/+G7jwPRJCjizLFuHF+1ZNPdUQp81+a940XjvOFBpxTi8O8Fu
         ikF2xaEJrW2+Vcrxwdw0kMVeWrR4yR9O6geiboPpWoLVLaa07+L+2GXH90/4epDXAVFE
         n0imckoATCmt7BzIC86Q1GWxEhEAHrM/uxtHSH8LKKZggyj+nofvD2QuGt4KqsV7bZ9p
         m3ZgAXxC8SloGBE37ZjWW/KJUvVp7vZ3ICNhj0OgMX6DjSVHuvcDe2QY2XwRCapbhB/J
         z4dgroVqQYDTDgeJ5fPJG4f6kQvVZvjfs86AzCd2Pn3NAUvNKj6Cnhsdzv8I/MrJL8yQ
         7miA==
X-Gm-Message-State: AOJu0Yxv9pJ4lIllEgOoIaHV5VSDigXD/6lkC8Np2C81p8qWW7BUau1J
	IfE+PlXPdCKsLBpSiwxUMmCblDXC3MTgAMXir5eOat2WPy02eWnN/Tf5r7Rvkdl/wm3yq5aMvSA
	=
X-Gm-Gg: ASbGncvwTh54wa4StTLN83o/b37sNg/LlvKgnDkeYaoqCUrDB1OLGNzQr/uSf4pNWD0
	PDTCcoBLBgMcUovk4FDE9xBiztzwIiBVJPUhhmmwETki+Yp4Kl1HzSpVha4kqExqBBK5qqRv61Q
	KV+l2tOGJtljcNAVf0GRMXLbpmx2742A8gzLKhOYdIO3zgk7NdY1AchwRuPu35AGRaSEi8K7451
	DO8uSMwZSQcZtZWVXQSrIJjFJjC6TnBFQ6K9nZfP4Om2bxNeUhPEFtgyqCYd1Uu5UY54oykZJI5
	VqEiIDb6iyooRFu7f9waONYfm0NH0WwSyVnEE1lfWzbHW7iVnVhNVH4Fd49ofx6DCByYLILX1HI
	p1nvrxHOQZA==
X-Google-Smtp-Source: AGHT+IGgaqmfp5XWsFxY1xA/2lqF9f3q6zJGWlTf8/5spXPhIo85zJjIag/SaVzmO3byEJrZK8qH/w==
X-Received: by 2002:a0c:e5c7:0:b0:6e8:f6d2:e074 with SMTP id 6a1803df08f44-6f0e5bf4d63mr515436d6.28.1744224824755;
        Wed, 09 Apr 2025 11:53:44 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f0de95f6f5sm10546076d6.7.2025.04.09.11.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 11:53:44 -0700 (PDT)
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
Subject: [RFC PATCH 16/29] lsm: output available LSMs when debugging
Date: Wed,  9 Apr 2025 14:50:01 -0400
Message-ID: <20250409185019.238841-47-paul@paul-moore.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250409185019.238841-31-paul@paul-moore.com>
References: <20250409185019.238841-31-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1491; i=paul@paul-moore.com; h=from:subject; bh=m5SDi/Ws99YGf4fQxXOcnXDyD5cqe3LLHIxu36oK/q8=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBn9sHKChmrczEfCENzDC+pQCGE4BSux72u/rOKi LyDwGDcHkWJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZ/bBygAKCRDqIPLalzeJ c0liEACBjtJdV3P9wJwmBVYcpndOIjNNDeoEg5cXOjcXj0zt8UxLXmlzgtSgeqlgViWqhXcJ3/Z gzv8bkkMpYHWMdcKjcgwm4l2g+SYC/54zYW0GbDX+8hYi7vVafzMm0urmzVezfWXf2bWI2kAf0G Vth24pdK4ECfiZbv9ahaQ92l43GP4OeCcTaj8aPJnela4idSxxGqwPLxkKFcsBisW1cxXoXw6/e 9ngPRZjdSheh9EVe+r+yX1xIoCxsfYNylqFvCokCGiq5i2kv/z2QnymzmQdgEPFX2nvPQX4casB skGrc/GdFHexG3OzeqFxqC261T1s2V0H2htV7p1jjYmhNC/Z+cbzjAYzEeTsMEMqcGrYka897lA JfM1K91gFmHdOFixHHdccoGxuc5uaHbJh49SIvfb/lf1StSAQy594dBQOBeZBzqXS4YdV2zfbV3 DUZvBdWDEZbGLKnIGrmvpIXIyzj7+Cd2M+ipufGklHhQJmR/YKM63TzuNA5zCnjgFN30fYbWL/s UKeNtnrVY5cr3Ma1KSnQAVQ3I/v+TQp0Lr6Pp2fH7XjWiXrzlidJWE3BclbBTAWSr9nbYyLxw2Y UFklhUZDe2pkSPWp3bXINAbLuIy8G/zOTDWQEUg1UMiq63moES3c1IDeLttNOMSrQPTgn89CBEB dsPntWBtJ2AJUng==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

This will display all of the LSMs built into the kernel, regardless
of if they are enabled or not.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index aba1253ffc4c..8e00afeb84cf 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -363,6 +363,8 @@ int __init early_security_init(void)
 {
 	struct lsm_info *lsm;
 
+	/* NOTE: lsm_pr_dbg() doesn't work here as lsm_debug is not yet set */
+
 	lsm_early_for_each_raw(lsm) {
 		lsm_enabled_set(lsm, true);
 		lsm_order_append(lsm, "early");
@@ -385,9 +387,24 @@ int __init security_init(void)
 	struct lsm_info **lsm;
 
 	if (lsm_debug) {
-		lsm_pr("built-in LSM list: %s\n", lsm_order_builtin);
+		struct lsm_info *i;
+
+		cnt = 0;
+		lsm_pr("available LSMs: ");
+		lsm_early_for_each_raw(i)
+			lsm_pr_cont("%s%s(E)", (cnt++ ? "," : ""), i->id->name);
+		lsm_for_each_raw(i)
+			lsm_pr_cont("%s%s", (cnt++ ? "," : ""), i->id->name);
+		lsm_pr_cont("\n");
+
+		lsm_pr("built-in LSM config: %s\n", lsm_order_builtin);
+
 		lsm_pr("legacy LSM parameter: %s\n", lsm_order_legacy);
 		lsm_pr("boot LSM parameter: %s\n", lsm_order_cmdline);
+
+		/* see the note about lsm_pr_dbg() in early_security_init() */
+		lsm_early_for_each_raw(i)
+			lsm_pr("enabled LSM early:%s\n", i->id->name);
 	}
 
 	if (lsm_order_cmdline) {
-- 
2.49.0

