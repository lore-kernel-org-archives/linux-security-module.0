Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F0838D419
	for <linux-security-module@vger.kernel.org>; Thu, 13 Aug 2026 18:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786644509; cv=none; b=AJ0TJkpZC5RwJpGdt7ckFC3Z2C5zhT4232NLxKcujLDniKp5pAB1D4FUj02Ei+flhv99O+iVgjE5HOS0N+qdoiN97o9OyZNtZG+k4HqB8z/3epJHpduCGbJOlYAoakXh3TLF4uZs0gQCwHR0aXRxaRhfzjrHcFjw7ieDtyH5uAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786644509; c=relaxed/simple;
	bh=18uwLcHbLGRiIseJ5viEoswF+GNIRi+RyFvLZ5C4nUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tb9JlPI+NM66JIqhpLbwCPJ/IrM8Oq59UlWs8J4ZyyTZGnLMRJnhy1pfYVPqv5jwNsvZZr5s0uSw1tRmjbj6txtj7jz9S5QiGCRcltiJ2TBpgtSonYdMIzmNRD2gBaELTz+Qfy3oxS0NPmZZp1qDWO8qbD9eHie9IcWb5fVdIg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Ft3PM7mi; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Ft3PM7mi"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-936623c6dd3so78824285a.0
        for <linux-security-module@vger.kernel.org>; Thu, 13 Aug 2026 11:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1786644507; x=1787249307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Eh4YnFKKRSVLMKJwGIOxJMvYKZgsW0irEzH9LlXR5fc=;
        b=Ft3PM7mitdUh71iptuIVOmQj2QBdmFeqeMHo7IXDu3nxwi4l4TJNOZ0qsXoZ2hJWwj
         gdbHpSodaoLS0e+C9Ykg1yWvpqnonlnRWdOm+FrtYae5luoj3XqexaicfmnxTpVPmUAG
         1fTV3LGqcvKqAkUNCfaqwWHcxj1T8TI1nIbBck0Ykc9c++7TJgElzgIsMlseZyU1O6+f
         wZE2/f/B9qE6wFwJeI2U56SgSm0AXX5HnDydkNihUOcYDa0XzXJDwFVAMQy2O/ESQmqs
         XGVReDSXDEa6lcY7utmVOzB+D4lyIFQ1/cf2G06fQ2FMW9Wxqe922sykZu9fKjTQObjF
         0QYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786644507; x=1787249307;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Eh4YnFKKRSVLMKJwGIOxJMvYKZgsW0irEzH9LlXR5fc=;
        b=PeVRYZiH91KSXZivna4PAmOAQH0w642DSHZvKpf39PfgWte4X7XPwrMlTNu/dSJ6ga
         YL/8QXhNoJlCuyg3kUYhU5qfxgg/rPoO9Md/igIcZelS5bp5WP/WwfT6CYe0PqwH+f//
         gbFud4jz5/UB8KBXkn1ZDimvh6OxmNxVr9JbFl3E81MmmQIR50aaRjOXqigGhpNgi0rP
         l9AFnOdVJmE6gATPzsE38bK66w1JnE3ItIgX+qQxQ904Hd2hBJOcuhskiIzJL05c+/fr
         M8qNXabD/oLgo69ct9QJh1MivlAqD+C7msweD9eqWj2NDm4wh+VYMQWsYiEHDlZd705M
         urRA==
X-Gm-Message-State: AOJu0YzNKFw5UOAH0Gqw9oQzgTM6Szyr/y6pUCL3pf9pspGsDm3xegW2
	GQ1+TRpIqOOrwy8Jl1UxCK/9TF2gSrn56vqJGXqfr3lXb7L86webLWOEs20z17DUQsQXQeDVSwE
	pR16TqA==
