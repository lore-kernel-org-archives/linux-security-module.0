Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F21246775
	for <linux-security-module@vger.kernel.org>; Mon, 21 Jul 2025 23:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753140274; cv=none; b=c/AQcKXZe1cIeO4rBmv8s3JIpUAi/rKY5Kmezqu0IusBjjNX606eqQZnUZXmt8MQo1hpYWhAx6N7yQb1Zu+Kx0nh6kjphOWcXAZPka8ztpz3wjsf5gckpUamVYagDFmahHZ4lTM6p3SCHcmdi9SFeXII3FN3aRa4673RZ767Wfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753140274; c=relaxed/simple;
	bh=fXylwXXBB6mvLKxQHAl/i0nDwp3GIxUSzI5Ds9tCq5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iEa03lLKlZn4mSDJrqBvZIgd5xNAuQVhGluIsY/KcJfn4YjD/7d7AupuLr+/cp7NgYJnPI1q/uY0l/crJsLope9QBwfcCHJ6rCiQAtMGC7eM/t20AfMVbv4h5auTK4NIVpmJduVD/HNvJgT5ls44CvFWSE4eZZZ1tdVxm5HDGD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XKasALV3; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XKasALV3"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4ab6e66ea68so66217891cf.1
        for <linux-security-module@vger.kernel.org>; Mon, 21 Jul 2025 16:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753140270; x=1753745070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AChpKruSXH4shBW9tTAspXM8SkY0T38J4dZ44b7wxoM=;
        b=XKasALV3LJrz5ajU9kxUT6ZT/vK1/OZInY0wwKGGsgBEkOLl+eIosDwGJ+6jLuYp0H
         93jFF06ecSnzmdc9GL1vg0Qmg4Ezis8nmCZxZJaen0LN8b/T3khuM1RPhINTkcUOzFsA
         Lsu6domA3ofNKXS8qSD4etALwWyWKcZkr0/1TKfAeZzbXBx91gvwT2wttWVmG8hCKfTo
         dfRJiUxmwEsmy5odbyGAFAU4euFkjD0WOSVcamnDEP1mNCYYT4p3xgJc5AL83Xpdlk6o
         ru+IJ3XoPzGfDF6ZHrO2vhvaQzxP0stNrHBSorxzA+j0ypbdpLSA3OFW3bm8AgblmgHv
         jrTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753140270; x=1753745070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AChpKruSXH4shBW9tTAspXM8SkY0T38J4dZ44b7wxoM=;
        b=a1WmtDP0eSxDUCnA+0Gy2D0+/ATMtrySQ0GiEprrdWVtAed0TJGg+NMbjKrPrlDhp0
         2RfTTn7me8kkOTA66m5hqNkHu4dicjQW3n3e23EEBGuTHcr9RLXDVN0Gnju5fcspBLWM
         /JRQRKLGAjQWiRKcZbAKQZaksqcFXMx6cyMF3bpnl/gd13zBIS4EYIuwqYzHIS9DMF1V
         yxKM3JB1xXmup1MaQZdjgeH6XJC9y3Pg4AdjlYulDXhJG/vCnIQkG70Ml8Mq60k+2E3w
         WwQI5gakAEdAgOy44PEaR0TMubEN5g3JV0vHNlO2S+EfrLmQows2bkS6QWBsbw7B4UFx
         zHjw==
X-Gm-Message-State: AOJu0YxsgF9tlgdjRJoWZw3PzRUt6n4fL6ZkzA4g4QUSUQnTb0JwzriU
	obQZLQTAq+514FnHPQEWtUTjbdsaocSpdD/4fm3MNca6ov0QMhJCFsWvtGIfPz4tDoLB8wbhjyT
	P/6Q=
X-Gm-Gg: ASbGncsY4/GBEkOrPFBdTS+Uj7QpLTW4P8HD5qRoXvLVfrXLA0dqgB6yCfa2p15JpD+
	FKbOZ6yc8idkI/m6HriNLTaTEzpOONLjt3Ay0rBeRo3s8OYjyyRctG1BoOVAayuFK2N4Hw1zKc/
	TM2ENZOpDBtfESQ9yYzLh1cHWMNZIiMxuzpeLFJjEOI5zWUB/PQiJlpycJhbaWokPG6GryRjRbF
	YQ9ESgrnF6Y3r5Z5+/5hn3mbcx56fPn+Je+na7P+8nq3ZXJ3RoYnFI0IwiAYGJBtEgQNO1n+dEO
	+tnhzZllU53YEeWHP8/k/Vy/tiZrBzAoG0FEAkcnr6qw3jZPaXNrfoA9DEO4FFtc1zCNX/v/KGv
	Sw4feFe9l/SFzzW6OcaenOcf53G0gxGkUEEJF9cN42vbZocp+AXDQbyCnSvRSq35RXXzPaweJWC
	Uh4w==
