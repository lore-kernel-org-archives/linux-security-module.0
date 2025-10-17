Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06F3354AD5
	for <linux-security-module@vger.kernel.org>; Fri, 17 Oct 2025 20:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760732937; cv=none; b=E11cok6sCFuOiUwSRn+/ihFGh1je3D0Ouh8RyJNGLBQE0I7Hdf3DVa/9jjhrbjIYPdkuB8y8fl12cHi/82buY2YmlMVi9NFTtED8huQt7IppR/Uy9OerpoDiEnXK4gtWByBDmJNwxCDQRFDKgUXxFfeHl+8YwjEOEF1xG4P788I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760732937; c=relaxed/simple;
	bh=p2Ce0fAk0SFnWQePyxl4rn3OKs3EikjCAPjpgfBGA+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XWbP8lXdMBwzmFBzX4BJL/CG61xQRw4t6V6cUGt+rG6x+2kBq8LR534Vgdg+NzSZEWFuTriri8uo6vi1V7JB/3773uM9s8KSKxe09aDpHOcYjXcaGAHNoyUmW1rePRiQCVFsTbqL3xXagBlSKmmzeG9HBHUTQNvt30CaOeQAL28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CWOwz1iM; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CWOwz1iM"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7f04816589bso356439385a.3
        for <linux-security-module@vger.kernel.org>; Fri, 17 Oct 2025 13:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760732934; x=1761337734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=es2cZBdDZyMKEccsuc58tNq+2XmQOc3QvnTXbNqdXJk=;
        b=CWOwz1iMMOJ8j+CoUI0VtumHhsGvx6Xh2f40VtfYQrG0GIw2fhl+ENzTNnu6+uSOXO
         61xtBMFmHhDZwNouFdwJUYz7pZFKTRg8j1AXlcqeoMqNw6+JI0CyoP5jElWhmVbMiUu5
         tab/gfOTEYSnLebi10RXDB2EjTK3mgdXm4D8xeKq5+KwxHbBEcqaDdNhUHeyrnMSkhcH
         oyRljp80ZSQC5jdTkZGr7PiwJkYffUARh0NgwptvtFwh69DmUuG9vnUH9bsQDSHAmABn
         R64mHKZKhsINu2xD8v9jK3dtuIWeQEdRGJpg18sXNzxWRQ7plBpW7G35EY4iC6igMOO7
         h8Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760732934; x=1761337734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=es2cZBdDZyMKEccsuc58tNq+2XmQOc3QvnTXbNqdXJk=;
        b=NpJ4mJKqxOBxJ9JFcV6V8Hj0UyahHX89nXF96sUlixG/McN3N0CupQo8VrKHvFwIew
         t1ANX4A3pJ6KuE4OiT7myGDqepc9hoXDB0XsCf5J35gXnIfHfajgLPxOtKZvVEGHRTWe
         4wLenD5/vQ01G7VHMQ3YZmYN1FRvnO30Nj7Id/BopQBlW3J6AOk57j3zXZAVH6+HOff1
         /zxo+j5XMz68AWxB/JU8zafK8YN1jxKDt2L0N1cHAyEQdZggT2ADeuIFniQTXyX08G1o
         bzxc5qyv/N22i2vqKDhir6g0UvT1cvtCnBnbHkafg7ojqWzGYIb4hO9LuVVKjBQQP4e+
         gOVg==
X-Gm-Message-State: AOJu0Yw8EIQYL/iS4bbLxICyqXLsWblIIs5eEjA/sFxGrANkXJ/CxKx1
	WIV2xpvIema4Ujn0nnyq5ykjLfC8c5K5Uk2RL/ng36VmKLY1M/UfnUDdrjcnYRoDLubbbzCsTe2
	J1GY3YA==
X-Gm-Gg: ASbGncutkR/JPUNCTWvFYVN35yp69ce/5OLbrJsfHVi+Cibk+uvVIJgnVmnhIONYq+C
	lwg113S2+9pOTF5MMoDgvyVXDGWYnxCrKuR5cPFSTHZLt/WIXxhz+QfUj2qUFQN3SoQQ8Z7zenz
	2XNlbLQSLrcPI1eARspW5ImJ2dvASGFdrJ/stfRS8++nPYyLNMGjpKEcRze7myrAFde/uEqhDvY
	7OX7l2NwrP/TQdWRXO03SyvRphGypbKoyNGBdjLFP/I6InfR3wefxCbMwMEcTm+EqETRGqs7I7G
	CaYohnbnrcbKmU9r5AXiCdQ/9FD5BHwwpvh0kAbDap6dw+5oSJqU5WBCfdej3mKxNYPwq+Wn3ga
	jfkK8rddxFlpTf1rJenTxAgmrVTr5BZN4SZsi8WqLAG52ZP/S1vGkTlyerRcR6oFA4RcGlW0rD+
	uv4AXeOhE/EMv4gdLCZHln8CmATU6R9aEgxqdupV3SgK+gsw==
