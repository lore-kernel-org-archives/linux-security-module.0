Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBD71FC7F1
	for <linux-security-module@vger.kernel.org>; Tue, 13 May 2025 21:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747170628; cv=none; b=NFkFCVznmaeBxPHm/XeEKiu+yWhYDqF7kZo8vMAsEVS2mYqRM+N+eVd9Ql5uJYnKHYbdkFGJqhjxC6HpayGX5HQ+vsDfa3G/aaAwV1xfHYsUFFt0R45ns3J/VDpspM0hGgZt5XMXJpiYZ/WhOAf9lAu+MnHzjETtJVSRMDmHjLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747170628; c=relaxed/simple;
	bh=82zEtRLhUQDpsLvYBWZVZquqMGMoaEvNl8BtBzmS4FE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YvgEjP1LHGRS2Q2eZRdn2pnb53EfK30L8VCBNvRUzzS0kwy2cZ6tSDB6Nm5/ran6hb+X5OzLE0jUMzXKer2DG+0l79qZG4/EjD+SBnJwTRVmzVdgRetw8DWCkdegrVEgXqnsnzxa8a8sAb9XMyHkQI1MonquPfxF2v9q8Bae/ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EFnQoGNA; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EFnQoGNA"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5fc4fc27983so833a12.1
        for <linux-security-module@vger.kernel.org>; Tue, 13 May 2025 14:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747170625; x=1747775425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=82zEtRLhUQDpsLvYBWZVZquqMGMoaEvNl8BtBzmS4FE=;
        b=EFnQoGNAHT+HNm/BO6dpQc/hpbe4FHRkl/KBSUQ0dbVLmNf1M/tZoYwwQLKlJ1jvBc
         BAoKLv1G+V1ho4CrIRd74+jJrMhoaNo51UePMRuOJTirDrVCFR1P5CshEmy+NKwJtqx0
         np920pie86rdJPgxpk6p4tZbuA9U9Hk3HT+PUbdMrmbMo61cws7Lkgy0E6uwbxxceQ0j
         2GV8Bm42zgqd3kfTHRyahEojzz7pDLYOXzerYt1Byk37giujpPVNTtziS50YV34crund
         VDcILoEmCzogT4/PvpCEabuBfr/OZ12ib9FqUHMCQUC8LxnPUgrr6KSUUxIeVk26SyCp
         YHmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747170625; x=1747775425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=82zEtRLhUQDpsLvYBWZVZquqMGMoaEvNl8BtBzmS4FE=;
        b=rr5CqHQ2hWwo6stk2739/Tdo3Ng+TKWZ0afqPUtfZYA6M7KTS0UqFDffBMm769FQhX
         auxVfwKd2PRTTJUNICBpmGxJZXNX1fS4W+fTidt0gbz4RYxRnkSP7tmhSpJM+8EDguM/
         thB9GxNBjZwmJl3jFJ4DHMP6mMrajwV4hY3CQin2klGmggPsYuAhqfSyLJVznsHbjXpV
         Kxur6U2k4mKBPlgRYowZQX5f7I9/gCQblWzMlJZ40h9n5kc+L3ucN82lDyyMEHwglWBv
         e/ElZw11vriLa6NZDq1b79Grz5iTIlQMMU8Qy6J6s0z7SBtbatvOeHtyl1SCr0oAn2Rb
         +few==
X-Forwarded-Encrypted: i=1; AJvYcCUmg1GriqWm9ie4Q5m3H7pirYl/yJMf2oYzgX3simmX8mnM77uqRiy4+toRSGQeUM2mXgB3HJn0m8NieU15nKou+asn3vQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQoQWKj10UB7As+wJnA/wd4fdaqXJIoNd621ukqjDY4SPA2lbb
	8G2FLb6BexD7yxyCpys/ABjqAWZoe//CBZltT1WazH22/Kg90+eyMl7IpdpLxpEvtjAAE6G1Rvd
	QV1bEs3KI428jduB8cXgMmO2oz5F+3nLaoNRRXsIq
