Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5653F0A9F
	for <linux-security-module@vger.kernel.org>; Sun, 18 Oct 2026 17:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792344735; cv=none; b=LFeCYbZpktKFZvigSLQVhE7FZ3wc7vMsVbsxM/tylVHcoszmcdy0HDL/7qAcRwOgSsDZ1atbn3/V1MlHgYPWoqeLdGjkpUv6mKOA9XkUX4BKhZzD0Tm+e8VdfKNQBVB4cdYoR+7RUQk90cQRtXU+2A8SIh/nK9JDicFqdfTzAy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792344735; c=relaxed/simple;
	bh=ygQVGiHSjT3tlHXRhpAp7oFN6VeF+Ph6/YpTvlB2qao=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RLoUMZXZzrx+AJHLf/8tCN4oVer8EXXWmyv2lazwzXFTbcZJsKVHZcBnV6ETcwFBYBm9MkBkN1+vpwOvQsaILx54lEJJvUsPyYaWefSG0pkYG+3dD5Go8O1V+c/si/1U1rD6SwSiLRScEZ/fAtOyeMCgdx06qhS+XTq9SxK+GMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=jRzxDwpS; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="jRzxDwpS"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-93f22a8515eso138694485a.2
        for <linux-security-module@vger.kernel.org>; Sun, 18 Oct 2026 10:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792344733; x=1792949533; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8lvj9KPlOdCKDh2SaywkpdHWEJMa5bSU8/Juqep2VFU=;
        b=jRzxDwpS4QFIeNa3t3r4R3g0dnYHcvl1oMlcY7guyN59yF2ifnwE2+yQFMCnptaF2f
         FMOdUqKpmNqodKPgfE9aeIlCst4ypWNReve96w2zidoNsoMgvlrZ62tDSAZkoAnUkHrS
         maZKVMl9OB3gUHfVTABLM1WlwFr23O5Vr6i3uLIQOPgxQD9AoqAZeHsqsExVRz0BHegX
         U42B/Z/pIuznJgk4dtOw85ED5gyGs4QLxQ/UDDr06Gc8MFVB8/zNm1nW9Wy2FCjtfi40
         gX5nTSKOIR794rD8+bjyIpXQuVQz9XvIxPNNFa4TogJnhOcylSKe31U8To8ibZVlLIJ6
         kAEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792344733; x=1792949533;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8lvj9KPlOdCKDh2SaywkpdHWEJMa5bSU8/Juqep2VFU=;
        b=hKHmynFuf6dgs411HNswo11Lfv3+0FXI+EdGVWvLLJOdV5Bw0BwGgzxdoPdIIFR9MV
         4+nJ+XHkZ0D/9cnEZljQAr26zbLSrYnqJTq1l35krU1QYupKan3l2o8RTK8HGkzSOjjJ
         SpMpzned10okjl054/T9DM6Ku2cf0L0SBqt8OBIiVtidbgwC4sFojxjrmZi+r9uF1q69
         YnqJ26ctcH3j4lChr87uS8CXKNPaRuUqRW3sppA0kFle4Y3wbvEhPnDoCauNE22GqQqu
         DAlwP8bIIFEdUFpVFZiau1KF6c69KllHf/NByaAslSt5jhBCacOF7EsrnZgKbSMVZSDc
         1mdw==
X-Forwarded-Encrypted: i=1; AKwUvBxhSxj5E/LYX1aWYcypQj5FKQEWg7ruAvyIWzozX34csxrvd5dyz1UYOl8hBkjhcrX5A1DqhZX4Mse8EAsGOczmva177l0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJjrlrC23y0zvDXXR3gT6aiMhyKJBRWz6MwqVcJ+FL3vxksSwxw
	tuP64brpSDUX0P9m7Wtla2SfUJasEgAuYDBT8Posolz5oHisLqmzoRNBFcVuPySyQBIRTfQskUl
	Kzx/t
X-Gm-Gg: AYBFou1TRjbWaOY8qG6d9anihWsywnXfUE/9HwFB2L1/3W+b9eDCHO3fepnwEViEDjf
	43la0exHnKf8EbTdVHxvVqD9q6Fzfxgbjlq/QLEIBg80RlXfAEOKpTq6qopbnRjJtTpdAA3V2Ub
	dfLLsHgWg9bwv8WvjRUsj8Ymbl5kkjY7zYangjAZ5DyiDcxn7LQJjgjQq92/e7zGhHLuyxDxJD3
	yBVAIygRJS4BrK/eUlbqkqrCQGAZD/SbZTk57AcFMFIE9ShZg4N4tsbabtHPvu/LiKWGYItLDls
	OaCi3DFmPSJBymXThr55XuQd4d0hzUVDUoAdeB3fpbj5Lccmf0+tymUXRMVNKNgrKLaFXOCtGJc
	InTTIv1WHZCuUNkEOSNLmJwKfg0wLsUbin7Q+ccACQO8z5UNp+vpK5Q8GOmawvHZjUVb7bruHNc
	9C2JzScGRQ89EV/00pO0/h46BwlZY/atjMu/r0Y7xUTCuliyXhCevme10GReCVvkbukd8fEgoV/
	H5yadcfeHsdKvs=
X-Received: by 2002:a05:620a:450e:b0:93e:fd69:9a93 with SMTP id af79cd13be357-93f29ce0b58mr1042282785a.31.1792344732608;
        Sun, 18 Oct 2026 10:32:12 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f1a192378sm750188085a.25.2026.10.18.10.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 10:32:12 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Sun, 18 Oct 2026 17:31:50 +0000
Subject: [PATCH 08/13] sys: use cred_ids_allow_control() for prlimit()
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261018-b4-cred-ids-v1-8-7bdf2db4ea9f@toxicpanda.com>
References: <20261018-b4-cred-ids-v1-0-7bdf2db4ea9f@toxicpanda.com>
In-Reply-To: <20261018-b4-cred-ids-v1-0-7bdf2db4ea9f@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>, 
 Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <sergeh@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792344714; l=1001;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=ygQVGiHSjT3tlHXRhpAp7oFN6VeF+Ph6/YpTvlB2qao=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKizJZferVr8QroxUhZYbmb+lrebZ9hLX+lZnG7QE9fBnd9BWETpFl17MgWZUR/JeH4CYTm9yy2
 jgPxRds7m9gE=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

check_prlimit_permission() wants the real uid and gid of the caller to be
all three of the uids and gids of the target. Use the library.

No functional change.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel/sys.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index efef06240a8f..5cdfb6b8e485 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1713,12 +1713,7 @@ static int check_prlimit_permission(struct task_struct *task,
 		return 0;
 
 	tcred = __task_cred(task);
-	id_match = (uid_eq(cred->uid, tcred->euid) &&
-		    uid_eq(cred->uid, tcred->suid) &&
-		    uid_eq(cred->uid, tcred->uid)  &&
-		    gid_eq(cred->gid, tcred->egid) &&
-		    gid_eq(cred->gid, tcred->sgid) &&
-		    gid_eq(cred->gid, tcred->gid));
+	id_match = cred_ids_allow_control(cred, CRED_IDS_REAL, tcred);
 	if (!id_match && !ns_capable(tcred->user_ns, CAP_SYS_RESOURCE))
 		return -EPERM;
 

-- 
2.55.0

