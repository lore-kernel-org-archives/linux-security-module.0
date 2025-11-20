Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1DA2264D9
	for <linux-security-module@vger.kernel.org>; Thu, 20 Nov 2025 18:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763662495; cv=none; b=mk07wWcurhJ/xD0lYGGDaBUQaCdT8KQj5kG7xsrG7nOd56DFOccRlywJwNps35ISxydTHx3uRYgx/pwo3bV5S2zwBL0kxsKkOBVGo+N2LNDMdUcy9iYjSkNJzQFUORHUFTUN79LV03Yv2vdR2Z8OW1Nyx+AeFyeIgCnk7hW/MKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763662495; c=relaxed/simple;
	bh=wecZEUleM2pVH/ldG6VyoxAP3Tx+t9JIJBh2fst1eeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J8BMx0SxKNnuV3QwfZx3ANz9/Ckz8Yy1dHxjo3ZPYtR+sJg6ceyAUJfk0lz7r6FGULzvcz1v+yehwISOoigAG4Lv/i0lIMKKzB0tzsRKfoGxvLFRIVJEwwDoQxuXxrV+ubQN9XCdeOP2Enj6qTtFhBYyTm3cPo4fcKI7jf8f3eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QLMRwRUX; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QLMRwRUX"
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-b735e278fa1so244123566b.0
        for <linux-security-module@vger.kernel.org>; Thu, 20 Nov 2025 10:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1763662491; x=1764267291; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+BPfdnrOHpw/8tC+sL0oorkp9gKYtrunKdRWYzTn+GA=;
        b=QLMRwRUX4Crc9J2EPzBlOYuQgfOW8+Avuxk3QWBvzWyi8mHqmbjSJUWSoJhBIRyO3g
         TQxY7ZrAk0mhZBj551XzVxeO9N0/UGbH/xGY2RzaPbGHiSn8Eo4X6F4CGHzXQQtK9pyQ
         ecqdPom+XVSJrqfsBVlvd5+jL1FOi4WycWswY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763662491; x=1764267291;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+BPfdnrOHpw/8tC+sL0oorkp9gKYtrunKdRWYzTn+GA=;
        b=Xtsz/2PD+sY6ShZHdv6aaibun2TwwG3ChtVI5v3Sw+Ujr4Yu8yyFfXRzeNXpbMA4sr
         3o7eUmDzYPzDhUmJS3IJHWQJ8gGUZ4xYJJP+fWXoZC6jgXjWlfGT+dooz0opoO6W1rYT
         WpsUMSoWSJmI3895HG1cX0TVMkQ8EDktkBuEKflfUhm1w7epFXESF+kr1h/RDbSm+JjQ
         AxkpxIv66mrxuesKgLVzubCZZyObtAP5ERscFw6Jnr81/EWpT/LLqbtV0PHq/LKtC498
         Zzp6RLUcTPZZwkbbZO1ayuIVTExOSoNh+syEPpYdf27A+iGTJ7Fb24ZBPPiDnP34S9vB
         OIBw==
X-Forwarded-Encrypted: i=1; AJvYcCUi9EbwqLXcl9O7jRj+6mSsu1KkR1ZqHJKCcJ0mO9zySYnKmjHmBQ+Fz0tVLYiwvO7GBh+jQAgPiannHwIDN8F2IuESD4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUk8jo4T+4UPryZ/EOqs7rHWk5pFVXsp6OKJLn6c1NCIQD2RZC
	BrmTd9cY1JsYcqjc9r9c/rlq6DtSyUSh5+6Ns10Z+KjRH78W8XISQepTmjk17GhDZd/g/9EYb7v
	Dry4kYdo=
X-Gm-Gg: ASbGncshDPkxrga7O18O7+ClG62gHjiM6AVwZ+PjoNRrVt5L63IvtSPmLajTD5f3Bnn
	peYHFlugwl249HcEIL3SFwiXy9DkAgFbQtKgQ+WRQdxXqrPzLHc/FsHYDGFq4Hj4rS2vMBzF+VJ
	II/fKBt+bdUZ7+eHi5Hi4nGvPx4ubhcfY33WcpHJsinsluETpgQytsv11MhoOTzhiApxuH39lkg
	t/azqsag86myJMIubWyBaC3aS+Y8yYc6yv6DRuWqelh3XsVdxafP6bBechUUU8F+Cv2TaztPhzx
	uUYNY+cmaSP31KVh9SPH5Kru8TQb8cF5j6gkaUgUhXo5qsITxvnUznBvuU57T14DEDn2nXUf54x
	E3NtR7SyY2oYgOJLprozW3jnl4sP5cY5cWJ2RlITLHyf376Drg74sPSFlC7JGwF4M8nlSAvVzyH
	VZYpbDl+8bTvv65OtimDLh6o0siCxUsPFwWLOEfxmYMSIKpVkc9d6BfCBrCs7b
