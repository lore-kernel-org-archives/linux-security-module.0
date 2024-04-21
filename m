Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD7B18030
	for <linux-security-module@vger.kernel.org>; Sun, 21 Apr 2024 16:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713715493; cv=none; b=QEIlXLVEWxZ86h6OgsuYXVV+z/2Ohqt326KL7Tb7wgs9XkxvHQ01fj8mOPOnVbWUSn6FAyxUEbsXvbgmPt5KPv+w60QgOSTMsITSpcR/q9m1U+z3v9Fro7IlplF53/OtNd8u1hqMe+T3+faDh4sfO4sfCEsBfAPDgsyMqohLMIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713715493; c=relaxed/simple;
	bh=2M6GaHV9sMSfCXjCBMsfVQw6K83qKyB9KbBEyHhGlaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V2VVnYZXnEB2r5c3sMHAHPmqbUqkJ9BuIrKffP43Agz6yHz9xv4AoYIS2669KUn8/ieG+3qCX5MyZhMf416FVcqxIpnqGW+mSAnFPQf0VuOOa68ZF/sZa9lzZWHohOR1svnKAwRjUubEmWGdGmN5zQdukTA56Tg/SOJGRcbzgE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aJXoVa9V; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aJXoVa9V"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56c5d05128dso3222553a12.0
        for <linux-security-module@vger.kernel.org>; Sun, 21 Apr 2024 09:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1713715490; x=1714320290; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eGbOttjXSy/dn3keYAVj3six2JIbvufZsOSIb9RbwPA=;
        b=aJXoVa9VipHg79p5W9Vuno8rsPU45ervHo0dF8UnyithyOzZsf/j6IJsBO5v63chIG
         5DIsxxdDn7AKosiOETXEMaHLjf3BzB7diN13hfEqM/jQpzX8OH/+IA3SYDQFDcjdC/mv
         Gh2DhucqJwNnqFfk3EZF2aTre7+TMVBvXc7GM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713715490; x=1714320290;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eGbOttjXSy/dn3keYAVj3six2JIbvufZsOSIb9RbwPA=;
        b=OA44dJ5oUISndqZcxnNPicKSkuVqGDbfnW7cQGcnRirp8qi/0oWclVGamqEyw69kCD
         gShJQu5fQ+ZAflUqVvrtVzmVRJfQl4ha9RkmD4e0xz9ZwEO/l3if3q6Poqnd5hBiLPZC
         FN5dtuvjMG15s5iQX8HZAolRp8wzhYXHRwt8nVev2ag6EEp0ZC4zHJwSrsQsjiJfbrpk
         fJvUV/XTe57bM0bdApQoTuRgfWeNVAKpqQtk1XPwyk0ZWzurdxPTGyvBAqslXSPUSepp
         MtlavV28Cnnoi6u5sdVPM6cvn0jkhJJNnuqdUI9QBwSkI9QDY6CmhipMW3ZYBSjWAaEn
         HBDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeDNTYQjO14PG65/Wvtn7AdJq+jluD33XfuOb7GOUjTrngVMh4R8BLJbnlKwYSAbdk0gVrkTLPGTeXhDOty2qW2CgDKgGLV8klrOK1XPdW9DOQu3HJ
X-Gm-Message-State: AOJu0Yx8yIL0SyAJqeoL/dKQPe6FAZLMJOa/cU8sDkt+dHllcPZJylIQ
	sF9S102ZFJLTockoaxACcw3mCf+4eKhHYBSgwsRLRPZEfWiBcpKxJ3OP5s5OUPES8+YIPP3xjnH
	IJVYAPg==
