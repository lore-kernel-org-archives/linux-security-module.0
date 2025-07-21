Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CEC24676B
	for <linux-security-module@vger.kernel.org>; Mon, 21 Jul 2025 23:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753140256; cv=none; b=E+aIGdQzQM6xeOAdJ5fWqU4XPLaPpFE8+dD2/yjc7/P/iCI7Bag2r0GIIhYj5/YJ0GtOr1mFqTykU0cI7yCVkBVq6fl0rlLW0c4IVCfkkzm+4GNJklKg2W4/kOZSOJNGAWSbUsV4O+PFZwbNQW8CV/tbb793FcHZK2uMvUVdfHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753140256; c=relaxed/simple;
	bh=mwF3ZjAzSHlGtLJaNMcChK9N/YSg9AZ/qVLLLHNmcZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SGTzr+g2d99v6EWSCFjWaZR1vtmSj1Y4A75kICusqQJwNi/3dPLiPTpNsAaFWrwwIl2pu1TdKkAm0JzpC4I2FTpkrAmQZaoIeyDyPD1x40wHyvz4rZNBsm2HqVxli5Y7dkpK1qOwypVfNhFX/egsivAWGXLjgmPFGLWrJJiafT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=eYbb7Ip+; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="eYbb7Ip+"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7e33fa45065so420975285a.1
        for <linux-security-module@vger.kernel.org>; Mon, 21 Jul 2025 16:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753140253; x=1753745053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=laSC4A4BTyLjXy+3yuNmVRhYLbVBWD8DtjxqkjjPiWY=;
        b=eYbb7Ip+ck0a/FVeqTqhDdqim/NB3ZY/jAVpkl3pljbWmMEoSRvOW+EdXwbDe518Mb
         LXEnvbepZGVc1+7/EO9DV5rXhoRjGP/OJOg34N8bwAwvqC08P5NnRUpx9hRrXPCW075m
         qOnNXqJMwRkTUZ/QMb7FaT1G2zWviyJXXhpxouEj3RdMURwEHeWh33eI/vB153hQ4BN2
         yjpHad7bTFaBXA9gkWd/xj2I+YuIW5CErOvjhVONvnPefxeNfwrXhafu0pCKiNpFGBBb
         1izaop58RYHT8ej3iUxozwnhdsLvEvkIKHbGxSPG9wUXL6Sywxd8YuYFwmO8pCnGLq1N
         bAZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753140253; x=1753745053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=laSC4A4BTyLjXy+3yuNmVRhYLbVBWD8DtjxqkjjPiWY=;
        b=xRf6uoW+P+SrMiktKXUptt09JT7GfB4eFSJi3SzB59h7Of+6FMx6XiMkpXm+RrvwK1
         0mesbRz6QSQ6Y7BAHlCJvLT2Q9HkyJDG8/QJiSh8NEWXZGBGXI2keShYTAlI7eqdufuK
         OoWCEMLXuLfFHF9rarwDlDO46pg8qKCu/TUUHoKVPJuhF0pSpHtsQOMXkIqbYPO95fCe
         hw+kHjiAkrkMtqeRrcP/3x7DxSCJrOm6YKlmYG+Ad2/rWULH1Ewr0jCzXOI5jXGX4Kta
         nUONZO2munRxyy1qHbpuIBRqCrAl83RtgPVNknYT+13tqG092dnsZ4O2h6Si4cKPfqrA
         FUNg==
X-Gm-Message-State: AOJu0Yw5qw8Eqwj/MySBSz1zFz5j3fXbmqYtQQwOXpce9weDErGIRXPr
	9wIjl47NkQ1MC88jfEM065y5EYPQj6kEErJQ1Nc6v8Oy1ERc2KPF08hhJIBUh/pFygzKs7lYJK+
	SNkM=
X-Gm-Gg: ASbGncsw4PHDDG2kaUAcDHZ/+BnCY07Mhs6CTwPvOffMeg2b0C+GWXvaQWkzwWmJC3u
	0Njk9+r8x/zCy4rd8H51/9DV1lIU2/F0GLVeSHgz3dbgZeNFNqENDOYNWlKNsJQdZDtnoNoAh19
	1uISljEZL7lq2hVFoJH1ljI3MG2I9HGYOFIts24+00vnaajle90l45KNzyeXO+cTK7QYlnoeKuX
	oQUPP5EzOUsw3LHSbJvCR4RdzphwCQTHFoZaJepY7yrvOG2P+efP4Q9GuAmycxIxoRaWbhe7ACK
	sabVnxPBvdJqAf5euuifMq1k75seGC5ZWps4lYd+Mf7MPdo9+SxTvX11uqUhZWdEoLdWgRODuaF
	SKFEK9fXr3aLYpQSn86RgwroKrFpx14YzTN9ULeesmhiAxGDoE9XH9+BrADE+s2WAYkk=