X-Gm-Gg: AR+sD11Z+EKCZPlMT7E+yorFil4lJkbVvyYeWdRSibZMeJQiJl46moR1go9jFxxEyuV
	ZIKqEGGbsvRcBtUFczEfWq4OGjFc4NTDKeq/horTuHzUrl+52Rh8dtWmIB7cHW3+YkarFdI2nTH
	ujKVs/Qc1uyLaYRWDLb5vBO4SC46IJLJF/ucKQCLJy0PxC4f60Ti+liR83K2ZGIRP1nQVngGuxm
	PQ8z0yoEzEJDdxxcu+3tex4opwOXGOKFJGUy05FY3PT8PWn464xpGnNWhA/MkSx1LFXkjEgvf6r
	uDJYmjPCED/G9hz6trgiZU1WdFCaSNiVVnWOnqmUyMAwbTCerD5im49clP7vdCPh+rHfDf7SeNg
	D5KxfwNO1EPdD5LQmommdTCDnFB2BG+b2Lt7r5GBVS/P5wIQFYoX9jflXgH281pBPx+8232HnHR
	cuM1knchIVXhKTMMaSN0PuC9Dx5w2TcgaewIWiWwAltA1SERJC4QM/y7OMylnX5GcROFZKdqBzD
	4LzL92hw9SiGj0o0AuY4Qid89r0dgvbZA==
X-Received: by 2002:a05:620a:f01:b0:92e:57ea:8c8b with SMTP id af79cd13be357-936c03f21aamr732218585a.0.1786644506957;
        Thu, 13 Aug 2026 11:08:26 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936cdf55745sm42553585a.5.2026.08.13.11.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 11:08:26 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Subject: [PATCH] lsm: update the BUILD_BUG_ON() in audit_log_lsm_data()
Date: Thu, 13 Aug 2026 14:08:17 -0400
Message-ID: <20260813180816.223079-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1162; i=paul@paul-moore.com; h=from:subject; bh=18uwLcHbLGRiIseJ5viEoswF+GNIRi+RyFvLZ5C4nUc=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBqfggQ9aTWqcymPqCy8MNx2Sw557v95DLLWPLEQ LlWT9gnTACJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCan4IEAAKCRDqIPLalzeJ c9JsEACvZ73wdp2Sec2SSjIZhn7NQX7Ph6M/NuZfa/GbcCSsLY1Pd+MkFXyjAGzlguhfpVFDDgb MJh/x57dSZ377e7OViZV6H86MAk5lySsne0sJA1JXTHEyPvLpHbq7gEzitA6lHnIicyxQkReGIB buEI5FZu4eh6w4QuLBYSBCUmt1qZWD4Tlvt5T6jPDoyxeSbJ2lbHuzue91E3luZKG2GJ8b9SGLV bh0ShT3fQZj4dGISIvhkuqbq/R2PJGO8lmywZZDzW5eR3hGEBvcwDZcwyxry7Zi1A3ZtcfW+Irf 9UCrH6LO69iMhR+uZvuB7DKBDyB4rD31+u4YhU0SH/DnQI0Ox6hTohvyDvy6S7X9vwfHX2g7KQ+ nPJdG6yGIere4TJ2zyEgWh0W/L8HafwJdtEXBJhHDbfUdbIwdf0dwME9xga01k1FAxOzA9VClwk sZxCKavFfxwBL2HAUGVDIYdxkHq0ignnF23zxDIvPoLwZoLOMwnD/j7fp/YiFPT2IaL1gh3E37z FfBknbU2x7M6AoBXx2DBPMhoay99v0QcMgVw1JURnHM2Z1iA6Acr5wKVwOPJrwGoCeIYE6WSFel zq1vHT+fZCjUG5PTJId7EauNCZ6IlxwbuEnVS3QHq3bUA6e27+uPYktciE/U+yhAZQz4Z1tIiNf hOkSod+YZMpCyoQ==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

On 32-bit systems the newly added namespace fields in the
common_audit_data struct exceed the BUILD_BUG_ON(sizeof(void *) * 2)
size check in audit_log_lsm_data().  Convert the size check to two
u64 types to both fit the new fields and move to a size that is not
architecture dependent.

Fixes: bb20ca26f960 ("lsm: add LSM_AUDIT_DATA_NS for namespace audit records")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202608131232.Owej9tlx-lkp@intel.com/
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_audit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/lsm_audit.c b/security/lsm_audit.c
index 404ccbbbf94c..29116ef2986b 100644
--- a/security/lsm_audit.c
+++ b/security/lsm_audit.c
@@ -182,7 +182,7 @@ void audit_log_lsm_data(struct audit_buffer *ab,
 	 * start making this union too large!  See struct lsm_network_audit
 	 * as an example of how to deal with large data.
 	 */
-	BUILD_BUG_ON(sizeof(a->u) > sizeof(void *)*2);
+	BUILD_BUG_ON(sizeof(a->u) > (sizeof(u64) * 2));
 
 	switch (a->type) {
 	case LSM_AUDIT_DATA_NONE:
-- 
2.55.0

