Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97131205E02
	for <linux-security-module@vger.kernel.org>; Wed, 19 Nov 2025 00:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763512102; cv=none; b=oPEi3ghVsdS6AE/PLtaFIvtfi0vR6If5JczgRZUkakijOrt+yZy/c513PslgYjI7mZrQIU1aFBDlZqow/ajSLVr576+Wve4qHgqnPYEye0X4dWzSCQoW81I3j+1DQx366UFrkv+CaMbKsMn93jxeX5ydn/IHLxhI7d5tuURaQCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763512102; c=relaxed/simple;
	bh=UHNeHKsjnGv3GUrebcmCEp1NCtwEbwc7XQ5JqmGof6E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=F55zwP1oLhI89Sxd+/jEJuACA4Brqe6RFcGX1haWmE0HcafZFb0AVnTk8m9fkrnhE7tT7OypGXYeFyTbI24raiJ2CxAdu9VOhj38nQ+KdDsqubIJ+GnAO5PYGh566tW8TnLgn/q16qJh4xl9YpUo/Xb2j9SLwUs60k9vCT5TU9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XhUfIhLz; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XhUfIhLz"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4edb7c8232aso86807841cf.3
        for <linux-security-module@vger.kernel.org>; Tue, 18 Nov 2025 16:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1763512099; x=1764116899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=aOkVC78XrCcFuuLei5X9Ir4tyHmhf+JwmI5FeOT2e0s=;
        b=XhUfIhLziPhpMFCmM4i+OF4/NWEnKePEqARzyh/1GfhdfaB/q+UQkGsF8WEKt4xxs5
         EbJ/aWaV5clYcf2NGDn1SgncqfJB7pOCil3MEFcSb+ahih4RU6rBwtvyAwI4e91AjxKF
         O56IjYqFMwkiZlxuei6PqiGjRi+A73duKF0iiB8qCR+ISJ+PGDsmKHUHyEnnv7Em8bGF
         1q7DNdU6BuQkQ0FbFq98Tk065xcZ44PAcHWXER8S3bbHfr/74zgOqhr0DVm6EUZxm6QM
         j2rYK5lFzkO1Ag1FjZM/mgy0T9U8raPleetnlr0iRSCMk34SpDZwHwNZgstu/cN4XU5V
         +AsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763512099; x=1764116899;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aOkVC78XrCcFuuLei5X9Ir4tyHmhf+JwmI5FeOT2e0s=;
        b=muvhe8LyZ/D56Lpu6TsSaYwrNofx/+7bu0S8HDdWoHLI+iocF5n1VLiig1Eh38D7SZ
         sZq5ydTBiwTPamJyroFpR/gV/gLa9QlBRn+YTQUT0vj5HTYXhLMl8dq5yI0WJFKUmWzf
         7L2haa1OavcYb9FVZhIhZZTmiwng02o1W59L1J1kmv7zCNxbatl+E4Z7xnanx7aCTe13
         ZlAYOGC4Jd5JM+UwDDYG7pcGB4iLvBvwUIxS932M4RDuxOV8Fqy/ENzYcDHYPutG/fe1
         xl7ZQ2Ybc/dHaC5ZFuQVQKi7qxlSLJriGJYoKH9rITijNb6lKFWM/PfOlOVeawy2WQY1
         D2RA==
X-Gm-Message-State: AOJu0YyQlvegcMNjNR2ocf4f9nlRZMhINgsfOejdJps1Wy6bcb28YtUG
	4j+yLcdm+tcMGWI5L/6Iyca+rdktb31jhaNZA52FHUanb3RY0NdhBkB4SXxZYd/u0G8dsW1gQBA
	UGeA=
X-Gm-Gg: ASbGncvRg1QGf0YIL2t7WnpA5nn2HPvQs1LEx40FPEmV9cHYzGcKy3z6Y764RYnp53G
	kWgblgxjWFftVqdnKOGCbdXxuBAcmG2TycxD0urtSQrKpE9vZw9fSpjV05L+K1wd0tt4Owdc2xB
	6QC26LLdc2o3bxSdpTcIveGyy/FwYgto20Jvw+XGvNy8YVE35rMDc7utlx4ykcWQwj+Vs6rO6xI
	0GbVElpUWL5KegXF+qAGUKfX377mlfvuYGfa+4pZrlnVxvXOqKqwW6QGwjc5UREvareq5RU8r0x
	+3Qctj05P4SADMj5YzVuT17e5SK7IQdVPtxSsfst0KnxIWpz+XU6IyQqvYkLERUX/IsBHoghabG
	liDwebmVS5FV1oJ9mOFZYXivaV4j0sdLSvIdS9lN31SFpyDS5bpylAZUzCASmCrL7//ozl/awq4
	LNjUEix1dChrxbyylZIVl47YrVpGEdzi2px/w5CwptvlptLmWK/Uuoq1pLcHUAFrlQI6o=
