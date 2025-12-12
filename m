Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B296C24DCEB
	for <linux-security-module@vger.kernel.org>; Fri, 12 Dec 2025 10:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765534570; cv=none; b=HldLN9Vp7vyxyyGwc0QyHExY/wkbqSc6Ujw/lMgqSWhzBPYoRY/wtY4Hg567UvTrHpxRgOdJk4Lilr+8BAED9MTrf7CL65EBSvxKI/k5wTk3SrmG5nSjxmK8KVyol79mLzCtR+OMEbVLQrrBb7O+6wXjTlzTZzkDDsWs4ntua6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765534570; c=relaxed/simple;
	bh=Yy8AVUr1WzoEhC0gwViTyIIecU1pDeO+TdO72jBT6kg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=etWkJoshtZ/LS2g5+3nUIgVGX4RpcXRT3y2rg8swEwAvDluH0kXzLZe0TrlOsPxvECkHIxcVDXF9QHJDmMWt4OUbZUiCsEM1c0lP9JeR8uaUdYmp0jaXs+o7V+VTb1tJQm6ATDJjU7C63MJBxxEgfMWeD0/jU3jmRAbG7vSW7EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kbkpTIwj; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kbkpTIwj"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-bc0d7255434so698533a12.0
        for <linux-security-module@vger.kernel.org>; Fri, 12 Dec 2025 02:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765534567; x=1766139367; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Yy8AVUr1WzoEhC0gwViTyIIecU1pDeO+TdO72jBT6kg=;
        b=kbkpTIwjpQS8ePNpRzQzmqynFKNs7/NxFbTXEqQxrUChBOEd0ClCuYdBQSv/22spWQ
         Mlau/Z1r7/t8B4xFGTNsO12c5ZTlO8IX7JmdNjWmjdVZ/Jjmk3SOeb81vSBizctBon6C
         b9PSWBQffnaVrZsxTpaFewgJOaV8M65WyBFjjc/d5LNfdNJtX504o4PmkXzgy9+JGpaR
         p+BOqszpjmfwPdF9SWGeFROnU0ow5OvvXnKcQ2WceWvfngjFOxfI5+Rs21yMoX+9CWFu
         9Pv3ZqG+EuPi3/Br8MUwkjm1WFmizI4Ur371xJf7pXnmBlKHwciyx1Eiw/6wKklL/E6/
         Jp7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765534567; x=1766139367;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yy8AVUr1WzoEhC0gwViTyIIecU1pDeO+TdO72jBT6kg=;
        b=kNkrTY6gqNnadG5QylYftcXkmOASxGpmib/BoH1ImeH/GUJrGUN2W27Jq45NeAeBby
         AQUsukHmRiG+NkWoUlLgnbLDOO2g4MT9uUhebx8JCS5CpxxZ2p0hZWOfPQBeADtAQgqa
         9chsUXgcvesTiSp/rJEglVyeOcr7OF7+4atzjx4d2Hu8LFyJMGBdpPND6zIQz07Ln+eL
         psD/jndU86TejcRgD1piYh6JWckCqGClyDsPVjwi9gtGLKzQ7Oc1Mz2fXjDab6qR/xpq
         T/INbFRMUyArzcww98yCi+j3Mvm9Qg53CpX1YaIMS5ZQ6AO+fQtF0arwZXkHEHx7z0DM
         4wRg==
X-Forwarded-Encrypted: i=1; AJvYcCVanqtnsqsb6FdDwpnKYBGX8gtlf6zao/1vrO/4g7miNUzSWmB0eEGwBFoABimVmGCn0Pt+tKTOKYzoB5Z09vNx4frBMWI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz2/kBYZUmiASsPJ43mQ9iWGpof+7ql8Z2inzrbbEAhSyMoMaI
	vlyesKr7ayO3DoUpkRLML1E9ft/sE/F417J6mFgJ8iJ7S28dcFpb710pM9ugNCheHDt6UiS0qhq
	2PR0RHOWBxxEfUY7GqCR4Uwimpg1tQZg2ldeOY1aI
