Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BACA2FE04E
	for <linux-security-module@vger.kernel.org>; Wed, 13 May 2026 18:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778695525; cv=none; b=mK8X3V1XeM+bE3Uy7GjU271/YDb4e4JY2jsSVkX2s3wkrp+JJnDA+huvpCYS32S3wuzRn3oy0sdki0LUAe+NyK27EJa6GoqeRcsDSKFSiwI8c3/2BGeFHlra5f3vtaC6w9/Ivg4iYBlRdVQyu4punhq+OXdloGfJv+eoVD8ZNHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778695525; c=relaxed/simple;
	bh=FE8A64iidfVw4A2IvmYWSV7KY9NgQ3FU4Gd6q/jNYtY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GSuA642po6Dpp+CmD8qH8QP4xsAYD+oAvzHF8Z19/DgR6GzKuUKJ65ZwFB7V2/Hqhj3gkI51FP3JrcbhbItHy41Z+Ba7PQDjAxukNon+ITVJIsW4PeDHzGzxgOSrbm2LnS2FRRRmTavOxOaK8wRzenzqLLJf9S65u/lSlBMp+cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YlHEiF38; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YlHEiF38"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-575267e3398so4954049e0c.1
        for <linux-security-module@vger.kernel.org>; Wed, 13 May 2026 11:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778695523; x=1779300323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uHWxc9xR0xx+1aooy6fDyaqeRR6HlXhTTExD4xHXTUA=;
        b=YlHEiF38RFdG8LkHiHd67pUrDkjGzZK6+6RRpTNkfFvfJCAc/ZZ92Ne4aJturuHF99
         meSD0DXHp981tPbUzrlc0d3ugknByePh8uf3Kznt+DpX59uUWyasicYDY8EZUIq702Iv
         romyh0XDLR3wUBJpHvtAsTDbDEsHq5ZqiJ8o03Iktb+k6buFZ1HEdHIyVS15vqtvohJf
         vs1qRN3wqpoZjCnBkdqWjgYYCVfYLzpmtoxlFbcikWiE/X98s7tSkVBOXHkIArMcBSqK
         zXracIwlQ/v0nQwdRx22FSgGhtOFpOuR0MkEK3OPncpAQ1l4ZTSFjllUy8CHkHmUIZB6
         t8gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778695523; x=1779300323;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uHWxc9xR0xx+1aooy6fDyaqeRR6HlXhTTExD4xHXTUA=;
        b=eQtZ7KpXTuZuFqiTFTKdQqTLSiahFuYc5JRmtrvJVZFdpCDE9bBVkfyWJ1tTxVZ9Py
         RS6FumZ+w9T9zYOhY3LMlz0aeOkW7rPwjBWGojO8a+DmugX9vKOntglbhqVsBoUd1vDc
         jTHjSY9mbgcoMrVlqUAQHYnvVDdl+9iR2DhL3D8PEDEPr+yEN2m3l8iKqczJB+JJEK+N
         qlNcnny6IIHLMkiB0gsHeUbgWqgVkfHBRzYZq93d3A0oprq2tV/UPLAO9HJiC+LcAyhP
         KIuT7PAFiQXKbGIc1BdOzk3WHsvqITNj5dnxakMvAkqrb6QHwmvx5OV2Lp6TPhIh0IJJ
         TS0w==
X-Forwarded-Encrypted: i=1; AFNElJ/CqEEAEzqSIFh1HCtxXdMwKRw4AsYRbkspNu+/Hbhz4qYXJaf0Xl9K88INyEAlZCWqG36qE2/sGNaN6iFCzt+8X1burbc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2r7n78Ywha5ThnXtQt0/djSe3WIN8WTgKfwTaFyeFknGvLrwP
	ACwWasXBeGSYM1kpZkc/hubq8S8AD4t6yHuRVaLmDleITYHuM5FONwzE
X-Gm-Gg: Acq92OFHawzV7lKWPUIMTN83t8VQyjhK7CMRNMhYnCqmqppfIGCK3hw2QNqauWYvdyA
	T/XPzGfMHyGDJpG1WlRwsJ7IDILodw1Y0Oa0AMJvDqVwN22MzVsz29W2O+XkXoFgwSzf+BZBAmh
	pgScyuIHCLbR3pci5fJNwynnDacZtnRJD1A+oLzxQRtRb3TGCWU9Qm11pybcsRJK1ilImHZd3YA
	gQB74vROP8qI2o7Aun6BAZM9pBVDrV9uD43reknDrhctMvuslvMdzm7yyIFXTGgw9TwoNPsZWQi
	qSfLdvY6J6ZpZGoenUQL4CbOvS4shejRiAdWWaVvtHqqOb11fGTN7jCoUwRf0hY1q8HJUA9yT4p
	2ARjjV6jcNERz73Em2CCyIdjK/ISOjYb5dATx+K++QD4EyAh+YiHF7fx7uQRniIcxMClHaSd8MB
	y4QmeYhEn6P7QhmT174knHIYxKzV6H01Fg12PFJhwNO/4o5rXMIEJaU5zGr1FFyEE4nj+gZjXg5
	oT0JiD+M87eirroql9OqKWYKJcNutZmZazAScBGAqcSkBcLa+gRNGQWWA3bIlJ4JcKRT3+8D0Mw
X-Received: by 2002:a05:6122:6187:b0:567:4e8a:fb13 with SMTP id 71dfb90a1353d-575e6fc03eamr1897242e0c.8.1778695523093;
        Wed, 13 May 2026 11:05:23 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c908562931sm2523326d6.3.2026.05.13.11.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 11:05:22 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	casey@schaufler-ca.com,
	serge@hallyn.com,
	john.johansen@canonical.com,
	linux-security-module@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] lsm: hold cred_guard_mutex for lsm_set_self_attr()
Date: Wed, 13 May 2026 14:05:06 -0400
Message-ID: <20260513180506.760657-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Just as proc_pid_attr_write() already does before calling the LSM
hook. This only matters for SELinux and AppArmor which check
whether the process is being ptraced and if so, whether to
allow the transition.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Acked-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/lsm_syscalls.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
index 5648b1f0ce9c..08a017669c02 100644
--- a/security/lsm_syscalls.c
+++ b/security/lsm_syscalls.c
@@ -57,7 +57,14 @@ u64 lsm_name_to_attr(const char *name)
 SYSCALL_DEFINE4(lsm_set_self_attr, unsigned int, attr, struct lsm_ctx __user *,
 		ctx, u32, size, u32, flags)
 {
-	return security_setselfattr(attr, ctx, size, flags);
+	int rc;
+
+	rc = mutex_lock_interruptible(&current->signal->cred_guard_mutex);
+	if (rc < 0)
+		return rc;
+	rc = security_setselfattr(attr, ctx, size, flags);
+	mutex_unlock(&current->signal->cred_guard_mutex);
+	return rc;
 }
 
 /**
-- 
2.54.0

