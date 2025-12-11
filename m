Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5094F3128B2
	for <linux-security-module@vger.kernel.org>; Thu, 11 Dec 2025 13:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765458780; cv=none; b=Pp5pW6d8ENSxxpWVjCbHc3/GjNFV5aQCCI/MDnHLovivqNtjELAHC1nLddN4RFZKVdfBObjJUqEYuL0iTmTMcRZq1AWJ+q2MJ7Gn0h2qz2cRZN3owquAdueQfexmWyRhHqq40lSJukDG1PAIhguWoOHhH0kpixBqQQz+9ykX4I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765458780; c=relaxed/simple;
	bh=v+ZQdnBsG3Jds4SOxdBrDPR7IaFiwIcDFZln0Uu2MNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZTPbBl2Vk2be4GsmUuvC9Eg4TRGqtAfLQq9GmndPRX9IQDvO4/NKvvFop08hotHfSb9w17BK0ztYOH1jvyplLVyV8iX4TIH1eo0fTTX5t4NufDoRk5ihS9NuJpPgbqrSYXSs5C/mIf4nlgzv8XIf6L+8z5B+KMX7IClglKtCVe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f+P7Ofz5; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f+P7Ofz5"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7a9c64dfa8aso36600b3a.3
        for <linux-security-module@vger.kernel.org>; Thu, 11 Dec 2025 05:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765458777; x=1766063577; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aSAWeLhswH6DwjvXpmjx7xXAiszMCLjSPlHn40Ul7IQ=;
        b=f+P7Ofz5GvNDqM11PpoM73HtcOSq+PXPnz1Wn4vDScEqJAf0blvok2y+9qhtzuGGol
         g3+2lLtll5Tb9cGXC8R9v6zYlWmrY25cxLGr4IH1k/t8/PgtrAkCwyeXqsbcnIcbjMPs
         Eq3n4uIZ2rc57yVIjhUaW47rj7UYk/v8LtDQdbzto6SrolDCFxrbO912J5QyZleZjvoT
         B+sXSjiWLOW2hIrm2jQFWW7+irMgNRudUcExYjlDdWX/iIzIaXV0pvdARMoYg4ZCDIeI
         zaPYn8ZAKUkvqTGnZeIfqtjwGMGSq5hLaVGt3aGhDWxXgmKFW7Urv7I7OQghOXagcbCu
         G6Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765458777; x=1766063577;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aSAWeLhswH6DwjvXpmjx7xXAiszMCLjSPlHn40Ul7IQ=;
        b=IKUKYg3M4ZA5+3byYXED3DaetBQs6jGNYTmQfwyNCoGc5dJxdsWxVOFWiyBu3Tb3Cz
         j+xk70V1Qy9OIVKcWCfzoZTi/pCPqto5yV7vjqas5zdIHhb0Z7XQEXqHdpdrBFXeGAWX
         NrLqxYwBWEXK++G8Vch44lrS63ahLTP2Flc98XmUtFq+HqOyDYPtVnSsYc5dfYSisUf4
         89Uv7IgEvZa2owo6svYuLplVx5KCp8ykDfJAkt2g32aIfQfEIjXWq5BZLqvNSHzUx+zX
         DNrFacXvXrW/tGzhbEOyti7KYniRZa5FIuGAP2YNAe6CVQ5k3VciZz/wHUKJCpzfRDw1
         nOwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQrpARoWZe3KAiN+JNk3wyaTiJ3XMJO+Ji+40JGAzyLqn5eMfbbelnPIOmD6TIoCwkbF3ALi0sCE8VGp7fMaocZTl1Pno=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzf7R0DRA/92LHqKGbqjdnvMyQKMAWvuoINfcD4TYtVEUIKLsv
	VKCosbS+3ZGgNisnLcbp2pVKO1YdDkHfJpuYAUZmwG+MvHerpCdjUdHagr9b6W3+i05D+s8CRje
	HTe84AyfxoIan4iIi8R8JyqEQ/lyyU9DvgYlZV3/l
X-Gm-Gg: AY/fxX7wqpEPLYBAiZ7wF3un+EcfipEtYnljs8v0KH32tt3lAkqXMAgCj6S0ZU374qU
	a/V7gPJ+d5tl3PMzvVE4ETIk5eXT1oNkSAJvh48MQn3cHXLuSPH+UHgjVEIf4AoJegUynvcJqmY
	BmAUSKzf5H39OqyGJMF3J8jVsNrlrURVLAF8L1cTSGjPHxvdWD8O3wiG72bbzMVxspK9QdZAJoQ
	Ver3loViKUlFP2tjd1k0kRoLGkNuCYqLfYL/FoKuqFLehTxgXb8Mqke+ylgsm7FEO8KpQR0T2Kq
	6qUNqNytZCFyC6lHYQs3sqvJ
X-Google-Smtp-Source: AGHT+IFKUTpUZDJYgmni8n60xNJbrbAVNuDkEgVCtA4vIsV0NrU5sPU9y26HNSVsbHocOOsMdXB5E5HCLF6JNhBBnMQ=
X-Received: by 2002:a05:7022:685:b0:11a:5065:8763 with SMTP id
 a92af1059eb24-11f2966a3c7mr5044765c88.5.1765458776836; Thu, 11 Dec 2025
 05:12:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120145835.3833031-2-elver@google.com> <20251120145835.3833031-4-elver@google.com>
 <20251211120441.GG3911114@noisy.programming.kicks-ass.net>
