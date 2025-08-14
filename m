Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1DE283CB8
	for <linux-security-module@vger.kernel.org>; Thu, 14 Aug 2025 22:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755212085; cv=none; b=sNtmt8097o2FeS+eotfv546oe8kC7kYrRc/om1zUfREMjaul8Opqi7Ashxqrs8G/bIUabf0RgMqNHeZ2w9UzUVnk1QBiLFKM7G68dspp0AR6r+UBU3T/YK7Z+y+jXo3OExU6MrgpjuVangCpJgid36zq4SoeWsnMYSs+rV+HKX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755212085; c=relaxed/simple;
	bh=EvRj0z3A489OwYu0YhC8iHhEFaTZ6nZVfs50KsVwhjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LiXDCkit155D8w8Au1nbVz5fsgtyYSpBHMnI4f1os5nhDH0sJw0aMlgtgS/YfDuWzZAkLxemRlN4hl5NiaKpwugHgH3RGDwmlVMefVc0B3+xoGSyx3EqWKKsMTkAqKnp6YqTKHlqvmlfX+18cICwaUbjVmoGzkWbidhbFvKaB1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HDDweydV; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HDDweydV"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b109be3726so21105821cf.2
        for <linux-security-module@vger.kernel.org>; Thu, 14 Aug 2025 15:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755212082; x=1755816882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zvm/Kq47q7OtcRC/Hfg6cCBD4lKV7XRKo9j1mbdEctE=;
        b=HDDweydVSDBCePUpNpr9J58YD3OWCsQ/1qSc8KmmtpzB7xwG02FHydz52oAj+dALuU
         lESoDA9ftWCkG1BDu6Wt1GNpan8Nk0htyXhUsY5+d8FMERrlhn+qCUnDvfoEmlgjB3ZU
         4vhnaJOyGOKyQiuJSJXwXod+/3LBUpTIjlZm9zsC7azgRfihi7BGbK07W/yh8untlnmz
         MFSRybYrz7jTPugCHHCDN8QG9LjCX7ARUlqsAAwJstcotTOwaGOvVv26vzrMcDGC9a9h
         au8/Ves5H5n/il8EsEQY9k/B3NZmx/gYO+ki/gohNZ8N30qLDcraNB1BShgN6y8VtxvQ
         VAvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755212082; x=1755816882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zvm/Kq47q7OtcRC/Hfg6cCBD4lKV7XRKo9j1mbdEctE=;
        b=LRcgrj7A3VrlHKjsTOMPIHdkoZ5TcaFPHayBT5+iyICmxEKgHWD4Td45Lgr3wgAoZN
         9lX3EVdxxASLWKqzTd0hoG+79Nht1LD6ApAU2eMkUUHdALNH9BNzxwP041spDSPQW+Ef
         qwJKECfuNslWv6dUkZ90Ne70KLwehMScnR3l8mX2kVrHumnl/1X0I6nuzg65tQ79c8V8
         tGfDWsLBi6I7bw3FBz79tmcN0a0mYozo342GjYGl6DHxVCFjZ6ypSL4igz7sK8eMu5wu
         AJWFIUELZG7J/MfpBVvOY0h98FOiEGHyCPBaafTRtzMYNS/CqyUGGQqYs5IjJp2RyngM
         v8GQ==
X-Gm-Message-State: AOJu0YwU0ME/YLTxA0PLVPLlfLBW4ZnIQLFiNr8nkB7UIGftTM1yAvfS
	NaMH3XbjC4foys+B3ZNm0eaaiqQTINPCu8u/vfPuB/zGnaqR63JzjJxQ2dehaeLo/dFRdnQYvOC
	lxR8=
