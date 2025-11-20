Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5B73570DF
	for <linux-security-module@vger.kernel.org>; Thu, 20 Nov 2025 15:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763651526; cv=none; b=mQftxSsp1iP9c+74CAbe0cse/hX4NtmjA0BviPFLz0lEApD5HCQ+1qORyGs2l7Quaxtn5WMuqOp0Ol3Uf66DhyYoLmA80J6q5ddwCKC8iNUWw12IM3Njybzzmhe9teHzMMXSm1xYzMCRVFK4gXi7yViCjSt8DIdo7xJUbKurIOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763651526; c=relaxed/simple;
	bh=EwfXd6yRg4bFKtUUrXe0W+ENNOKQmqy6Ot7CBhxbXoQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A4j+TQCXEQXpPpuR4DemfmSEoHnKfJkB9R4OCvyMdEd/ZtGb6BPb7pEwywaicHmFo/U0BUof67steZoDZuG/qN23PfBhAkD/JT0mawFdxTalaD2FHZqC2FDvKxsOO0fTO6oMsUOn3lxvyWs69oUguL5QSOwiVq07/yV5EJhylto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xsfFmKc8; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xsfFmKc8"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-42b5556d80bso773198f8f.2
        for <linux-security-module@vger.kernel.org>; Thu, 20 Nov 2025 07:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763651517; x=1764256317; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sW5aRQBUT1YS/p7X2M8vu94/jdaGEDQWZc189ONsN2k=;
        b=xsfFmKc8YQqE7ZmQkLgJKnqmKOU/uA87c6/ON0okVKo2MBLULEPO2/NPOCcjl+IDBc
         JaBGvwlVkOZigGvfWcy0qxYz7k29aod+CZ4S71gKcSLnL1gKpBN2IAGKVrQ4zDPaz3SM
         64Cj1jEhOc3VbKpN2vIGxsup63VTlWJshpiDDPu+goFDb7dW1/eivI89N1BLCn0eBVjy
         pAiSGh1blGwNhBfoNISXlS64PUZ1XR2YyC+MfoKbXGum6EpVh3pkoTLq1mVW+0ttxhXl
         d88uyRuAkZdKYgVmg6AHeJKGKGwcXH35YM2nNfVr1k8v23/0XRFm6L2NqvsZ6FmG9nyE
         9Qvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763651517; x=1764256317;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sW5aRQBUT1YS/p7X2M8vu94/jdaGEDQWZc189ONsN2k=;
        b=kPXv6khQBaJIOqvgzr7CbOd7YoLOIMiqcH4PYRAqE4sA0Fo8N/hL2g//fTajZEuwzf
         7VSQVvD5LLFac1S77tKFuitz9Mgh7QTdMvbw7ozT+EjSxWnHGfM7KkCsgCi0wr4JeosM
         So8ddBUa839wzZ3MjeETDkOQUUuJ4r0TmxDIgxwcepZVhnW8fO+XXp/xGrwvC9J5H1NX
         0nATjln1da7KidJIz95VZHUtNT8y1Vi7/nuH0Y1u3LyPLl/Snj/X41ChYVkx6hhGqXnU
         ESAGDxXDLpGE+jer97kaBbFQdCUVHzJkSGPo0uNn+4/5YuWNcqJEh/KuQ6LZrhCceFOE
         bmzg==
X-Forwarded-Encrypted: i=1; AJvYcCVguV4iTnOvAoUwWlq2bL0ye30HOF/Efv2TXx1o6Mnpd/aQzB7fhFXV3aNZcfp6janUsY8KpSKUCk77VPFuZoj0gnmqtXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH/Bo+jPL7bO1gi6BAYQ0UO1h/K8N7zujbVJd/J6SrFyc5n2L7
	2y6o0oE/4TllmEebS8iu5exxmy1PzX5yOhJf8u6zJWhkKfd9DUCHgeDpXfhaBMcu2ZfTpCii8FH
	0eA==
X-Google-Smtp-Source: AGHT+IER1f7gc9WQ7LnpbrPIA/y0BLZGbO4bUsdn+Ne1pOxE592x9Yu2PvTpMRh0Noc8+8JrQHGkxnvByA==
X-Received: from wrsz10.prod.google.com ([2002:a5d:4c8a:0:b0:42b:3a01:7808])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:adf:f290:0:b0:42b:3e0a:64b7
 with SMTP id ffacd0b85a97d-42cb9a560c2mr2413997f8f.53.1763651508025; Thu, 20
 Nov 2025 07:11:48 -0800 (PST)