X-Google-Smtp-Source: AGHT+IGR3ndRwfwcpR2AZDSxZ5D6qDOEkxCXXuwJKc2a6LVCAkBimE7QkoSpZmkzlqzjkDJWiHCy7Q==
X-Received: by 2002:a05:620a:2556:b0:7e3:404d:8dd9 with SMTP id af79cd13be357-7e342ab2721mr2843036585a.23.1753140253177;
        Mon, 21 Jul 2025 16:24:13 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e356b4677csm459128285a.32.2025.07.21.16.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 16:24:12 -0700 (PDT)
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
Subject: [RFC PATCH v2 13/34] lsm: rename exists_ordered_lsm() to lsm_order_exists()
Date: Mon, 21 Jul 2025 19:21:16 -0400
Message-ID: <20250721232142.77224-49-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721232142.77224-36-paul@paul-moore.com>
References: <20250721232142.77224-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1878; i=paul@paul-moore.com; h=from:subject; bh=mwF3ZjAzSHlGtLJaNMcChK9N/YSg9AZ/qVLLLHNmcZE=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBofsu3I2CF2dWmc/V5ahR5wheUO+S6kvfLvkal5 srUcV2JrKOJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaH7LtwAKCRDqIPLalzeJ c0fWEAChRKn+FJl4HDckECX4DwusW4Ag8Xd1LeMR+B3gFLexRjxyekaHpFAQcvIV25XY7B/cRsr Qbv48MCrLBUGH/Ea0oEtRpEAuWssrT3hPUEw5DbtNSj6O4kU6o1bSj9YUW6PIW+vl1TFuJKL/0a yhT44n/VHkQM4iKnfuaLgx5kVCnd2iWA6aT3Z2GCZixrGwefJwqJFNbzNDt0t5M0cUjISR7Kn4L KrfZl8XX5g9BL6MJ/M4ZrHuiKdcQm9BPHhpWTilE5M3cpj2OdrTsKAFom3SyVtWLhqOXGTLX5E1 VnZEwTyhef6QLlUEKZR8SO5BtwggXYM+BhfYQtMnomCj5dIlPdLUfjKKb4ddPJ8WyGNJSqxwRCF gevkrLky2chEuU7ujyFQajZ8vxcBiAk93EG+eHGEiO0/kONRK9V7GYuqgEi80DWcfS0Jfl2hMRE CMhw8PoxKn39XZCWuwPikgrLGyuLXIj9aWaM8c6w8qvrkhGB8BXoe+RFtJN+Mgw1I3t6rK9mcvU ZTqNhoRwFRQ+9fY1T6RsXhwpNwYLqyI/M4FWC0W2ufUej49GhSJQ19e4cIwUuryxchq+js/H9ps nLTbIw0t03ysGjkmN53G3Bka3Vm6fZifbq1o1Ojz+vQUsFu7MMFM6m9hZihXwUYqcVBcFHVg5hO PEP4D1g6Mtx5QkQ==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Also add a header comment block to the function.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index 14bb6f4b4628..01825da2755f 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -108,8 +108,11 @@ static inline bool lsm_is_enabled(struct lsm_info *lsm)
 	return (lsm->enabled ? *lsm->enabled : false);
 }
 
-/* Is an LSM already listed in the ordered LSMs list? */
-static bool __init exists_ordered_lsm(struct lsm_info *lsm)
+/**
+ * lsm_order_exists - Determine if a LSM exists in the ordered list
+ * @lsm: LSM definition
+ */
+static bool __init lsm_order_exists(struct lsm_info *lsm)
 {
 	struct lsm_info **check;
 
@@ -126,7 +129,7 @@ static int last_lsm __initdata;
 static void __init append_ordered_lsm(struct lsm_info *lsm, const char *from)
 {
 	/* Ignore duplicate selections. */
-	if (exists_ordered_lsm(lsm))
+	if (lsm_order_exists(lsm))
 		return;
 
 	if (WARN(last_lsm == MAX_LSM_COUNT, "%s: out of LSM static calls!?\n", from))
@@ -266,7 +269,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 	/* Process "security=", if given. */
 	if (lsm_order_legacy) {
 		lsm_for_each_raw(lsm) {
-			if (exists_ordered_lsm(lsm))
+			if (lsm_order_exists(lsm))
 				continue;
 			if (strcmp(lsm->id->name, lsm_order_legacy) == 0)
 				append_ordered_lsm(lsm, "security=");
@@ -281,7 +284,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 
 	/* Disable all LSMs not in the ordered list. */
 	lsm_for_each_raw(lsm) {
-		if (exists_ordered_lsm(lsm))
+		if (lsm_order_exists(lsm))
 			continue;
 		lsm_enabled_set(lsm, false);
 		init_debug("%s skipped: %s (not in requested order)\n",
-- 
2.50.1

