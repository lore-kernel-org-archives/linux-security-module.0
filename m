Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802298;
	b=Za/c7IG+sNLDpeAaYG3aw8GQeeaQtKSsGbUTwfcihAyBDAIXTnjtx+EPDQtSP0Z1v+4c
	 lUhRzaB6mjUADX0wBY1vemnZOIaoZwJdYwa6IgsSBD3z81ONAaRtmrNaGEafKMK1q+bRi
	 Tz9ZAxNIrlaY4oH+MTLVpkhhVO6m4WfgYXKDu00M9T9UVJ/pOiHYjEpvF7yoRGMdl0pOH
	 2XBCNLbKy0AuC2Mq8fiZWo4dZlWOX/GQjNgn8mLa3B5peJvL/6j/AQFUb//OeVQjFOiB1
	 G+KIllNs4++7n47kKZu276PXZfsrfU4AeFooxY+6TnrFI+FBOUjS8PYeLxDPhPYogpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802298;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=75Vz0VFMgzVs9eRdW/Wv1i02haW1n/3TAUM+kue5zp8=;
	b=YLa2FDopVMj00OoX7sL60n6zEgAL9M9zYb8YZe6EaCW8ZAxLvabSHG+YmzEfXwP4gVEF
	 +vqf9aRoqSx0rpQVniEpf/2eX1QcuDAqRDD4XbFVlA1VqwF+ytndL9iWMg0ULGsIdzRKF
	 WigaspL8LxIF0aRKkHiEzgenLV1aZ2+M91VCWhS8qMowD1wzq4koNESb7r/gKXxySZ8IR
	 Klvwh7quxQY4KpWQtJ1ZsmMik5TgzN614hC2Olffjg5jl2r9Ou3fjPkOL34BhKzy6WJQi
	 dy1EugdsBPWLNa9xdCCQQGAQ6rSoE5AdtolbGy0h14CsRGBBHx/HnT2HBrBBaWLJm1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=rxji3EH5;
	arc=none smtp.remote-ip=209.85.222.173
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2FC606A331
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 14:24:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D2FC606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=rxji3EH5
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-93f22a8515eso74957185a.2
        for <linux-security-module@vger.kernel.org>; Wed, 04 Nov 2026 06:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793802297; x=1794407097; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=75Vz0VFMgzVs9eRdW/Wv1i02haW1n/3TAUM+kue5zp8=;
        b=rxji3EH5yfI/ldbhulzm1cTw+5TZyQV8cP2waUNn8q+wNrVV+28NppoAORW26kfIEa
         SH6E7SW9ly24vgOdPYYfbQPNkcHvtvIEfkdl0PmxsU12vLWPgkcMkQ9zMfhsrTvT+jMW
         ixdEwazm6rT4F3DMFmGjkDQWchbjqGjrKOhcnNFFVqHV+82bf30V3csZK5ubcy0Mi0va
         2INS79DQts7Ce74vvop+PC0V2xRv4EZ/k+DEGmBBfXV77LAh+i79iUWYmU58/FefxHc6
         5WD/MIzbwWm80tPER9k6ytUtqtoeL+u0jiF9JiobcK9BQXiwadzwrTNhYVhVfCUbZhwL
         7X7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793802297; x=1794407097;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=75Vz0VFMgzVs9eRdW/Wv1i02haW1n/3TAUM+kue5zp8=;
        b=OLvPU3O51WU628VPzRuxxrLy730zdl5YEMBFtivpwUOUf4/KY4MHy/97XHsh1D1y4s
         QDPw3M3yAQquGofFCjw8Qn+iaIZNzIEZRFhuWQStbyx66h2z3l34+hjW9qtJSuFWfEJr
         bBt/zcBilR5AdUrR1OehZhxqIQmDL9a569B8EIlIYq+FlHdeqaGbBYL49GfBUsdB++5T
         laWjxjYw26ZxRF8PHDM11NGox/+dwYy7wlLYaCoCqolNAlC2fzq28hon0bS/FNgG5zvG
         kJGtJurz2eCXgNfGCiio/9NIjg5G6notuxb8qsSUZgWaOqGO+TW4HHGttH6aZVjU7I3F
         mroQ==
X-Forwarded-Encrypted: i=1; AKwUvBzhDsWmWgUfVtf1akfgZJE4tnwgX0HpHoUXptxgiwMbEgGGfEc0iKlKFBlsZ29UTRokUM+WbP7YyMX8vjodRUtufZnmDCA=@vger.kernel.org
X-Gm-Message-State: APuU4Z91NLv2Ne3tqxXjyM+Z8hCr2VfmYTh4loqjNP8TwboFohcHwbQK
	BuZGPDiLq2W1PDWYgMyW8Ydevjt/z5SDFFWGQQUKDrgtVzDNBI81+LQwktbclJf7WyY=
X-Gm-Gg: AYBFou0AqNbk6BfB9L/YYoawXRZevr3u1Tued1cY6NpuwArCTh3HpaJgvysd3omCQZ9
	Qml3u1DxFR4xIa/pBbo5cFky+x61jv22DbjY2baXzAiEUl1Qrk23tlXldSOqTVfv+ubxQ9roqY8
	fGuL135sBjXLMpTCbCp9zSXdjzdg3aqcaxsptxmzpDlcVqjyDYvNWPahBjR3MrZip3ktypsQOpr
	M4pXCJ1427IAC4ad/91EG2bgmW4U7lHH81gy/ivW8bQOVkf2UBrL0uL0GGB814Pz3ZTVPMwQhGo
	tlkY1GzUMPGJJRxS0mlQNwIAg99w60n7QZ2akcwkuXoMjHO9oQxqLn28qc2rjz9fpHFed9/gwy5
	aleIoMG/lL42v7SdezjJYHwN5893upK0/6GznXBaXfaJrjqxXGPJRAHUPeWdpSI8DepS884Ih4P
	rRslX9KvlL01sFAcGwkoRmwwl3P1XSij11kobTLIgg0iymIdvQsymljli/J9XlcpAph7Mr3Ys7S
	VfRrEUxs5t+5AtD9BPxuZdZs0iLFaiTwPzRFESvbQ7X4fVwidv2cr3MA4mYD7W7rFLK0j7W7btr
	2kwaU6kACDMaShlVyMO+7zxAT2u6zGGYXn1ZUM0Au4CCYA==
X-Received: by 2002:a05:620a:2987:b0:93e:623d:99ec with SMTP id af79cd13be357-94421744cc9mr2734321685a.13.1793802296945;
        Wed, 04 Nov 2026 06:24:56 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.243])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d488d41csm209937185a.38.2026.11.04.06.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 06:24:55 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 04 Nov 2026 14:24:32 +0000
Subject: [PATCH v2 05/13] sched: use cred_ids_allow_sched()
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
Message-Id: <20261104-b4-cred-ids-v2-5-956213608f16@toxicpanda.com>
References: <20261104-b4-cred-ids-v2-0-956213608f16@toxicpanda.com>
In-Reply-To: <20261104-b4-cred-ids-v2-0-956213608f16@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>, 
 Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <sergeh@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793802280; l=672;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=ImeGFC9E0VS07fk/4WaXMGVI0o0kdEHLm780/RMXxek=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QK+gnTocRhHrbPXZJVH+S0euTmf6h1wO9Ccxsz5BBpiCsV7ndeahXaddCx+67kv6vX2ni3ZY2Ml
 JvmpWkwNn3gg=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Use the library in check_same_owner().

No functional change.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel/sched/syscalls.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 45a127deeadd..31650000d6cc 100644
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

