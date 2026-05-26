Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27A536AB6B
	for <linux-security-module@vger.kernel.org>; Tue, 26 May 2026 15:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779809752; cv=none; b=tPE4zCe9GQRvG0U8/eU20M0LniXCJN7ZVW+M192D/EVzY/5oyZNcxPX/6Oez8Gma369kpkf7I6t0uqgECzeKjSDku3+Odbr+cYSwVgq9wH6X/1iD3CvBYbRgXTWRxh8mPuCnmfsPtzl+oVWfTZJscW1VZchuqJL8YRE0GlZGeXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779809752; c=relaxed/simple;
	bh=BdrCyzbp+2MqB2Q45Ge3JlLUe63MVsEBUoIfS6DNtWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m3SuqUay5ggacMqyjP6nWPi7gqSnCKxXQqUTihEu0SqG2HYbPa/mQL/kRbt379UAP/xgRrm1IszmmJ2gBomFEtbqGEhA2NWHYGmF199GlAdBoq62xK42xQVOrt14s3B3JndOOgZqvTibHN+v9aV6UsHJVuUGl8bfaSSDffJh5O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zetier.com; spf=pass smtp.mailfrom=zetier.com; dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b=Pus19jnN; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zetier.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zetier.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b="Pus19jnN"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-91080895355so1223521285a.3
        for <linux-security-module@vger.kernel.org>; Tue, 26 May 2026 08:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zetier.com; s=gm; t=1779809746; x=1780414546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FaDmpgG4YmKy0EzLVmDS2/ARG0WGlq46PT9Krk/q/WA=;
        b=Pus19jnNWL+jgBZsnVAC/QriICxVXNYCkJ/1EbAFpa7cjpYKFLaTao9qJD5mGnOb1P
         aGJ8EHyl4CG9wyvp8Sn5TcOfnaCQz3P+EbEyxtriUH5d/4SdknWFRDCemRLa9FEMm7DD
         U4uaM9cckmgmJ9ROTrx/zuZG5XqAYieYfTPT6GwkvC/XCrc1GKLDbavUeO07MtVxBFhH
         sH/QtyBD3SzKpAi11SEqQA0/hPq8lHw/AOCnk49DKj5aCSTZg2hJfWWnyzw13XKGZOxk
         WTXJ4H0pVAvjFbWA+LThoeqW7S3bZ4OyD0iyFxHSJyL6QzwL3V1Ic5JGm2FmsAgcbCRE
         lNnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779809746; x=1780414546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FaDmpgG4YmKy0EzLVmDS2/ARG0WGlq46PT9Krk/q/WA=;
        b=Bx3WLZCdiMHneHjHdhfiPqGNQ/QBPjEc8ZIFARm5uBpWe1M9NVMhUKqWfHRAm9sPmw
         jVVteZ5+CQxtQwgDwszo3VQk2vRh/sUGwG3nJiJTRxcfK3viL8DChGvSoIqz3UsHF7pJ
         1Hjx/731nA9uda+4tfbCs48qKFlv1uAnE355iraJ7LudCyQuGONoec+kqv0fZP8eGjII
         bNdZWUMvd52oXS0dLUl64M4TZH5OmrEMbEyyy1WurD8AvvHewt7+AYXq5ZOo2uF8X19j
         7JZg0RuRicl/9l1REFCZm/lelJuh+nUZ5AL76yEFg4kdL2jCorNnMQmf88gOtEByTKAu
         QOxA==
X-Gm-Message-State: AOJu0YwaHWSQrE1QQf/exwwtO3oJSN1yWgu0aj1P0ko+8wx1FTvpFOU9
	1f/trx2CMrRF6v3DEeYdfEO8USVmwiYlz0GpIt1KX5Uk3lSd8fqPsRO/AEP4aN3xwqGHwj38Ubp
	1XqFRTCU=
X-Gm-Gg: Acq92OFuynkeJBT76jJPoxeF+SoohM65TXmWbVEJ0fbPbGy9IaIhQvjyfZQ3udsM2je
	nJ99RvDQOygeEf8Sw1hqIeYHuBLQ4+O93NNpE6DiGKargfCoYpPAKBufBQbmmBwuRd7P/D7e2Yh
	XM6iQHjriylZaMuicq9bz62TOSL92AZFx21jMlrB70GJXzs4PRxD+y2RBrAddV7vHD2aTJrVBmZ
	kq9SNf5yX7NIFP0GZlv1D30luEKYcoR7DO8eZ+krl8pXF70T15OFk3rCgLRGg3MtQ9MM44C5fVf
	YxZMjSEVvumBHTL8tYSXBl1BfzU4r8wIwYZOSIrdqznrHr/DXKNEmA0kBAB0auOv1P7zxs6vgu4
	GjzA5bQFbAWQ/a+mlX9BsjOZnGDLlWCGbeURWIhr0BhlTQYN/PTxs89EdhgaPzLvds3N9NRekeT
	v9Z9iIQDvAeB7ofjHmhYrig4Mu6RdCzybaN+h54WFxX48IAJFsn2q3b18qJ+m61JdGyrWUtMJY6
	0ubnovDWg==
X-Received: by 2002:a05:6214:5c01:b0:8cc:ec7:72c9 with SMTP id 6a1803df08f44-8cc7b550894mr321270736d6.19.1779809746352;
        Tue, 26 May 2026 08:35:46 -0700 (PDT)
Received: from warpstation.incus (107.191.145.34.bc.googleusercontent.com. [34.145.191.107])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc80dd02c1sm145053886d6.6.2026.05.26.08.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 08:35:46 -0700 (PDT)
From: Ethan Ferguson <ethan.ferguson@zetier.com>
To: kees@kernel.org,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Ferguson <ethan.ferguson@zetier.com>
Subject: [PATCH RESEND 1/1] yama: clean-up ptrace relations upon activating YAMA_SCOPE_NO_ATTACH
Date: Tue, 26 May 2026 11:35:42 -0400
Message-ID: <20260526153542.105483-2-ethan.ferguson@zetier.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526153542.105483-1-ethan.ferguson@zetier.com>
References: <20260526153542.105483-1-ethan.ferguson@zetier.com>
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

