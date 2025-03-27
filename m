Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61B41B960
	for <linux-security-module@vger.kernel.org>; Thu, 27 Mar 2025 01:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743037616; cv=none; b=Ui5++KKvRNhR4wcPbouAVLsItvbz87klB1OpB1wzdJmYJwZ98G4P1C3coG1OTQz0R1kQDG4y2EtC6a3I7ih0piB7g0kvFKoXdc7qUu2vwC7ReFagWVJW1MdFUwdvYIhD0Rqf1H7dpNW0I6nzlx1YdDeuq5bDk00Lmu4uNJ7VSko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743037616; c=relaxed/simple;
	bh=PDzZXzGgpa+3aT/pBp71bWpbRe/VUEFk4HVLQOHBTLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NNFQWXaB59bsw7ZaZigSXZu1/2E8kkTfbOa///GwFvCApXnk/LaHy2zQgdRgPIWRlj3ooj2sZsEMnSmhsnjeg42W6GE3LTYXAWP+WGx+q49HvbTQ110MVf8UAEUs3c8GoBbtcYiIndHKStTxrC7HSVh8/Qur+hGDk8VBGoglqaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rAdqY/wM; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rAdqY/wM"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5499c8c95beso3846e87.0
        for <linux-security-module@vger.kernel.org>; Wed, 26 Mar 2025 18:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743037613; x=1743642413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+L1qMxOdQhRml0aQ1zbxnH+K6qVWg32HMVNaSIUwDs4=;
        b=rAdqY/wMwmTL1BtQcfdKy/9jyTiw6nGun+WVHFX+cLo70Bq8WXfXz0soESNXhUUOp3
         +AyVrv7x9A4DzU7HPv+m3GIzq71uwUlCwcKaAGJznkfyT7MLLfmefuAnxa0w35Okn5Hh
         K31r3mEjwA7DMEkR8xPjwiErddQUwqijYxWZa+DcWz82V55rYRRhwBwKPvCFgB/FPtrT
         KvzNMJsg12EWYJBylo35V336mdSGwUouwf7FX+P9NS64riwdlEglWI+9aZ/l9FW8V4F3
         6sMx1UNZ2gicvQT5SAZ1ij7FXmYXvNsCdFAosENg7Rg5HF2xgI4kvaagvntj02kJcQpc
         6Zsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743037613; x=1743642413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+L1qMxOdQhRml0aQ1zbxnH+K6qVWg32HMVNaSIUwDs4=;
        b=k02BdZVuZN3SdnBxI4cSq10+PRBFW2h/rDnfPa6tSyZx+rryRbfzSUCIFjmbprclTe
         671BpzHMYgu3Gc3r192/xIlRjVODN9svrFNLfruxH4FI7lxNHNaC8iKbVTrZpbDeT20m
         L7qAFMkfj/CRtc44qvzuLPLDx49FgD2NDDj+S12PQ/Bijv9MC+YjikpCUUNotx9rkHtS
         Wq24qlTkH6oUMHEvphWwVoTqTm48Q1Bp2VkGqYohua8Q7CDYb9AY2/dwZjygmXTyg9o4
         GdfiPIfUtXeuME361F5+KbFYHRDmO+xQXxkT2RaG7jLwE4/gO7p6Zd6wPsRJX/7EuVaE
         FB9w==
X-Forwarded-Encrypted: i=1; AJvYcCW2tGbbDvZoSuFIAoGKretprJryZ5pHFsloegNzF176mSDegp2PaqPD3DKyYKLcJAg4F9Dc/8RZ5hz/wELIIp92nbNrSQk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw19zQ7WyetjPTizKn/cYR8hyxI1VtVZwgnpPduHYFKyQc9lGHh
	bl+OqlvcZGcONbTyIk7ti11xpvT0kwhNW910TrGnR9oX7wWm0ODWI0yj9uwx10fErelADSSP4QY
	NazQvLv6wO+Fdu0J+QH+SOLYwnsEtZdjgaZaY
X-Gm-Gg: ASbGncvL7dGzZY/FUP/8ULqErB7jdE7oSOJolXfl1ZHnt+GlsZXX751RNLrkHbS7Nvs
	7Q++O38MmzintzPcBLzUsg9y5YDJPYRtX3Hh/A7D0eBgWa4ZHprvCtBKTD9BGXNNsunxv80bgHW
	0VLmcNti7lRxUu5jfARP0REYx+UF0c9c8b/5pk
X-Google-Smtp-Source: AGHT+IH/NMWE5Itnv3tw+53wI1lOQywMDWedrWlQ4fGn4pZ7pLbjFx8IamRwmDSAIYEZTiYzWdFsUx8z9SXMlCHmCqo=
X-Received: by 2002:ac2:58cf:0:b0:549:7c56:5300 with SMTP id
 2adb3069b0e04-54b0467226amr19427e87.1.1743037612625; Wed, 26 Mar 2025
 18:06:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d0ade43454dee9c00689f03e8d9bd32a@paul-moore.com>
 <CAHk-=wjbahY4JjLCXNT4o3xVq2cejqBG69z+MNfHsN9FQBnbOw@mail.gmail.com>
 <CAHC9VhRExVqdhHqs0njs7NY6bFg0BfcE-gMpS30HW9O7MSDfWQ@mail.gmail.com>
 <CAHk-=wi9m8-_3cywQCohJQEQtuQ+teS4gOtBkWZrhFWzNy-5_A@mail.gmail.com>
 <CAHC9VhT3D7X=4SpO5xbYm=JUwJqTa7tn=J6QMDBV96c7VBUw4g@mail.gmail.com>
 <CAHk-=wiH3hoPTxX3=xTRzRuCwktf3pNzFWP45-x6AwoVAjUsUQ@mail.gmail.com>
 <CAHC9VhT5G6W7g9pB3VM6W7wCEJjWfYSUWNgWF+rRiQ4ZQbGMEQ@mail.gmail.com> <CAHk-=whwQhJtafHN4B1w-z2Gno__xLHS4NouKKHrYNTYa8kz3g@mail.gmail.com>
