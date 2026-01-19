Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5E03587AC
	for <linux-security-module@vger.kernel.org>; Mon, 19 Jan 2026 09:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768815661; cv=none; b=HlGzZvZaotTntG6X6ssD7GrRC/Y345aKs6hychd7DZm6I0w9bXZJnQ3gAFe7yoc+9tUTMxERM5RazmQ8/TCCX6eV3oxzjzEjDsX7vvwAWhJUR6BgOyrVCyJAqI5MjqTInnUErmLYs299M1Jz1BEr+TuTf7y4eiwAwQr5/S5aoi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768815661; c=relaxed/simple;
	bh=y9/1uLJMC7+X7yi1h38x4esMDvrYwSDX9pt6Sh+Dy/I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KJtkaTL+szcEv1pYes3UntnrW7u5rvNin8hSuueIbj3CiXW561hxqVUTPljBC5j6tdto35lPRlt6YEyFFLxCrce9BYglHj7P8CPv0lXD05/n7rc1RmV/a3siLihEOllTT1LBGyM7fAh7EVVdMjag0jiIgqIdZg7UGdKoh6D5e88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lSImHJBn; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lSImHJBn"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-47edc79ff28so25949045e9.2
        for <linux-security-module@vger.kernel.org>; Mon, 19 Jan 2026 01:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768815657; x=1769420457; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CA3Nu437Rj+eAevya/i4iek0cQKs4Ymlx+qux+GVc44=;
        b=lSImHJBn+H6dS9/VrEouBwalyZflWzpJgQBwyX65HgE62415Bckxo4Bu/5W8G0TZzH
         ZWm070IlDWr73MbNf+U9SOQ1927APAYEc5S6T5+xGmYROb5bFuBAMbssknpHrzBTJvfq
         zxz6HmOUw4dO0X2Ziwe6p2S9qfFP01tYL79zXp6ca34KHL2vz7nXNNT0l5kp1Z8w2n0f
         Mm9p9jvGl0j28oYIvUix+b2KaEwTPY7pTji2P51gSrS/ubz6j6lUGRET9TFa1ffQacBV
         B1Ggusozm+sqPd2mhGIUicx7ioCLsPI6kIr+HXRgJeqLZQ830oXjTWWYBycc8mmlbNoU
         mV1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768815657; x=1769420457;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CA3Nu437Rj+eAevya/i4iek0cQKs4Ymlx+qux+GVc44=;
        b=SOMmKdsASDuDFQuS+byvnUFSdlJQUxaQtu8FTqut8IAJnA6s26Hy8BcpoVrnvPuZG4
         ACEhngqi6huDsmLw0shnRy+9qFKje7bZwbxUmGHYLnhfvzpjapwzlS3xDgNIp6JUk6Dk
         EMuWqw3/0xEdIU6GJ7gGYBk10+1OCOPiGGTsvzvGfXTnxINAJ7GNKgFrfVyieiAPDT1E
         qaYjdBGMP0tECajtqQepUfz/y2Iaf2SwOmFSRsWy9xcMLgzedqHLT+01vnopnJmwhX3x
         WxJNrUt2vIoyfmkLKcHP34sTWRAfelbMjlL2MGqEL4YQ80N3X/NLaPRlOXgDgGlVx8pq
         nZEg==
X-Forwarded-Encrypted: i=1; AJvYcCUJMYPqMhZOhTDdPgM6/wOtzKeuMxEv09rOaBAGPm9wNONh5mGTshF+NPTimcJVm2gPjBtyqAOFg9G+tENBhiaWyluecUc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq8uEYId9mBvWvqH5kKlxH3rlfK13evvim7KZYtemteQjnbKgx
	P4pemQhvi+gVEkL8dcM6z1A1G2mB0Ix/GKvC+zNEthyFDlEn23MOkCeOmIxbI6vuY482a7I5q2x
	omQ==
X-Received: from wmbka9.prod.google.com ([2002:a05:600c:5849:b0:480:2880:4d51])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600d:6413:10b0:480:1e40:3d2
 with SMTP id 5b1f17b1804b1-4801e400518mr100658775e9.29.1768815656749; Mon, 19
 Jan 2026 01:40:56 -0800 (PST)
Date: Mon, 19 Jan 2026 10:05:54 +0100
In-Reply-To: <20260119094029.1344361-1-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260119094029.1344361-1-elver@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260119094029.1344361-5-elver@google.com>
Subject: [PATCH tip/locking/core 4/6] crypto: Use scoped init guard
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
 crypto/crypto_engine.c | 2 +-
 crypto/drbg.c          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/crypto/crypto_engine.c b/crypto/crypto_engine.c
index 1653a4bf5b31..afb6848f7df4 100644
--- a/crypto/crypto_engine.c
+++ b/crypto/crypto_engine.c
@@ -453,7 +453,7 @@ struct crypto_engine *crypto_engine_alloc_init_and_set(struct device *dev,
 	snprintf(engine->name, sizeof(engine->name),
 		 "%s-engine", dev_name(dev));
 
-	spin_lock_init(&engine->queue_lock);
+	guard(spinlock_init)(&engine->queue_lock);
 	crypto_init_queue(&engine->queue, qlen);
 
 	engine->kworker = kthread_run_worker(0, "%s", engine->name);
diff --git a/crypto/drbg.c b/crypto/drbg.c
index 0a6f6c05a78f..21b339c76cca 100644
--- a/crypto/drbg.c
+++ b/crypto/drbg.c
@@ -1780,7 +1780,7 @@ static inline int __init drbg_healthcheck_sanity(void)
 	if (!drbg)
 		return -ENOMEM;
 
-	mutex_init(&drbg->drbg_mutex);
+	guard(mutex_init)(&drbg->drbg_mutex);
 	drbg->core = &drbg_cores[coreref];
 	drbg->reseed_threshold = drbg_max_requests(drbg);
 
-- 
2.52.0.457.g6b5491de43-goog

