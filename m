Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54E5283680
	for <linux-security-module@vger.kernel.org>; Thu, 14 Aug 2025 22:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755212093; cv=none; b=VmPL7nzLZz24Zrcue/hu6zRPuElycyvPrRTsI5nf1+RKBE0zG9aJEO1L86FCNa1oxL0EwQFyunIIlULD31hON2/I5ctRo0NuBR6MeITkADMU0a/lebpFZEzLXRMTshB6+DPmdnUzwpxwRUzDfh20JxKW+i2UP8nIWxyLrGSJ1Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755212093; c=relaxed/simple;
	bh=IofOLPqFk103DpDSz3vcDIcRnYYkeXQGoibj3GbkQnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NNkPabuXe+Q9yMGk4mii44kO8uwfc7YiskfUI1gn24uo3yE01pRVu5WTFvPe3YuoOgjY6d/NCi6flVxurubhsZi/4QB8+qJt+o5vLLjxshQD5WTl0oaopNwDarvmh990TjkqHuunuZBXDZkkMK9MCOtZHTjL65/PLp/MsUs22ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JHEm5t6f; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JHEm5t6f"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7e870636870so139817885a.2
        for <linux-security-module@vger.kernel.org>; Thu, 14 Aug 2025 15:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755212090; x=1755816890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8eshVoT55p858G+JJIp3jnxqorUxhQOHxqjzPEYjU7o=;
        b=JHEm5t6fftfHMxN9HgdrtOGOT2UqOemb6I/rHjxJUlpAlx2Kla9DzS/qrZpxQcxZkZ
         1KTgbpmKZ36ss1hSJ8Gvipau2asPYokjqp9etXD8zw+xjnIT8f2C1cocH3RYcuj99x6x
         U18c/zkE6op+A9u3mvcI2usVwRxzlhBRnMg3cAR1M6Oyd08OS6zo50VEC6ZOjnEzC/Hu
         Q24zdSY3Q6dBW5ZKg2sXUdoEkjbunrUbg9P0w30FErcl1YzMeUWFNLjOZm9MiE4uTj1B
         iGDIk6dx2tmH4+qzcpmWCai4sRORMrzE9uvf2NUU9JiaBXfWol8HCqUFcuuA1yhHGNaD
         Jr/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755212090; x=1755816890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8eshVoT55p858G+JJIp3jnxqorUxhQOHxqjzPEYjU7o=;
        b=v/PV3rPhfyihPtVT/gKUsCYBTNKvE+PRmRHfObcLCtK/xbFnzd0TFVrW39TN0arkXQ
         o+8RWKI0kszQ6cHXK6QrVl4DlqhGwfXLj6zzjg7Wt3EVAQW/OsvqAq12olZmd59SzNPB
         OtyV/if5H5Q9X2ojqukoiwv+BCZNcBGIYP2xeeQ1KV9/s2hj/TsYc71eMKZg1HJq3tu8
         FoGSa/LEww/qvcDt+bYxeI7HlCHRyonrO7RIxyKqlRw0sAea4NUN9iGKiRWaXcbTrOH+
         dFYx/W4fzQa8Umuc704nD2oMM4JyXyKSHDtBssHdeNS3DfOffU0HeAg7yHXW5y8zyhSP
         30LQ==
X-Gm-Message-State: AOJu0Yy3MgWJ3CR8GUeZaiBM7mGN5gIBIZnqpQF38+KpcANxC/v1+s36
	dUbc3mrkVJ6KaxIpdsbVRnEAuidGOuiFAaOYhkaqsga4CGzHYa5wIlgZTXW+EetzoPWchHPLqFN
	xv7o=
X-Gm-Gg: ASbGncsa0Vr5fNOagtE/iPFkcAXX+jsAxQpU3bl/vMUqz0NJ9VHeTjmpz+H//m6thO0
	A6ydVnQz8ZKIjupnsrhYH2mMIaVchKCAQNdIE+9WbWha1RryspUSpt3L8C2FZIRiXUl7CsVZu/F
	2FbPkCGJJ02RdCpT9KgI6lhLoSifmjZ6HoThMDo8FbhTF77AA6gz2sREFpsqlmWYhNKgDZH002F
	vfcH9ADMxcu4dSm/fPFXJp0Ahm5GeH5eQ1TUFa12Kv5vlevqKLxZZKgVPU+J1tj8U7k8zCpddtm
	GWGqokQT3XH/BY6I9ghphNpShK78NIx7KbN9XccoCpchq8hYRaoaX/K+HhzvcT5HsE8TPMpJ4Nm
	OTiZU91FdbsIen0HTZEvqiqJaULyrb7ueEVSqiAUJRoaotoilbYSS+apDCPxqk8Wgfn0=
