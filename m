Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3871C276050
	for <linux-security-module@vger.kernel.org>; Sat, 20 Dec 2025 12:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766235129; cv=none; b=RfFxUfFzSEiyxqm8W1iBOD/eZCxj8v+gS9nrncChXd9XOp7mQt5UWJmKGof8h9eAa7VuzEBNtBKmdShIQqi6tLaTctGo+Ek1He9KPxPSGQsDO/LqXW8pKlWpah51EV2YYU8mDV0fgyxNDvct69VnVLHzIW8cfwTHtAOiG2rgYPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766235129; c=relaxed/simple;
	bh=wkv3Ho3KGiVJkt5Z4uain5drk7TOMSZYfvI9aQbzCrQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=scjnGHrh9D3m6QUPcPgNRwwhu9HTYMA+tHjvaecKUq0KBBncsNW2ubCs1ooR1mLMfCeSMxQUF9ZnwhYkaa5oQyEre530cAPMNrLPNhg1jnmAR/5ZpugBVZO6O0iodFeS5npgaVcJFLfPPoKcckuKHcJ8ijj7EyiGj4ugYerav6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4fKfKSKv; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4fKfKSKv"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-bd1b0e2c1eeso1944726a12.0
        for <linux-security-module@vger.kernel.org>; Sat, 20 Dec 2025 04:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766235127; x=1766839927; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+dbDPICBAvFxThOmxuLLN+XESg+4otRZJCktLSd/IHI=;
        b=4fKfKSKvM1SC6Tzv/bJ7SpdOWrpUGOe+n+A0s4HucJnyJXoUvg0bBqgs3cJDHd9d0P
         fxyPZ1jO4LYfkUJb/NShyPV2B7ey2yft+RzlVDNvS34KL0lvRtgDj8MYBTSJ4uB11TOb
         kJgeX/fWH4r3ZoBCu5rGx9tgC0Almi31+Rg7noxwgSeyltZaSWzD5G26BrXB4I3DxRCX
         yQDd1uSFawTeGBdhklItdKxkhJ5GeWzKj2oZPIE5K/jf9Jg5LMnqMxEaFGTIiDw+BYK0
         QnIBI5evkUDynqRI//PJWAeBUCPNPRR5RX5+KOrMK+tZHSGNK+Co9jfADrmS1yHAKKBU
         /Q9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766235127; x=1766839927;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+dbDPICBAvFxThOmxuLLN+XESg+4otRZJCktLSd/IHI=;
        b=KB064+RP93vsZ9REaep62okWsOuzLoyQnMhKbGDjm9gfCLJAIYg0RV0NW0+aq7FjdE
         Amx7nXh8rNF6pCOpP+RyhlExXBZTKa7rLx+ZmKLXuQKlWHVc/7+Aj2awnsBhnUpqSDqT
         Qi3ZPVYnkswrTvMPcw0eD/1xVkbC5Luc8tX4uFj/FQUA96q0Qhl/nxw9r0LVlU9dtFUn
         F5mnssQM5kVE8fXh4UV5EA/tcD14b0cjP2YBkQM6FDQAL0f1JScNVBG5vG1AcHdM2fmZ
         y5sWuaCCP1u+mrIu/VToGMuUb7thWLKSBoK+VC38w8Y/HodVzIQS1lQNU62nouUSo1f3
         9SCA==
X-Forwarded-Encrypted: i=1; AJvYcCW2+X449lqnKUHot8As3XH66KMjGM4CcaYxWNAZ0Gcc2KlsVHOv1I96uYzxtIaGQY30ZnujXdvkJQL2NSgXPDZ494/RGBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzONUgs/ra1iDPfm9NZwhG41lgEPEb2pwBqyJ5+6wmjOSuFQ/Q
	aGjmbNcCBKr3kfVw+xOg402KUSZbFI9whc29xqVBlXqtr+3JbVi2F0DAAiYQYVe1SKTzQcHBOAo
	OYKkd00ElTfequUbGxSwAx/haaoNLJV4yQmtMaZ7w
X-Gm-Gg: AY/fxX463hIhygcgZs4aUwduyT9k6ZGIGyBUlYAaFZ73YphNJHQLlROTOsUWfhgizHT
	x2u2HCr+C2J3qE21+HgzV1wZAsqYwm4ElRLK+Dxg7dr7/wT3VKuBXEKpsejQsiOTU6OBvla/DmN
	jhR2Dd+e9ed899kNTZmi45dY7EdnQ3vWjb2ZCo5bYIhme+XhJAPQOQAl1+pHSoMvdd2WMYc28u7
	sbzg/a4iw81lmasII1cdm8OwiCbvWF8eXepaDU3fYXidFcRHWRI4v8HE+PHLx2pO1XA+Pu5gZ4w
	2MoCisg6DTMOdQlqyvcRRHuhmFk=