X-Gm-Gg: AY/fxX7EETuOT4aVf/4aJVy9ACaNZOTe66DOiDySlOBQXRWA0JzLZJiE107QT2xBGNW
	hCQSLpM8g/LKOr/TqR8JKgu4uCjvbdR2T7hryzCOFoy8kG9z8QbRw+F15Qn9I8OoTEZLDwfKsuQ
	iQPdqH9fKihDY2Cs4NWEjpa/z4FO+hsqEeoSik4oWDtmRi5cjIgqIUiDZmbHLeJiOZq8PR65aq+
	32AALXwYJvD/cOjJarVfkhZA+Qkj9iAhD+g50cEj0rjSU5ucU0O9lWe14xjOchQONkcM/oPHse4
	YDy4waFO6VGeKvEpLBMqv3WaKXRKZ4++8jSA1A==
X-Google-Smtp-Source: AGHT+IH8fq53xzz4VEeZIfjpPn2aDZft0vSRUPpE08Jgar7Bwxv93jAlmI/oD2Bc5sYJ04yKuPnrNx+rDd5kmEFlwB8=
X-Received: by 2002:a05:7300:2aa5:b0:2ab:ca55:89b4 with SMTP id
 5a478bee46e88-2ac303f2fbcmr872533eec.43.1765534566419; Fri, 12 Dec 2025
 02:16:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120145835.3833031-2-elver@google.com> <20251120151033.3840508-7-elver@google.com>
 <20251211121659.GH3911114@noisy.programming.kicks-ass.net>
 <CANpmjNOmAYFj518rH0FdPp=cqK8EeKEgh1ok_zFUwHU5Fu92=w@mail.gmail.com> <20251212094352.GL3911114@noisy.programming.kicks-ass.net>
In-Reply-To: <20251212094352.GL3911114@noisy.programming.kicks-ass.net>
From: Marco Elver <elver@google.com>
Date: Fri, 12 Dec 2025 11:15:29 +0100
X-Gm-Features: AQt7F2qb9ENq_mtkRfqCrKNBJnxHOwKNFDuSBIrcF4bjbeWckbG0712gmoUp-Ao
Message-ID: <CANpmjNP=s33L6LgYWHygEuLtWTq-s2n4yFDvvGcF3HjbGH+hqw@mail.gmail.com>
Subject: Re: [PATCH v4 06/35] cleanup: Basic compatibility with context analysis
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

On Fri, 12 Dec 2025 at 10:43, Peter Zijlstra <peterz@infradead.org> wrote:
[..]
> > Correct. We're trading false negatives over false positives at this
> > point, just to get things to compile cleanly.
>
> Right, and this all 'works' right up to the point someone sticks a
> must_not_hold somewhere.
>
> > > > Better support for Linux's scoped guard design could be added in
> > > > future if deemed critical.
> > >
> > > I would think so, per the above I don't think this is 'right'.
> >
> > It's not sound, but we'll avoid false positives for the time being.
> > Maybe we can wrangle the jigsaw of macros to let it correctly acquire
> > and then release (via a 2nd cleanup function), it might be as simple
> > as marking the 'constructor' with the right __acquires(..), and then
> > have a 2nd __attribute__((cleanup)) variable that just does a no-op
> > release via __release(..) so we get the already supported pattern
> > above.
>
> Right, like I mentioned in my previous email; it would be lovely if at
> the very least __always_inline would get a *very* early pass such that
> the above could be resolved without inter-procedural bits. I really
> don't consider an __always_inline as another procedure.
>
> Because as I already noted yesterday, cleanup is now all
> __always_inline, and as such *should* all end up in the one function.
>
> But yes, if we can get a magical mash-up of __cleanup and __release (let
> it be knows as __release_on_cleanup ?) that might also work I suppose.
> But I vastly prefer __always_inline actually 'working' ;-)

The truth is that __always_inline working in this way is currently
infeasible. Clang and LLVM's architecture simply disallow this today:
the semantic analysis that -Wthread-safety does happens over the AST,
whereas always_inline is processed by early passes in the middle-end
already within LLVM's pipeline, well after semantic analysis. There's
a complexity budget limit for semantic analysis (type checking,
warnings, assorted other errors), and path-sensitive &
intra-procedural analysis over the plain AST is outside that budget.
Which is why tools like clang-analyzer exist (symbolic execution),
where it's possible to afford that complexity since that's not
something that runs for a normal compile.

I think I've pushed the current version of Clang's -Wthread-safety
already far beyond what folks were thinking is possible (a variant of
alias analysis), but even my healthy disregard for the impossible
tells me that making path-sensitive intra-procedural analysis even if
just for __always_inline functions is quite possibly a fool's errand.

So either we get it to work with what we have, or give up.

Thanks,
-- Marco