X-Gm-Gg: ASbGncudfjRKjRMXxKsCgNbgfopBmi6/26n4rX3VyIJPWDO4EvlZR9i+DGAFDGeb4R2
	CoH7lziRQlL/QjgPkGK3q5HXrDNgYxwQtrZ4fSmKxhIqKHP+9R85xaG5nevpz/MEWvMxEWQ5jIr
	hZCwzuUOAYmc6nrp4EFdySHSCb0drxEaYFPRrVouXLUi01NsKfKHMRW3Cfcqjyl6QC06GYqzPzA
	31cOlYSmp/PnjJhXYz0Yak4xZTDQal5qReRqF6HN4PL1kZPJUARijGzAIKCzq66604Nseo45j7S
	0NbKD77hqEa7lQNOJKKocflv3lyBoBxQEW2gT1qPidHc8CIpdT3JgGJnljv8R9XTK2HtQKj9ax9
	uzefCZEhAsRYIRK6ZbB05Bk6ztR1LHtqfJyEfPJFp+KRwRZEwV6E6V7FL+0zVkW88q40=
X-Google-Smtp-Source: AGHT+IHYbz6wO5EzoDxYSgqc7ezt6nnVQVZBpa8Cfj2ETC46lvOPeTyaI7KR7TvlpCvGq/iCZq+Fzw==
X-Received: by 2002:a05:622a:15c7:b0:4b0:7b08:b072 with SMTP id d75a77b69052e-4b11afa04f1mr7707501cf.9.1755212081894;
        Thu, 14 Aug 2025 15:54:41 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4b11aa7cbeesm2336011cf.58.2025.08.14.15.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 15:54:40 -0700 (PDT)
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
Subject: [PATCH v3 21/34] lsm: output available LSMs when debugging
Date: Thu, 14 Aug 2025 18:50:30 -0400
Message-ID: <20250814225159.275901-57-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814225159.275901-36-paul@paul-moore.com>
References: <20250814225159.275901-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1546; i=paul@paul-moore.com; h=from:subject; bh=EvRj0z3A489OwYu0YhC8iHhEFaTZ6nZVfs50KsVwhjU=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBonmjQqxLNEVB9FixjO46YYoRTb03zMbFRC8Dvk 5N69+KXHQ+JAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaJ5o0AAKCRDqIPLalzeJ c/NuD/9L42jZjqF34ixMTfTCSI55pHCiIGrqmtLmBUbWjM2M51FLmbT5NmKa5O085XlGsXGK35+ 9k4ODaGVUjP9xFYEuStRMIcQQ8l3L3ed0zqoHe9xKvyk4YpvbOFstEGAPaT0vKWS5BEfaehRo4+ 9DKKlbMd459E0JAVG9qIGzSKw/chQFD317LMyU1jDbE3suj6H1bU3nWndplv6VPa3upPzNcJVwa oHCesuJM1S53ZnlUt21ZwEpKRLN2eV2eSb5Wo2fhhzS9B/Rrfno4ygLVDJwg2OfZJPk9WjcuWW3 g55ZBQGreQmx64zTbe2tZBGSmtLGMN/tMz7+KFcgK47arKPs3p/JFq8Y3vVZ7queAIsqRvljykC GKrpRWwORu8b1jUxIdXE91ERV7zpg/9ZFoWFuf9FMqZkvo163mjWZMQrr3V4Ex+TPq+dfNFvDHb UQrRORJmv5kG9zWoDkA3FToWf4J0653OafIrdrw19wIlww2ZkrnafkhldKvJ6R7aCnQpsHDkJzg B+zuzxOr94axhTaenawYfqDaVQvHh4Sf6B7DpJH4osknZcN8JXjk2287nj9cc9ziF6uYBHJlxgR dtm/aacZf+W3+fTthCShMlK4QOWoeXCICLC9+a0Xk0LrFBEL6m/pVTmVTmjsO9jHibeG/wM7UY1 q5Ddms6aWmQvc/w==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

This will display all of the LSMs built into the kernel, regardless
of if they are enabled or not.

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index 2f7ae26fca0f..c6aea57a01e6 100644
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
2.50.1

