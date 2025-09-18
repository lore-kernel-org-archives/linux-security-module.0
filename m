Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEC63148BD
	for <linux-security-module@vger.kernel.org>; Thu, 18 Sep 2025 15:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758211013; cv=none; b=E16HUfh5VpeRya985oFxeFgjrH9+kahnGloZ1Fe6g7ZOWSUonRQRzDLZQLxdbWOY5DB1YaHT/VZjyRKe6bsZmJZRCps+qm67G+IoEJm2ILrTQScxAJdJkizF+UFMHCTYjnPQViit+iyaDQA0YCQlb9QAfbM++PKLa5ce468IwZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758211013; c=relaxed/simple;
	bh=XhR1h2E8azi9+Iqslf03I/SakVc5s2CaBmw/N8HkwwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QwTK9ym7NvJ+eV3pWIX0uhhfrz4ggSQjtyN9VjT9xuC3YjpXRF4GpP5GuEoYkH2HqdD5Eh24r2ew2m1yBJbckp/TIUGtnm5wdlTZGCE3Ij2OONmeHYBQxoa3tbSFtD4ueNQClUN2/l+8idw08UeQASZIrwaakHww5lNb0D+U6GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IGML7mCO; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IGML7mCO"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3610cb77a2aso12200801fa.0
        for <linux-security-module@vger.kernel.org>; Thu, 18 Sep 2025 08:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1758211009; x=1758815809; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hpKO6CsQCuex3g+QZ22KGPC+ZgcKRmVKS1THDCqCkXc=;
        b=IGML7mCOpgoEXL+6J0p6fXVDsGc6HJwGSAV/FlCYZgrIg/YuTFAWB0GLiWVllWxWVy
         ytmf0nTuBKcA7WBS+hpp126tqWOpPAWQagNouaRbJy55OoF0vr/XN9aY0MqbrS7QXDso
         /Z/4ExkJOK1+w6f1Nxz9j6tnGmLwnM+86Fb/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758211009; x=1758815809;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hpKO6CsQCuex3g+QZ22KGPC+ZgcKRmVKS1THDCqCkXc=;
        b=gN0z4E4evkLFz2Yo+G+E4KecMf1xWKSJFBVtWHMyvKnNeQubtY1XlYXbFPaa0wkv2T
         FEkzNpAOpnxCucm8jxeLO31o5DuodzQWPxLOFpgct1xCGDijsuacczkCe8ZgmEolnJb5
         9YPr7DctgB2Uo8CekY6a4L00Jbslm4AkmTg69PhHU+cJXfE4FRF9nL8GYpU+901wqkla
         gBeYfV+xtFG93Wp/m7hyetYWAGEcjjdBDfvEF2yD6BK9Zah8tAwioXAOGZ8dPQ4tD2+h
         G4sbU2iD+xxwMtA/2LT+qZNwAbH1dK1I6XmP/p535NMQWgFq1+y9QbP1H+YtM+oOJFgi
         c4pQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/CwfW0GNO2gNp00cnJjGy25+91gvC68XEC94R/U4eA62bH/TgM7UW2dsCyFdNVGCf1QiThbkwR5diIEaWfJxN4UpW51M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRsuxK81dF+S0WWFMdjM0K3oQSlJh9qC7WJAtI7KZQXZ+FtkaK
	2NKXp//rD/yBHvVlIwsKjciwUrxAiUlR9Hc0GsdGemzKPF2GtnTPvoW6kyUCJGwIa6iYPV22Lmv
	BRCA5vXE7tA==
X-Gm-Gg: ASbGncucq9TzTNvAVsy7MV/TUWyvs3+FknepC2bVC7kJevN4EioVOuEDOlBEWGwLLiq
	8CAdG8Gts91acn3dLvYu9nlnDb2Kq3NSG2JBgMR/L9nC2TqYUxDVb1BpSGgVH3HPeBy7BQzXkkb
	pTORUYjg5p7Zh9Tcyc5sXUkApdl2/Sc5sqhyjZhuNq0AZCGVJnCVdoQ2dFmJeiVCk6N1bR8+sDj
	WEpYrOAJ2nGgb+n75VdUcMZXIgjOFh2WnDATkyoXT3xDZZfAB00uxUZh1L4oTfjUjM6FIeoXYcz
	4+NaV18xONaeeO4OrJVkXvX+0pxqpH9/Ht9gGXLwLdaXAidX5+r0q9C/Tzmu1lPVtDCrJZkSBwD
	7mfv8bESnd1rfZNSHb56hx7PTLG76vLD1UqTRIUJLP5d3xiFLAFOn5bQOxF7dmn9uIBsDHso3FU
	VuCgK6F8JTRImCClw=
