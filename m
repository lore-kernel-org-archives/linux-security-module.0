Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC161B652E
	for <linux-security-module@vger.kernel.org>; Mon, 11 May 2026 00:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778459188; cv=none; b=kDOBDPw7ZabxwSZBrSuiMLULGYYi5O1bv4V3YwsJTuUqrWbJc97Ddm72dEJ5Ne+jlpOjnTa08JHX6vbOpH0vDMytcplxonMASlgP+0THRtMiUrOs7+SprqV+IkyX6TgYwaYw68RxY5hutqPVuAEwGsMFYNTe5RKmZyzHgz/PnBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778459188; c=relaxed/simple;
	bh=Gc4BjbjAkK3FN//bnqQVa2VmsEh7oqkZB4y9TzGJOhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K/e5qcp+GE3IgMOFSqfs9Zw+CW1aj8E1fgVtJf0QcHgtxoS222ci5TKWvFxcxOk3rhTOvfNxenxMWz2B07AC0Uql8LcuDP1lWYV+NHPTE+5B9HbKB+XUfl5+2r/aXvgTD/TGVpRZvIio8Qtv+gbB1pRseOsvfRvV4qygDMOAPHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=MLA4d7+6; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="MLA4d7+6"
From: Konstantin Andreev <andreev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1778458642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sy+plRig+Tn3dZToCkzxhLMm5c6emJqjSL3afGeeR10=;
	b=MLA4d7+6rXpBHQep60/3ItVCZivDQ6utxtIBy61+Jpr0OD1mAGM0YLx+xPK3lI6lIsiHm9
	SaXP6pPFOhYyeWHVhBNmFUE15u6jaw5fcFtWrWy8XZfHa//m/7s+rk2Vx79VVPNPsR8Q14
	ovCRnItAqalgqaHEXI5H8RQtQShRalk=
To: casey@schaufler-ca.com
Cc: linux-security-module@vger.kernel.org
Subject: [PATCH 2/2] smack: show msgrcv() subject task in audit
Date: Mon, 11 May 2026 03:17:17 +0300
Message-ID: <20260511001717.3522345-3-andreev@swemel.ru>
In-Reply-To: <20260511001717.3522345-1-andreev@swemel.ru>
References: <20260511001717.3522345-1-andreev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When a task msgrcv()'es some message the SMACK audit log message
looks like:

  fn=smk_tskacc_msq action=denied subject="bar" object="foo" requested=rw
	pid=456 comm="mrcv" ipc_key=2
  fn=smk_tskacc_msq action=granted subject="bar" object="foo" requested=rw
	pid=519 comm="mrcv" ipc_key=2

where pid= is a pid of a “current” task which calls smk_tskacc_msq().
Usually, the caller of smk_tskacc_msq() is also a subject task
which determines its own permission. In the example above
the 'mrcv' process has label 'bar' and wants "rw" for label "foo".

However, when sender task delivers message using

  ipc/msg.c`pipelined_send():
  ` security_msg_queue_msgrcv(,, msr->r_tsk,,)
  ` smp_store_release(&msr->r_msg, msg)

“current” task and “subject” task differ, and
the “subject” task is missed from the audit message.

This patch adds two fields, subj_pid and subj_comm,
into the audit message:

  fn=smk_tskacc_msq action=granted subject="bar" object="foo" requested=rw
	subj_pid=564 subj_comm="mrcv" pid=577 comm="msnd" ipc_key=2

Signed-off-by: Konstantin Andreev <andreev@swemel.ru>
---
 security/smack/smack.h        | 1 +
 security/smack/smack_access.c | 9 +++++++++
 security/smack/smack_lsm.c    | 2 ++
 3 files changed, 12 insertions(+)

diff --git a/security/smack/smack.h b/security/smack/smack.h
index 9b9eb262fe33..551fcf2a1832 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -261,6 +261,7 @@ struct smack_audit_data {
 	char *subject;
 	char *object;
 	char *request;
+	struct task_struct *subj_tsk;
 	int result;
 };
 
diff --git a/security/smack/smack_access.c b/security/smack/smack_access.c
index 350b88d582b3..fb85356266e5 100644
--- a/security/smack/smack_access.c
+++ b/security/smack/smack_access.c
@@ -331,6 +331,15 @@ static void smack_log_callback(struct audit_buffer *ab, void *a)
 		audit_log_format(ab, " labels_differ");
 	else
 		audit_log_format(ab, " requested=%s", sad->request);
+
+	if (sad->subj_tsk) {
+		char comm[TASK_COMM_LEN];
+
+		audit_log_format(ab, " subj_pid=%d subj_comm=",
+			task_tgid_nr(sad->subj_tsk));
+		audit_log_untrustedstring(ab,
+			get_task_comm(comm, sad->subj_tsk));
+	}
 }
 
 /**
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 3146fa83c2f1..6f6ff9b20981 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3383,6 +3383,8 @@ smk_tskacc_msq(struct task_struct *tsk, struct kern_ipc_perm *isp, int access)
 #ifdef CONFIG_AUDIT
 	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_IPC);
 	ad.a.u.ipc_id = isp->id;
+	if (!tsk_is_current)
+		ad.sad.subj_tsk = tsk;
 #endif
 	rc = smk_tskacc(tsp, msp, access, &ad);
 	rc = smk_bu_tsk_to_obj(tsk, tsp, "msq", msp, access, rc);
-- 
2.47.3

