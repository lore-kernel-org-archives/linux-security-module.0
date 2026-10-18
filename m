Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6853B14D6
	for <linux-security-module@vger.kernel.org>; Sun, 18 Oct 2026 17:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792344739; cv=none; b=X0znS/3ToVOYhZN1EXHo4kyxkNFG/wuiIkz7HriKNPaVGtPpjkHFwMjZQ6+FAjjEXkTXRcVRMgeRKs5zueL4sxL1kmWh5PnBslsiUOHCYSx3IGLp15BwP5nminz70mhbh9x94KYrUEcGzSrgI8koxT8pJz6aTRraOv9eSwlCGoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792344739; c=relaxed/simple;
	bh=qeX7xi2TIWT1Uq5NwKJsXNm4ZD2F8CQPNdUdpDcgTF0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DeKr0iJztlgG5Wv8YYDBEyT4gEtpCyun8xRXAkpBQBQInnCtyObeIfG0Wd7+t8CEIvq6PBXSMKWNEuRcDMotAOn2AApu5ZzCt6g6ZslQlBMeI+sD75jAspwkHErL6MpxMRdSM1uXgAdCu7jrXQmi8fMCRHacx1UOBOrEv0LYOuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=ThUIwMsI; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="ThUIwMsI"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-91ba8fcc684so15340046d6.3
        for <linux-security-module@vger.kernel.org>; Sun, 18 Oct 2026 10:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792344737; x=1792949537; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wIBUS5fRwkHF7Vis6YMxw26AcynjEyFCRMVdf1VV1Hg=;
        b=ThUIwMsIbSSoqQBWhvgrqStwkXCKLk4cLF4OeSi5/dqhY5KBhLSxB8vXfJRC/+dos8
         8PC6aH1prykGZ+Qi62wFyyBD2LVszm9RKLAyZZd2x2AZZZAy291Nf2kLq78vMBsVek1G
         BLft1LV5KWkEMMK+DdqMUunOwLmkBCeHB70wZthqAUfD0o23ZiIiUY0KJsIohIOhPV4f
         0ITn6/eKXM/w94GXyHIWS3K/E4MJs+s1+qLN1Q9MJaojTfOf45LSQogXwu12GnpZE3vQ
         FXUknpF8sbjLsk0rMemV8G+qJsj93b8nXkXTyVYiGnLM+98NyAT/8WOZkXL5CJbFtRVH
         mYig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792344737; x=1792949537;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wIBUS5fRwkHF7Vis6YMxw26AcynjEyFCRMVdf1VV1Hg=;
        b=eNmreoBk6M+UyuY4wAedX+dfTW8tqklz9QLxAN0U45Cq6o4YS8x0PeTVvlCI5r//Zi
         5uHW3N+DEOC4lsO6jVG90LYciSzHk3bZ0joSLdcD2FwEnkIoBQ2isp7R5+TB51EBLHjg
         nxa2h/Mkw0iYw8nopK67nBFNO99e4HTtQgFu61606Em5sHpHpRzJhhYJHMN3V8vtnwXH
         t//Jh9bRc5FD1rZbCk6aPk4Fw6V8j2eEVGhIv3kELkYkDsHnrgVVFusQW+WsvvSC6Cwo
         Q8ILju8Zu9Heu/2wuiD714eiK9O32pHrcm1wubsqFnTlcxNWQvYF/D47d2zoQ4wnjWeJ
         +w+w==
X-Forwarded-Encrypted: i=1; AKwUvBwa8TlRk1l9VZt/prOXRiU6/hmMjIB6Hl8VoqmGT5NqJyhPd38zko0gKX5QuvqbcxPxBA30P/5i+1zKjy5sj79Tl5oTokI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLnkQWC4D69/8vyt4OrXIcX+Ak/pt2HIeVYK9qt+7h6v/LWhI2h
	oTiTmlFonbfku3r/p5ciK7ehcSFGWVVE7UECVeE5kFv54Y8r3cjUL/xtwRqxfLVCbWkCjnVZVpr
	G3Lv6
X-Gm-Gg: AYBFou2BovFT7qIS5GPw9VFrCnlnKK6xyiIORzfTEVQYET8ilERDq9Xm9Vd/EM3VusY
	HADZW+VaDRmVTdiu0VYuXvDjTXU0iyvcAzC4lnwx/lz2QLMwuDIAwRhI13w4UWAWOvk05ghq5vu
	3CQ/+eI5OWwIP25w1O6Cfz9vV9UleOqEgQe77RLs18fRQ4TNMs0+bx1TKYgHMJEbjny1ld35ipO
	KiMzB8++90GtW02VX0F6eTGC7NjbI9yP5bdtCt3FAD0C+UqJfP0MKxYhNfUR0vZsUxfMAHsmrbZ
	5H/kmGwdUoDwHBH5Ogg7AXjK17lwM0Gp+dmc0muToF3XgdgVhZv71+4Vk2eleNs79xj11gcUYUj
	Uj8YauUyRIjNw927FrW8YXoUt0LTjx+5Oy5l2E6c2UQ0ozOOGxLYSCGUAMexism6EQmZuUdZJB5
	WKl3Gq2j4nmO3CjXWAQ9NUp0nHRkonewfi0xU6lCzyv2z7Ajjx8iNtxrrcCNwkBBeJXwL8bbGy6
	t8W0IemP5/iecy+eqRFcn0spA==
X-Received: by 2002:a05:6214:5f0f:b0:91b:aeba:3c08 with SMTP id 6a1803df08f44-91bdec2deb2mr107832736d6.5.1792344736841;
        Sun, 18 Oct 2026 10:32:16 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.240])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91be5dbaabasm43375276d6.5.2026.10.18.10.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 10:32:16 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Sun, 18 Oct 2026 17:31:51 +0000
Subject: [PATCH 09/13] block: use cred_ids_allow_ioprio()
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261018-b4-cred-ids-v1-9-7bdf2db4ea9f@toxicpanda.com>
References: <20261018-b4-cred-ids-v1-0-7bdf2db4ea9f@toxicpanda.com>
In-Reply-To: <20261018-b4-cred-ids-v1-0-7bdf2db4ea9f@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>, 
 Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <sergeh@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792344714; l=727;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=qeX7xi2TIWT1Uq5NwKJsXNm4ZD2F8CQPNdUdpDcgTF0=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QNwSPTMnO97kWwxKIJW1r1/RqXfign8BpIbRx7S0TpeIonrebRdkQ28PlbN7MjI/ZjRY/A9VC34
 JGL6sV0h2TAA=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Use the library in set_task_ioprio().

No functional change.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 block/blk-ioc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index d15918d7fabb..80e1ed2db8c8 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -248,8 +248,7 @@ int set_task_ioprio(struct task_struct *task, int ioprio)
 
 	rcu_read_lock();
 	tcred = __task_cred(task);
-	if (!uid_eq(tcred->uid, cred->euid) &&
-	    !uid_eq(tcred->uid, cred->uid) && !capable(CAP_SYS_NICE)) {
+	if (!cred_ids_allow_ioprio(cred, tcred) && !capable(CAP_SYS_NICE)) {
 		rcu_read_unlock();
 		return -EPERM;
 	}

-- 
2.55.0

