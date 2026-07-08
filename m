Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4B23F8238
	for <linux-security-module@vger.kernel.org>; Wed,  8 Jul 2026 21:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783547330; cv=pass; b=t5VN0+/T27l+MBCk4MdCIJ0UKrxR1RVHQcxhA05xmu2PL+9r7bWJiMSVheEpVLLxRz/EtfUpCjbEsetEdkiifiMjN+B1w2Vkk88HvdxWigfz5F4T4q1OMfgqQj1V+wJEsWd8s3NP05jHP/qeh8vz8Po9m2BupYA6FtQKYYrGP7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783547330; c=relaxed/simple;
	bh=NLMDF7I6FstMAQAeirtdi6wuSf+np5zuq01Umjpc8ow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=obVHnW8/YoH+dxL1jf6KavFcS9Gq4t/z0OQIZ0pwA+7f8hchXlGQ2S+KNePlG9VlRvwPwp4g52t8BfAyMUWZNxSILs7UsTjlewS3GEOUZ2CgWS4uZaxDRl8GKqONiW6mmFrw+1uyL543w3Nof5Fdc3HMxLS4Q5LF7eIYv8dnSos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=snlbuN0T; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="snlbuN0T"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-698b78c05b0so1852a12.1
        for <linux-security-module@vger.kernel.org>; Wed, 08 Jul 2026 14:48:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783547327; cv=none;
        d=google.com; s=arc-20260327;
        b=YXK/JLPsY7mhjItOouQ9g6aGbpLD3Dg+sHFkKU1YmV3rBnplDwvUBwCeZ/5rRX6wGg
         5MmI6G1yIySU8LKGjuF9K5Zp7kqWLExgSz55YibQX9DoYIdZPOkOxS6hQiNw4HnVQSQv
         VFzcNYHN+olS5zmkqqocm+/PNVKT5srUGAkidGM2Fs719MhlbH40ViaeEaVtK341RDCn
         7AvMm7cI8Y4Q3NZikNq2ud5qc1BGlgKpgmMTk1WyA2BlN9OixQoGNkzd3+Fr+Vx8gL7P
         o9Urw4RodSuyG/rRAzjcpkj2lh4vaEBoBBZpiZj29aU9zrfP+RjpuEkmQDmiyNRv0wMh
         8vmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DKUZ0lFg17Mh7sHmvQEAtUOIrfiiXO1vlZnioYWzL2U=;
        fh=drBBVwVyvRnQJ+2AYhSvXByvH3Ao4ys8LioXdrPg1Q8=;
        b=N//Jo2Z1E6T4TBNWWzGQs6xEPNM4eq7lxj8HlbraiAVZrVSezXffUfk7TlKl/uYAVS
         iFQTLowuige4SMzPN/b1HBOflVijLOypaj/sGUq4v9LIaEjFiiKRPcfhooYkCcLgztIB
         RnxZcLtr7tKF3Cszfd0qpXJUzcQXySatU1d09evcT8bHy1n/Oc0ZCGUvRMBVydLAWRx4
         BexOodyEZk+O/R7r4Kz3rmBxKerkqnAAI7QY2QBkrTr4UyB+A0xxxmafaGNl547OcGBG
         VI4B7NkEUDYH0TPpx6/ZGZEe8KpfSqC+7WdeIF9Gvtpg4H4cY/OWJtnFBiaAiuEoTXrt
         mCew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783547327; x=1784152127; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DKUZ0lFg17Mh7sHmvQEAtUOIrfiiXO1vlZnioYWzL2U=;
        b=snlbuN0T8wHaa3tJ6R7Fw8Fb5eUHt6G3EXUUvM5WAQORi5t7JPHtSIy5M92Ks3YRX3
         uMkpvZ61V7xs8nrwJaKD9O+EV+SgKRBDa0zO7a4pjr8KfsRybkpAENjOPOuCR8VhB0Z9
         YdqlK6dbq/Gnue3JmHc3zsG8ghahOfaiYS5ZuIgjcGbrYdkRSvxpV9lPpEuvxKmEsphD
         Sa3G61FmTFDL7XZYUtqbh4TjLBb2mLbJRDwY3UtLR3/IvEhjusmf1j4BCRRb9Efjt4fC
         ECbDQkacrWhg9+76fw/w/Pf24meRV/r7zjudYOtKmIhv95roFCjcpxMMUa3fAK2jhhih
         qolw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783547327; x=1784152127;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DKUZ0lFg17Mh7sHmvQEAtUOIrfiiXO1vlZnioYWzL2U=;
        b=enQMB2y578Me0jPfm5IaV4o464woLsq/vEDbYawHiqYMrhC4NOPRjTduFJpvf3VZfo
         POBo1tgygLd9JorbniBRqDQOsNJYFqqhtSGLu36nIZwjUcOQ1jG5izgQOxWKNFej646D
         juMvuDGBtmJtskjPYYNp9QTILGg/f9i6zhHxwk908FKV6d4aO08R22gGFLL/ivRctsJ4
         7lxXVZysA0onoF2YGpaZMU9/3LOwFJgoUa01lu4h/5kD9LKL2zMoJwagVahRXZQ8iclf
         S6S2gTuUVhhpIhFPYL0Lv9eo7HRK1ibf3n7oWg3Dbb2J63vqnV2QJrLzA0dnnEEJygax
         hcBA==