X-Google-Smtp-Source: AGHT+IHxBlIvOFVaayE2GTVSy3Uy6A9UWRhOsJPb1Ilc0Jxo2o/gZAeeZd3fzS/unXwDiSOaP51UCg==
X-Received: by 2002:a17:907:72c9:b0:b72:ad95:c1c2 with SMTP id a640c23a62f3a-b7654d898femr430414166b.11.1763662490997;
        Thu, 20 Nov 2025 10:14:50 -0800 (PST)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b765502a9cfsm254639766b.57.2025.11.20.10.14.50
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 10:14:50 -0800 (PST)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b762de65c07so185864066b.2
        for <linux-security-module@vger.kernel.org>; Thu, 20 Nov 2025 10:14:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUr8ZP9P3lSJplA12bvkvmBNTPtzotxaWVgwUOaeQwX6/A4neY67FCr2On6ig2KFi2ghqDiWdEP4wI+dclqYsqT3NAHQ+4=@vger.kernel.org
X-Received: by 2002:a17:907:7f0a:b0:b70:b71a:a5ae with SMTP id
 a640c23a62f3a-b7654fe9b97mr482177966b.44.1763662490181; Thu, 20 Nov 2025
 10:14:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120145835.3833031-2-elver@google.com> <20251120145835.3833031-4-elver@google.com>
In-Reply-To: <20251120145835.3833031-4-elver@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 20 Nov 2025 10:14:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=whyKteNtcLON-gScv6tu8ssvKWdNw-k371ufDrjOv374g@mail.gmail.com>
X-Gm-Features: AWmQ_bk-my8wSL6P8yRhTUREdDraem8VrQQmjD7uS2S9oN6T2mRX46ftlS1ytQU
Message-ID: <CAHk-=whyKteNtcLON-gScv6tu8ssvKWdNw-k371ufDrjOv374g@mail.gmail.com>
Subject: Re: [PATCH v4 02/35] compiler-context-analysis: Add infrastructure
 for Context Analysis with Clang
To: Marco Elver <elver@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
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
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Thomas Gleixner <tglx@linutronix.de>, 
	Thomas Graf <tgraf@suug.ch>, Uladzislau Rezki <urezki@gmail.com>, Waiman Long <longman@redhat.com>, 
	kasan-dev@googlegroups.com, linux-crypto@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, linux-sparse@vger.kernel.org, 
	linux-wireless@vger.kernel.org, llvm@lists.linux.dev, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Nov 2025 at 07:13, Marco Elver <elver@google.com> wrote:
>
> --- a/include/linux/compiler-context-analysis.h
> +++ b/include/linux/compiler-context-analysis.h
> @@ -6,27 +6,465 @@
>  #ifndef _LINUX_COMPILER_CONTEXT_ANALYSIS_H
>  #define _LINUX_COMPILER_CONTEXT_ANALYSIS_H
>
> +#if defined(WARN_CONTEXT_ANALYSIS)

Note the 400+ added lines to this header...

And then note how the header gets used:

> +++ b/scripts/Makefile.context-analysis
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +context-analysis-cflags := -DWARN_CONTEXT_ANALYSIS             \
> +       -fexperimental-late-parse-attributes -Wthread-safety    \
> +       -Wthread-safety-pointer -Wthread-safety-beta
> +
> +export CFLAGS_CONTEXT_ANALYSIS := $(context-analysis-cflags)

Please let's *not* do it this way, where the header contents basically
get enabled or not based on a compiler flag, but then everybody
includes this 400+ line file whether they need it or not.

Can we please just make the header file *itself* not have any
conditionals, and what happens is that the header file is included (or
not) using a pattern something like

   -include $(srctree)/include/linux/$(context-analysis-header)

instead.

IOW, we'd have three different header files entirely: the "no context
analysis", the "sparse" and the "clang context analysis" header, and
instead of having a "-DWARN_CONTEXT_ANALYSIS" define, we'd just
include the appropriate header automatically.

We already use that "-include" pattern for <linux/kconfig.h> and
<linux/compiler-version.h>. It's probably what we should have done for
<linux/compiler.h> and friends too.

The reason I react to things like this is that I've actually seen just
the parsing of header files being a surprisingly big cost in build
times. People think that optimizations are expensive, and yes, some of
them really are, but when a lot of the code we parse is never actually
*used*, but just hangs out in header files that gets included by
everybody, the parsing overhead tends to be noticeable. There's a
reason why most C compilers end up integrating the C pre-processor: it
avoids parsing and tokenizing things multiple times.

The other reason is that I often use "git grep" for looking up
definitions of things, and when there are multiple definitions of the
same thing, I actually find it much more informative when they are in
two different files than when I see two different definitions (or
declarations) in the same file and then I have to go look at what the
#ifdef condition is. In contrast, when it's something where there are
per-architecture definitions, you *see* that, because the grep results
come from different header files.

I dunno. This is not a huge deal, but I do think that it would seem to
be much simpler and more straightforward to treat this as a kind of "N
different baseline header files" than as "include this one header file
in everything, and then we'll have #ifdef's for the configuration".

Particularly when that config is not even a global config, but a per-file one.

Hmm? Maybe there's some reason why this suggestion is very
inconvenient, but please at least consider it.

              Linus