X-Google-Smtp-Source: AGHT+IHk4iO6R1OfYk6YUl2JKfc0qCqXN8LONWT0w50ZscwAo0JgeSEi9AtUKu0w2va2FCPPamkEAA==
X-Received: by 2002:a05:622a:130f:b0:4ed:b25e:a721 with SMTP id d75a77b69052e-4edf21609femr236796051cf.78.1763512098665;
        Tue, 18 Nov 2025 16:28:18 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ee16389879sm70539011cf.24.2025.11.18.16.28.17
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 16:28:18 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org
Subject: [PATCH] lsm: use unrcu_pointer() for current->cred in security_init()
Date: Tue, 18 Nov 2025 19:28:09 -0500
Message-ID: <20251119002808.444259-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1081; i=paul@paul-moore.com; h=from:subject; bh=UHNeHKsjnGv3GUrebcmCEp1NCtwEbwc7XQ5JqmGof6E=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBpHQ8YIbUKI7vVIL7SbAaXAZ0ck6kSPYyz/JYk1 4nfvDFDt6GJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaR0PGAAKCRDqIPLalzeJ c57zEAC7nQ+ztq6Bgz30P1FxNE/AqTvT0/z7y7KtAKyO80gerESf1S06Lelc8EZ7ep+1itr8mKd drDfHhZ0XT8wdRmeWbuO8OhNYNJ+23mUP+fmDh5q6mzaEw675b00vAdp+n7bO4NchPoJzk1cyJg 7xg6xrG+G0E5DMah2yQZckVdcjNJkJ2rg8WvcNw34G9sBVQErr/vCwC1HE8Sue/cMWBa63qbS07 f/bZqL1Jt1NFwt5KTo3Pn9dTNYJ8GgagYseMv7jbdl+w236hmmmKlKrgATuA0hY7YmY1PfDOdkX i1OP9hXwcIImlofGVgbl8/p8UMMaToVsQJfRW4DodNVQVBC+DmWawJOkCvw6pt0Dqjuw3acO3AJ huvAKXtgFkhMr4bpi5rjsSmwoofD6PBr7YdVHYlo0PgY9g9HmH6J9jJswvLIja3HJuLzY//lCNR Sgg+75x1pvFpjp3BUYCS6d7hVq/5fT5DCM+/uVD/OfyQ80+FnVi9uxAoUCa2V0HPj/zVdRNyuPI eljtvypJNG7QjOwfMrHdxGgV1bipG/P+zOWuGefv2RH7wEOWgRBbijXYOcXvqBP9AoovwxG9IwN hcSXEU8Rfkp5BQihAkpJI+kQi0xlpztyOoQiGefdvT4vOvh2aaJs3fANXWy9FnPX9el3eSmRqD1 1PduSJJdWax1FZA==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

We need to directly allocate the cred's LSM state for the initial task
when we initialize the LSM framework.  Unfortunately, this results in a
RCU related type mismatch, use the unrcu_pointer() macro to handle this
a bit more elegantly.

The explicit type casting still remains as we need to work around the
constification of current->cred in this particular case.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index 6bb67d41ce52..4dec9199e4c2 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -467,7 +467,8 @@ int __init security_init(void)
 						    blob_sizes.lbs_inode, 0,
 						    SLAB_PANIC, NULL);
 
-	if (lsm_cred_alloc((struct cred __rcu *)current->cred, GFP_KERNEL))
+	if (lsm_cred_alloc(unrcu_pointer((struct cred __rcu *)current->cred),
+			   GFP_KERNEL))
 		panic("early LSM cred alloc failed\n");
 	if (lsm_task_alloc(current))
 		panic("early LSM task alloc failed\n");
-- 
2.52.0