X-Forwarded-Encrypted: i=1; AHgh+RoTkE/j+NH8Pi6SxNdMot2p2mFuh3juZATNeC/be833oBs5YMYLRiW2k+tLZSIZc4hFWHzHT5f6w1ArEqz4atLKzHk/g9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTnbx0LMFaSy/90O5vQLyZkIY+AdboT+Um079PRLfOgC6/icyQ
	DMXsUTUC5EQgwVawHxWpVYU0oVg6uaWFS/4D05QY5wbHTzdWpFKLNSBEsLPwqCDUqoVSealY3Sz
	hFQ9m5lQngbW2zpELnb944RodkLogwg/LVB9QnULs
X-Gm-Gg: AfdE7cn1UNT69X8GjdnzL7ToaL6Oh/3FzTTMj8TknK6UpuAULQf0Sysz98FuYCv1DO6
	mEZqYiQ97Fq9VrZNDGGZWoJhNzn1SLV58P/uihSqyWoANbcMAXRM91NCpJEWmn0idP+8umKtYTz
	xL0o8+tq4UpvFLBYVV2CqUmwbK5Cy802olDT2bDZ+wsu3hcYhJ0gVTzplnLwuQSt8xbaasPljX6
	emN8a3PYEG8YgXR+XQsfJ0lfOWpIFC6ZF8bjkNtkjSdMsBue15KGexrWLQ9g3O4MelPOXKbfqnu
	XX28meuiRLPWE7su5hpm4tJ+VZNDxyyxJVSydHN08w+d15F/Us5tDBJCsTGSwyV8o+82
X-Received: by 2002:a05:6402:2053:b0:69a:fb2d:e84b with SMTP id
 4fb4d7f45d1cf-69bff1b2bacmr4833a12.9.1783547326726; Wed, 08 Jul 2026 14:48:46
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707210336.2060040-1-mic@digikod.net>
In-Reply-To: <20260707210336.2060040-1-mic@digikod.net>
From: Jann Horn <jannh@google.com>
Date: Wed, 8 Jul 2026 23:48:09 +0200
X-Gm-Features: AVVi8Cd70VXTPmi6Yd7YJ6QWdP__iVuKDOVFxgYsM6z5t2MksbTZvyWjknkN4Wk
Message-ID: <CAG48ez3ywK8FZ-TZFzp1GwiW6Wb+DeO3OFt3Ys4QAeGTS0jv6g@mail.gmail.com>
Subject: Re: [PATCH v1] landlock: Document the threat model
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Bryam Vargas <hexlabsecurity@proton.me>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>, Justin Suess <utilityemal77@gmail.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Leon Romanovsky <leon@kernel.org>, 
	Matthieu Buffet <matthieu@buffet.re>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Paul Moore <paul@paul-moore.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Tingmao Wang <m@maowtm.org>, 
	Ubisectech Sirius <bugreport@ubisectech.com>, Willy Tarreau <w@1wt.eu>, 
	Yuxian Mao <maoyuxian@cqsoftware.com.cn>, kernel-team@cloudflare.com, 
	landlock@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 7, 2026 at 11:03=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
> +Sandboxing is layered
> +---------------------
> +
> +Landlock is the access-control layer of a sandbox, not the whole sandbox=
.  A
> +robust sandbox also needs steps that are the program's responsibility: s=
witching
> +to an unprivileged user, dropping capabilities, setting ``PR_SET_NO_NEW_=
PRIVS``,
> +and confining all threads of the process with the same domain.  A
> +single-threaded process gets the latter for free; a multithreaded one ca=
n
> +enforce a ruleset atomically on all its threads, or must otherwise synch=
ronize
> +them before any untrusted work.  Landlock is typically applied last, to =
tighten
> +access and make the domain identifiable and auditable.
> +
> +Stronger isolation can come from combining Landlock with other mechanism=
s in a
> +defense-in-depth approach, notably seccomp-bpf (see
> +Documentation/userspace-api/seccomp_filter.rst) for what Landlock does n=
ot yet
> +cover.  A long-term goal of Landlock is to control access to any kind of=
 kernel
> +resource in a way suited to sandboxing.

I think this part is something that should go near the top of the
document, and should have a title like "How to securely use landlock"
- most of the document is focused on telling kernel developers or
security researchers what the boundaries of the threat model are, but
I think it is also important (and maybe even more important) to
present this from the perspective of "if I want to design a sandbox
using landlock, what do I need to pay attention to".

I think it would also make sense to give more specific guidance on
which sets of syscalls, with what argument restrictions, can be
permitted in a seccomp policy because landlock covers any accesses
that these syscalls can perform to objects to which the process
doesn't already hold file descriptors or such.
I think it would be helpful to have instructions like "you can safely
allow socket operations if you ensure that socket creation (socket())
only works for AF_UNIX, and that the process has no existing socket
file descriptors for non-covered socket types, and you have fs_access
rules, and the kernel is sufficiently recent".
