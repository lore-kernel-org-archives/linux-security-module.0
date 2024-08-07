Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203DA1B8EB1
	for <linux-security-module@vger.kernel.org>; Wed,  7 Aug 2024 10:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723028144; cv=none; b=QQkpKGIWK4J9ZL/ji9tXW0/PHZs8CySAfXXK8vCTYo+ZngDmtql3jWMY6Q+CHqWnnGteqWS10iwBCmHgBPdczuKgEa8rsEFIKNUMMAQIxke8IXiBpBdzP2sQ1FqCsRZ7/o1vzXwkNXM/EiZC3bj3fo+0bLbB7yKVZVZ2LP+TFJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723028144; c=relaxed/simple;
	bh=4VeYB/5KjZu1xP4yhehU2c+3ldJcBRoEhBeRIzBgB1M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qxD3ZvYnzdPSGOhwULaFWKjB+rpoyCPVjsT2PP1DhNfBrY3cFbLTptSntEcQ9zEcUhBzIMjfCFM4WQfyXLDTz4u+ThvZ9m9hfZM2wVuJf7v2TCEE5stiJ73GTprTnWXCCsq3GvNiG5lyVYOfjYb/mTUxCJ25K0BfOD2dU5inFXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UVEJLaFb; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UVEJLaFb"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3686b554cfcso929229f8f.1
        for <linux-security-module@vger.kernel.org>; Wed, 07 Aug 2024 03:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723028141; x=1723632941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g1CfpUgJXS7BrN7tAFA68qWsxl5eht2ofVsjd8s8rPw=;
        b=UVEJLaFbfMUwjaKEz2LQce5F3791HikaDXswCKrZ4hOJc8ztcyQ2E+WND5OYMbZyUL
         LsH8vnQwF43e4E0segbL4u9sF1imxeOHgWD2/Hznj4EhGssd/QdpGTYVNxM+nvcxlveL
         4R9Ufv+/6Dz8EZdQQhVsXNf3r3e3RbRYuxJN+NrXjWhe2I5v5Abx1tEywBF/AW4OiwOD
         fuRWHXgQMHgAvtfqmnnOuDM/+hU2aUPp+lWe9bcOFHd3zDSy7YiKqCAIS/zaKLdLjMpj
         I62lSoo0Z/LlKUAxDKHcl7DXySyVVT6ogZwshuwvIwjhyen37jBPOOzOhBhLmqDoW9Z0
         aIUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723028141; x=1723632941;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g1CfpUgJXS7BrN7tAFA68qWsxl5eht2ofVsjd8s8rPw=;
        b=dOwFZdUGxSb1om+lSzNN3nXICffs8pNf4aMM5/AOLFsyxPWexxZspxymLOldeNe30y
         f14fGqI7nZ+vLB9feEPaa+m6/HKlBAo6tLlk2jwlywwQXsWZ/eGkhwrZDJ8YDexRP1Ff
         r/biE2lUkczG0U/cxwUvspdCFaK1MPU94/DHDchDiHza0XvdfUneL8IW8vLNeV6/Y70t
         WJMvMxpvvk+sD4VCmCIcuHNgak21+8774tCfOeMRQwz70Dfa6e3a9qvbeZ35CAU+m6zY
         FakUfIjCvxNdWkDm1sqk/FUsm+EjCekBXDOU5pofBT5nrOeZ4KbJH9jwHzinqDBicvl5
         VRuA==
X-Forwarded-Encrypted: i=1; AJvYcCWFpiHbJkm67PXfpph/x9QTinFqhnmNTNJmCB+1sLhmUH5lJxZJL7fWL2LPMdHCCMdVKfMXtUDwCjxQerL4tAl8cR6TwH1HWUnaN145hTBRrG84Fvsn
X-Gm-Message-State: AOJu0YwLifueNDbe2lPRDX6ujdHWuwxbTjG26VOklzzpvjBR4KPX2UlN
	knbG2yj3JRUBgQWmskls2CI13ux4SFyDnyRj0OeZVm5U/0jILl6Xvr9HwDK8srQ=
