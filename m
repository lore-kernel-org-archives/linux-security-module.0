Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D83358D0C
	for <linux-security-module@vger.kernel.org>; Mon, 19 Jan 2026 09:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768815663; cv=none; b=YfF6C4uKyYjxmdCQv0DP1+3pB8eZ1CVociVhtI8aL1r+ZKUBXU3zAffvafLw+VyDHQZNYiUVoef2taMrSoOeIsPiCJ4e1+1Ik59y7yVpT/KKdXxTT0hNRZ1FHnz2U61rpoN8LnB+qW+NAXgm+x6ueUGX1WkY5rusViPrWRmaLOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768815663; c=relaxed/simple;
	bh=fI1glmYoH1DqxqK83xKlTtx/Ar+iZrLYeSgCJ+MEbqk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iRMQ0enH5nOuJU+Zi5MeTEiDct6nKQRy5r6wVbxfZKaM8tIVC3b2OeuOUY8Zb/73xZUXUJg1UT3OJpNeR6Va6VQt0OpQpVvHGteJrupfy0jrjsIfYa6U3dgHgDZ+RaKX1TPE00q05I6PpxwMADNT2SZAIRDSryUfQJrU7uoiQ3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uu0zsUK2; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uu0zsUK2"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4802bb29400so21386335e9.0
        for <linux-security-module@vger.kernel.org>; Mon, 19 Jan 2026 01:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768815660; x=1769420460; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5O5shuIyt2OF6tzGpJJeUtztHqWv8B89x7ZKRetoFcY=;
        b=uu0zsUK23jzmEiaM2Subjz/ybCMO0DMBce9778NGTfo96iqoQN8UXZCF7eAGW1zAT3
         4bXPHXoe4IY5Ab74cv7dW31EZpR0dAPxrNmiOqWzKk1duMMqVIfwXumBLoV6SLivHliF
         OVGP31IrWiXyDXqxnrIMDT07qTvhg5kaA2eebblQxjVyRlzpwrKlyvxmgXw2uiYRSt4a
         qQkayttv06jd9yRvkrwzByurgxm1GzM2kHfF2jfp0JcvmcjoKD8Gt4yh4FMawZOogYYJ
         gib4rQeHt5rR/+JTTx9fvr3DO0QmcBz87i8Ktb0EwJX3xBvcluAHub0hFBzJewhzcXUx
         f69g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768815660; x=1769420460;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5O5shuIyt2OF6tzGpJJeUtztHqWv8B89x7ZKRetoFcY=;
        b=lSpjfuLcRqORcrQqzfzsJI/t3g7cNAZTlmwNn60FEr5f94X1IWGHBOeC1yJmiMCRea
         FW8onIDaGwP5NSXW9KIktxGyyTppMrv5h8X0U2mJFmMFZGImFY17SI83nlrDinN3blRK
         +9TNCnUsCHtPH1bveVzxMEAqnjACIuwJSsz8GLCthIEnKrYVtR6X4BuvFA0jELwGuYMe
         GPylhhvoA9fzuIvFwzvdYYMd8dOTH9ZkHPbEzHbfCwZfnPAaAL0Tt2+M/8/1u93dsna9
         8SxILtushdrzHqL4Ja4ZxtNR0Nz50xTxNXMjLPD/w+NwkeJl+GUvHF1WTGPmTBV+hQrr
         3NfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUW5rziylWrHS24yR6OONgRMKBSIqSVU7W6XHJ0dSUlBJMF14WV3zo+ySfDn7zpGbrHtdLoSi/1/V5pPDVOqNdrM41j++s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKYncMnBkhEf1HsOywIuDyLseXGfpZi0WVu+my4tNE35UEF+0B
	pF1/FcVSiXJiuhE7PTehkKwO8xRAoYfpY0DgfkDg19FvQXh/E0w52+iDkGz1UiPpm+9E0WPgl8O
	oiQ==
X-Received: from wmbhb2.prod.google.com ([2002:a05:600c:8682:b0:480:3842:3532])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:8b81:b0:480:32da:f338
 with SMTP id 5b1f17b1804b1-48032daf48bmr41618245e9.14.1768815659820; Mon, 19
 Jan 2026 01:40:59 -0800 (PST)
Date: Mon, 19 Jan 2026 10:05:55 +0100
In-Reply-To: <20260119094029.1344361-1-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260119094029.1344361-1-elver@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260119094029.1344361-6-elver@google.com>
Subject: [PATCH tip/locking/core 5/6] tomoyo: Use scoped init guard
From: Marco Elver <elver@google.com>
To: elver@google.com, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>, 
	Christoph Hellwig <hch@lst.de>, Steven Rostedt <rostedt@goodmis.org>, Bart Van Assche <bvanassche@acm.org>, 
	kasan-dev@googlegroups.com, llvm@lists.linux.dev, 
	linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Convert lock initialization to scoped guarded initialization where
lock-guarded members are initialized in the same scope.

This ensures the context analysis treats the context as active during member
initialization. This is required to avoid errors once implicit context
assertion is removed.

Signed-off-by: Marco Elver <elver@google.com>
---
 security/tomoyo/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/tomoyo/common.c b/security/tomoyo/common.c
index 86ce56c32d37..7e1f825d903b 100644
--- a/security/tomoyo/common.c
+++ b/security/tomoyo/common.c
@@ -2557,7 +2557,7 @@ int tomoyo_open_control(const u8 type, struct file *file)
 
 	if (!head)
 		return -ENOMEM;
-	mutex_init(&head->io_sem);
+	guard(mutex_init)(&head->io_sem);
 	head->type = type;
 	switch (type) {
 	case TOMOYO_DOMAINPOLICY:
-- 
2.52.0.457.g6b5491de43-goog