X-Google-Smtp-Source: AGHT+IEwIBLoQ4+JHgWa6JqxJS7+Vatb1KsBpZ2aXKaotGUFahNxV2oYYdgxJtY1txmdDb3Z3aq8eg==
X-Received: by 2002:a2e:a9a5:0:b0:350:8cfc:7129 with SMTP id 38308e7fff4ca-3640aebc907mr540061fa.13.1758211008957;
        Thu, 18 Sep 2025 08:56:48 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-361a1e07754sm6912751fa.8.2025.09.18.08.56.48
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 08:56:48 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-55f98e7782bso1451596e87.0
        for <linux-security-module@vger.kernel.org>; Thu, 18 Sep 2025 08:56:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXXwQk7gOaHbh2I1vR4BqZOkG42ihLtl6x/Nj4M3fhtAqfrIqJ/baJuZqo27BkwtifyNB1SHxHVUCVWVHuJ3gbBF7DcLn0=@vger.kernel.org
X-Received: by 2002:a17:907:9612:b0:b10:ecc6:5d8d with SMTP id
 a640c23a62f3a-b1fac9c9b84mr417765966b.26.1758210601571; Thu, 18 Sep 2025
 08:50:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918140451.1289454-1-elver@google.com>
In-Reply-To: <20250918140451.1289454-1-elver@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 18 Sep 2025 08:49:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgd-Wcp0GpYaQnU7S9ci+FvFmaNw1gm75mzf0ZWdNLxvw@mail.gmail.com>
X-Gm-Features: AS18NWBk4u9ObN57KesSGhJyt-aPlWZgKdxYhvzpAyoaxlNUF53WHe4dSKjzUBg
Message-ID: <CAHk-=wgd-Wcp0GpYaQnU7S9ci+FvFmaNw1gm75mzf0ZWdNLxvw@mail.gmail.com>
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

On Thu, 18 Sept 2025 at 07:05, Marco Elver <elver@google.com> wrote:
>
> Capability analysis is a C language extension, which enables statically
> checking that user-definable "capabilities" are acquired and released where
> required. An obvious application is lock-safety checking for the kernel's
> various synchronization primitives (each of which represents a "capability"),
> and checking that locking rules are not violated.
>
> Clang originally called the feature "Thread Safety Analysis" [1],

So this looks really interesting, but I absolutely *hate* the new
"capability" name.

We have existing and traditional - and very very different - meaning
of "capabilities" in the kernel, and having this thing called
"capability" is just wrong. Particularly as it then talks about
"acquiring capabilities" - which is *EXACTLY* what our lon-existing
capabilities are all about, but are something entirely and totally
different.

So please - call it something else. Even if clang then calls it
'capability analysis", within the context of a kernel, please ignore
that, and call it something that makes more sense (I don't think
"capabilities" make sense even in the context of clang, but hey,
that's _their_ choice - but we should not then take that bad choice
and run with it).

Sparse called it "context analysis", and while the "analysis" part is
debatable - sparse never did much anything clever enough to merit
calling it analysis - at least the "context" part of the name is I
think somewhat sane.

Because it's about making decisions based on the context the code runs in.

But I'm certainly not married to the "context" name either. I'd still
claim it makes more sense than "capability", but the real problem with
"capability" isn't that it doesn't make sense, it's that we already
*HAVE* that as a concept, and old and traditional use is important.

But we do use the word "context" in this context quite widely even
outside of the sparse usage, ie that's what we say when we talk about
things like locking and RCU (ie we talk about running in "process
context", or about "interrupt context" etc). That's obviously where
the sparse naming comes from - it's not like sparse made that up.

So I'm really happy to see compilers start exposing these kinds of
interfaces, and the patches look sane apart from the absolutely
horrible and unacceptable name. Really - there is no way in hell we
can call this "capability" in a kernel context.

I'd suggest just doing a search-and-replace of 's/capability/context/'
and it would already make things a ton better. But maybe there are
better names for this still?

I mean, even apart from the fact that we have an existing meaning for
"capability", just look at the documentation patch, and read the first
sentence:

  Capability analysis is a C language extension, which enables statically
  checking that user-definable "capabilities" are acquired and released where
  required.

and just from a plain English language standpoint, the word
"capability" makes zero sense. I think you even realized that, in that
you put that word in quotes, because it's _so_ nonsensical.

And if not "context", maybe some other word? But really, absolutely
*not* "capability". Because that's just crazy talk.

Please? Because other than this naming issue, I think this really is a
good idea.

           Linus