X-Google-Smtp-Source: AGHT+IFGIvIwa8WNF1menjGeEMvSBVjGCT6kAL+y2Eh1Z2cmIw9BZdm96N5Lr7Wk4HOPV+6hqxnwqA==
X-Received: by 2002:a05:622a:1b86:b0:4ab:42a5:7f1b with SMTP id d75a77b69052e-4aba3e1e339mr338330681cf.47.1753140269911;
        Mon, 21 Jul 2025 16:24:29 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4abb4b246b7sm46898641cf.57.2025.07.21.16.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 16:24:29 -0700 (PDT)
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
Subject: [RFC PATCH v2 28/34] safesetid: move initcalls to the LSM framework
Date: Mon, 21 Jul 2025 19:21:31 -0400
Message-ID: <20250721232142.77224-64-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721232142.77224-36-paul@paul-moore.com>
References: <20250721232142.77224-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1823; i=paul@paul-moore.com; h=from:subject; bh=fXylwXXBB6mvLKxQHAl/i0nDwp3GIxUSzI5Ds9tCq5k=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBofsvrk4z0QvdJFbI8xzz63crkC3dDkkM1dTnFz NCzwCtbYEqJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaH7L6wAKCRDqIPLalzeJ c7qDD/9OUnm2rpgD5G+DPGb0vSJv0Pf+Zl3c0qosUmKqR4w3q4tW51edfhPgBJEZi1QOJNe9rgO O8pj8PFMZUHnFCP/08hUsmiAFLxC+TyHg7XAC9taKHDR7zLH39vILPAdCUxCmktun9QIj73CX/s ehAMdY+kYADRID34MvUiRAOqjG/KJiB8kM7Pmg4p0JEDPzHZXTfEdVFMnt+v13Cxl+rycJQin3z 8uX6MdVJG2sKjJyu/dN1XwB20EErcDTO3LsJEMaIjmtUjP08iG8UmGYUGSWxBPVhFXUhUZaevQB Z7psoYdfHRj/1o+17v7dbvndThCOqfd4IJAh3M5Qy/mYXLOwOT+ZwYR0axyTO1zE53O6V5SEhNm Ov4uDtu3n6Vrb94VwLBv8AKyTdK+6p+iEJBgmWQTQX+mTXo9VysMUARTNTEfXYmsC8ZGDe4nEB5 OiOGMLlpoWFcJ4VkMjECHgMPtaOQI9Kw6S6whs9yaN4gPZuS8jJMjllt9k+CV8OliuGAEYistwy wdWk/kbgpQBCbSN1H6nwUzBdB7x2oo86dOm5q5A7045ptGiC9XYT/uwS1w4/EatnYC2TmmLOkXB Cn77viBHeeVvU6O5hxGoKBfInkcllihGTMSU/vvo1lGGmEajnuxUbv/wAi2DTRfyBKwtUrOCoaR 40JpZztB60hZzQA==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Reviewed-by: Kees Cook <kees@kernel.org>
Acked-by: Micah Morton <mortonm@chromium.org>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/safesetid/lsm.c        | 1 +
 security/safesetid/lsm.h        | 2 ++
 security/safesetid/securityfs.c | 3 +--
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
index 9a7c68d4e642..d5fb949050dd 100644
--- a/security/safesetid/lsm.c
+++ b/security/safesetid/lsm.c
@@ -289,4 +289,5 @@ static int __init safesetid_security_init(void)
 DEFINE_LSM(safesetid_security_init) = {
 	.id = &safesetid_lsmid,
 	.init = safesetid_security_init,
+	.initcall_fs = safesetid_init_securityfs,
 };
diff --git a/security/safesetid/lsm.h b/security/safesetid/lsm.h
index d346f4849cea..bf5172e2c3f7 100644
--- a/security/safesetid/lsm.h
+++ b/security/safesetid/lsm.h
@@ -70,4 +70,6 @@ enum sid_policy_type _setid_policy_lookup(struct setid_ruleset *policy,
 extern struct setid_ruleset __rcu *safesetid_setuid_rules;
 extern struct setid_ruleset __rcu *safesetid_setgid_rules;
 
+int safesetid_init_securityfs(void);
+
 #endif /* _SAFESETID_H */
diff --git a/security/safesetid/securityfs.c b/security/safesetid/securityfs.c
index 8e1ffd70b18a..ece259f75b0d 100644
--- a/security/safesetid/securityfs.c
+++ b/security/safesetid/securityfs.c
@@ -308,7 +308,7 @@ static const struct file_operations safesetid_gid_file_fops = {
 	.write = safesetid_gid_file_write,
 };
 
-static int __init safesetid_init_securityfs(void)
+int __init safesetid_init_securityfs(void)
 {
 	int ret;
 	struct dentry *policy_dir;
@@ -345,4 +345,3 @@ static int __init safesetid_init_securityfs(void)
 	securityfs_remove(policy_dir);
 	return ret;
 }
-fs_initcall(safesetid_init_securityfs);
-- 
2.50.1

