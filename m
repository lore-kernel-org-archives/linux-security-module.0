Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC14494832
	for <linux-security-module@vger.kernel.org>; Thu,  6 Aug 2026 19:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786045306; cv=none; b=raExEYH3Z2cDnBZOal8ISyV6AuMEC+iIdoDM2koOEC6cl55jlXoBVJZzwdb+9mEH//NlO7FSdqyZeT9RzSff0TdE6o6a3Piw7f28VHEyXj4wo+HRTO4vOzHasczmjyWaWYh2mtf/7oXKniMMPqeMPdjYuwpUbXEjfff1ImagzpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786045306; c=relaxed/simple;
	bh=sSboF3nOx5Fbmhas6I6ey9seACJAKplyQAcNHv1o0WI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cLjgZcT4dJfPHP254Ra8SDHZQihG1p/cRtfu2f0MO0MYxwuOb8MnFCwveX5DdVwlqdUfnuJ5+JIQz+pV4i+iI5oCLKv4zlBMPUzp7mwLKJnxW66U6m/fJq0NujWuWVZ/PAW/xqV/FMcPjoVU2BNq/JAXRdMZ1N+4SC/kubatBOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cLnF48e8; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cLnF48e8"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-495509b08ebso10525e9.1
        for <linux-security-module@vger.kernel.org>; Thu, 06 Aug 2026 12:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786045302; x=1786650102; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0MZnaKjwN+F5O6KUpqyw6XaSkX7zjUg5vy7iF6PcqM0=;
        b=cLnF48e8QSTFGt1K+YFVIkyy3bIzeGUQgxhDPem3MaR2XIgTEYLCDYNhK6v9o85YUF
         t3plAcfgHmxoDb54d2uXc1k6PqtAA1PCYXSbKC+1ijpTvzILm8BUfY237YBf0C2rEGE8
         XDE2M9FOEN/PR9vc6g+ow0IiOHH0c7Q9nrLNL2UpI+UtnYyhma3jYF52A6NQ5wM0pbi1
         S18nGzAVh1xQpopUu7xDpkKTEqU19RP33W91ZegVk6MsGVIf7y8W8pSciA9mR/ISL3qW
         78jPbF22RcBV8cIOHkQijMP8m+7/+d6QB899zbSDTq7RYC52gNlAmFT3xs6SH2KVZj4k
         5sLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786045302; x=1786650102;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=0MZnaKjwN+F5O6KUpqyw6XaSkX7zjUg5vy7iF6PcqM0=;
        b=XTUvTZVA8BCNTTzitSy6f7nznqgSuSV7I27UO+TPjoRQk05Vq0tSTUWIhkDdDuVUxd
         5V9u+lqe+ppNmPKrzW0YdKLqvjaZUhxjmADZ63q0GONBr+hBoLkwYhwlva2gKll4TSIL
         6Z04/Ekv+KG3CdsAC89DGpL0SYUNwiSzzRujOl57GIcnPaZJKpsjPCsfVthDzKTZmuiS
         oPucS5qcyu/X8JUu39UGWoRgmH/02iTDWBM8EAi6qygIBJwqcK0pqxcu3Qd7Z6lw+w+7
         CiHvmU1VmYsxcsO1vbqe5uu3MOPq3BVx3LlmdML7UcQV44GfrbzxyJZL26laARu2lUZ+
         qgHA==
X-Gm-Message-State: AOJu0YxvhtI/4RtDh1VWjzZ77rYkWUWSAfA5qeZx1KBCqAyMHazFJZ+E
	lDVpqMk3umjCZ+aOpLi7zkefNlaHG+wPe+at+JiAylOR8sNISCQXPYBAU7uIcaF0Qw==