In-Reply-To: <20251211120441.GG3911114@noisy.programming.kicks-ass.net>
From: Marco Elver <elver@google.com>
Date: Thu, 11 Dec 2025 14:12:19 +0100
X-Gm-Features: AQt7F2ok29a5Gxu0w202jEvGPrWPxaH5LVi0EBv48F585MyX9KePj1tDpUehhNc
Message-ID: <CANpmjNOyDW7-G5Op5nw722ecPEv=Ys5TPbJnVBB1_WGiM2LeWQ@mail.gmail.com>
Subject: Re: [PATCH v4 02/35] compiler-context-analysis: Add infrastructure
 for Context Analysis with Clang
To: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@kernel.org>, 
	Will Deacon <will@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Chris Li <sparse@chrisli.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Alexander Potapenko <glider@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Bart Van Assche <bvanassche@acm.org>, Christoph Hellwig <hch@lst.de>, Dmitry Vyukov <dvyukov@google.com>, 
	Eric Dumazet <edumazet@google.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Ian Rogers <irogers@google.com>, Jann Horn <jannh@google.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Johannes Berg <johannes.berg@intel.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Triplett <josh@joshtriplett.org>, 
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>, 
	Kentaro Takeda <takedakn@nttdata.co.jp>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Thomas Gleixner <tglx@linutronix.de>, 
	Thomas Graf <tgraf@suug.ch>, Uladzislau Rezki <urezki@gmail.com>, Waiman Long <longman@redhat.com>, 
	kasan-dev@googlegroups.com, linux-crypto@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, linux-sparse@vger.kernel.org, 
	linux-wireless@vger.kernel.org, llvm@lists.linux.dev, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Dec 2025 at 13:04, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Nov 20, 2025 at 03:49:04PM +0100, Marco Elver wrote:
>
> > +/**
> > + * context_guard_struct() - declare or define a context guard struct
> > + * @name: struct name
> > + *
> > + * Helper to declare or define a struct type that is also a context guard.
> > + *
> > + * .. code-block:: c
> > + *
> > + *   context_guard_struct(my_handle) {
> > + *           int foo;
> > + *           long bar;
> > + *   };
> > + *
> > + *   struct some_state {
> > + *           ...
> > + *   };
> > + *   // ... declared elsewhere ...
> > + *   context_guard_struct(some_state);
> > + *
> > + * Note: The implementation defines several helper functions that can acquire
> > + * and release the context guard.
> > + */
> > +# define context_guard_struct(name, ...)                                                             \
> > +     struct __ctx_guard_type(name) __VA_ARGS__ name;                                                 \
> > +     static __always_inline void __acquire_ctx_guard(const struct name *var)                         \
> > +             __attribute__((overloadable)) __no_context_analysis __acquires_ctx_guard(var) { }       \
> > +     static __always_inline void __acquire_shared_ctx_guard(const struct name *var)                  \
> > +             __attribute__((overloadable)) __no_context_analysis __acquires_shared_ctx_guard(var) { } \
> > +     static __always_inline bool __try_acquire_ctx_guard(const struct name *var, bool ret)           \
> > +             __attribute__((overloadable)) __no_context_analysis __try_acquires_ctx_guard(1, var)    \
> > +     { return ret; }                                                                                 \
> > +     static __always_inline bool __try_acquire_shared_ctx_guard(const struct name *var, bool ret)    \
> > +             __attribute__((overloadable)) __no_context_analysis __try_acquires_shared_ctx_guard(1, var) \
> > +     { return ret; }                                                                                 \
> > +     static __always_inline void __release_ctx_guard(const struct name *var)                         \
> > +             __attribute__((overloadable)) __no_context_analysis __releases_ctx_guard(var) { }       \
> > +     static __always_inline void __release_shared_ctx_guard(const struct name *var)                  \
> > +             __attribute__((overloadable)) __no_context_analysis __releases_shared_ctx_guard(var) { } \
> > +     static __always_inline void __assume_ctx_guard(const struct name *var)                          \
> > +             __attribute__((overloadable)) __assumes_ctx_guard(var) { }                              \
> > +     static __always_inline void __assume_shared_ctx_guard(const struct name *var)                   \
> > +             __attribute__((overloadable)) __assumes_shared_ctx_guard(var) { }                       \
> > +     struct name
>
> -typedef struct {
> +context_guard_struct(rwlock) {
>         struct rwbase_rt        rwbase;
>         atomic_t                readers;
>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
>         struct lockdep_map      dep_map;
>  #endif
> -} rwlock_t;
> +};
> +typedef struct rwlock rwlock_t;
>
>
> I must say I find the 'guard' naming here somewhat confusing. This is
> not a guard, but an actual lock type.

The switch to "context analysis" required us coming up with a name for
the actual objects (previously: "capability") that "guard" those
contexts.

The reasoning was that these are guards for entering a particular
context. The lock guards the given context, but the context itself !=
lock. Clang's naming of "capability" was a lot clearer in isolation,
but the problem that Linus raised is that "capability" is already
overloaded in the kernel.

The fact it overlaps in naming with the other guard(..) infrastructure
is not entirely coincidental, but I see the confusion.

What's a better name?

context_lock_struct -> and call it "context lock" rather than "context
guard"; it might work also for things like RCU, PREEMPT, BH, etc. that
aren't normal "locks", but could claim they are "context locks".

context_handle_struct -> "context handle" ...

?
