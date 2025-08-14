Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BA228468C
	for <linux-security-module@vger.kernel.org>; Thu, 14 Aug 2025 22:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755212081; cv=none; b=hY862ZVq260hAzE/AV/UxK6tNbTe2AUnwh6/efCXMXm1r3/DmYhIVjJWu0qFP9/ZnQC4yCJb9vKhEBLqSgxIDgcnWeNBHC1jo3SRpas2EqXnptvG8E2+9/qqjHK6joFr86rh5UrpJ9k20Pgt6L8h96fZAQf4mqWRR2DPZ5z8K64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755212081; c=relaxed/simple;
	bh=Y3OuBAfJj2L0PqvbZIjrXdDxw22/e6oMlZYQWyZudio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C1a4uLEJihPMaJvbidEi3La7J+2jPb5K8I9lq4Sa9cjOqtxzwz9196tfh6d/Pvmy0NXEmZyS0/OwwgEeRwRyPg+DBoT1fmTTBKqi1oLGkKdMu7St3ch6+iOqCfwuCxCd2YB1JgfJUsscN774UHq29NsA4quqaId0gCpsQufhe3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=EwELvnSU; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="EwELvnSU"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-70a928ad710so13031906d6.2
        for <linux-security-module@vger.kernel.org>; Thu, 14 Aug 2025 15:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755212078; x=1755816878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CWJkDdIda33c/xNcCXmr9ZId/P5gWn4X7HG7bQO9qB8=;
        b=EwELvnSU/u6wzIyUgMzfTyR0nGKBDXYtMwuOXSKr8MGaf+RrIWaDqbaFY34pc5BPUM
         qjRel0/dKFPQpU1u3sBGrpNTTZMXJmwiS8nVsZs0u1y8M4BRWgUaeKSTthS7I8n1RFgN
         DVsTTZF9gQOoEOS18eOF9+4TsWFYHeSlJb4mh72KGDmi5Ogfgb7jN9Zp+3NS6WU35qVR
         3UgvOaCR6jRKkc3bYOm1FtQlnjvBq4Wa0I+/0kX0Hw6JWvEmd/8VeBUKPtx3CxGDK22k
         VnMo704NZHN6Eljbm7iPFUVFZ99FgPSWJ/valYAHai4hxF4bZsfcmvw5Sll3NupzBIgU
         a2pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755212078; x=1755816878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CWJkDdIda33c/xNcCXmr9ZId/P5gWn4X7HG7bQO9qB8=;
        b=KE73cmKBAjeATHARMCapl8X/f/6aLEYkEfy5I+TmE2tlv9aAym3FXRKuUFNRVcNqVL
         FE7DO4/iNvWIBVw2FB/9qmAmBZXGMeuGicHMMQMplvWm94AQ3VDhn8UCu8muDV4ffIYj
         6/LpKg6eeXrRbgg6cQbwqCcd8EVdS38mSOBVtP8XKbUEKmOzxigE/c37qNAoUENIARTV
         hsVyn0Hp6Fs9YD5Rs1gwuvMPHe07DY4sjRf7JSWi8iB7Tk1zdFRERJEooUZv5UweSvKo
         E/aQ42dKjUdKZWoydFtnfrjYgAkUrS+qU14nfLhIywzpAMgQURSak2OxupS7986+WHGi
         bkmQ==
X-Gm-Message-State: AOJu0Yw1ESzzq23zbyqB6bfwPLL9X5NnUjyHg4dqJJ2WGyUDeCnaUJ1I
	WjZBj87jbXCo8qkPciprgjzWMsv8A4yqCHxvrmK7n5MJlcav+UYLgeQEdHIZKvdd2lM/DRlUvOA
	n6nk=
X-Gm-Gg: ASbGncsXFCnvbhRtuTqCVMBtoiMeMRmYdsR14TZEkrf2DC21z72ytbxaKdwBgbcsA05
	S723xsWeGYu6P0snqVXpjVG49FYCL6nU6mOMtk4EGFGxJsz70d1OEkPCWUZBzGcySK4Yk92WiAN
	XO12spkYBZXd8jyxbxKzA3eviJEUn7cph527VYsZg6SvVPX5r6y6tjvlYe7z5IzgX7vp88FrO5W
	gD3u9DFR6WHwfpYejIStu7Z7YhIeE9KrkwigORYJygd3SbL0JpxnGz0d+Vd0F8I9vrx8LqliToV
	23mavJp8dfza3FVd3jsATJ7x7nUNwmrMs5qyR71SKnJvuJ7QDvp410BWiCThMMCAr94MfE6U5Cq
	nmYa+YlDaR1YjAONeHsmrX/riG80J0/vsFqPScxlu9c3ozUP6n1xGSA0etS8vKY+dFQs=
