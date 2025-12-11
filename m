Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272C32C0F75
	for <linux-security-module@vger.kernel.org>; Thu, 11 Dec 2025 13:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765461287; cv=none; b=HJpsBKFS5zt8qlGvXRmOu0YVTxFS/TuwyLAwXkWFodV1f4YkLKyymnPjX5/cUNwOpsUwY36ZwZ0uWIUZGOJOxfaNCSBuV7zP2eLR0ODwgFkpIRTz+M6FIbH8LuFiq/IwrImQrFWQ/F9SCX1MZSMTJq7SHgmT3e0dVUE4mtJMMtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765461287; c=relaxed/simple;
	bh=asjipvlumTAG9LX/ZrgSM7qOg2tY3hiQLpH2JweZG4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IKa6fhKTu3pcnjaVsozylrHYHU11L7cO4hoLplwldwi15Nfbz+bK0zIjFybqkIBDT6FgsQK8noR40dndCMkBYVDhRIc+hk8ZsHmSF7ODEwHagaC6r50C1ZjWP0egyZW5ZKGPnh6SwQK6SaUa7K5Joh0AFgqNWotxldPonWY5OgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uDYj/hL7; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uDYj/hL7"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7b8bbf16b71so106252b3a.2
        for <linux-security-module@vger.kernel.org>; Thu, 11 Dec 2025 05:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765461285; x=1766066085; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aWRPRAJ89lgq7qGLYK1gyasHO8BcBnTXm3hkZRbZKOw=;
        b=uDYj/hL7oGwh2XUzc1hqD9+sdZ/Sx2Sq2KIskqtRR/WRmu2isIV04TAqo6JOKiX4kF
         NCpsGtZjwJuX40Ngt1BNK/SQaQ2XpxVQUmNG0btiWJ2i0K4XwxIlSK8GOLCMHLZZhDWN
         WwjUXaxR3Abzxj6Dcz0KKvvpDorVhHMUBws/PgXonrmgS/0ghFX/2ApTrYXWqPZn6utb
         dD/vbXSKFO6Yi5HxsWNMKFQNDEVQRC/xUBmSXlp5CmOLIAyyLDUr+XUKig6XSeGgXovr
         0TEArh7ZcaNENoq1epGedgYRQErJdCKsp57ZQPTUpjmd0nyjiuCtg+KRrEgd72Q3Y6cn
         cRQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765461285; x=1766066085;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aWRPRAJ89lgq7qGLYK1gyasHO8BcBnTXm3hkZRbZKOw=;
        b=FMqPySPnysCS0fVPDRXPJs/jHbfBfc1FUbimaUhKHmCTDfsF1UYGhnmZuacDHvq10w
         r8gIqGGE0hA654Ev5BAe8KHbt2u2lGI7lFpL0fmYY6s4KgM2ittgeXIdOtqw4Wl3lxJA
         peJV+Uxrbc73+AC3SKsoWAnEMN9ftjs/xhl3VtL5XsAaPu0dgi/9znoV4k84Lj0M3wje
         u+MNC8yb+t1TI0LFJQMmjy4M4E8b0P3yGDvJsimtPcyMe7ahzD6L7caxiREwU7OoHB2o
         Dyf6f+oN7EadPH2C9yXjHm7zZ3g/z2by3cMdhYXfu/YyGuOuvh1dYAWzoEc29HNiwbLB
         CnTg==
X-Forwarded-Encrypted: i=1; AJvYcCXT8GrLpQr5IxeHf8u6cEVzdkzMvwIaFyAUYqeXBBZZRZBLoTaLChA4+soiredc6rWFHQ17ZNQIibLfPIRc4ZFdQ9cLPC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdzjLrJy1d1bzM19NEfi4IDT8bM7DsILifDaRqUZDL6oxAjlgD
	1bPWFPflRwkHfPMRUQDf/Sx+M1xaQFlouTDXIVZHoit8gEU4sCROaEdJYeL/vsoiEc9cZhN9C72
	GUMvs8Qa6T+s2+XGWY+QMaxx5QHQoboSYucucS4O+
