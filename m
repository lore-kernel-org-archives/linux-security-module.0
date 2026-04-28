Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F016D47AF6A
	for <linux-security-module@vger.kernel.org>; Tue, 28 Apr 2026 19:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777404547; cv=none; b=YJlpAtzFO9/y13UALWWxtc7w0/P4gywiD2q0R5KEXrzlIPismeykDuXf94nacBzOHN7IzHauPU3Ek8fgtmfSQmKk9FG1zFZQiqcZzLcI2G+s0jUYUEmJyPHiSSU9AG2Q6UVYhPVLFLTT+S9s3Fi6q/TsMiNXNG/b0iCLsuLylNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777404547; c=relaxed/simple;
	bh=BdrCyzbp+2MqB2Q45Ge3JlLUe63MVsEBUoIfS6DNtWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oYt1que+uH0Kq4lSYnLcvS/Til1o+XdmWhUTkP3c/Z7PpjiSxzWKQBd5HgzLwIEtDDd8zw3uTwKaOHfW6bE32pJ5ut/NiqzXf5OHihSQh9jCXzNZZV1STQMEyJRi4V/sBrcUpl4JeeLxSYWMhLXVG1PBWHyZhzaa4TmiNG6w+L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zetier.com; spf=pass smtp.mailfrom=zetier.com; dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b=NOm8yQ84; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zetier.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zetier.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b="NOm8yQ84"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8a4b8c3a30bso133300586d6.3
        for <linux-security-module@vger.kernel.org>; Tue, 28 Apr 2026 12:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zetier.com; s=gm; t=1777404545; x=1778009345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FaDmpgG4YmKy0EzLVmDS2/ARG0WGlq46PT9Krk/q/WA=;
        b=NOm8yQ84G2EQvDYz7spOcB/JOgP3rLLdVujUxfiX85SJe+txBtWht6BTAkCU4kb90c
         /kca7u5nBmgxx/mhuKmaj9NLo7DWOJ0of5I+SZh54oSbDd5flY+hNBnoeH2kXWta5KSp
         z9MpRYDjLDKFPD9Ar99ytsh7P3Tz9D+FPAZoXWHhHwSQoFtnNd45XB6csS0yMDtF+8vv
         KXIAHCzzne8B4ImKmc9vIQuLuEYtpz24gjxDO0pVbYobliGY+0k4Dn9JDem8AFmS9rIY
         CxxVTzW6clvbOd3+ae/kBNRT66leb69iTZSlPO1CyfRQwaPGqVlLqC4CXTvYNSIi7gm2
         hz/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777404545; x=1778009345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FaDmpgG4YmKy0EzLVmDS2/ARG0WGlq46PT9Krk/q/WA=;
        b=elvUiZaTo/scN0path0Ay67zlQCDdO7AqK6xV8lXtDFK2jAJBMPVwqYejG0uciQJ90
         dl3oT/DboHN/4ddJV/66GLuR1x7GubcHWmGvFCdtQUpYh7DTMEBw9PZUnT/agtxzpNEi
         XXYUovXrxHF3FzwLB2ogOw8j3qDbJ9CoEQBhaMxVkCye2L+qS/TmsxS0dTQyUdnmfc9D
         aKpsMbqj6z8N8KAMoXvEBoT2IZOo+e/MC414Hj/fkhLFCLyDbF6J3sS1/99tPI7wUBXn
         wyU3OgggKoT6quUtdxL20ibB9gCYl5M11l2LODDvVnksH9UV51LgrUvSLduJamjz4NSa
         ZhnQ==
X-Gm-Message-State: AOJu0YwP8VlL62axVow3ObD5P7pZzhc/93WuBHG26GzMwindzLVsWjGa
	PzdvLnSepX1lkcYuQYSTjrjIG5+oyf6rqNS6Tf/GYV95RsCounm0ySUdY8ceDykXE34=
X-Gm-Gg: AeBDievkxElG+76HfQ5GEPz3xSHSR2jckntOx0IYlYPVm/CsW+fLzqYDLg19orhtYZh
	GJ+IZI9BsDGTkLjyEGtPZSlLuykD7nFoYou0KNa1x10lJk+pxb05d0/vEoPsCzKIxTuSCayS7dB
	EGI7gj54pjNVuz9Y+elo+EIdShNLeI4lXUp2Rd1wXlEFf/wUB09qIpucCBth+gnGuXQCktQSZ2t
	Kqw1IWHk+Bthx3n9ERPzL1Cy3WU7aV3i6VmUjpudiIhF4XXN51ULcnaIWPJ7oDmZicuUQMpyM1q
	G6aGZKyjsxqPhhyjS3TGmruWppVXfuESDnIBOWouWtIf3Wam2pqKdBygHWmkOaLvk4/0OOAC+2A
	r7YQ0l1z22G00PTHofhhUXGuCBcIGyrokulOhi1S9VSJ7/m7h1QNxCI9qm2qxDOC8ftYKvVuML3
	PGJY2rM9cKI27lKK6UZs8cQhuzNGLHOYXOGxEaAlijnRikyhDOgFAaePVmPEQ0gn+1d8n3LyuYO
	cBTChUjdlga6HqaxfRLn9QSxw==
