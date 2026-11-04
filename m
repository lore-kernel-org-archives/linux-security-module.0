Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802308;
	b=T4iO39EWRsAZYXUzEnBXo8hqK8HNBseN7fmoGlNIWSr6QJoa6pjZLOGFSfA5elzczaWI
	 HPIhOCa7e99ECRJziArGTmIEoLNf39rsh5RPzC5AhhK7+b6xnkFa8VvWJxndKKmJwt0JI
	 SqWjfwZwLKLv1VmXsEby+4oZA5Cac1ZJ9yEKl9Vgl++IP2iXRcVy9NXEy2uVKDS7Sb49G
	 vw8tummWFSRF57olSCC0QfYEC09mvaPyzsXPh/piRVo1+MHJ20HM63+QezlqABBSO73rM
	 ceYD2ojzRU0Ba5FdY8EROCJOrTGylm46VY1Z78U46gaDUOfoWMzZE5UX8cMSgnMm7Ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802308;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=uU0ZmbKgtbpmyh0NRAjEO7QIbv2AN0GiKmF3kwfwG1Q=;
	b=BbYQ/Vq1KTZKy7pvpr4FD1cnMlP5+cLe5Z5qCShchHsOuB2VR8zb0RazrJ7PoDzFm7c/
	 CoMJ+3UT1KWSFXa8PTaofs/Xb7UNM9crfvRrTlAR/DS3Y0H5b5AQpxfiK9LqnAfoIUl9D
	 tOln9fdVz065b8bcHsgI2DM3jWbAt5fsnLCgs2GPwyxR2G8xzA7r3rWKFb/vwGSQQaJFa
	 EbjlQtHs/zl2ed125CkwyMDC6E71lSrTJvyaxUNn4IIKAJkoQCu5paTof6diuKKEyPXK1
	 WnfslW8tEy8wlvgdYh3FGz4GF1Q/GUK7c5lYo2XehDU6gXRHFN2h8baSRfUOtYWB6Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=oEyxWkjV;
	arc=none smtp.remote-ip=209.85.160.177
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1179E606A32E
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 14:25:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1179E606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=oEyxWkjV
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-533861a59b8so7204521cf.1
        for <linux-security-module@vger.kernel.org>; Wed, 04 Nov 2026 06:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793802307; x=1794407107; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uU0ZmbKgtbpmyh0NRAjEO7QIbv2AN0GiKmF3kwfwG1Q=;
        b=oEyxWkjVmoeJkbuKHHlBXaO5pE3LeLoAki3G5gy/WAL+wBxujZDWIIP/j3syzdlQnR
         n4fkTqUY84Lef9XQZgD2YYjFx/RW/8Q0f3yTPmhwl/iU7ssJRgTwP0V2whXDd3Adbd7x
         Ps9ZCl228Mk1kuFjUZa5tHOcPMG/fd8v9LtSSnAMyRxcisxsQqz9HaEpcDhOvIFa3wan
         2r5LQhm0CUSsRliibxwDUO2afRj8kmZzXYjorcbiRjLAzCEojByRljd28Wu+CMLrgMPj
         k23FmT5QIFKYZAFI30apeCJuQEGHTFniTbC2meeNwbY8rtYrbnTuEAvQqc6GsuIMSa3a
         FoZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793802307; x=1794407107;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uU0ZmbKgtbpmyh0NRAjEO7QIbv2AN0GiKmF3kwfwG1Q=;
        b=vjT6UfgiNAOtOmludVsII7bMGtNgtnuM8BngqsNWFLGi0dRYs4RcfcxVzP3FT12F2B
         XjKoCLrF/dRR9BZQtOakrDkWslZJ7kU+eU8GODWBHeqY5/xbVQuDFvRIkB97JlAJvL5Y
         1LWVa3zeEoF3gPT3fSBQGPGvRG0ViEzHaSwy0He6SOtLjmLXcWz8pnT+WJThej6FMkN1
         NMvF3qAIlwlagh5iJYVy4DYRTS2KdBcJz6l0amXIJcrgdOtyXmwx4Glx8WuqUBOvWDAb
         LKGxLzYG/6vnSnRTAyinvtg4fKURN5r4R/ytNc/57Gajzvaix1v471xJwB/5JFonSTTN
         m4Rg==
X-Forwarded-Encrypted: i=1; AKwUvBxJdkEwYJcDizv7844WtLKlNUEhID4xjCqS8qiqQIkN0l1rdsroQDgH8Q6J+N80d4OvRl01dfoC0WWGFgnlRm9WUqTv+rM=@vger.kernel.org
X-Gm-Message-State: APuU4Z++zyJQaX1cLhLiaHwWOa3BOxQrlEkxuVaDPwzh1ll1BhCIEN0P
	0AaIaC0vJtNJgt5hhrn9k+2M8gTWI4EjUmU6x0FYKQdYbibyK5gZAXZR/8vw863qffA=
X-Gm-Gg: AYBFou05IEk4ULCJRLGBJXIjKOfWEvFttVoulHchB1AwkM0MW18w0UGjmleoQnBHq+J
	+vyTgOGoIWZ38apCzjoWwnnpbk96WMNAloMQ6OjCcq+zxZjV2bsony6O9IEicba5R4E6ngwQGNX
	2SJiE6ZGU7nSjqZ9KrNA7QJ57ssw1hYNmJQ0Z8LZpnth/fgYSV9P/FTVFDNjAPR2Yn+UoHFCV21
	qZOdJ4ibkkv4HTEW9QU5wsHXEPZlVN7yRBdV9fTxWgUGOWMZeo+pkOtLmnoJPpDb8K5c/gvC2i8
	qePPTAyA/RA0lpE2dhe8hoWNNnVtdNbBmTDrQT7yjH3MRIDSraa+LbJNHuVoDhqSs7zlr+nFSJL
	UtdbY/iy8txEHe/EIeGx/nTG23PLJfR+WOY96Eh+W0foim8RgeXPAxCs91XRSvpLDwN95fQHHxN
	MCUB+ep6w7a25XWm7/TH3zLgnKnhR4oflPDxCosRz8cZEp7A6UD61c9kcXTh1DUSzGOBX5IMzwj
	J5PDC2d1CURolRd9DUpe+yEXphv/YVuOHLiYQ5p/4pLtNsUFcGFSGRhhOzTOMvS+HkL5ji4iyr+
	ShP009mVCtJMMKG7JEqd1dTXIJb94Su/5JjKWntrCj54dw==
X-Received: by 2002:a05:622a:a15:b0:536:3463:88d2 with SMTP id d75a77b69052e-542b6a72b11mr270017251cf.22.1793802306837;
        Wed, 04 Nov 2026 06:25:06 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.242])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b10c4c4f3sm25077861cf.22.2026.11.04.06.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 06:25:04 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 04 Nov 2026 14:24:36 +0000
Subject: [PATCH v2 09/13] block: use cred_ids_allow_ioprio()
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
Message-Id: <20261104-b4-cred-ids-v2-9-956213608f16@toxicpanda.com>
References: <20261104-b4-cred-ids-v2-0-956213608f16@toxicpanda.com>
In-Reply-To: <20261104-b4-cred-ids-v2-0-956213608f16@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>, 
 Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <sergeh@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793802280; l=709;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=HCkm3woz1Qj/8S1BhSv5R6Rgu330cZd4oZfznXBked4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QOBqOKRK9z9065uB+rXEY/3ytfPvmwrvE+aNV6nps//9u/bgg+IFqePBtmuCmppOJHYnoAL8E8C
 lW40Ek8HG6wE=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Use the library in set_task_ioprio().

No functional change.

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