X-Gm-Gg: AY/fxX6BVoiGNjVMJsIUK4tV6pu1M3m/A65CFYf6sxmrXxiH719xeOBB6VveQJxJNt9
	yYETY+FehBCMzmBaKtlDnQvo0ebCwHPfS7vK6vV35jAqKv9Pb2mjlb+Nle7S3lOryHqES+Jq2dm
	yfDj6HvEP9M1KoP78gexr4xAo0+qJSwKbHf8PUm6wCzNSwxwUbiE6QIQChwPzs8i1fCaCs2eK+V
	avD9MRvEijb990EM2wQTg9lCfJ3YPqivEIcWJs5vWNgqwccWkG4ZbTF/pP8Pe9WAkmRuhvCcypu
	h3bXJRtW2JnskhxG9UySwO9H
X-Google-Smtp-Source: AGHT+IEaaruplzdVpdnApdH4OVSrHUz40RptUVIyI3MxrgnCoT6vGrQB2vef/vIeMxQHfT2Nk7cub+UMnQmlsyGPvik=
X-Received: by 2002:a05:7022:2219:b0:11b:bf3f:5208 with SMTP id
 a92af1059eb24-11f296558d9mr5045780c88.1.1765461284380; Thu, 11 Dec 2025
 05:54:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120145835.3833031-2-elver@google.com> <20251120151033.3840508-7-elver@google.com>
 <20251120151033.3840508-17-elver@google.com> <20251211122636.GI3911114@noisy.programming.kicks-ass.net>
In-Reply-To: <20251211122636.GI3911114@noisy.programming.kicks-ass.net>
From: Marco Elver <elver@google.com>
Date: Thu, 11 Dec 2025 14:54:06 +0100
X-Gm-Features: AQt7F2oz75av79IX-Fsq5GL2dibuf0pX45-76DYGUr2aahssaITkwrN9Ju3gYq8
Message-ID: <CANpmjNN+zafzhvUBBmjyy+TL1ecqJUHQNRX3bo9fBJi2nFUt=A@mail.gmail.com>
Subject: Re: [PATCH v4 16/35] kref: Add context-analysis annotations
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

On Thu, 11 Dec 2025 at 13:26, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Nov 20, 2025 at 04:09:41PM +0100, Marco Elver wrote:
> > Mark functions that conditionally acquire the passed lock.
> >
> > Signed-off-by: Marco Elver <elver@google.com>
> > ---
> >  include/linux/kref.h | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/include/linux/kref.h b/include/linux/kref.h
> > index 88e82ab1367c..9bc6abe57572 100644
> > --- a/include/linux/kref.h
> > +++ b/include/linux/kref.h
> > @@ -81,6 +81,7 @@ static inline int kref_put(struct kref *kref, void (*release)(struct kref *kref)
> >  static inline int kref_put_mutex(struct kref *kref,
> >                                void (*release)(struct kref *kref),
> >                                struct mutex *mutex)
> > +     __cond_acquires(true, mutex)
> >  {
> >       if (refcount_dec_and_mutex_lock(&kref->refcount, mutex)) {
> >               release(kref);
> > @@ -102,6 +103,7 @@ static inline int kref_put_mutex(struct kref *kref,
> >  static inline int kref_put_lock(struct kref *kref,
> >                               void (*release)(struct kref *kref),
> >                               spinlock_t *lock)
> > +     __cond_acquires(true, lock)
> >  {
> >       if (refcount_dec_and_lock(&kref->refcount, lock)) {
> >               release(kref);
> > --
> > 2.52.0.rc1.455.g30608eb744-goog
> >
>
> Note that both use the underlying refcount_dec_and_*lock() functions.
> Its a bit sad that annotation those isn't sufficient. These are inline
> functions after all, the compiler should be able to see through all that.

Wrappers will need their own annotations; for this kind of static
analysis (built-in warning diagnostic), inferring things like
__cond_acquires(true, lock) is far too complex (requires
intra-procedural control-flow analysis), and would likely be
incomplete too.

It might also be reasonable to argue that the explicit annotation is
good for documentation.

Aside: There's other static analysis tooling, like clang-analyzer that
can afford to do more complex flow-sensitive intra-procedural
analysis. But that has its own limitations, requires separate
invocation, and is pretty slow in comparison.
