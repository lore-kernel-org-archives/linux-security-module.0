Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802303;
	b=uIP2zV06sCENgzcI7saKCLRNQRJkBm4RVA1Jo2lOfKB58AaOn4QgdvnzMJ+km/FGARRd
	 Uu23FSWLRhA3Jv3Re3o+sJ38pOa5YhTO9RJgZYv+g/U2mg9msDToNBCAwV2NGE9wPF3WI
	 hiY8moY5SR53ZVqnlpQ5nipnr/cR7DC3YSKtzlNaa/2dGmWmn7jizokvSwRzY/ZxW2MR4
	 a2/eIY1cDTOrnw0DN8lK6v0HpQc3tzXOzUffmNJNQA8licXnjUgplXUv24qnnG8F6xhcw
	 CTkz71HPQHrF35NihxpgHym/loHzMlt2RD0jYbK4f4nHWgeGc+g6MD4ks4HUrZidHlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802303;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=o/jpNxRKXj1HQ8M8q/J1Wj0lnd4CYnsGrh81DKTgUlM=;
	b=N28/78wxdqfQAFjHRg0vAUfWA4pNJS0Kk8+wzQ4ZVEwHtVTYrDTYDzMFkuMFyWf7yKDs
	 aVQLYXWXecjLsYVEuf6NGeoeDnoFE1/Gwg/KLg0Akt13ewwSRZZcTIp0hOARze63YnM6K
	 7s1JjsUGqnzKaAf+0Yc236pwusEtq+prpfRFgVEYaFL3FMplGsxyu/TbGqIYhL7s3vd7j
	 QjkkPrEHrCbkIXTdH2CPp7kMh/nOiqJBaDVNO8wCOyPy981450OGTassw5CQgysLtUz1A
	 SRm1evO/RaeVQ35/VE+2yj/x16NZAgQRs1JpxhIyWg+0id3wCtKJVqaeQtmah7fuBxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=c+usujfd;
	arc=none smtp.remote-ip=209.85.222.174
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA66606A329
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 14:25:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFA66606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=c+usujfd
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-93e7ad9f78dso92997485a.1
        for <linux-security-module@vger.kernel.org>; Wed, 04 Nov 2026 06:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793802302; x=1794407102; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o/jpNxRKXj1HQ8M8q/J1Wj0lnd4CYnsGrh81DKTgUlM=;
        b=c+usujfdOWO01tiz/rUVaQ5eBw0bEs1yCRFc+ArT91Laf+Zaw282OhwIDIjNsukvoR
         xYSCht4CqG+2bAaXsoDnty1REY4FONwm1nuUPPT0uAHnFNcRV2pQExO5RXhjbFXBMQC/
         LZcqWzbXOVf8kZct0Vj5PQNpFzfK/EW9r5V8sjv6nqtCJm4caAnJ5Q0c0oNczNVKA1Me
         Key8Gx7+8EkCLQ//vDsrxTqIbJIb36+m1ieRGlvzh9h24N/0b25KNcCwonV5BQfk817t
         evF6UCKdCZqo088cjNDUX0/Mf/gGtfxFU0S3u2rioqWYEJ3Xm0CCUl45Dmks1P4g6U6k
         pjug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793802302; x=1794407102;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o/jpNxRKXj1HQ8M8q/J1Wj0lnd4CYnsGrh81DKTgUlM=;
        b=fQe/IN04nSuf7cgsHhmE1Soub5dZSJzX+BVFR38+wVcQXb7hzH0p7TSVD5EDdThsdP
         m5Cw/bvkTL27SrgKCV4S09V7P7TVToG++5JFEUJ9M+RBRsKNetL/6BOJLsKf2JsL7WYl
         KteGQ84BoY+sf/xygY8IUN+djr312BsY6HRrmZcqf8YMCp1XQxm/2ryP9W3B0tLh50WE
         qljsj3VvtW1Ujc6fwApYwXyNZhusVFWs9myLv5tqBk3chFEee7JoGW7FdcJ/q/SEstF5
         eE9OX7E1nWYJnwGh6OYDWJokyCPYgYVv/WwjopBOUPsGn0S5iof6Yib/ljeEIPZ6roXB
         ugrw==
