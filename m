Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802310;
	b=uCHGiKPp29aVALS0rvTNj9HHPIo75rYpegyykj79+xBOEsOI8kmcCCSlQctYjDID+vSm
	 l2MZ1MxLKx2KjqGVOSLv4K4qsyXBDcukocJ60GVtIbuq9CWgiONp+XBFrkkTKa3bMu/VB
	 e5K1C4cw2Ngsg9UQHd/mN+XeM6LKkW9u/ElJxyRa1vKHZ7wLKmHeCa0WcNLk/gnHCRxcq
	 llDLk0T5xMql2LIU2TyT8tt4hraahqr6bOQnYewr2QmhsCEQf7rfVNiBw4whnYg6oD6Ig
	 QY7e/4qy4LUfMv55jpUMRLGuwPpdC92gAW0FUd7IA9/JvOIfXsRB/YXk2/MVYJMD3lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802310;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=tXSVOWbTASTrx3VWAw2GnqycsSMwDyX6sPcpsk3+i/o=;
	b=vvxMn6E0nwbb/fTj/GwYsdM+AqigRIRQaTI5rPqHBrfFtjRt2IWiqPVu3Vy67XmaM2Q4
	 AiQVjABVACYDYLtqWVSertuS8s2NedIRHfaT/8y3+V36qhzfaw8JokvY6W9BRM0ExeutP
	 L6z/dgo1/d6iQZbrTqABWWKaoBKe31zU4QkiONEXK/ECgxu7uzlLF8NFLVID0Py7vA3Vb
	 o7DxIW+a04BqzEeOaUsDlQzss19rlgNk2k2zMtu08wlhZinLi2dkyTifN81+0yJTVD6rY
	 Md/WcvPANW15hQAqWTvKqtdtCUDh4T9s09Q9Eb8gBS6lOqXQD9RLVfxzOsqjkcHXKAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=V1W92qgg;
	arc=none smtp.remote-ip=209.85.219.42
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC42606A330
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 14:25:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AC42606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=V1W92qgg
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-91bb5795792so8729676d6.2
        for <linux-security-module@vger.kernel.org>; Wed, 04 Nov 2026 06:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793802309; x=1794407109; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tXSVOWbTASTrx3VWAw2GnqycsSMwDyX6sPcpsk3+i/o=;
        b=V1W92qggbYZSKAJCPGsrdYUPj4V7bLC9pjgO9f2qlaofm6igVAT7h0TzehwC5LPW7o
         suT+f/VRGIgcfonqFmV0UN89XIj8ZMg7afvw1be0humu3G/SVHZui+J7EqAbq8D3jVsv
         /ZUGWTT6zdgyTevlcBxI5ucdfMasHCX5w/l7r07U+1TlSgv/YbCCtjiactJ9Z7q1zHSD
         pXtAs14Ww6E8d1+zuMKS+eKNc+89r3OT/upqvBw9PQuKoERQSgCrl5qSFOSN7VUj3C2Z
         r7r2/4mc7mcXCaJgHQjBpiocBKtuDF+df/ArC3I3lv9djbvQW4cfasiiHzt0lKaBA8yq
         yvpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793802309; x=1794407109;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tXSVOWbTASTrx3VWAw2GnqycsSMwDyX6sPcpsk3+i/o=;
        b=qv9BVKAMSnqetQLpw2X2nBb69nhEcOID3opJVckNnxIb3VWVJa+Mgb5LCtAlpqxdov
         U/Z+iItRowubu2Q6DrZaVVCGyQ6n1c8RL3UW3hYBuWFVMimF8PZYaEtGpJumwQa0p03D
         KaCkNekL0JTZFLRpRPTKix5+VgT7Ceo6Bi1rxoFu/IK4HU4h3XT82gLvKMICH6Jj/NE6
         DRYWNy4G3me7qa9hwXDCEswucqCNzCyW9nuxSp4MnhCJxAFT7/vcsLHYiVrnMZQBE96g
         Z8TnKumHVdKyMMKFCt/OzFOsfjjZAgwhmeGptDBtmm5H2W0qlFoXof/89LrsA2cxj2m1
         +WPg==
X-Forwarded-Encrypted: i=1; AKwUvBz7/Q5YKxINbQ8qSKef/D0hy4Q35TLBuCkmwtKP4bSzHHH4Y247HmOQ68F9McLeKVMj2HqGO4+8CSyose6w0VKGq/V8LYg=@vger.kernel.org
X-Gm-Message-State: APuU4Z998RcDoXN2aoMZlIFxTPIDQ2uILifktJ/jKTzg85/8x5bl2xSA
	4lX6QQnjUZDjSRhSrzZ7JytaKwMZm6lYAxE9+AXsuEzLE1xrfulTNc0ZWRcR00UPh5s=
X-Gm-Gg: AYBFou3Pmb97k8DqwwojtFGy+KHozC5EcweMlsu8ntW5pwaA+yWNzf78vC24PKUmvCz
	0kuanLYLBBZqebTXot3QwA6bMGVa+j9WVg6OnrIcZwaQg6bK7uzmyE2mW0WhdxorJKQRVnqPDwS
	Ky0vRSjMKvXNduWO481NwWPizNKWexs3IpYSFzH71clPafbr8oAFGSMrekePF0gHslsiBJtOX9L
	OIYSCQEAnnx4qzV+bvhFpZgfYTNOXvYgFiQnZ4jimHozA53TPZSVnwo3QK9OMrIPS8jpa4RFruF
	msY+RwFUoI8ba07S5Ojn/7fPiqJ8zh1fsc9Np4YDo9fc8fjcGfDReKal68ejvtGPqQkKtytjkN+
	q8QAy0PAdHt2qwkqOejLJ9eRq1SQJy4NtNR35D3g3ZC9IyIy/TzrYIvdTzf4rTAWbLCI95N/4ip
	G1ySvO0RNTnl3eOopOwRpSPkGbAY9ogq7FLUDyrdMnbElncrjUOvDt25pbeiWyt4qQ60NyUcQtV
	R1UHRfqAAAtkWszEzSMXtNpxSt78sQKe1eDbsKOoLPpJNccY/HxaDcqdncrBHS/w3CmL7TYBk/K
	J0kPI9uzB24TAH4wdSwRW02Drv3smf1AW7OPjyPdbXG4/A==
X-Received: by 2002:a05:620a:2a03:b0:93e:c12c:9dd2 with SMTP id af79cd13be357-9442178fc95mr2431154785a.82.1793802309425;
        Wed, 04 Nov 2026 06:25:09 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d482eb96sm212222885a.23.2026.11.04.06.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 06:25:08 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 04 Nov 2026 14:24:37 +0000
Subject: [PATCH v2 10/13] cgroup/v1: use cred_ids_allow_move()
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-b4-cred-ids-v2-10-956213608f16@toxicpanda.com>
References: <20261104-b4-cred-ids-v2-0-956213608f16@toxicpanda.com>
In-Reply-To: <20261104-b4-cred-ids-v2-0-956213608f16@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>, 
 Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <sergeh@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793802280; l=834;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=2GqVTJZoW+5QW5iLTOH/2OThCJUTSIt5jDc9Dw7O+kY=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QPTBmC9zKa3anuEfG2w9gFULzvnccPiFkknC+4fFymZXCOg9EHFh34w97JqgtGlrXApZa/nsl/p
 IW4jGufbWggE=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Use the library in __cgroup1_procs_write(). That euid 0 may move anybody
is part of the rule.

No functional change.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel/cgroup/cgroup-v1.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 7f55a7bc8402..216a2dcdde86 100644
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

