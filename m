Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313033B4E84
	for <linux-security-module@vger.kernel.org>; Sun, 18 Oct 2026 17:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792344729; cv=none; b=MTQGXwr1KiDs/7xYNurW6R+jGebpnqkKKVSvJevcx/XOt3B11QbL/ZWb0/aRnbEUYosjq9mQkoSlhvz0uLHuFrQJqQx1GNdZgJgmiZPI7SsOPlHWUU6G38np+r0nEnlYMcL1y/rwOKSyxyl3K7A2dDsLzhPTRTMifqt5YoqE3CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792344729; c=relaxed/simple;
	bh=Jg5GmXznOlPYSuEkiCV8w3Ra1IGLFI5Hd3M/6KyUrEM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AkxCddnCZkHgqh5cmunEnt3x9zyR4g9+zWXMp3FBazM08K3BXausdAWAZ3H0M4L/WT2nogYa7zsT4kN51PNJTKoIjFcT868C6C8+gDyClhs8z4BPhOWC8vk4C/1RkI9dNo1On3MTE3AcbKHmKCzkhqX1nSWS6DrFRg2g5iWEv8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=O5nTO/wZ; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="O5nTO/wZ"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-917a64f28d0so31133366d6.0
        for <linux-security-module@vger.kernel.org>; Sun, 18 Oct 2026 10:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792344727; x=1792949527; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1ospxx2BkClEH6ACvwXOMAdeuChnoZfZGV7wg2yWb6g=;
        b=O5nTO/wZf1JUeRoTt4peElpSBxfiEtoObUUwL3pRqH4/LFw0dwjUV7XF/88/FRm8Jh
         3kc5E4YWf8afFtNQMb11K94fkdF2vC542zVAhfIn1Ojvzcs030ytCaBgd1RyGqkJxrJ5
         QSGxQaWoxxoAP/b38iRmkpEWAPasbWnleIxsqa+ufx85Y/FEpDLxohgbUoBLHaYjRmAQ
         YI6fOWjkQ19RSDDbWQEHChF8EV+jYNp6W0rPxS0QaDbVCB79zkgIAUyDh6jSGAVdFuy+
         pQfno4UOG1/kCsURRtsqMGeN+0O2flkj+g2JqLi7o7uUARS9JT26CRmDaq3+RvnePFwH
         W5PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792344727; x=1792949527;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1ospxx2BkClEH6ACvwXOMAdeuChnoZfZGV7wg2yWb6g=;
        b=UtQlevc2Gdo1zuDtOnHQpszArcecBnUnsLpg3s0uBD+zYNZg/bloWG6xQ4gw7Dob4Y
         yjTLEt/yJwh7up6PxuknVpQhDIW7aVlWlk5ZqDwJ6sdYwXix/KP5iKHringFwyCrE/id
         FVVS38zqI+t3eRl8ZsyVwnk0Z8OshtKRha584O7t9/e+gTADuoD5gUKR8R8cz6NSq1NX
         v0W50ADIUi2U0SqW8sxponUvYHi8SUyeOAvljA7eAd5dKo7tzaIJCZ6CzF2Efv7GQrJa
         +01XwoWPIdp5p1hRxX64wFPDpDNTPs8tJ6WPOX5H2YkHVA0ykaNlxZny3kPwIGQlbDbJ
         2bpg==
X-Forwarded-Encrypted: i=1; AKwUvBywI9lD+qfU8cutFdm8I2O8duDnINGbVMq9Bqm3cmmHn0aN7sD9yfK+E+DDav1yeCs3JAzKuEu4XAomRv0OkYezmbmU3bw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKi9uMf4Km3X6S0CQjuM0V+doTPBVYp6dCZ6qPIImEYEodvSp6J
	0ke8ttNhl2zXGYPaI01cNmHWcWKm2VbeoJ1fMw8ITyaPxL2W4hMOGYAvE0FHvPtlqhL1DaZP8Ry
	qiSEO
X-Gm-Gg: AYBFou2JYhPXdOTZfDtpsADEQqhCLWjgpvH49lzgEjSbvjOgrbOUFmeT925ryu98ApK
	5GYrjVnLdBXvcaWIhAPVWYEFzGFbEFWxU7XP5GO9R19xiegC1jx9w7BduTbWn4MPKzf0HfyKElT
	66Vir0TrY2Maz6YM5lCYjK1pUq9H2EGNMWn7IDIUz4A+BpAZvJnpK/4WH5IPInGvWVNUaNN9K8U
	iygwA8sAVd9F3oK0HVJxwWeWtsilfG2FPSX2SmgoK4meDyUPrtCOPBzUB+sol4jK8Ops75mVlZG
	OW8dmiOvmPc6AVHC5lEr/qJrT6HCgTuW2bMo6lT4SBHCTjOfSjC4lclJEcj72Em+5k5i4Qh9IgK
	4hDFxP1rb30L7ReKqN/KUIN2V4zXQh6mUXMJtcfSX+jvlqTtLj+6UcjBNISx2MaSzuSN1LKoS2x
	MGIi2KIiODDmW+HnhjtrqgwQ+vS/bDzqbOZRKtJWWWFYLss0+Fc9PDoO+LDLkwLDtiHxCjCmhee
	rSIaKZ0y3OVTqg=
X-Received: by 2002:a05:620a:4726:b0:93c:65e3:df81 with SMTP id af79cd13be357-93f17ec7a80mr1470685885a.13.1792344727138;
        Sun, 18 Oct 2026 10:32:07 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f32218251sm371796485a.11.2026.10.18.10.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 10:32:06 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Sun, 18 Oct 2026 17:31:47 +0000
Subject: [PATCH 05/13] sched: use cred_ids_allow_sched()
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261018-b4-cred-ids-v1-5-7bdf2db4ea9f@toxicpanda.com>
References: <20261018-b4-cred-ids-v1-0-7bdf2db4ea9f@toxicpanda.com>
In-Reply-To: <20261018-b4-cred-ids-v1-0-7bdf2db4ea9f@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>, 
 Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <sergeh@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792344714; l=690;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=Jg5GmXznOlPYSuEkiCV8w3Ra1IGLFI5Hd3M/6KyUrEM=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QOAY3g0DN59kHth4VEdFwI3I320GLDR/UkBOLylEaRRh7A5ovXpTMHVmfacAy9NlqkIQtfdJWB0
 8sMqPNvqLIAI=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Use the library in check_same_owner().

No functional change.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel/sched/syscalls.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index b215b0ead9a6..a361a02e1d02 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -280,8 +280,7 @@ static bool check_same_owner(struct task_struct *p)
 	guard(rcu)();
 
 	pcred = __task_cred(p);
-	return (uid_eq(cred->euid, pcred->euid) ||
-		uid_eq(cred->euid, pcred->uid));
+	return cred_ids_allow_sched(cred, pcred);
 }
 
 #ifdef CONFIG_RT_MUTEXES

-- 
2.55.0