In-Reply-To: <CAHk-=whwQhJtafHN4B1w-z2Gno__xLHS4NouKKHrYNTYa8kz3g@mail.gmail.com>
From: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date: Thu, 27 Mar 2025 12:06:35 +1100
X-Gm-Features: AQ5f1Jp_Nje7aoSlbd15PFGYPfjSW2D9aFtyUaNl9O0IYPmTo4b3NCAHsDLolFw
Message-ID: <CA+zpnLeK2Ecj1mBod2rFe4ymd9eXiJkbyYwFh4Yrmck3DVB2SA@mail.gmail.com>
Subject: Re: [GIT PULL] selinux/selinux-pr-20250323
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul Moore <paul@paul-moore.com>, "Cameron K. Williams" <ckwilliams.work@gmail.com>, 
	"Kipp N. Davis" <kippndavis.work@gmx.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	selinux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Nick Kralevich <nnk@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 27, 2025 at 11:43=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 26 Mar 2025 at 16:03, Paul Moore <paul@paul-moore.com> wrote:
> >
> > On Wed, Mar 26, 2025 at 5:06=E2=80=AFPM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > > That's insane. So explain to me why you added what looks like
> > > completely insane policy hooks.
> >
> > In the security_kernel_read_file() LSM hook, the SELinux callback
> > examines if the current task has the ability to perform the designated
> > read operation on file A.  Loading a kernel module and loading its
> > associated firmware are two events inside the kernel with the current
> > task loading data from two different files, each with potentially
> > different security properties, and we want to perform an access check
> > on each file to ensure it is permitted under the security policy
> > defined by the admin.

Paul, Linus,

Thank you for discussing the reasoning behind this patch. We wanted to
share how Android will leverage the new hooks introduced here.
Hopefully, this should help move forward this discussion and show why
these changes have concrete value to projects using SELinux like
Android.

Android, for a long time, has used the module loading hooks to ensure
that kernel modules are loaded from cryptographically signed,
dm-verity protected partitions. Even if an attacker compromised a
userspace process with CAP_SYS_MODULE, they cannot leverage this to
load modules from outside of protected partitions.

The changes presented in this merge request build upon this functionality.

Taking one example from this merge request: kexec image loading.

Currently, any process which has CAP_SYS_BOOT can use kexec to replace
the existing kernel. Android has 5 processes with CAP_SYS_BOOT, only 1
of which needs kexec functionality [1]. By using these new
permissions, we will ensure that this process is able to call kexec,
while prohibiting other processes. SELinux provides us strong, kernel
enforced guarantees which can be checked at policy compile time.
Extending on this, we will use this patchset to guarantee that kernels
and ramdisks executed by kexec come from known, good sources.

The other hooks are of similar value to Android.

Thiebaud and Nick

[1] https://cs.android.com/android/platform/superproject/main/+/main:system=
/sepolicy/microdroid/system/private/kexec.te;l=3D12

>
> What this tells me is that there wasn't actually any real ask for
> this, and you're trying to make up arguments for a silly patch.
>
> First off, "loading a module" and then "the module loads the firmware"
> file are *not* two distinct things with distinct security properties.
>
> The module DOES NOT WORK without the firmware file. So the argument
> that they are independent action is complete nonsense. If you don't
> trust the firmware, then don't load the module. It's that simple.
>
> Second, your argument that there are different tasks involved is true,
> but no, that doesn't mean that there are "potentially different
> security properties".
>
> Why? Because as mentioned, loading the module very much implies having
> to be able to load the firmware for it - but yes, the firmware loading
> might actually happen _later_ and in a different and completely
> independent context.
>
> In particular, drivers can do their firmware loads at various random time=
s.
>
> Yes, one common situation is that they do it during module load, for
> example, in which case it would be done in the same context that the
> module load itself happened.
>
> But it's *also* common that it is done asynchronously while scanning
> for devices.
>
> Or done when the device is opened.
>
> Or the firmware file is reloaded when the system resumes from suspend,
> because the device lost all its context, so now it's reloading
> something that it loaded earlier in a very *different* context, and
> that had better not start randomly failing resulting in basically
> impossible-to-debug resume problems.
>
> In other words, the context of actual firmware loading is pretty much
> random. It isn't necessarily tied to the module loading, but it *also*
> isn't necessarily tied to a particular other actor.
>
> So any argument that depends on the context of the firmware load is
> bogus a priori. Since there isn't some well-defined context the load
> happens in, any policy based on such a context is garbage.
>
> To put it bluntly, your whole argument for why separate policy makes
> sense seems completely made-up and has no actual reality behind it.
>
> It also very much sounds like this change was *not* triggered by
> anybody actually needing it, and as in fact sounds like just "let's
> pattern-match and do the same thing for these things that look similar
> but aren't".
>
> This is *EXACTLY* the kind of thing that I think the security layers
> should absolutely NOT DO.
>
> You should not add nonsensical policy hooks "just because".
>
> Security policy needs to have some thought behind it, not be some
> mindless random thing. And there should have been a documented case of
> people needing it.
>
> This is literally why I was asking for the reasoning behind that
> patch. The patch looked nonsensical. And I have not at all been
> convinced otherwise.
>
>                      Linus
>
