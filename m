Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16853B4E84
	for <linux-security-module@vger.kernel.org>; Sun, 18 Oct 2026 17:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792344726; cv=none; b=qamOWGudrqmeIh11KPdOyqNVaAPEqEdcOJO7bAUj6IlvtCjlOQpXmH6/e1UUqm8irirpRHBKXJfjdMesGealNyCBZH4/J1wEgqswqSJsWXQ7D5QqVQyFOWdvjS7SzYdXSNGpVhpR13lrxLM59MK3FCTxzk53AdmM9JaUVpkkISc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792344726; c=relaxed/simple;
	bh=gHI7eJ6aXefjpjs/BTHmJSNhf/+IT4VrWxP0xZGTO4c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m5RS+DaXCPZZXKhUXJqygxE/ZPDTumTUtvEol02wQn0nEW92a5WkVuIQrcB1ABbG7pdtHY6EqENgq0YkWALiRxdVKTnKevMtNPUcnoXYH4t9yZcmo6kcArN+1QveII36PaEGlx9+1+XKmxT1LzNHW/umlj7yup38DcVmnSw8zb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=qiSjNtak; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="qiSjNtak"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-918f75a68f0so22723626d6.1
        for <linux-security-module@vger.kernel.org>; Sun, 18 Oct 2026 10:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792344723; x=1792949523; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v9DMRFJtj1v/pgDnB0otoEeuOQ35799cJSy/oBGV94k=;
        b=qiSjNtakVDct2v/qXSnmuVSigGNAm9YHsweWPIw6+8UMhM8PwQCyuFsNxvXf5/p1Xd
         j09mZ2dAN92QxkjiiHigMORRIC+Bc0iLVcOCBN6FrrFiamlAV5ZYuasBIgCBHqX6PVr8
         JUKEHYyqwWJbVb7F75doP5dnvL/qsPmQnkmfwL2HSM6eEfEuOoOPb2JoSkkAgOKYtSUz
         HfCGuWp9SpI6r0XFkp95Sau3fpoLWN2tAXf93VgtpUriImAwPnekEcyeJwziOCnaHLCS
         KmY6dvn9Sbgmndr1lu9+qRRVtZUR5c2qwHYCl3KN5bs8/4xwH38EifOn7gC4z2Ye0SWS
         iRYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792344723; x=1792949523;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v9DMRFJtj1v/pgDnB0otoEeuOQ35799cJSy/oBGV94k=;
        b=pGzWOhquAegn6zfTu2U+57Ai2CUgI1aYdIgMt0SXqUVxY2DAGWndlJQdLy4Zzl+0CL
         MMvSmfj9002PXXhVshVs11omZvETiIk/vsu6pQgjq3U7pLF87l/Vln9/zWOhl6Q04QG9
         t1cZvUreIw8M9qIIcNEoftKetlbI3BqQBm47UWAB2+a9LldAN+eZ4ufS0dISCCUCm11o
         mnGjcBei8AXCnt+PGskVH+ocv3HSsIA/zWKxKmb/xlzzgObLEimVHd3ViZyPpg6NxEyS
         SuS/4TQdMgY8gkQUE3uzZBDAGuVFRK2hv5Lu7Y+larq4VMHI6tX4GnaMYO6WIllaGQiK
         4zLw==
X-Forwarded-Encrypted: i=1; AKwUvBxXR176zq3og+oazU387a4TeIH9zMEaVQcfN9KGDLU4VA1VlFcDGxxRXcTX93+b54uqNCH6gd/8YAlFZJwu5BBnwHoKYfs=@vger.kernel.org
X-Gm-Message-State: AFq9FYLJ59MDXosa+z4QxT/WPzL0EmD3nPvkU/gG3TbiZMhvwywdOR5c
	e0Ik47VzF88i52H93uVhN0fMbNdP9IwX6oVaXfyqaEWJvndF84/+yVJBI6873+gt44wAl/ek2Ly
	Y0e4n