X-Google-Smtp-Source: AGHT+IER71hrvHTVieS1arbGDYz9nc3N1uTLgbT/qkTOu9scEJljyERPamncWDvX2y+Ihon1rZXWtQ==
X-Received: by 2002:a05:620a:190e:b0:857:bd06:e9f6 with SMTP id af79cd13be357-8906e3c5dacmr606672285a.7.1760732933897;
        Fri, 17 Oct 2025 13:28:53 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-891cf58edd5sm38572085a.46.2025.10.17.13.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 13:28:52 -0700 (PDT)
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
Subject: [PATCH v5 05/34] lsm: integrate report_lsm_order() code into caller
Date: Fri, 17 Oct 2025 16:24:33 -0400
Message-ID: <20251017202456.484010-41-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251017202456.484010-36-paul@paul-moore.com>
References: <20251017202456.484010-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2170; i=paul@paul-moore.com; h=from:subject; bh=p2Ce0fAk0SFnWQePyxl4rn3OKs3EikjCAPjpgfBGA+Q=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBo8qYlqvsJCb0lq4+rC2FF3l0LyGbJ2Vf6Rh+Vm XRD7e56PsmJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaPKmJQAKCRDqIPLalzeJ c3z9D/4qUxfigozHW52WHzCNASVJD5Qmwfd030/umsT9w3dOPZ2ggptC9TVHBnyk8ZjcnnDmzD2 P6VWsM5/wkvyqihHMhNZYjcwRpV2XHGXI2RZt6axCW//X4muMYUdgOmBpZVPWKCkZhE7xOPtoIx dTE0FgF+X4u7gpBLJ651/6oQfkr8AfQ/f4kHsByXwjti1oUjYjzVcOgVy7HeupFIor+3NczPZe4 aX39Ww5aKyO+RggA7lh5lr5mXMRoqsgTpno6H48Qk3mH/f62dqOGtsr4sdOCLJzKIq9eO3WWXKF d8/2cVbd5b9wCPw4ExCa92q8wqpWFmUL9qcq0GzBMpF3WRbh1rYWmCvVCm7l4nkABqfFI9u0wWf Yp3/r/5HdzH7v0hLkXGbJu7wZ3vO2jtiPncF2vzQr1lkHuC/Dks2CO1SytauwYzG90Beme95Kxt fK+PPBaLcIjwLf7mV4cKluuof3JI+rpjvVb6Z4f7M0/D2AHZdr33qrc0n0phht58cRpFrsXrsd1 pg7krSzQI2nHAp9EPjvcxfy8mpH0KkeXZyaATR849OCfe99Q9qhgs9CdpHZ8sUZpGYtujgcqd42 ByiGjNgGApmtnJnSVIGPR8NhdzgZzuCwoKXrXLQnIhBnqWxyD5ar+xOgycJLSuOoSMFlMwAPquP 47hf1YdNQVthkiA==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

With only one caller of report_lsm_order(), insert the function's code
directly into the caller and ger rid of report_lsm_order().

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johhansen@canonical.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index 18828a65c364..09afa7ad719e 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -291,26 +291,6 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 	kfree(sep);
 }
 
-static void __init report_lsm_order(void)
-{
-	struct lsm_info **lsm, *early;
-	int first = 0;
-
-	pr_info("initializing lsm=");
-
-	/* Report each enabled LSM name, comma separated. */
-	lsm_early_for_each_raw(early) {
-		if (is_enabled(early))
-			pr_cont("%s%s", first++ == 0 ? "" : ",", early->name);
-	}
-	lsm_order_for_each(lsm) {
-		if (is_enabled(*lsm))
-			pr_cont("%s%s", first++ == 0 ? "" : ",", (*lsm)->name);
-	}
-
-	pr_cont("\n");
-}
-
 /**
  * lsm_early_cred - during initialization allocate a composite cred blob
  * @cred: the cred that needs a blob
@@ -341,7 +321,9 @@ static void __init lsm_early_task(struct task_struct *task)
 
 static void __init ordered_lsm_init(void)
 {
+	unsigned int first = 0;
 	struct lsm_info **lsm;
+	struct lsm_info *early;
 
 	if (chosen_lsm_order) {
 		if (chosen_major_lsm) {
@@ -357,7 +339,16 @@ static void __init ordered_lsm_init(void)
 		lsm_prepare(*lsm);
 	}
 
-	report_lsm_order();
+	pr_info("initializing lsm=");
+	lsm_early_for_each_raw(early) {
+		if (is_enabled(early))
+			pr_cont("%s%s", first++ == 0 ? "" : ",", early->name);
+	}
+	lsm_order_for_each(lsm) {
+		if (is_enabled(*lsm))
+			pr_cont("%s%s", first++ == 0 ? "" : ",", (*lsm)->name);
+	}
+	pr_cont("\n");
 
 	init_debug("cred blob size       = %d\n", blob_sizes.lbs_cred);
 	init_debug("file blob size       = %d\n", blob_sizes.lbs_file);
-- 
2.51.1.dirty