X-Google-Smtp-Source: AGHT+IFtmYmgHPN/6BN0SC8km0Tu12vbQt4dWnNje4CEmpk648nkvsXUHENQpz8NafC00gIT1jqE8Q==
X-Received: by 2002:a05:620a:4494:b0:7e1:5efc:6f6 with SMTP id af79cd13be357-7e87057e546mr635800685a.47.1755212090120;
        Thu, 14 Aug 2025 15:54:50 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e87b37a00asm44301585a.32.2025.08.14.15.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 15:54:48 -0700 (PDT)
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
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Xiu Jianfeng <xiujianfeng@huawei.com>
Subject: [PATCH v3 25/34] ipe: move initcalls to the LSM framework
Date: Thu, 14 Aug 2025 18:50:34 -0400
Message-ID: <20250814225159.275901-61-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814225159.275901-36-paul@paul-moore.com>
References: <20250814225159.275901-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1600; i=paul@paul-moore.com; h=from:subject; bh=IofOLPqFk103DpDSz3vcDIcRnYYkeXQGoibj3GbkQnA=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBonmjdwWYgrKhvk31wwxpOdsfNDjWhMlI00rab3 Xulm9tc9OyJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaJ5o3QAKCRDqIPLalzeJ c9PBD/9q7vJf8ZVwgynRNEUeU6jag3w/uDeFgLzQj+5l7iGhn4T4y90Aiv2oa71oXcxBFRxf7WA AV9GAWJ3otFaOxKtC+JgXv6VIOiNxqxfjcidiWJdjmhrS6zol+1LClENmHot4hRuLZKmMMdszn2 PFscqsb5b6FgWSXAs0XR/07dtS7bm0luivExo4mbTrTlLJjniQT1kINNv8gFN1KwyaVy0tkB0LH gWOproti159lO2sDYg5+ln6g02jNgGp6YZG8DJFMFCm2C1xEaCC8xRf3l1IcrHqwdbk3OomL4UA 1nI2L8R+yuU2GW5sM/SsMxH1fvr2MJPK4Qr9xPwnOD8TTbsPaK4BQgHwZQxHi+qMt7R+NQaH8yj FZhDlC1xBaMYzQCaADatCK/dafAzK+7m/e2ckOnBCBj3hfBIqAtNw4Z+vpe2+dMhBg7P7BCNqzA 8Z9MBpCGP3PyTBk/YuAaX5WiO+xoCWIu32ftyE+FwQin37EAVFjz0/TyZNGWUYlRG4Sse3pztbe FO8mkZr0Mu+iAoM5ARv65StoiT60wva9fjF7pxMEaYdBMU0TK4jSFNlwb3NvS6nzwTv1qX+dGP+ 2GiTBafSpTwN7/bjtIt4vm6TRHAcPvEpPvEgwpilJuXEAk9q3OZ6IjrtYoqnIVgZY6b2/YDt1mV O+JzmomYx0DOxGg==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Reviewed-by: Kees Cook <kees@kernel.org>
Tested-by: Fan Wu <wufan@kernel.org>
Acked-by: Fan Wu <wufan@kernel.org>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/ipe/fs.c  | 4 +---
 security/ipe/ipe.c | 1 +
 security/ipe/ipe.h | 2 ++
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/security/ipe/fs.c b/security/ipe/fs.c
index 0bb9468b8026..076c111c85c8 100644
--- a/security/ipe/fs.c
+++ b/security/ipe/fs.c
@@ -193,7 +193,7 @@ static const struct file_operations enforce_fops = {
  * Return: %0 on success. If an error occurs, the function will return
  * the -errno.
  */
-static int __init ipe_init_securityfs(void)
+int __init ipe_init_securityfs(void)
 {
 	int rc = 0;
 	struct ipe_policy *ap;
@@ -244,5 +244,3 @@ static int __init ipe_init_securityfs(void)
 	securityfs_remove(root);
 	return rc;
 }
-
-fs_initcall(ipe_init_securityfs);
diff --git a/security/ipe/ipe.c b/security/ipe/ipe.c
index 2426441181dc..71644748ed56 100644
--- a/security/ipe/ipe.c
+++ b/security/ipe/ipe.c
@@ -95,4 +95,5 @@ DEFINE_LSM(ipe) = {
 	.id = &ipe_lsmid,
 	.init = ipe_init,
 	.blobs = &ipe_blobs,
+	.initcall_fs = ipe_init_securityfs,
 };
diff --git a/security/ipe/ipe.h b/security/ipe/ipe.h
index fb37513812dd..25cfdb8f0c20 100644
--- a/security/ipe/ipe.h
+++ b/security/ipe/ipe.h
@@ -23,4 +23,6 @@ struct ipe_bdev *ipe_bdev(struct block_device *b);
 struct ipe_inode *ipe_inode(const struct inode *inode);
 #endif /* CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG */
 
+int ipe_init_securityfs(void);
+
 #endif /* _IPE_H */
-- 
2.50.1

