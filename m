Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96557350A15
	for <linux-security-module@vger.kernel.org>; Thu, 20 Nov 2025 15:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763651651; cv=none; b=R917RO4tSqnqbaOPn2+GwsdbC3UFNcSG0sNnp10hiG7upMojUNdElBcTlKckDGg4FVbFmUNL4ZdCOh3WnsdRKzMEYDjk72EL2e1JQst8HqhkHW1z6hmKTikIjmzKQfFXdGmkk7Qk8jCtArfbeMKa58eDTOaFhWzWH+hMx7kT7AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763651651; c=relaxed/simple;
	bh=yQGcXxXaYdZ5kiCIpIMXgPxTJIXhYJPCbcz+VxA3nLc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=goh7Dnbx5Xv7nIzCMzdAv8iuKY2ztiHUETjYPWxAay19WG4IB3O099vfWWe8tfMoVuqAtL90wT/8XtgGATkz3+O0hn05f/4Q4e+NqCsjP4IV1kf9XeK7RhqcRL7OfeHZiPiKtTsjw2OMeIlzXSKWEEEHPvMiLhG6dTDWzMznKgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AVGr19z1; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AVGr19z1"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-47106720618so9426515e9.1
        for <linux-security-module@vger.kernel.org>; Thu, 20 Nov 2025 07:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763651624; x=1764256424; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P9dnEf98rT3yxtmvLOfZj9VjyyDpDqGX8DLsl5ZbgJ0=;
        b=AVGr19z1SXDwkxw3BWODf4IZO157ZRMnPAJj7JT4JRPtGsCmGP2iCuL1ZbyKkDdO+D
         1mGJRJJNfACl6UAogwuAOGxLLhbPm74MbLhJ78u9MCwo6P8/eiKTEQ9Sb+NCUD4d5Cg/
         n0BJZmutrveIz+B/bky3LG+b/KFvkT5e4TZ1NX9zWhJrUnYjALGhUfBli8+IvVtlHq0x
         oz2JE1bkXbAIaOVK7QavdsrdQCUM8U4YpBBsYmVOaq7DUQFOj+h6+qu89MJYhaH0eil8
         UvDb149gRyT2cFu9UP8CoNvBBC/btV+jefC0gWKTH9JwGS4ZiD7tKQaoozq6m2nH3JS+
         3Cpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763651624; x=1764256424;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P9dnEf98rT3yxtmvLOfZj9VjyyDpDqGX8DLsl5ZbgJ0=;
        b=QZk0HyLP32eIcWxDmXo8zykzP6YqneFUUQCnsyCW/0EQgV1FlBsYJ/kd7o6GRFybNI
         SmR8Ub5JUd8QPn2BEFv+DHxDaRlHsectWRueen/xEUKNDdB2UwotC5c2OGvw7NzucpqQ
         T/Hag8NpZCIfahR+wfVNIBm7/HaKLfbCuQOdsIr0zRFRntZLmGiB2XZjRECJV5mrrAdV
         h1hadnYoj0pzZpODVmbuVBQkD4TAwFGt1nK6Eo3Vu1fahO/Jcz6TGAWzjC+D2P9X85IS
         AW9zuD3l8o4Hu5fPQT0dR+NCWleFgfUCBamvYIfT9JGXanwM2Se23XUUJ5NVwKUrXoL8
         q++w==
X-Forwarded-Encrypted: i=1; AJvYcCWQuoDf/dGTfLnu48YQcelQpjGULkvV2cihbBKaN6jCQW19U3hOlDkaRued6PVFYcV3WgGJuM0Jt3wFE51frb1/93TfC1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVfL9v09TtVqN5vu5bZTReqvp9zpgO49Rzc7gqJC0TkhE8d8TA
	6357Q+UUr9yGwybzcuu1gQLk/cQkU97qwHEu9bGckOQ6HZ37Kq55IDNIPHsq8ezn1vugAzJlKNF
	ptA==
X-Google-Smtp-Source: AGHT+IFzrSwtwY7miOmNK7LYeHpXeHuMSiPUb/wnjFTBiV4tGaze/1FaluK98MtjxDYipw+SZftzMsNxWw==
X-Received: from wmpq6.prod.google.com ([2002:a05:600c:3306:b0:477:9976:8214])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:b95:b0:471:21:554a
 with SMTP id 5b1f17b1804b1-477b9dd716fmr25371575e9.13.1763651623805; Thu, 20
 Nov 2025 07:13:43 -0800 (PST)
