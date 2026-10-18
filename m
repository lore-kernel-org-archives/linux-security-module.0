Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD7A3876A0
	for <linux-security-module@vger.kernel.org>; Sun, 18 Oct 2026 17:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792344741; cv=none; b=AFfHIH3j1T7jDtkrAdou1Aw4bpGc1N5rvrbKdi4/zgVkV2LBaEhgpOYx6TKWHkTXQSACVXhsMHGtFccc4tWO2j9HscmDn6uI7vJyX15qrPiJIVi60NN/eh2a/qJ2egXL/IkSossDkXNuMXojUVRntN/ybA0hRbCtjfyVTcypR58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792344741; c=relaxed/simple;
	bh=Fm+cRLeS4t5ddn+JG6oKLSC9A3Mc3gcFY0ot6KNwFA8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sJhI202TiNyNIKRa38XUSxx8gTALGQCD/YTNtwSEirduME+T7nvM7inN6R/FdRRV+gPtgSMoJf7c+60Ee34khxLqZpGowFKrJ6CXspQHOnKkDg7XsQ6MkOZVIeao5J74JG3JBE7Qt98RyLSVG+2Uc13zWftlBluceRD0t6fB7c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=FDOU+b3R; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="FDOU+b3R"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-93e515769d3so138655485a.3
        for <linux-security-module@vger.kernel.org>; Sun, 18 Oct 2026 10:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792344739; x=1792949539; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CX6iIo8beeffrx+MtR/k+kH5XMbnSUxQ/RD/PAMaWFc=;
        b=FDOU+b3Ribt6Jjdh4rYUT0gsa1PX3SUi/MWw60jaVTA2X8cLyeQl5W6x0NNIltJiIT
         DiAYd/8yvTfIH3sUqdLkA7P76qtZ6V5LvlzIFhtK44cdNZjYlirgTBxkQJay9YQR3wEt
         J0vmsC3a795bxDZt7po7U+ChpOJRXsvD8dDbV752LhmxlgaAbIEjpTCdVUXCTjmy0w91
         B/VONT2NnGeG0p3Lw6yCoo+CwG5JsjI1bTh2jhRo5nJvFup399/HAicsRBfeXYWjBTYL
         X7CEzdlCqcNt6b0ToEDyF8wUKg+WTQEwZLjlnk9tjpiSNYQoxAaCD86fIATPsw/0nLF3
         ch3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792344739; x=1792949539;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CX6iIo8beeffrx+MtR/k+kH5XMbnSUxQ/RD/PAMaWFc=;
        b=zsMwVIIb0TDBSbFaDHr/Na0hrWG52wRHaS56WZkrskYIkAiR8X3FT4Avur2C7/TKY0
         OqONprXL1hz3KJGIEJflNulATs+RvRtFCrrYnH4jX5evPEBulxxvvhXVl50lFlVqPBwW
         ypQerhvotGiJLNU7kY9FT68qWIVijqJzXZMhzYbCp6hFIVZk5KyKlz0Tgrh1WjdKlwRB
         7ZDt92ugHcua503Y8wlDG9aNFbdyuAJUUUqttxSegBLW3kmmsGOYHHtt7feWU5NqD9X7
         tuflWsz6sPlCB+rpX/Svivbviq48WSGs4/a7KctsQ0u4ps2i6tlLTOltA2XNMQwJo48g
         mHMQ==
X-Forwarded-Encrypted: i=1; AKwUvByjd2DOeeEgQMc7768WYp9MFf8djCfcK8bXaELx4rPtsxl6klmSlm+nO/zRl9Kyi64YyUVvHg7Tah/sexKnZ8wkoOEZYHA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIX3ziY09Zyo8qXw9ANQeTK5zQK2Qpq3yfZMy0vQRvjpr5g+2Kl
	XCUvHBSay+Apv5BJddWrYdGeA02ISFIEma48Kn2YRw5f0sv/FH1PqmzAsu6ieqy0k4haWI7mVn/
	vD6vx
X-Gm-Gg: AYBFou2/wHEni/6uI2OjLwm7Idt1fM+Blo4LL2jjaTasPViBJfEl0VlLq5UIiEtsV59
	X/y4rP2ntaqaYeq4RQWRpB+TI7psIl9gotw1uEITEuPvvBFrFJOSJBmbkF4eqk11jv5vKDDSLCr
	XXzmK7blyuoyWLu6y8lj/0ty5brWLjj/NAx8XGd1NyNReX1XUXJu76WbOKOb1YQXjj6i37Ip3j0
	W3mD40JRBziCjiS65SSJOL2lP4U/uk8H+Jt4kU3tg8WGTLX/QWf7U+O0oSH30ZU3aqMHicpGVt3
	63EyHMt4gY4NXwkTkzgLQ4EPklGJgiyopvlBh5xVCMG+3LlNLSNNrDEC9arY4z+H8Mu7KbaeZji
	NDardvVJi7Wt9fsKhLjLjPu2gCz5M1LAcdP5WQuvensgqw72OtesCR81XMcQ17+Hw/bZjif6mWG
	o1D6JnoXno9ghg1BSRfu6+UEorloZOb+p3dwCrQf2e2+gZJxAMTmTFDr3UWdk9RaUsVeysOhKze
	tIF414FSkBvZgk=
X-Received: by 2002:a05:620a:3703:b0:93b:c537:fdb8 with SMTP id af79cd13be357-93f29b9827emr920380685a.6.1792344739067;
        Sun, 18 Oct 2026 10:32:19 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.243])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f1fb55fdcsm662610085a.39.2026.10.18.10.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 10:32:18 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Sun, 18 Oct 2026 17:31:52 +0000
Subject: [PATCH 10/13] cgroup/v1: use cred_ids_allow_move()
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261018-b4-cred-ids-v1-10-7bdf2db4ea9f@toxicpanda.com>
References: <20261018-b4-cred-ids-v1-0-7bdf2db4ea9f@toxicpanda.com>
In-Reply-To: <20261018-b4-cred-ids-v1-0-7bdf2db4ea9f@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>, 
 Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <sergeh@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792344714; l=852;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=Fm+cRLeS4t5ddn+JG6oKLSC9A3Mc3gcFY0ot6KNwFA8=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QBZR+7JnLsOWdBe/3l+8Kuc8aLdBmIcVv/widSHOm9EANYHafg1VL578keu9PHeWuh5pDsmupXq
 XJtfV90Raww8=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Use the library in __cgroup1_procs_write(). That euid 0 may move anybody
is part of the rule.

No functional change.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel/cgroup/cgroup-v1.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index a4337c9b5287..c6b0f67b4817 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -521,9 +521,7 @@ static ssize_t __cgroup1_procs_write(struct kernfs_open_file *of,
 	 */
 	cred = of->file->f_cred;
 	tcred = get_task_cred(task);
-	if (!uid_eq(cred->euid, GLOBAL_ROOT_UID) &&
-	    !uid_eq(cred->euid, tcred->uid) &&
-	    !uid_eq(cred->euid, tcred->suid))
+	if (!cred_ids_allow_move(cred, tcred))
 		ret = -EACCES;
 	put_cred(tcred);
 	if (ret)

-- 
2.55.0