X-Gm-Gg: ASbGncvkbohX1T0Bvsya28wLQtGN3Py6DfcH0yqnMZWJ1l1YIZPyTfJTwAzqpCCYlkm
	3AyY7WFyoY5w7nj4Hb16PMiezaOGgvKX1PE4Q4m9xE+qfLHIS28Ct8xFr/bYkEe4aqmH/glqlXA
	h5HYPQPEy/G+nHFVRa3fdzLk2vtys7FIl0a587w5NvSi2Mvn33Gn5lcL4v3/Wy
X-Google-Smtp-Source: AGHT+IFFvoW0vaiQwXwOuLU8KHoNjqrz7yUskjzEQxJboJ77uRfEnj6qF+F1/xO6hcdFFQqM32ILfLKZ8071TJJxbuw=
X-Received: by 2002:a50:ed16:0:b0:5fd:6065:7bbc with SMTP id
 4fb4d7f45d1cf-5ff97e27b24mr28177a12.0.1747170624943; Tue, 13 May 2025
 14:10:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20221006082735.1321612-1-keescook@chromium.org>
 <20221006082735.1321612-2-keescook@chromium.org> <20221006090506.paqjf537cox7lqrq@wittgenstein>
 <CAG48ez0sEkmaez9tYqgMXrkREmXZgxC9fdQD3mzF9cGo_=Tfyg@mail.gmail.com>
 <86CE201B-5632-4BB7-BCF6-7CB2C2895409@chromium.org> <h65sagivix3zbrppthcobnysgnlrnql5shiu65xyg7ust6mc54@cliutza66zve>
 <D03AE210-6874-43B6-B917-80CD259AE2AC@kernel.org>
In-Reply-To: <D03AE210-6874-43B6-B917-80CD259AE2AC@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Tue, 13 May 2025 23:09:48 +0200
X-Gm-Features: AX0GCFvSGCrl8jRaWXokLgXy6n507r0H59ZuhYg2-C-s2mYQog1RTVhArK8PEPE
Message-ID: <CAG48ez0aP8LaGppy6Yon7xcFbQa1=CM-HXSZChvXYV2VJZ8y7g@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs/exec: Explicitly unshare fs_struct on exec
To: Kees Cook <kees@kernel.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>, Kees Cook <keescook@chromium.org>, 
	Christian Brauner <brauner@kernel.org>, Eric Biederman <ebiederm@xmission.com>, 
	Jorge Merlino <jorge.merlino@canonical.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, John Johansen <john.johansen@canonical.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Eric Paris <eparis@parisplace.org>, Richard Haines <richard_c_haines@btinternet.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Xin Long <lucien.xin@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Todd Kjos <tkjos@google.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Prashanth Prahlad <pprahlad@redhat.com>, 
	Micah Morton <mortonm@chromium.org>, Fenghua Yu <fenghua.yu@intel.com>, 
	Andrei Vagin <avagin@gmail.com>, linux-kernel@vger.kernel.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-hardening@vger.kernel.org, oleg@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 10:57=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
> On May 13, 2025 6:05:45 AM PDT, Mateusz Guzik <mjguzik@gmail.com> wrote:
> >Here is my proposal: *deny* exec of suid/sgid binaries if fs_struct is
> >shared. This will have to be checked for after the execing proc becomes
> >single-threaded ofc.
>
> Unfortunately the above Chrome helper is setuid and uses CLONE_FS.

Chrome first launches a setuid helper, and then the setuid helper does
CLONE_FS. Mateusz's proposal would not impact this usecase.

Mateusz is proposing to block the case where a process first does
CLONE_FS, and *then* one of the processes sharing the fs_struct does a
setuid execve(). Linux already downgrades such an execve() to be
non-setuid, which probably means anyone trying to do this will get
hard-to-understand problems. Mateusz' proposal would just turn this
hard-to-debug edgecase, which already doesn't really work, into a
clean error; I think that is a nice improvement even just from the
UAPI standpoint.

If this change makes it possible to clean up the kernel code a bit, even be=
tter.
