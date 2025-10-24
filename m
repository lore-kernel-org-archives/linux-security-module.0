Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B339306B3B
	for <linux-security-module@vger.kernel.org>; Fri, 24 Oct 2025 21:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761341431; cv=none; b=sZ+5xY5PK9AIXUO4Nd1cGqUjZiLMpm/x5rx8Byt12i3485zmIQw6gB8Qd9xbydVELx+q8bMeq2De1/1203A50O9ev7QFnH3l6/7uqSkIPrRRHmQWQ8BlBZrxK5dsUi7R/A5/RyczY0mk6SRT8s3Pn16dk93AVhrdQjYHxR+j3g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761341431; c=relaxed/simple;
	bh=6MBkEDdxnVG5HIz+RU52ThnAtl9OT03l4dcmuA7P9Do=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UQ/Rq/y3wQZjzNyxfXegy0ubgDLkj0wdlBVNmJs8ocwn3b2KfV4y495bAg2UZqUErqN3ggH7znqG2IE2AP3tjAGWakk7AUNhdAwq3zE2EuvUFvi/v3Ddm7K2ad+LlnaywzRLCIbTDnVMrUb5TVgvyHvWu8gwXMM+BemrzHJDkZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UnuBe41g; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UnuBe41g"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-62faa04afd9so1065a12.1
        for <linux-security-module@vger.kernel.org>; Fri, 24 Oct 2025 14:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761341428; x=1761946228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ElgC1tw3RRavn/IPbPddkKii2OlmwZLUB7ZUHz+dn2U=;
        b=UnuBe41gvdGZWpLSk/bBNlNOU1IpCaQsyi0U95shPh7FYZ0Bxb0d/vKnGum6xMFQkG
         vxkd1sfH8vfOEgsqVGK2/4K1Ah8qaohJcbolDZcID5y64T+YMAL+ONxSk9RrVjT0VFdw
         rTtQPRPhDYR5/M/oDPb5pzzAIE0DW6TOkuOOihsPPJScrYvdh39hWVMnt7fAP6gqFHa3
         cOXq+g3SLoKn+LHm2LooD6PIimvUJ5dBPSegtOwuWTNDn8tqwh9JqTC59WWfvDKeoUUt
         TAMVj/cCfXg/CZyJouLjNFS1xd4DJV/2C8KoFvGv9qI7xN1FoQikoKCOTgX1OcImh7yV
         pJNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761341428; x=1761946228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ElgC1tw3RRavn/IPbPddkKii2OlmwZLUB7ZUHz+dn2U=;
        b=ZQOVhBT27eO2JzTWEB7lrLvF3BIJ2sB7YWEVu6VevpPtl6CJFAmT8865xlrHxqfrGV
         wD9L3dcITo/DV7mdub3ZEogHThV7B5fx8B9wSiXFaNGHnWrehKR2RdS3Mgu/xxTF7QeW
         zUS+h4/gAxPhS78FxOQcUoRiRCcHJwC4DloPmivrbsBbwHMuMPdPhoy9mopSdgJPq6dx
         gtERJHWQmFjJTV5DYD0KYI8RqUiDnV+88DMXhSJZt09TD5WpMVmLLVa77vYsKQoRHgWV
         bOpcgE741N27xhvkAAHtfQ+mhvyK8E/z4s4F+k5O5zAu0kBdT9buafAxsjQupRXtBZE8
         24LA==
X-Forwarded-Encrypted: i=1; AJvYcCUtJdnzNQ5UeRqRIUb+MWNZJnWTMsFVjVSLZvIp/yklXrDq4GhDw4tphHlDzh8ma202MMoyLTcWTghzItlgStGD5KPwZbA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrhv0oNxIGBFuvrE4p++JXnq66/MmUEHRecVKEOInyNopKpfIq
	iJxIwjfQ9K9z+xkVXSu0texcXxghQnEm+rSUkmH8pkvVJNLbZl0qN4Hpmtipqjd+PrqbB1NVURP
	H/wOy7q1sfO9oqyP9HxyBQG81zdqL3v8QzxXkscZd