Date: Thu, 20 Nov 2025 16:09:54 +0100
In-Reply-To: <20251120151033.3840508-7-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251120145835.3833031-2-elver@google.com> <20251120151033.3840508-7-elver@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251120151033.3840508-30-elver@google.com>
Subject: [PATCH v4 29/35] kcsan: Enable context analysis
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

Enable context analysis for the KCSAN subsystem.

Signed-off-by: Marco Elver <elver@google.com>
---
v4:
* Rename capability -> context analysis.

v3:
* New patch.
---
 kernel/kcsan/Makefile |  2 ++
 kernel/kcsan/report.c | 11 ++++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/kernel/kcsan/Makefile b/kernel/kcsan/Makefile
index a45f3dfc8d14..824f30c93252 100644
--- a/kernel/kcsan/Makefile
+++ b/kernel/kcsan/Makefile
@@ -1,4 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
+CONTEXT_ANALYSIS := y
+
 KCSAN_SANITIZE := n
 KCOV_INSTRUMENT := n
 UBSAN_SANITIZE := n
diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index e95ce7d7a76e..11a48b78f8d1 100644
--- a/kernel/kcsan/report.c
+++ b/kernel/kcsan/report.c
@@ -116,6 +116,7 @@ static DEFINE_RAW_SPINLOCK(report_lock);
  * been reported since (now - KCSAN_REPORT_ONCE_IN_MS).
  */
 static bool rate_limit_report(unsigned long frame1, unsigned long frame2)
+	__must_hold(&report_lock)
 {
 	struct report_time *use_entry = &report_times[0];
 	unsigned long invalid_before;
@@ -366,6 +367,7 @@ static int sym_strcmp(void *addr1, void *addr2)
 
 static void
 print_stack_trace(unsigned long stack_entries[], int num_entries, unsigned long reordered_to)
+	__must_hold(&report_lock)
 {
 	stack_trace_print(stack_entries, num_entries, 0);
 	if (reordered_to)
@@ -373,6 +375,7 @@ print_stack_trace(unsigned long stack_entries[], int num_entries, unsigned long
 }
 
 static void print_verbose_info(struct task_struct *task)
+	__must_hold(&report_lock)
 {
 	if (!task)
 		return;
@@ -389,6 +392,7 @@ static void print_report(enum kcsan_value_change value_change,
 			 const struct access_info *ai,
 			 struct other_info *other_info,
 			 u64 old, u64 new, u64 mask)
+	__must_hold(&report_lock)
 {
 	unsigned long reordered_to = 0;
 	unsigned long stack_entries[NUM_STACK_ENTRIES] = { 0 };
@@ -496,6 +500,7 @@ static void print_report(enum kcsan_value_change value_change,
 }
 
 static void release_report(unsigned long *flags, struct other_info *other_info)
+	__releases(&report_lock)
 {
 	/*
 	 * Use size to denote valid/invalid, since KCSAN entirely ignores
@@ -507,13 +512,11 @@ static void release_report(unsigned long *flags, struct other_info *other_info)
 
 /*
  * Sets @other_info->task and awaits consumption of @other_info.
- *
- * Precondition: report_lock is held.
- * Postcondition: report_lock is held.
  */
 static void set_other_info_task_blocking(unsigned long *flags,
 					 const struct access_info *ai,
 					 struct other_info *other_info)
+	__must_hold(&report_lock)
 {
 	/*
 	 * We may be instrumenting a code-path where current->state is already
@@ -572,6 +575,7 @@ static void set_other_info_task_blocking(unsigned long *flags,
 static void prepare_report_producer(unsigned long *flags,
 				    const struct access_info *ai,
 				    struct other_info *other_info)
+	__must_not_hold(&report_lock)
 {
 	raw_spin_lock_irqsave(&report_lock, *flags);
 
@@ -603,6 +607,7 @@ static void prepare_report_producer(unsigned long *flags,
 static bool prepare_report_consumer(unsigned long *flags,
 				    const struct access_info *ai,
 				    struct other_info *other_info)
+	__cond_acquires(true, &report_lock)
 {
 
 	raw_spin_lock_irqsave(&report_lock, *flags);
-- 
2.52.0.rc1.455.g30608eb744-goog