X-Received: by 2002:a05:6214:33c8:b0:8ac:af33:a236 with SMTP id 6a1803df08f44-8b3e3098287mr76207046d6.35.1777404544822;
        Tue, 28 Apr 2026 12:29:04 -0700 (PDT)
Received: from warpstation.incus (243.69.21.34.bc.googleusercontent.com. [34.21.69.243])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b3ee9cec79sm1922826d6.15.2026.04.28.12.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 12:29:04 -0700 (PDT)
From: Ethan Ferguson <ethan.ferguson@zetier.com>
To: kees@kernel.org,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Ferguson <ethan.ferguson@zetier.com>
Subject: [PATCH 1/1] yama: clean-up ptrace relations upon activating YAMA_SCOPE_NO_ATTACH
Date: Tue, 28 Apr 2026 15:28:18 -0400
Message-ID: <20260428192818.1035760-2-ethan.ferguson@zetier.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260428192818.1035760-1-ethan.ferguson@zetier.com>
References: <20260428192818.1035760-1-ethan.ferguson@zetier.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clean up ptracer_relations upon YAMA_SCOPE_NO_ATTACH, and prevent
further modification by processes.

Signed-off-by: Ethan Ferguson <ethan.ferguson@zetier.com>

---
 security/yama/yama_lsm.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index cef3776cf3b2..3b7c5384e6bc 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -26,6 +26,7 @@
 #define YAMA_SCOPE_NO_ATTACH	3
 
 static int ptrace_scope = YAMA_SCOPE_RELATIONAL;
+static int max_scope = YAMA_SCOPE_NO_ATTACH;
 
 /* describe a ptrace relationship for potential exception */
 struct ptrace_relation {
@@ -119,7 +120,7 @@ static void yama_relation_cleanup(struct work_struct *work)
 	spin_lock(&ptracer_relations_lock);
 	rcu_read_lock();
 	list_for_each_entry_rcu(relation, &ptracer_relations, node) {
-		if (relation->invalid) {
+		if (relation->invalid || ptrace_scope == max_scope) {
 			list_del_rcu(&relation->node);
 			kfree_rcu(relation, rcu);
 		}
@@ -204,7 +205,8 @@ static void yama_ptracer_del(struct task_struct *tracer,
  */
 static void yama_task_free(struct task_struct *task)
 {
-	yama_ptracer_del(task, task);
+	if (ptrace_scope <= max_scope)
+		yama_ptracer_del(task, task);
 }
 
 /**
@@ -224,6 +226,9 @@ static int yama_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 	int rc = -ENOSYS;
 	struct task_struct *myself;
 
+	if (ptrace_scope == max_scope)
+		return -EPERM;
+
 	switch (option) {
 	case PR_SET_PTRACER:
 		/* Since a thread can call prctl(), find the group leader
@@ -432,6 +437,7 @@ static struct security_hook_list yama_hooks[] __ro_after_init = {
 static int yama_dointvec_minmax(const struct ctl_table *table, int write,
 				void *buffer, size_t *lenp, loff_t *ppos)
 {
+	int ret;
 	struct ctl_table table_copy;
 
 	if (write && !capable(CAP_SYS_PTRACE))
@@ -442,10 +448,17 @@ static int yama_dointvec_minmax(const struct ctl_table *table, int write,
 	if (*(int *)table_copy.data == *(int *)table_copy.extra2)
 		table_copy.extra1 = table_copy.extra2;
 
-	return proc_dointvec_minmax(&table_copy, write, buffer, lenp, ppos);
-}
+	ret = proc_dointvec_minmax(&table_copy, write, buffer, lenp, ppos);
+	if (ret < 0)
+		return ret;
 
-static int max_scope = YAMA_SCOPE_NO_ATTACH;
+	/* If max_scope was just activated in this call */
+	if (*(int *)table_copy.data == *(int *)table_copy.extra2 &&
+	    table_copy.extra1 != table_copy.extra2)
+		schedule_work(&yama_relation_work);
+
+	return 0;
+}
 
 static const struct ctl_table yama_sysctl_table[] = {
 	{
-- 
2.43.0