X-Google-Smtp-Source: AGHT+IFzbz2KIT/3HbXsSe0WjqHBANAb1FGTnrCBb9l0sQLH421A2LZ/Jpds8CH8Z+BbtGLFwHITAw==
X-Received: by 2002:a05:6214:29ea:b0:70b:a280:208e with SMTP id 6a1803df08f44-70ba4834a28mr8828106d6.34.1755212078100;
        Thu, 14 Aug 2025 15:54:38 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-70ae6cccc5dsm19595826d6.27.2025.08.14.15.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 15:54:36 -0700 (PDT)
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
Subject: [PATCH v3 19/34] lsm: add/tweak function header comment blocks in lsm_init.c
Date: Thu, 14 Aug 2025 18:50:28 -0400
Message-ID: <20250814225159.275901-55-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814225159.275901-36-paul@paul-moore.com>
References: <20250814225159.275901-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1848; i=paul@paul-moore.com; h=from:subject; bh=Y3OuBAfJj2L0PqvbZIjrXdDxw22/e6oMlZYQWyZudio=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBonmjK288u79ih/3X/EAs8f5ib9UTus8qDfYWED N9t/xn7NTWJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaJ5oygAKCRDqIPLalzeJ c9P8D/9GGLSGMoO2Vy9gChu4IqTMbm3zepQVEuTI62dwz7ieLNKxbXezMnzuiQ/TNmLVP0j+t94 2Py5E153WWKMkOw3r5clgQcon8rtA7fOsPW7M/bDVGItuIQyocDByDJARn6egN91MZCXKkfxJER paMyCrNP1GeyYf/fpjIkZeML0DbVwpY/RSQdLHSY7DS2WGvyRXaOFIZSNq3Z5hm/ySMyoevm38X JwR4mv5yb/V4IalTxC+WQRi1eXejhZ7W7qu18Gcoe+VwxdCtZwY2x5hlG77Dt/b2WlA2VltGWHz 4hX/uH4geROWgk8lt5yIxMteHUuWpfvA4jcfDeZbJM+J2togGcHbsKnhSTck/SKW9DDBvWg7vNn yvKKgSU2lTA2DbklAE3/hlfy9quTsmmPtC0FOxjJaDH01yMKwXFiDlTyAEyudyCybixozfzbbHD RHkW5ky6nMQPR/gj2l/H1cy4Md5XOGteg58aiBV/nQTNvm2jm73phgBsGZHfyINTrjvfIxnA9PF b8vX8ie/iHvWa8nDzRGmOGtTwlU6qoYhBUCj49J0rfsSo+wdf9QBq79KxsJefobsIWJSH5958hX Juqg5FueyhRccrP2CtGUGQ9B3k7USwKxLM+7rmTUSh/B3KUa11jrCfevK8itCuaUMZ5ei9pMwHb zPyt5iw0XB87AeA==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Add function header comments for lsm_static_call_init() and
early_security_init(), tweak the existing comment block for
security_add_hooks().

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index f87f5441617b..37593805ba9e 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -315,6 +315,10 @@ static void __init lsm_order_parse(const char *list, const char *src)
 	}
 }
 
+/**
+ * lsm_static_call_init - Initialize a LSM's static calls
+ * @hl: LSM hook list
+ */
 static void __init lsm_static_call_init(struct security_hook_list *hl)
 {
 	struct lsm_static_call *scall = hl->scalls;
@@ -335,12 +339,12 @@ static void __init lsm_static_call_init(struct security_hook_list *hl)
 }
 
 /**
- * security_add_hooks - Add a modules hooks to the hook lists.
- * @hooks: the hooks to add
- * @count: the number of hooks to add
- * @lsmid: the identification information for the security module
+ * security_add_hooks - Add a LSM's hooks to the LSM framework's hook lists
+ * @hooks: LSM hooks to add
+ * @count: number of hooks to add
+ * @lsmid: identification information for the LSM
  *
- * Each LSM has to register its hooks with the infrastructure.
+ * Each LSM has to register its hooks with the LSM framework.
  */
 void __init security_add_hooks(struct security_hook_list *hooks, int count,
 			       const struct lsm_id *lsmid)
@@ -353,6 +357,9 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 	}
 }
 
+/**
+ * early_security_init - Initialize the early LSMs
+ */
 int __init early_security_init(void)
 {
 	struct lsm_info *lsm;
-- 
2.50.1