X-Forwarded-Encrypted: i=1; AKwUvBxkZFNaRBDfE/8OES3hqov7GtBTEE/CGqsS3mY+/3F+9+FzkhCK4JNMhYTp8uQ7iIsB6qmihCfU+IKc4hubDWvT0Ye+rt0=@vger.kernel.org
X-Gm-Message-State: APuU4Z97UkB6KN8GH+ziEw+yymkoAdmoh3vLc+36A3MMQHRcRRGci5u7
	zqF4n0JOYxMvVbTO81fXHE4b/A/SfGoAWHVM3aXKrEplW2iKgtb3pPKqkYXGunsopcA=
X-Gm-Gg: AYBFou2+jPwBZZ3PmxQQhOaFp4HL4zxmdPKP75w7Q6/sBO3wMRLKm4rMhWv56c1GS2H
	gP1ev2vIpWovz5Po0xFGp2clisZW5CjBEFuZjBBAmxHjFDwn95DalX9HIBQNwlnVAsBlJMi3+6e
	/0KLkeSQkfoItUf47bW1HuAwgPvT3o6rrDEGTW0pvxk6DW4IgR6jWWw8joCMTn8T+/PTIF1foat
	grI2MtcBe1wCERtahRzBS2IiHIEn/NrFT/MS6mF+rGfqZH4AWTdya2CIcHIx7KIIDiCht94jK0x
	0WTMeX5EsYZH6K4xIfu5E6y8nH6/g9S3aNy3X6BMLYQsysB82ikewzgbOO+sJhLnEi1zABi23FW
	HpyFEC04Ol20NaWwJm+lAlUOYQWmxSMH+B2uuWaXymVDfczPqP1DDvh31wxs6BcYmNlGogQRVeg
	AhV9Zli2+CdUO2vtWbkF4HNhIE3/pHxZjPVzxXnv94pBJ6gcWLt+lahxWcEfbbgBV/pI7RZEHq1
	jjqbO1c6XjPlNYoj6zCqdGLmFd2m4AT/x9dFhkzjECCPV7YXG1A5Vw/OWTKv0v73Ak9ILrDGPcz
	vGc1c02zU3PcTlqPayM/elsmwMeR9M0SH77SpftVaSnlTw==
X-Received: by 2002:a05:620a:6ccd:b0:93e:9292:1b96 with SMTP id af79cd13be357-94421585b68mr2812746985a.3.1793802301529;
        Wed, 04 Nov 2026 06:25:01 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7dacef6csm20042246d6.5.2026.11.04.06.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 06:24:59 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 04 Nov 2026 14:24:34 +0000
Subject: [PATCH v2 07/13] sys: use cred_ids_allow_sched() for setpriority()
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
Message-Id: <20261104-b4-cred-ids-v2-7-956213608f16@toxicpanda.com>
References: <20261104-b4-cred-ids-v2-0-956213608f16@toxicpanda.com>
In-Reply-To: <20261104-b4-cred-ids-v2-0-956213608f16@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>, 
 Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <sergeh@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793802280; l=771;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=VPsh6fgJJw5nz3/M97zkeRfTLM8beD7v2X2dOB0rRnE=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QMcbR93y0W1SyelgwjZFfc7apeyUd8ZPOJlTVOf9soBY1axMc2lMqQ4PGxDU5zQc7JH4yMXmoNq
 E0ZCmG6VE8Ak=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

set_one_prio_perm() makes the two comparisons of check_same_owner(),
written the other way around. Use the library.

No functional change.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel/sys.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index 755bfa5ccd92..e43491a9dceb 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -220,8 +220,7 @@ static bool set_one_prio_perm(struct task_struct *p)
 {
 	const struct cred *cred = current_cred(), *pcred = __task_cred(p);
 
-	if (uid_eq(pcred->uid,  cred->euid) ||
-	    uid_eq(pcred->euid, cred->euid))
+	if (cred_ids_allow_sched(cred, pcred))
 		return true;
 	if (ns_capable(pcred->user_ns, CAP_SYS_NICE))
 		return true;

-- 
2.55.0