X-Gm-Gg: AYBFou2+uRFy67vIgJR9B02SOK3OYE0R1/YP6h+hBLkZMk0ViOCYQf13dQnpash/ifu
	Zfjcj3POrq1fovYKyqzGovWHgHrOGtMPyLOBTA2Wl/tjLgTw2ZMxD9JTeEFqNgFSJGg+gtCGH9p
	dbzDX22wvp8iiN+qAUHIwDrg2UXlDJPR0ceoHexABIMAuP6J3LyrU928nLJXODPdie1szsZsCs6
	MavnGcPmKty+q3lOFCQh0BxFsFIXzV6cyHWAi/yfmYvkGViH2vwiSrBxll/vnzP3jI6QW9r15NK
	7LEBqAH5Q8AKVYvCZFKOgRYD0RnqMU7WZfQz4pLl7uzNMCurBghLmAJT1DTbF2vk1nwJNBrncib
	eizo2aORSM8To2l+Ni+vLvBgorf2thEwXsBPlyeE1rSvXB+aU6EYtD5yzmosOQdmkY6K5qHdVhM
	3b5RiQlo0CcwaXU4lK5h6kGBoElXHZsM5f3+xHmq+oEZK2s2sKoB4rZU1ZhGxos/acc2539P4nk
	W5y1cjOnZGxmS4=
X-Received: by 2002:a05:620a:1a1a:b0:93c:7955:afd9 with SMTP id af79cd13be357-93f29d8d97fmr926748385a.52.1792344723545;
        Sun, 18 Oct 2026 10:32:03 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.242])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f1a18510fsm753031985a.22.2026.10.18.10.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 10:32:02 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Sun, 18 Oct 2026 17:31:45 +0000
Subject: [PATCH 03/13] signal: use cred_ids_allow_signal()
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261018-b4-cred-ids-v1-3-7bdf2db4ea9f@toxicpanda.com>
References: <20261018-b4-cred-ids-v1-0-7bdf2db4ea9f@toxicpanda.com>
In-Reply-To: <20261018-b4-cred-ids-v1-0-7bdf2db4ea9f@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>, 
 Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <sergeh@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792344714; l=1257;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=gHI7eJ6aXefjpjs/BTHmJSNhf/+IT4VrWxP0xZGTO4c=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QEVNZAffAF7X38dSF67KaYGn28GTqbfoaAHsAIBWkVE6jT9Twlxr3b0mv2VKln8SmcgCajh2aXu
 9Z5zF8Vl0ng4=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

kill_ok_by_cred() and kill_as_cred_perm() have the same four comparisons
each. Use the library.

No functional change.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel/signal.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index e433de93b430..bdca8f9e0fbd 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -791,10 +791,7 @@ static bool kill_ok_by_cred(struct task_struct *t)
 	const struct cred *cred = current_cred();
 	const struct cred *tcred = __task_cred(t);
 
-	return uid_eq(cred->euid, tcred->suid) ||
-	       uid_eq(cred->euid, tcred->uid) ||
-	       uid_eq(cred->uid, tcred->suid) ||
-	       uid_eq(cred->uid, tcred->uid) ||
+	return cred_ids_allow_signal(cred, tcred) ||
 	       ns_capable(tcred->user_ns, CAP_KILL);
 }
 
@@ -1530,10 +1527,7 @@ static inline bool kill_as_cred_perm(const struct cred *cred,
 {
 	const struct cred *pcred = __task_cred(target);
 
-	return uid_eq(cred->euid, pcred->suid) ||
-	       uid_eq(cred->euid, pcred->uid) ||
-	       uid_eq(cred->uid, pcred->suid) ||
-	       uid_eq(cred->uid, pcred->uid);
+	return cred_ids_allow_signal(cred, pcred);
 }
 
 /*

-- 
2.55.0