Date: Thu, 20 Nov 2025 16:09:32 +0100
In-Reply-To: <20251120151033.3840508-7-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251120145835.3833031-2-elver@google.com> <20251120151033.3840508-7-elver@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251120151033.3840508-8-elver@google.com>
Subject: [PATCH v4 07/35] lockdep: Annotate lockdep assertions for context analysis
From: Marco Elver <elver@google.com>
To: elver@google.com, Peter Zijlstra <peterz@infradead.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	Chris Li <sparse@chrisli.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Alexander Potapenko <glider@google.com>, Arnd Bergmann <arnd@arndb.de>, Bart Van Assche <bvanassche@acm.org>, 
	Christoph Hellwig <hch@lst.de>, Dmitry Vyukov <dvyukov@google.com>, Eric Dumazet <edumazet@google.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Ian Rogers <irogers@google.com>, 
	Jann Horn <jannh@google.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Johannes Berg <johannes.berg@intel.com>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Triplett <josh@joshtriplett.org>, Justin Stitt <justinstitt@google.com>, 
	Kees Cook <kees@kernel.org>, Kentaro Takeda <takedakn@nttdata.co.jp>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Thomas Gleixner <tglx@linutronix.de>, 
	Thomas Graf <tgraf@suug.ch>, Uladzislau Rezki <urezki@gmail.com>, Waiman Long <longman@redhat.com>, 
	kasan-dev@googlegroups.com, linux-crypto@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, linux-sparse@vger.kernel.org, 
	linux-wireless@vger.kernel.org, llvm@lists.linux.dev, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Clang's context analysis can be made aware of functions that assert that
locks are held.

Presence of these annotations causes the analysis to assume the context
guard is held after calls to the annotated function, and avoid false
positives with complex control-flow; for example, where not all
control-flow paths in a function require a held lock, and therefore
marking the function with __must_hold(..) is inappropriate.

Signed-off-by: Marco Elver <elver@google.com>
---
v4:
* Rename capability -> context analysis.

v3:
* __assert -> __assume rename
---
 include/linux/lockdep.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 67964dc4db95..2c99a6823161 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -282,16 +282,16 @@ extern void lock_unpin_lock(struct lockdep_map *lock, struct pin_cookie);
 	do { WARN_ON_ONCE(debug_locks && !(cond)); } while (0)
 
 #define lockdep_assert_held(l)		\
-	lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
+	do { lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD); __assume_ctx_guard(l); } while (0)
 
 #define lockdep_assert_not_held(l)	\
 	lockdep_assert(lockdep_is_held(l) != LOCK_STATE_HELD)
 
 #define lockdep_assert_held_write(l)	\
-	lockdep_assert(lockdep_is_held_type(l, 0))
+	do { lockdep_assert(lockdep_is_held_type(l, 0)); __assume_ctx_guard(l); } while (0)
 
 #define lockdep_assert_held_read(l)	\
-	lockdep_assert(lockdep_is_held_type(l, 1))
+	do { lockdep_assert(lockdep_is_held_type(l, 1)); __assume_shared_ctx_guard(l); } while (0)
 
 #define lockdep_assert_held_once(l)		\
 	lockdep_assert_once(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
@@ -389,10 +389,10 @@ extern int lockdep_is_held(const void *);
 #define lockdep_assert(c)			do { } while (0)
 #define lockdep_assert_once(c)			do { } while (0)
 
-#define lockdep_assert_held(l)			do { (void)(l); } while (0)
+#define lockdep_assert_held(l)			__assume_ctx_guard(l)
 #define lockdep_assert_not_held(l)		do { (void)(l); } while (0)
-#define lockdep_assert_held_write(l)		do { (void)(l); } while (0)
-#define lockdep_assert_held_read(l)		do { (void)(l); } while (0)
+#define lockdep_assert_held_write(l)		__assume_ctx_guard(l)
+#define lockdep_assert_held_read(l)		__assume_shared_ctx_guard(l)
 #define lockdep_assert_held_once(l)		do { (void)(l); } while (0)
 #define lockdep_assert_none_held_once()	do { } while (0)
 
-- 
2.52.0.rc1.455.g30608eb744-goog