X-Gm-Gg: AR+sD122M3OZ1L8qxN5bpxpHgI/GyT9TGDeYsVjLHQBW/xw/1S3FbBkSJ7kvXwL1swO
	9jJHPKjScaepFybrvmU9JuftoKQlfjfTR7rJwhGeDCkiWHHA+V1gq1MjMVX3SKfqVp/90aeArvR
	U963Gu/Opuv6TMI+pUehry1z78fAzHUzxkN4/sjO043aAB0hZ+rgZbQDqYkDsFWcfHJcae2hPo+
	WGr+jhombARlnJl5Q2Cn9BCnx8jn5ugUeE2n0a5ferAKMZFHLvaLRGRYYi90pIVELZ3flZltPs3
	5RCCUmMRUBU6WI0X2StHm/DZkZHMZb9MRnwMuxtucdOW9kx9sk3g4va7jmVc+KPkbh5be/ZQCzp
	xh/bgneifZCyfW2acWxBvQIW7hSuWR+oXRMh2SvrL6eNNDaLjGVH37tsxcCtPB9wxgwIanHo/Dg
	3PDPfHN5Dz4f764zBZQYYAJgNemjN/0SkWFZa3YfDEdCRID1zS3drpxadB7SBfbW8RdSTStyDqX
	NW4igrugwB3Yf8cg07pqhq0MkzhShDz7GjpjBy5S0vyHwzj
X-Received: by 2002:a05:600c:6c09:b0:493:aca0:32e2 with SMTP id 5b1f17b1804b1-4995c06a0ccmr235105e9.4.1786045301935;
        Thu, 06 Aug 2026 12:41:41 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:8b80:1ac5:3668:4014])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ff7b18368sm7435085f8f.20.2026.08.06.12.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 12:41:41 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Thu, 06 Aug 2026 21:41:35 +0200
Subject: [PATCH] smack: fix cred UAF in smack_file_send_sigiotask()
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-smack-uaf-fix-v1-1-26426d389a26@google.com>
X-B4-Tracking: v=1; b=H4sIAG/jdGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDCwMz3eLcxORs3dLENN20zApd47TUVFOLVNMUS6NUJaCegqJUoDDYvOh
 YCL+4NCkrNbkEZIhSbS0AMjQdG3EAAAA=
X-Change-ID: 20260806-smack-uaf-fix-3fee58e5d92e
To: Casey Schaufler <casey@schaufler-ca.com>, 
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Jann Horn <jannh@google.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786045297; l=1537;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=sSboF3nOx5Fbmhas6I6ey9seACJAKplyQAcNHv1o0WI=;
 b=I3ZfOezORja7D3V6dZUdiOZdMsOVgRHOaFgYMog5MQ+JKbSUKi8qBVN8gs4ATCd4kyTU6RByA
 TJxQfddNyziBOrMkSnfmhsvKOl5JJFPhifWoQZnk9iiFV8xSYex7hDN
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

When inspecting the credentials of another task, objective credentials
(->real_cred, accessed with __task_cred()) must always be used.

Accessing ->cred on a non-current task is forbidden unless that task is
being created or destroyed; a task is allowed to change its own ->cred
pointer with no synchronization, and changing ->cred should only affect the
current syscall.

smack_file_send_sigiotask() was accessing both sets of credentials: First
tsk->cred, then __task_cred(tsk).

Fix it, always access the objective credentials here.

I have tested that this bug can lead to a KASAN-reported UAF of struct cred
in smack_file_send_sigiotask(), and that this fix prevents the race.

Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
---
 security/smack/smack_lsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index ff115068c5c0..bbe6cd6b03f7 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1964,7 +1964,7 @@ static int smack_file_send_sigiotask(struct task_struct *tsk,
 {
 	struct smack_known **blob;
 	struct smack_known *skp;
-	struct smack_known *tkp = smk_of_task(smack_cred(tsk->cred));
+	struct smack_known *tkp = smk_of_task_struct_obj(tsk);
 	const struct cred *tcred;
 	struct file *file;
 	int rc;

---
base-commit: fcaeecb8b0cd44f77d03b28de0671258d4db18f8
change-id: 20260806-smack-uaf-fix-3fee58e5d92e

Best regards,
--  
Jann Horn <jannh@google.com>

