Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61108358D22
	for <linux-security-module@vger.kernel.org>; Thu, 20 Nov 2025 15:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763651686; cv=none; b=O5qCrrIbEHwsK2B4dTIs1PhjOqEGzugrvpAvC1fLgI98usKdp5XNiumdYW3AByO0VSB4tP6gms1Kze+r+czpygm1FQIUV0FcsgB1eoURbGXH1xg/ddB9lKFhryXEX4DwS8x3v/HfJpHQ3ekv76IU6dJzdFqES1UBYOPrhtDNzOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763651686; c=relaxed/simple;
	bh=JghkiwHvBvL6JcsywiEEh15XJk0LP4WSUGT+cTqq5kc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kG2McOlI8AoLVjtw93iqrO90sdVSJErcSTmkyIruYJZKGbHCGJJpV5eTlMCd6XWJQrtPqH5N/dv19ZGnXmoJdYvUpUN9HUEBJ8Mb1mKyVA+SQNZV14kXbM0TEC7R8D1+vHMxtyozOMUCTBb4oBEHzupbkqjpwEC6ucKC+S2aKLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CJHAYRpj; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CJHAYRpj"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4775d8428e8so7791745e9.0
        for <linux-security-module@vger.kernel.org>; Thu, 20 Nov 2025 07:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763651635; x=1764256435; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Im5hsj1DltxV90KwIidFCTn0DS8FZncDFP7kTqaMpC0=;
        b=CJHAYRpj8OdyNZb9AA1JEkkGxogTxd4rLTjbLE2ImVrpUNP7iruS7fNrJbcEcbFDmR
         S4R0OuQRmnqP1zeN+epjN/RUXQcciANAC/S+LWnHaii0RAyiiT02phA5POdjnHUaMeDw
         wp1XhYYHnkB8BWvNIwB9MM2D7GO0wERdk6U53yuEk2HVRbKTSQ3dE4PBA47tye4tNUBc
         G6QqCwUs0XGMY53xRTBVYJnFcYzzcUZe1DsVIDWkTe5jl0Q21Nug0wQyG9AMTsGHD4P5
         p3HwB23RqXXJD9VgamMqIW4abFlWzPcir+ji95zxTIsUttAENUCrTRjy0LI6SxOEQ7Ig
         qejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763651635; x=1764256435;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Im5hsj1DltxV90KwIidFCTn0DS8FZncDFP7kTqaMpC0=;
        b=AizVvPI47B4OUS+o7DGHEWYWB+dp3+uxNr7NfPQpCIM1eHK9vubhkAo2oE7Zyo+ure
         E/X3Y6c91f5hqShnUkmgpks5CdiHRA8hPvVjQ70TH69qT49GD8Z8O2SQfZsLeUJ8lkhz
         eU1rxF779jyJBzkmugSShUN490XVImRHgt5uV+0jvBkHWMvEH9t23JBunApdbYillE5M
         NHl8WFw04d9fpk/lSqDZArl6fIDYwgj//e0HKqaR0QBCCI6MClU+XjrOHj4CO7vGSlK0
         UoEl4PkUtOszr5CL7J48wJYGu6nP0GAbQOaEP6hLd+U5qHv+f8BS5NZV1UfYkPzHY+Sb
         BEEw==
X-Forwarded-Encrypted: i=1; AJvYcCW9qXv5RazsdZSjo8hFsMcRugshQdRZAx9qeXvVAP15QlhlImRK/jxYNcQOwYu7O5a8Te2XIGgbppae3pFl8omgEa1tUas=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy/icGdBgO26mhIIbk79DTuyTFnooaBfPLOyxT/0NfSiT1ZAIB
	xZZNbXL8AM84IznamHQVEXtruIFoAWeW4md6/XLOH/ozQFdeEZHP5/Kb+ZiQWSd4MjOZzwP5xM0
	oPA==
X-Google-Smtp-Source: AGHT+IE0txFyfqWr7t8p06ZvcBdzNhQeJVfQ06tB7yPqhvYYx4yW0lw4v6t9Cn2mD+Uk9FOLbPP2gAnnVA==
X-Received: from wmd10.prod.google.com ([2002:a05:600c:604a:b0:477:9c68:bd6])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1c1b:b0:471:c72:c7f8
 with SMTP id 5b1f17b1804b1-477b9e1cbfbmr31262875e9.21.1763651635197; Thu, 20
 Nov 2025 07:13:55 -0800 (PST)
Date: Thu, 20 Nov 2025 16:09:57 +0100
In-Reply-To: <20251120151033.3840508-7-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251120145835.3833031-2-elver@google.com> <20251120151033.3840508-7-elver@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251120151033.3840508-33-elver@google.com>
Subject: [PATCH v4 32/35] printk: Move locking annotation to printk.c
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

With Sparse support gone, Clang is a bit more strict and warns:

./include/linux/console.h:492:50: error: use of undeclared identifier 'console_mutex'
  492 | extern void console_list_unlock(void) __releases(console_mutex);

Since it does not make sense to make console_mutex itself global, move
the annotation to printk.c. Context analysis remains disabled for
printk.c.

This is needed to enable context analysis for modules that include
<linux/console.h>.

Signed-off-by: Marco Elver <elver@google.com>
---
v2:
* New patch.
---
 include/linux/console.h | 4 ++--
 kernel/printk/printk.c  | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index 031a58dc2b91..1eb3c9d9d6ae 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -488,8 +488,8 @@ static inline bool console_srcu_read_lock_is_held(void)
 extern int console_srcu_read_lock(void);
 extern void console_srcu_read_unlock(int cookie);
 
-extern void console_list_lock(void) __acquires(console_mutex);
-extern void console_list_unlock(void) __releases(console_mutex);
+extern void console_list_lock(void);
+extern void console_list_unlock(void);
 
 extern struct hlist_head console_list;
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 5aee9ffb16b9..7646952a92f1 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -245,6 +245,7 @@ int devkmsg_sysctl_set_loglvl(const struct ctl_table *table, int write,
  * For console list or console->flags updates
  */
 void console_list_lock(void)
+	__acquires(&console_mutex)
 {
 	/*
 	 * In unregister_console() and console_force_preferred_locked(),
@@ -269,6 +270,7 @@ EXPORT_SYMBOL(console_list_lock);
  * Counterpart to console_list_lock()
  */
 void console_list_unlock(void)
+	__releases(&console_mutex)
 {
 	mutex_unlock(&console_mutex);
 }
-- 
2.52.0.rc1.455.g30608eb744-goog