X-Google-Smtp-Source: AGHT+IGsql9b6XqEByT2JI6EJEhP+fnJE7rKvfkdXOp43hr3iEetIXDAyduDraBB/TXIoG1JGgOLgw==
X-Received: by 2002:a17:906:2b9a:b0:a55:5ed2:44d5 with SMTP id m26-20020a1709062b9a00b00a555ed244d5mr3854863ejg.68.1713715489576;
        Sun, 21 Apr 2024 09:04:49 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id qy34-20020a17090768a200b00a55a59c629fsm1201340ejc.121.2024.04.21.09.04.49
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Apr 2024 09:04:49 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a524ecaf215so374660366b.2
        for <linux-security-module@vger.kernel.org>; Sun, 21 Apr 2024 09:04:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVQZ33xpRNTwaiCqPqDgg1n0vkxhAFUA3A0ym1M//Qb0fWNmqUruydonMZsXfFdP00jj9ploxv5byHGlHnKeLDmme5AfchPHpdyhNKgH7w4vSGpus36
X-Received: by 2002:a17:906:1949:b0:a52:5925:1f76 with SMTP id
 b9-20020a170906194900b00a5259251f76mr4723538eje.47.1713715488755; Sun, 21 Apr
 2024 09:04:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e696e720-0cd3-4505-8469-a94815b39467@I-love.SAKURA.ne.jp>
 <CAHk-=wjEZvnn51dhhLqBKUd=cuFhbYA47_OyfUOPB-0zKToL7Q@mail.gmail.com>
 <CAHk-=wjzqaqcicTtWfBtXyytJs1nqjJNved2JFsLVsVLYgVkuQ@mail.gmail.com>
 <CAHk-=wjW3PdOZ7PJ+RHUKRc8SqQhcWXCACOvmwBkKUKABHKqwg@mail.gmail.com> <6103a212-f84f-4dad-9d33-a18235bd970a@I-love.SAKURA.ne.jp>
In-Reply-To: <6103a212-f84f-4dad-9d33-a18235bd970a@I-love.SAKURA.ne.jp>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 21 Apr 2024 09:04:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgjZ0DJgeo5Sk-Kc5vw8TXGuxXftPV79Wv221ncstk1tA@mail.gmail.com>
Message-ID: <CAHk-=wgjZ0DJgeo5Sk-Kc5vw8TXGuxXftPV79Wv221ncstk1tA@mail.gmail.com>
Subject: Re: [PATCH v2] tty: n_gsm: restrict tty devices to attach
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, "Starke, Daniel" <daniel.starke@siemens.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 21 Apr 2024 at 06:28, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> "struct tty_ldisc_ops" says that ->write() function (e.g. gsmld_write())
> is allowed to sleep and "struct tty_operations" says that ->write() function
> (e.g. con_write()) is not allowed to sleep.

Well, clearly con_write() *is* allowed to sleep. The very first thing
it does is that

        console_lock();

thing, which uses a sleeping semaphore.

But yes, the comment in the header does say "may not sleep".

Clearly that comment doesn't actually reflect reality - and never did.
The console lock sleeping isn't some new thing (ie it doesn't come
from the somewhat recent printk changes).

So the comment is bogus and wrong.

> Thus, I initially proposed
> https://lkml.kernel.org/r/9cd9d3eb-418f-44cc-afcf-7283d51252d6@I-love.SAKURA.ne.jp
> which makes con_write() no-op when called with IRQs disabled.

The thing is, that's not the only thing that makes atomic context.

And some atomic contexts cannot be detected at run-time, they are
purely static (ie being inside a spinlock withg a !PREEMPT kernel
build).

So you cannot test for this.

The only option is to *mark* the ones that are atomic. Which was my suggestion.

> My major/minor approach is based on a suggestion from Jiri that we just somehow
> disallow attaching this line discipline to a console

Since we already know that the comment is garbage, why do you think
it's just a con_write() that has this issue?

And if it is only the console that has this issue, why are you testing
for other major/minor numbers?

> Now, your 'struct tty_operations' flag saying 'my ->write() function is OK with
> atomic context' is expected to be set to all drivers.

I'm not convinced. The only thing I know is that the comment in
question is wrong, and has been wrong for over a decade (and honestly,
probably pretty much forever).

So how confident are we that other tty write functions are ok?

Also, since you think that only con_write() has a problem, why the
heck are you then testing for ptys etc? From a quick check, the
pty->ops->write() function is fine.

                  Linus