X-Gm-Gg: ASbGnctOtLg9vm5Mkzo6p/YZzG/kzTSZmpJzwz8R/64+JBXsz0rpluhpoys5+9Zlm4m
	3mlAiMqnTCvozri11vdJ02zFfqki9Y+KXV4qJ0aF//HLgT56UIQQ+/o+nuTAmTrdLMCuVh6zCOJ
	zvdKumxqtH14wSlBY7E508Cwh1NRAQzNQeywRy7U2dfWUjyA6X6OpY9PaiNpwYSglhG6M2U9+IO
	oyMbVpjg12XaP8d487w4I5o/Tu1m8RsdOK1lXjigEmlYYuhpEqVj5UcfySvRyEpehQCvFIBE2AA
	xOqFkIzCPmvECw==
X-Google-Smtp-Source: AGHT+IF8hDpyD4vG3722BZFL565cvKXbEY+MJqYmbKpfICeZv6zAH1iX+Za0bQwy7opXd5m1eU6OBPH5eRUnIEVuIRo=
X-Received: by 2002:aa7:d3c9:0:b0:634:909c:d3c with SMTP id
 4fb4d7f45d1cf-63e7c0d1030mr32113a12.2.1761341427556; Fri, 24 Oct 2025
 14:30:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001111807.18902-1-gnoack@google.com> <20251001111807.18902-2-gnoack@google.com>
 <20251020.fohbo6Iecahz@digikod.net>
In-Reply-To: <20251020.fohbo6Iecahz@digikod.net>
From: Jann Horn <jannh@google.com>
Date: Fri, 24 Oct 2025 23:29:51 +0200
X-Gm-Features: AWmQ_bns23WD6z04uY7yFltLR5vNyAsJwQyjKC6ZLLC02O0Gy7IbjRvRBNutmJs
Message-ID: <CAG48ez3MxN524ge_sZeTwL0FEDASaSTb-gm1vPO8UwpijTeHqw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] landlock: Multithreading support for landlock_restrict_self()
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Tingmao Wang <m@maowtm.org>, 
	Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 10:12=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digi=
kod.net> wrote:
> On Wed, Oct 01, 2025 at 01:18:06PM +0200, G=C3=BCnther Noack wrote:
> > +
> > +             /*
> > +              * Decrement num_preparing for current, to undo that we
> > +              * initialized it to 1 at the beginning of the inner loop=
.
> > +              */
> > +             if (atomic_dec_return(&shared_ctx.num_preparing) > 0)
> > +                     wait_for_completion(&shared_ctx.all_prepared);
> > +     } while (found_more_threads &&
> > +              !atomic_read(&shared_ctx.preparation_error));
>
> Is it safe to prevent inconsistencies wrt execve?  seccomp uses
> cred_guard_mutex (new code should probably use exec_update_lock), why
> should Landlock not do the same?

We don't have to worry about interactions with execve because, unlike
seccomp, we don't directly change properties of another running
thread; we ask other threads to change their credentials _themselves_.
From a locking context, restrict_one_thread() essentially runs in the
same kind of context as a syscall, and doesn't need any more locking
than the existing landlock_restrict_self().

> Why shouldn't we lock sighand as well?

seccomp uses siglock for the following reasons:

1. to protect against concurrent access to one thread's seccomp filter
information from multiple threads; we don't do anything like that
2. to protect the for_each_thread() loop; we use RCU for that (we
could also use siglock but there's no reason to do that, and RCU is
more lightweight than the siglock which requires disabling interrupts)
3. to ensure that threads' seccomp states don't change between its two
loops over other threads (seccomp_can_sync_threads() and
seccomp_sync_threads()); we don't do anything like that
