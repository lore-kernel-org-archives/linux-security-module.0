Received: from mail-oi2-f1.google.com (mail-oi2-f1.google.com [74.125.231.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBE93ED132
	for <linux-security-module@vger.kernel.org>; Wed, 19 Aug 2026 23:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787183141; cv=none; b=k9zAwwtfQAbqRsPAr9FaLsg/euTmM52qoVn05mtcr+xHaYDlSm2mlq+dZ10Puydfu4VMJv3r0hgLnPtxjhAbWKu0uMrRljCgAtFHuDSjHQBObmysSAR4A04rnuImrZhUkYfZ5FSPjrEER/T2IdwqeMrYb2W+2q3wjD7QGsNmrCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787183141; c=relaxed/simple;
	bh=oFpEEkzZuw0/h/6GrG817pqCoPcXIXnRLQcyhoYplYY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pmnbY0Sn0bLKuMYk6H23Yl+YAthzyUGmz7iyPV69L/RCg0lGksDOsV7GdUQ8gqN4iRQSkJPKxW2CUCld6RsLLPNxh1mGOqyrdHYDGNwM9EfHwPwEDwZ/x4Ua7vrXI2Q+GnFHwqkEEW634TQqUcyUiljNKE8ChR/YFj4t8SUY4Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=IISIJqeT; arc=none smtp.client-ip=74.125.231.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="IISIJqeT"
Received: by mail-oi2-f1.google.com with SMTP id 5614622812f47-495f936d5ecso427424b6e.0
        for <linux-security-module@vger.kernel.org>; Wed, 19 Aug 2026 16:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1787183138; x=1787787938; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XAWmDaL9ozcPdtpfoj1zroE11nOQ3lqCom2P7tPqO1M=;
        b=IISIJqeTbXPTrnm65gTPFOuSRqHK1vPOPQrkpNq0m9Kg7+6DNgMaibh5aYWsDsAzYt
         +qBR8PCs8000A87S9JR7tIt+URb0+01z+fG1h4+bQyIKDhv4zUpECrV+9tZp419gMVeN
         8RuEVynhG0WkKJAOAAFRcWKwRQnID/AQILwxYQrtWO4wQsVcCAL1XnJpcvVpxT5Z2rzl
         ib6ynJtT8vLlga3Gl/BJxRwWniVHeMKe8sV59TaUg3WX43LRI+XDjzLYAjeeqJ8I7/tu
         uSC6eoNAQR9ieVk8MCPVOb+Y3l61csNLEOmLv0qsL6V99L2XEEe4A4cjZLqbEM5QrmZL
         t0cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787183138; x=1787787938;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XAWmDaL9ozcPdtpfoj1zroE11nOQ3lqCom2P7tPqO1M=;
        b=PHmrA5ii/xLapgihuuikt7q3oAfrjsdzvR0riZ1zH6cRt7C/C4+lwKOdCxvgpuBkJ6
         OzNjTEa86wsPifLMVGpOxIALr88Xjg9oeu9ueyi9L58/EdaCgCrDi6fk+q2o5zFt42M7
         bCow5P6utweP018I88Wnz9rGnS84gxXXeffeALJoYFd4oqgADCX34T1rU5mLHVSyc9+U
         GSUVcUeWSXp51+8AQF1W8VWyT+BZj6RBsVhHjZa7yFYd++WXACt41w6Jnpe8kadQxSkq
         b6mkElLeYHmwXtyGqXXWeTqSvS5wkG8y7VQDDYtlE//lnhub7zUAaK8Z+gH7hWx//+un
         zLwA==
X-Forwarded-Encrypted: i=1; AHgh+Ro6dgfHfL14Zy/54597GkU0LNyfk/MW7DUB0PsCU0e9axQzlpWbmi4IkD3Qyy1gUoMBj/pW3lA7MLc9cT9+681qs2IRNQo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyznmpug93dX0adtlmext7cChMo74R4rjsmongLvcMWbEjVeJ8D
	6zveytD2OlzvmrJspbdB6fpY4ch1Q0QUAdnfydqUb9VMMaRnrbjmrECVQKu8MsiPzkNiaVyPUMh
	mF7RzRD9CGHLS
X-Gm-Gg: AR+sD103lm2xF2l9bWdZKNUzyk2aJf0ms5QOaKGWi35If6BiKPmxB/hsgw44NpEBR4W
	CNWcg92dGMDmyggmQdAsW3nKAQTlaNN87PbJDihkcor3NJr8aSXliem5t+l37+fETj0LzsbtpTv
	VMDnRl+QXe6j5unLu47xBLtQULAzy9Mdjir39IqEbSzzK6bQv5fZs0PidJhyOP7tfyshmZsE9jM
	EsBYcChc5Lc5Xq7IQ7CQgRd8xlxtoBNGeCneO9lidE7W/TRP4sYxonKLkcRdYsh3JRvPsmoIB7U
	J0s7ElSPZ5cI6ViUAfGwNB2jrVsyFvB+FqODU9SFihPWDOfjvpTraD+E802yM1Qyn11TsvYBkse
	COxSOM2UYjhpNhczPUTcmqli/9DAVh3DYPEO6c+phcSLAHR5sn5iFuPK1y1S5QaMfDSS6jAOAaV
	OjMldNTxHwMYO28XcVYehZ0JLfrQqm0duiZqIQeZR5UQhR
X-Received: by 2002:a05:6820:4dfb:b0:6ab:13:b207 with SMTP id 006d021491bc7-6b13c628f09mr7498861eaf.27.1787183138499;
        Wed, 19 Aug 2026 16:45:38 -0700 (PDT)
Received: from [127.0.1.1] ([2a09:bac6:947f:3af::5e:75])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b13c90d160sm3470216eaf.0.2026.08.19.16.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 16:45:38 -0700 (PDT)
From: Frederick Lawler <fred@cloudflare.com>
Date: Wed, 19 Aug 2026 18:45:23 -0500
Subject: [PATCH v2 2/2] ima: don't measure/appraise files on configfs
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-configfs-v2-2-cb6e65d11589@cloudflare.com>
References: <20260819-configfs-v2-0-cb6e65d11589@cloudflare.com>
In-Reply-To: <20260819-configfs-v2-0-cb6e65d11589@cloudflare.com>
To: Andreas Hindborg <a.hindborg@kernel.org>, 
 Breno Leitao <leitao@debian.org>, Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, 
 linux-security-module@vger.kernel.org, kernel-team@cloudflare.com, 
 Frederick Lawler <fred@cloudflare.com>, 
 syzbot+448c2e24b1ceff13ed2a@syzkaller.appspotmail.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3142; i=fred@cloudflare.com;
 h=from:subject:message-id; bh=oFpEEkzZuw0/h/6GrG817pqCoPcXIXnRLQcyhoYplYY=;
 b=owEBbQKS/ZANAwAKAasltHYDktNtAcsmYgBqhkAcjHzG/qYuRMvT477GhsiecXpJmpmZ+kUik
 MSqeZmGa2mJAjMEAAEKAB0WIQTLNBqMVmu1PHvjOe2rJbR2A5LTbQUCaoZAHAAKCRCrJbR2A5LT
 bbLJD/9vc+sLrrAclb35dsYrwJ7oYmcDmAS3qVF7MzUZO5x1fYWx4kwedfpm0L+CKwMTqEv2if8
 visFeiT2CYEaiPBCr6pg6I57TeuFuIrGIDQp5ma4lZdM9CLIiA4ncx/Otex6JxNdbGdvLmJo0Yy
 X1m94AT3jJkEP7azM8jTP1+BB/WZEbwK8Y45ZKwyNth2J6yOxw/3n6q6aYFI87NcbTTGsDyHfGa
 YPVD+vGMlm7CwI6sW9Argi9+I9eFs0vq39RscMFzIqOdQotu9Pyk7NgwzUbJFG2b9B2Vdr8bl/t
 KNyWr76ZH5llepvFgJ7K9sZWrVuuWYKI9lNPgVPyva6IRMmhZtfOjF6iyVVaB3mD5ZYN1lnXnok
 lSSKYpbt2vxa+KZrYE3LAfxaLDTcb78v3bZ9mLbHn5sPuXBLsnY884N0jCw/cjFA0tU6/D0avaN
 ccUYcVQmZWTZ9/FfrPWG9oKBMqDWu2E6MVEdZEcAmjbMEU2K2hwsITiZa76uBom+8DcGyWb3fVo
 +fyqkNe9G76pRV7Epv8WN3JXfLfpq1avTL7tCL/BtI5THwNVmgTGGfVY+HlXBJIFbkOPK61WQWj
 +3F5rd/PfKJSHVgsFTXZADuiPHfLZMw7MYfzsbJgkQM4JJwmhFZAIb/3ydtjeUSTcwS0oHCcdrq
 jHXJKWBSdH+UXCw==
X-Developer-Key: i=fred@cloudflare.com; a=openpgp;
 fpr=CB341A8C566BB53C7BE339EDAB25B4760392D36D

IMA measurement of a configfs file causes process_measurement() to hold
iint->mutex while performing a kernel_read() to hash it, which re-enters
configfs's own file locking (buffer->mutex, frag_sem).

Separately, opening any file with O_TRUNC now causes ima_file_truncate()
to take iint->mutex to reset the cached action flags, while sb_writers is
already held for that mount.

When a configfs-backed nvmet namespace is involved, these two independent
lock chains combine into a cycle:

iint->mutex -> configfs locks -> subsys->lock -> sb_writers -> iint->mutex

Add configfs to the builtin don't measure/appraise rules, similarly to
other pseudo file systems, so IMA never takes iint->mutex for configfs
file in the first place.

Reported-by: syzbot+448c2e24b1ceff13ed2a@syzkaller.appspotmail.com
Link: https://lore.kernel.org/all/6a77c7cd.b50370da.49fe0.0031.GAE@google.com/
Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Frederick Lawler <fred@cloudflare.com>
---
 Documentation/ABI/testing/ima_policy | 3 +++
 security/integrity/ima/ima_policy.c  | 7 ++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index 19258471b7b26b2c42c1ab2d11b4fd630b2e6f81..b8a763e4c9fb1a5ccca97518e80e0452554c9e96 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -108,6 +108,9 @@ Description:
 			# NSFS_MAGIC
 			dont_measure fsmagic=0x6e736673
 			dont_appraise fsmagic=0x6e736673
+			# CONFIGFS_MAGIC
+			dont_measure fsmagic=0x62656570
+			dont_appraise fsmagic=0x62656570
 
 			measure func=BPRM_CHECK
 			measure func=FILE_MMAP mask=MAY_EXEC
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index f79d07bb63c6fc4ba6fe594140de8d59f57e4f0b..68d9a5e6c232ea0678e9f51f105cebecccccb43e 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -165,7 +165,10 @@ static struct ima_rule_entry dont_measure_rules[] __ro_after_init = {
 	{.action = DONT_MEASURE, .fsmagic = CGROUP2_SUPER_MAGIC,
 	 .flags = IMA_FSMAGIC},
 	{.action = DONT_MEASURE, .fsmagic = NSFS_MAGIC, .flags = IMA_FSMAGIC},
-	{.action = DONT_MEASURE, .fsmagic = EFIVARFS_MAGIC, .flags = IMA_FSMAGIC}
+	{.action = DONT_MEASURE, .fsmagic = EFIVARFS_MAGIC,
+	 .flags = IMA_FSMAGIC},
+	{.action = DONT_MEASURE, .fsmagic = CONFIGFS_MAGIC,
+	 .flags = IMA_FSMAGIC}
 };
 
 static struct ima_rule_entry original_measurement_rules[] __ro_after_init = {
@@ -211,6 +214,8 @@ static struct ima_rule_entry default_appraise_rules[] __ro_after_init = {
 	{.action = DONT_APPRAISE, .fsmagic = EFIVARFS_MAGIC, .flags = IMA_FSMAGIC},
 	{.action = DONT_APPRAISE, .fsmagic = CGROUP_SUPER_MAGIC, .flags = IMA_FSMAGIC},
 	{.action = DONT_APPRAISE, .fsmagic = CGROUP2_SUPER_MAGIC, .flags = IMA_FSMAGIC},
+	{.action = DONT_APPRAISE, .fsmagic = CONFIGFS_MAGIC,
+	 .flags = IMA_FSMAGIC},
 #ifdef CONFIG_IMA_WRITE_POLICY
 	{.action = APPRAISE, .func = POLICY_CHECK,
 	.flags = IMA_FUNC | IMA_DIGSIG_REQUIRED},

-- 
2.43.0