X-Google-Smtp-Source: AGHT+IGt+z3jjIQ5JZ71Sm7Hm7Y023gn/0oFOumyjerqnx97PjhdWlctYsTLYdnmPaqcAi0kbDv17g==
X-Received: by 2002:a05:6000:8:b0:368:747c:5a04 with SMTP id ffacd0b85a97d-36bbc10f6c5mr9798605f8f.25.1723028141352;
        Wed, 07 Aug 2024 03:55:41 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd059891sm15644743f8f.73.2024.08.07.03.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 03:55:41 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: linux-arm-kernel@lists.infradead.org
Cc: James Clark <james.clark@linaro.org>,
	Al Grant <al.grant@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH] drivers/perf: arm_spe: Use perf_allow_kernel() for permissions
Date: Wed,  7 Aug 2024 11:54:41 +0100
Message-Id: <20240807105441.2156738-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For other PMUs, PERF_SAMPLE_PHYS_ADDR requires perf_allow_kernel()
rather than just perfmon_capable(). Because PMSCR_EL1_PA is another form
of physical address, make it consistent and use perf_allow_kernel() for
SPE as well. PMSCR_EL1_PCT and PMSCR_EL1_CX also get the same change.

This improves consistency and indirectly fixes the following error
message which is misleading because perf_event_paranoid is not taken
into account by perfmon_capable():

  $ perf record -e arm_spe/pa_enable/

  Error:
  Access to performance monitoring and observability operations is
  limited. Consider adjusting /proc/sys/kernel/perf_event_paranoid
  setting ...

Suggested-by: Al Grant <al.grant@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/perf/arm_spe_pmu.c | 9 ++++-----
 kernel/events/core.c       | 1 +
 security/security.c        | 1 +
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index 9100d82bfabc..3569050f9cf3 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -41,7 +41,7 @@
 
 /*
  * Cache if the event is allowed to trace Context information.
- * This allows us to perform the check, i.e, perfmon_capable(),
+ * This allows us to perform the check, i.e, perf_allow_kernel(),
  * in the context of the event owner, once, during the event_init().
  */
 #define SPE_PMU_HW_FLAGS_CX			0x00001
@@ -50,7 +50,7 @@ static_assert((PERF_EVENT_FLAG_ARCH & SPE_PMU_HW_FLAGS_CX) == SPE_PMU_HW_FLAGS_C
 
 static void set_spe_event_has_cx(struct perf_event *event)
 {
-	if (IS_ENABLED(CONFIG_PID_IN_CONTEXTIDR) && perfmon_capable())
+	if (IS_ENABLED(CONFIG_PID_IN_CONTEXTIDR) && !perf_allow_kernel(&event->attr))
 		event->hw.flags |= SPE_PMU_HW_FLAGS_CX;
 }
 
@@ -745,9 +745,8 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
 
 	set_spe_event_has_cx(event);
 	reg = arm_spe_event_to_pmscr(event);
-	if (!perfmon_capable() &&
-	    (reg & (PMSCR_EL1_PA | PMSCR_EL1_PCT)))
-		return -EACCES;
+	if (reg & (PMSCR_EL1_PA | PMSCR_EL1_PCT))
+		return perf_allow_kernel(&event->attr);
 
 	return 0;
 }
diff --git a/kernel/events/core.c b/kernel/events/core.c
index aa3450bdc227..4a69583e329a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -417,6 +417,7 @@ static struct kmem_cache *perf_event_cache;
  *   2 - disallow kernel profiling for unpriv
  */
 int sysctl_perf_event_paranoid __read_mostly = 2;
+EXPORT_SYMBOL_GPL(sysctl_perf_event_paranoid);
 
 /* Minimum for 512 kiB + 1 user control page */
 int sysctl_perf_event_mlock __read_mostly = 512 + (PAGE_SIZE / 1024); /* 'free' kiB per user */
diff --git a/security/security.c b/security/security.c
index 8cee5b6c6e6d..70cc9206e902 100644
--- a/security/security.c
+++ b/security/security.c
@@ -5610,6 +5610,7 @@ int security_perf_event_open(struct perf_event_attr *attr, int type)
 {
 	return call_int_hook(perf_event_open, attr, type);
 }
+EXPORT_SYMBOL_GPL(security_perf_event_open);
 
 /**
  * security_perf_event_alloc() - Allocate a perf event LSM blob
-- 
2.34.1

