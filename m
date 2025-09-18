Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC1D2E54D1
	for <linux-security-module@vger.kernel.org>; Thu, 18 Sep 2025 21:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758232522; cv=none; b=sE9t8ofI7pel4p3rT6Vqy7hAY2rO7IiMLHCELi1cm56vwc00g1EW58+v7bLTNOHbMeJRALMKON+BHH4lnZfYtwOGA5ggLbS6GTITdTDBZ8If/yZjn6taziPPoPIqenvJodfbHbu+0MVzg1AEWoCZtu7k+I+wmD+1nXOqt+E8uOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758232522; c=relaxed/simple;
	bh=OBdCMGeWv7G/tkOmZiDbcUQKLH/CnWF06gVEbnVu89c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tm9z5UfN3PCoUe0Y9XDw0vJ2JNM88WmnQwys5R6N4+FM6ZHC8CgdJICRKKC3BmfPlblgH/VJIHY48X0jebKPfcEi4KK29joBuEpTCMDsXvaQEohI8WEEnUhleBOxefIhpC4d9+4RndFAmz448A5mc24L0AiqI2TQeNuGnhbYj98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GmlkBUyR; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GmlkBUyR"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-34fed7add35so10245731fa.2
        for <linux-security-module@vger.kernel.org>; Thu, 18 Sep 2025 14:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1758232518; x=1758837318; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mLiszfQw8YctXWgw7Rv1CzeIAYsEhv/enJDimwborHo=;
        b=GmlkBUyRb0gTiLKFqZtAZkR5rTnHOYrUSn5QxEVC+VpLrNAER/0oen4fur2Onl64+b
         6dQBpkJj59bc/tXdEwE/eZ/dFMeCWgFQdWqWVcYZLaSwukO7OZivrldfacpK03RZt+G6
         jea2nI/6Zh2Nt+4HU7fmoQAu30ri3K+OZL0VA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758232518; x=1758837318;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mLiszfQw8YctXWgw7Rv1CzeIAYsEhv/enJDimwborHo=;
        b=wsLnhsIX65TDV9XkX7k4bJU264FytGTQjMDa8PwQQoZs5KT2xTLVJtplPviQBoFSEv
         2j0ZOIY4xqalgEK8nnPDx+c28mEvFRQ/lrFHLvb0r3Ybl2hUtaJ3TGAsNdovm7hT2AVO
         Q80CO8Fr11ln3NoUcFdrwsJqmtW7TffShJDc1Py1qIeLYJoKkthQtDW3htecuJ81rEsE
         JEQsINGxtsoogiErYqojx9qwb5Qi/BfZBhS7gqq2bD9N7ykqOhqOzANGXrXtGSFxbhCJ
         o0peVL6hib71Wf+IitJ+Y4908naMKK/MkzmY7z1JYk0dhUQFNJho1hgZtbXAhiVWNjHy
         T3aA==
X-Forwarded-Encrypted: i=1; AJvYcCXZIBJtcP91fNKauxkyvD0jHpzDFdeLCQKw7CxFNoV9VwaAu8N2C+3NgZVWOW468sNUhplAmqVA9rmtT8+wEDI0T+boETo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNnp6OlnAtf4JVEMVlr62D8zK7WsOJp7O7PpxlcL/29Ui2/bOf
	reU7Zh6jysWkE78R2M+jmo0JQZBkMJwFWq0KYmCUL4byBhT8yy5pMEYBLms8B3uhD1XLRLc+p89
	+Yh91HTme0g==
X-Gm-Gg: ASbGncvcuhPccqE9wcqECz5k6TNsKFlkiIl4Vhg3YFvWm1Tmrn26S6VkfU8+4FnEu8s
	d1J6QMhX6omsYmuP5TLo3GxAwwDRvhHJoLupMHSkDQn1llbzCfEc0xFTkJU64lts6pVrYqH5V98
	sQmkSOQPHiz9uX5C7IoW09FTm50xm5A8fsNUe7ZWN1+lJ5/ZOzg1W3H9Opmbar5hZCNbRTPyUtd
	Np4brjR6ypdJU+9N0t4gtuEWOsWeL7EY6Le/4ww9WBiFbkhudssXNSMgthUitUOKKwozLfWv70q
	r1snsBTnBpzZMYaCML9gNM6YKZ2rfb61OOjJOWqQZP4RTzRQDnmqJXkcKVbYspsOfOcMoqhsCT8
	v+jKmGIsM6RwywnS1l2JRnQydRGlHO6/wQsFFBtg7UnVN7QcC7Y9mTM1jxx0e6ePJnsdCJ6nX+p
	OHNHZj7B77nOaRtQU=