X-Google-Smtp-Source: AGHT+IFK+Y5PBS3dXibTZfBS01UEAFChnwqe6iaCyTB/4jIaIz5ZwPF8qLO8d7Qf00M2Z85ZCatTVKEE522UP0jz/Ik=
X-Received: by 2002:a05:7022:6291:b0:119:e569:f61e with SMTP id
 a92af1059eb24-121722e12e7mr5961881c88.23.1766235126461; Sat, 20 Dec 2025
 04:52:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251219154418.3592607-1-elver@google.com> <20251219154418.3592607-25-elver@google.com>
 <9af0d949-45f5-45cd-b49d-d45d53f5d8f6@gmail.com>
In-Reply-To: <9af0d949-45f5-45cd-b49d-d45d53f5d8f6@gmail.com>
From: Marco Elver <elver@google.com>
Date: Sat, 20 Dec 2025 13:51:30 +0100
X-Gm-Features: AQt7F2ppWjAa_1uLXQb3ar2W4qqqhjA5uP_vsvi-YrCuihuPYztcukGp4Yjpido
Message-ID: <CANpmjNOUr8rHmui_nPpGBzmXe4VRn=70dT7n6sWpJc6FD2qLbA@mail.gmail.com>
Subject: Re: [PATCH v5 24/36] compiler-context-analysis: Remove __cond_lock()
 function-like helper
To: Bart Van Assche <bart.vanassche@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	Chris Li <sparse@chrisli.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Alexander Potapenko <glider@google.com>, Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>, 
	Dmitry Vyukov <dvyukov@google.com>, Eric Dumazet <edumazet@google.com>, 
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

On Fri, 19 Dec 2025 at 22:42, Bart Van Assche <bart.vanassche@gmail.com> wrote:
> On 12/19/25 8:40 AM, Marco Elver wrote:
> >   Documentation/dev-tools/context-analysis.rst  |  2 -
> >   Documentation/mm/process_addrs.rst            |  6 +-
> >   .../net/wireless/intel/iwlwifi/iwl-trans.c    |  4 +-
> >   .../net/wireless/intel/iwlwifi/iwl-trans.h    |  6 +-
> >   .../intel/iwlwifi/pcie/gen1_2/internal.h      |  5 +-
> >   .../intel/iwlwifi/pcie/gen1_2/trans.c         |  4 +-
> >   include/linux/compiler-context-analysis.h     | 31 ----------
> >   include/linux/lockref.h                       |  4 +-
> >   include/linux/mm.h                            | 33 ++--------
> >   include/linux/rwlock.h                        | 11 +---
> >   include/linux/rwlock_api_smp.h                | 14 ++++-
> >   include/linux/rwlock_rt.h                     | 21 ++++---
> >   include/linux/sched/signal.h                  | 14 +----
> >   include/linux/spinlock.h                      | 45 +++++---------
> >   include/linux/spinlock_api_smp.h              | 20 ++++++
> >   include/linux/spinlock_api_up.h               | 61 ++++++++++++++++---
> >   include/linux/spinlock_rt.h                   | 26 ++++----
> >   kernel/signal.c                               |  4 +-
> >   kernel/time/posix-timers.c                    | 13 +---
> >   lib/dec_and_lock.c                            |  8 +--
> >   lib/lockref.c                                 |  1 -
> >   mm/memory.c                                   |  4 +-
> >   mm/pgtable-generic.c                          | 19 +++---
> >   tools/include/linux/compiler_types.h          |  2 -
>
> This patch should be split into one patch per subsystem or driver.
> E.g. one patch for the iwlwifi driver, another patch for the mm
> subsystem, one patch for the rwlock primitive, one patch for the
> spinlock primitive, etc.
>
> The tools/include/linux/compiler_types.h change probably should be
> left out because it is user space code instead of kernel code and
> the rest of the series applies to kernel code only.

AFAIK, the user space version is just a copy of the kernel version to
support headers that are used by both. See
4bba4c4bb09ad4a2b70836725e08439c86d8f9e4. The sparse annotations were
copied in ab3c0ddb0d71dc214b61d11deb8770196ef46c05.

And there's no point in keeping it around given it's all gone:

% git grep __cond_lock
<nothing>