X-Google-Smtp-Source: AGHT+IF1jKupcpPe6GVMGfbgM3aLVfXfPt7XterC8WClxQ0LZORiPRbzHf6wOBevDTa6RvfY2k5OZg==
X-Received: by 2002:a05:651c:d:b0:336:94ec:5d16 with SMTP id 38308e7fff4ca-3641a11fa9dmr2117851fa.22.1758232517983;
        Thu, 18 Sep 2025 14:55:17 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-361a8f571b0sm8313411fa.39.2025.09.18.14.55.17
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 14:55:17 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5607a240c75so1525897e87.2
        for <linux-security-module@vger.kernel.org>; Thu, 18 Sep 2025 14:55:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXa0UfpouMjgr5wX+3oZ9PzqlOdt6ZLiEQTriAIDI8hU54sQXWpXyVKt0TYLjdh8MsR1w8t0AW4L0ZLsWCxqpz9teo2Las=@vger.kernel.org
X-Received: by 2002:a17:906:dc89:b0:b0f:a22a:4c30 with SMTP id
 a640c23a62f3a-b24f5685fdemr62738866b.47.1758232077501; Thu, 18 Sep 2025
 14:47:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918140451.1289454-1-elver@google.com> <CAHk-=wgd-Wcp0GpYaQnU7S9ci+FvFmaNw1gm75mzf0ZWdNLxvw@mail.gmail.com>
 <aMx4-B_WAtX2aiKx@elver.google.com>
In-Reply-To: <aMx4-B_WAtX2aiKx@elver.google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 18 Sep 2025 14:47:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgQO7c0zc8_VwaVSzG3fEVFFcjWzVBKM4jYjv8UiD2dkg@mail.gmail.com>
X-Gm-Features: AS18NWBxHuMwwtU-EoNbPFA3uJ1YRJkAKqdurj12n-PWNJgH6ecKwZ8QZrX3P28
Message-ID: <CAHk-=wgQO7c0zc8_VwaVSzG3fEVFFcjWzVBKM4jYjv8UiD2dkg@mail.gmail.com>
Subject: Re: [PATCH v3 00/35] Compiler-Based Capability- and Locking-Analysis
To: Marco Elver <elver@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Alexander Potapenko <glider@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Bart Van Assche <bvanassche@acm.org>, Bill Wendling <morbo@google.com>, Christoph Hellwig <hch@lst.de>, 
	Dmitry Vyukov <dvyukov@google.com>, Eric Dumazet <edumazet@google.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Ian Rogers <irogers@google.com>, 
	Jann Horn <jannh@google.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
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
	llvm@lists.linux.dev, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Sept 2025 at 14:26, Marco Elver <elver@google.com> wrote:
>
> Fair points. "Context Analysis" makes sense, but it makes the thing
> (e.g. lock) used to establish that context a little awkward to refer to
> -- see half-baked attempt at reworking the documentation below.

Yeah, I agree that some of that reads more than a bit oddly.

I wonder if we could talk about "context analysis", but then when
discussing what is *held* for a particular context, call that a
"context token" or something like that?

But I don't mind your "Context guard" notion either. I'm not loving
it, but it's not offensive to me either.

Then the language would be feel fairly straightforward,

Eg:

> +Context analysis is a way to specify permissibility of operations to depend on
> +contexts being held (or not held).

That "contexts being held" sounds odd, but talking about "context
markers", or "context tokens" would seem natural.

An alternative would be to not talk about markers / tokens / guards at
all, but simply about a context being *active*.

IOW, instead of wording it like this:

> +The set of contexts that are actually held by a given thread at a given point
> +in program execution is a run-time concept.

that talks about "being held", you could just state it in the sense of
the "set of contexts being active", and that immediately reads fairly
naturally, doesn't it?

Because a context is a *state* you are in, it's not something you hold on to.

The tokens - or whatever - would be only some internal implementation
detail of how the compiler keeps track of which state is active, not
the conceptual idea itself.

So you name states, and you have functions to mark those context
states as being entered or exited, but you don't really even have to
talk about "holding" anything.

No?

               Linus
