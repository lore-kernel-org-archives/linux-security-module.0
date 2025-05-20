Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246C82561CC
	for <linux-security-module@vger.kernel.org>; Tue, 20 May 2025 23:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747785262; cv=none; b=q3d5ziweR9xhof1qeu3qFoewQKp1PfLyfohj6/GBueZx6KwahZrBtQUDYhR9oVWCWDE6eb9wLp9x5NxqlOz2lbGlHG+XXz6TZu6F9dI5cRIKEsJ5s1ClRgJXYN5fCR8FFWKBDKbKePBr4BBIpWUh9pT7CojrQPv7l7e2iXLkUjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747785262; c=relaxed/simple;
	bh=HXSxrItUgdX61UGmGJ8G6xV038r9J7hX1GxFRTIQYIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tHujdazvswpI2SXJrLuJq2+ROR7L++koWhhYjTTqAZwz8w4mhvHxs7a815cUArCwd1rE3UaibTENoMZtUAcjbE8Xj0OMe/SAFFnTLXcgNISsP8u4HYJ147D/DLBQEY5z6UeLeO4GuX4gPn4gT3bF7MXpnY6fc1q6OQha/p36ERQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mt7Mmp/V; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mt7Mmp/V"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5f438523d6fso28217a12.1
        for <linux-security-module@vger.kernel.org>; Tue, 20 May 2025 16:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747785258; x=1748390058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W0Y4C4XCgaYlr1H2zY+JGfM+ydN1FEcE8gH9r2afV6E=;
        b=mt7Mmp/VfAJToX7oqoxBV86+mwdoylYkKAijwfnTMUX5oOezbkSK7LMIfsaKYj5NW3
         gn8Gj/Y4j2M773muTOdJt4TLcTjErCbjXflibQCkOHVxNCZXz7JReedaN0/CXidBGEoX
         W4H/OvlvvVoN/lm44ylPl8Fs2LMdYPv5JhpP+TjSHQOOkD5zGngvO1KUdTGyCQXsdxrh
         ATF10PGZLj3y0idvFfpWNJRUmal+hBr+GMKzQoxhBRfDgLTKUJeJYc2UBPj/4oI9U66h
         sM+MvDRQY+2ivTzfbxroj8hXkuLFlfJjbnigK0vX5WxdAYNGxmuQd81UsptS8Q3gvnoL
         3AZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747785258; x=1748390058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W0Y4C4XCgaYlr1H2zY+JGfM+ydN1FEcE8gH9r2afV6E=;
        b=uVSL/tEsIGBBJ2+enZFXvjcDnv7xRWz58vhyVRjRnZ2SSG/pkeAw55UsCtZwL4e82e
         vF82CcKF76NKxYuPOCQhh8hruTT8A0AIusFkX/Bo0CG9JVIuyBCCoBSjds1sJUbR3Q8M
         Epm2V0861pfpzmqJk9Sh3iWnMasJEv8TAAG+lXpJvoJgFNwfMbucxFjIwsukHXuAdljU
         sf5jJa+CtAU2TZ7fyPMUJMIo7zM8h2+cQ1wJrI2nWxI74UMKjQoKrfcvBWWmJ9k9DM6z
         r+76DuO//YYnXDcAhqFgrVb7THLQQ6zizOLi0o1dkVGWr6mX6tZtBI0cLE0x//6SZaUS
         JMgw==
X-Forwarded-Encrypted: i=1; AJvYcCUqyrC2+lSWLA6ackkzy64KRR/SUHVtByC6pPtjUq2SXCfug8w47rRZAtOi54Xf3XfQGMDAzMfZWtu2/whuL1bpoYmj3uU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgFprlnbk6mmKmpib+v3TjMYTnpbsVlt1vD3Sni69lvd7FLPm5
	RvInsRnwemTzEzygc+zzI3nX2YL2S1r6X5PVJh8O9qkVTL463jchCQXQHO8O7+10P1h7ztHemqo
	I/nAsnT+fuUqTessOqpzjO/s71rROTnhBr1xmi6iN
X-Gm-Gg: ASbGnctyRuoUgWJ8euoazW7J47t8cvG061dS7t3tOeZtn4NDClQCL63bbNjBzPXefu0
	6CA1Rgxe1noiKlnxI0VV/YkrKirS+jHxR02/RMcnRIrcQRaArGj/06dGyqiYn1UOHnQDrK7PFby
	oHEfjuR/aRqHgDmejxRw/TiPTDuBcirORXaoywL/5/rJTZKZHjgi1aCq9apYUIKh3bv09QMxOQ
X-Google-Smtp-Source: AGHT+IGrg9aSFlT2KvupPrG/0AJtAMcHz7fM2KeFum99aTBUI8OWddGT3IB8klvw/7rbhQ+ElKInrCNGoKVhledU6Rg=
X-Received: by 2002:a05:6402:368:b0:5fc:e6a6:6a34 with SMTP id
 4fb4d7f45d1cf-6019c7917b7mr352553a12.6.1747785258032; Tue, 20 May 2025
 16:54:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306082615.174777-1-max.kellermann@ionos.com>
 <878qmxsuy8.fsf@email.froward.int.ebiederm.org> <202505151451.638C22B@keescook>
 <87ecwopofp.fsf@email.froward.int.ebiederm.org> <CAG48ez1VpuTR9_cvLrJEMmjOxTCYpYFswXVPmN6fE3NcSmPPVA@mail.gmail.com>
 <87wmagnnhq.fsf@email.froward.int.ebiederm.org> <202505201319.D57FDCB2A@keescook>
 <87frgznd74.fsf_-_@email.froward.int.ebiederm.org>
In-Reply-To: <87frgznd74.fsf_-_@email.froward.int.ebiederm.org>
From: Jann Horn <jannh@google.com>
Date: Wed, 21 May 2025 01:53:29 +0200
X-Gm-Features: AX0GCFs4Z6qnlABiFef4kw_aBk4BjppKHtP4mQdv5hEw9RVyVnQqQEL49K7pmMk
Message-ID: <CAG48ez0N_1CEKyMHdjnvwsxUkCenmzsLe7dkUL=a6OmU4tPa6Q@mail.gmail.com>
Subject: Re: [PATCH v2] exec: Correct the permission check for unsafe exec
To: "Eric W. Biederman" <ebiederm@xmission.com>, Richard Guy Briggs <rgb@redhat.com>, 
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: Kees Cook <kees@kernel.org>, Max Kellermann <max.kellermann@ionos.com>, paul@paul-moore.com, 
	jmorris@namei.org, Andy Lutomirski <luto@kernel.org>, morgan@kernel.org, 
	Christian Brauner <christian@brauner.io>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 12:13=E2=80=AFAM Eric W. Biederman
<ebiederm@xmission.com> wrote:
> Max Kellerman recently experienced a problem[1] when calling exec with
> differing uid and euid's and he triggered the logic that is supposed
> to only handle setuid executables.
>
> When exec isn't changing anything in struct cred it doesn't make sense
> to go into the code that is there to handle the case when the
> credentials change.

Maybe you could summarize the change here, something like:

"To fix it, when executing with RUID !=3D EUID or RGID !=3D EGID on a
non-set[ug]id transition, do not strip privileges such as ambient
capabilities and (if the execution is marked as unsafe) EUID/EGID
anymore; but keep marking such executions as secureexec."

> When looking into the history of the code I discovered that this issue
> was not present in Linux-2.4.0-test12 and was introduced in
> Linux-2.4.0-prerelease when the logic for handling this case was moved
> from prepare_binprm to compute_creds in fs/exec.c.
>
> The bug introdused was to comparing euid in the new credentials with
> uid instead of euid in the old credentials, when testing if setuid
> had changed the euid.
>
> Since triggering the keep ptrace limping along case for setuid
> executables makes no sense when it was not a setuid exec revert back
> to the logic present in Linux-2.4.0-test12.
>
> This removes the confusingly named and subtlety incorrect helpers
> is_setuid and is_setgid, that helped this bug to persist.
>
> The varaiable is_setid is renamed to id_changed (it's Linux-2.4.0-test12)
> as the old name describes what matters rather than it's cause.
>
> The code removed in Linux-2.4.0-prerelease was:
> -       /* Set-uid? */
> -       if (mode & S_ISUID) {
> -               bprm->e_uid =3D inode->i_uid;
> -               if (bprm->e_uid !=3D current->euid)
> -                       id_change =3D 1;
> -       }
> -
> -       /* Set-gid? */
> -       /*
> -        * If setgid is set but no group execute bit then this
> -        * is a candidate for mandatory locking, not a setgid
> -        * executable.
> -        */
> -       if ((mode & (S_ISGID | S_IXGRP)) =3D=3D (S_ISGID | S_IXGRP)) {
> -               bprm->e_gid =3D inode->i_gid;
> -               if (!in_group_p(bprm->e_gid))
> -                       id_change =3D 1;
>
> Linux-2.4.0-prerelease added the current logic as:
> +       if (bprm->e_uid !=3D current->uid || bprm->e_gid !=3D current->gi=
d ||
> +           !cap_issubset(new_permitted, current->cap_permitted)) {
> +                current->dumpable =3D 0;
> +
> +               lock_kernel();
> +               if (must_not_trace_exec(current)
> +                   || atomic_read(&current->fs->count) > 1
> +                   || atomic_read(&current->files->count) > 1
> +                   || atomic_read(&current->sig->count) > 1) {
> +                       if(!capable(CAP_SETUID)) {
> +                               bprm->e_uid =3D current->uid;
> +                               bprm->e_gid =3D current->gid;
> +                       }
> +                       if(!capable(CAP_SETPCAP)) {
> +                               new_permitted =3D cap_intersect(new_permi=
tted,
> +                                                       current->cap_perm=
itted);
> +                       }
> +               }
> +               do_unlock =3D 1;
> +       }
>
> I have condenced the logic from Linux-2.4.0-test12 to just:
>         id_changed =3D !uid_eq(new->euid, old->euid) || !in_group_p(new->=
egid);
>
> This change is userspace visible, but I don't expect anyone to care.
>
> For the bug that is being fixed to trigger bprm->unsafe has to be set.
> The variable bprm->unsafe is set when ptracing an executable, when
> sharing a working directory, or when no_new_privs is set.  Properly
> testing for cases that are safe even in those conditions and doing
> nothing special should not affect anyone.  Especially if they were
> previously ok with their credentials getting munged
>
> To minimize behavioural changes the code continues to set secureexec
> when euid !=3D uid or when egid !=3D gid.
>
> Reported-by: Max Kellermann <max.kellermann@ionos.com>
> Fixes: 64444d3d0d7f ("Linux version 2.4.0-prerelease")
> [1] https://lkml.kernel.org/r/20250306082615.174777-1-max.kellermann@iono=
s.com
> v1: https://lkml.kernel.org/r/878qmxsuy8.fsf@email.froward.int.ebiederm.o=
rg
> Reviewed-by: Serge Hallyn <serge@hallyn.com>
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Looks good to me overall, thanks for figuring out the history of this
not-particularly-easy-to-understand code and figuring out the right
fix.

Reviewed-by: Jann Horn <jannh@google.com>

> ---
>  security/commoncap.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
>
> diff --git a/security/commoncap.c b/security/commoncap.c
> index 28d4248bf001..6bd4adeb4795 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -856,12 +856,6 @@ static void handle_privileged_root(struct linux_binp=
rm *bprm, bool has_fcap,
>  #define __cap_full(field, cred) \
>         cap_issubset(CAP_FULL_SET, cred->cap_##field)
>
> -static inline bool __is_setuid(struct cred *new, const struct cred *old)
> -{ return !uid_eq(new->euid, old->uid); }
> -
> -static inline bool __is_setgid(struct cred *new, const struct cred *old)
> -{ return !gid_eq(new->egid, old->gid); }
> -
>  /*
>   * 1) Audit candidate if current->cap_effective is set
>   *
> @@ -891,7 +885,7 @@ static inline bool nonroot_raised_pE(struct cred *new=
, const struct cred *old,
>             (root_privileged() &&
>              __is_suid(root, new) &&
>              !__cap_full(effective, new)) ||
> -           (!__is_setuid(new, old) &&
> +           (uid_eq(new->euid, old->euid) &&
>              ((has_fcap &&
>                __cap_gained(permitted, new, old)) ||
>               __cap_gained(ambient, new, old))))

Just a comment unrelated to this specific change:

Wow, nonroot_raised_pE() is hard to read, but I guess luckily it's
only used for auditing, so it's not that important...

The diff of the whole expression that decides whether to audit the
execution, reindented for clarity, looks like this:

(
  __cap_grew(effective, ambient, new) &&
  !(
    __cap_full(effective, new)
    &&
    (__is_eff(root, new) || __is_real(root, new))
    &&
    root_privileged()
  )
)
||
(
  root_privileged()
  &&
  __is_suid(root, new)
  &&
  !__cap_full(effective, new)
)
||
(
- !__is_setuid(new, old)
+ uid_eq(new->euid, old->euid)
  &&
  (
    (has_fcap && __cap_gained(permitted, new, old))
    ||
    __cap_gained(ambient, new, old)
  )
)

And we do auditing in three scenarios (situation with the patch applied):

1. We have effective caps that are not ambient caps, and we don't have
a full capability set based on having a root-privileged EUID or RUID.
2. We are in a suid-like execution but are not getting a full capability se=
t.
3. [changed part] We are not changing UID through a suid execution,
but either we gained ambient capabilities through the execution (???)
or we gained permitted capabilities while executing a file with fcaps.

I am highly confused by the __cap_gained(ambient, new, old) check
because I have no idea why ambient capabilities would ever increase on
exec. I thought they can only *decrease* on exec? Apparently that was
introduced in commit dbbbe1105ea6a ("capabilities: audit log other
surprising conditions").

Anyway, yeah, your change looks fine, just the preexisting code looks
dodgy to me.

> @@ -917,7 +911,7 @@ int cap_bprm_creds_from_file(struct linux_binprm *bpr=
m, const struct file *file)
>         /* Process setpcap binaries and capabilities for uid 0 */
>         const struct cred *old =3D current_cred();
>         struct cred *new =3D bprm->cred;
> -       bool effective =3D false, has_fcap =3D false, is_setid;
> +       bool effective =3D false, has_fcap =3D false, id_changed;
>         int ret;
>         kuid_t root_uid;
>
> @@ -941,9 +935,9 @@ int cap_bprm_creds_from_file(struct linux_binprm *bpr=
m, const struct file *file)
>          *
>          * In addition, if NO_NEW_PRIVS, then ensure we get no new privs.
>          */
> -       is_setid =3D __is_setuid(new, old) || __is_setgid(new, old);
> +       id_changed =3D !uid_eq(new->euid, old->euid) || !in_group_p(new->=
egid);

Hm, so when we change from one EGID to another EGID which was already
in our groups list, we don't treat it as a privileged exec? Which is
okay because, while an unprivileged user would not just be allowed to
change their EGID to a GID from their groups list themselves through
__sys_setregid(), they would be allowed to create a new setgid binary
owned by a group from their groups list and then execute that?

That's fine with me, though it seems a little weird to me. setgid exec
is changing our creds and yet we're not treating it as a "real" setgid
execution because the execution is only granting privileges that
userspace could have gotten anyway.

> -       if ((is_setid || __cap_gained(permitted, new, old)) &&
> +       if ((id_changed || __cap_gained(permitted, new, old)) &&
>             ((bprm->unsafe & ~LSM_UNSAFE_PTRACE) ||
>              !ptracer_capable(current, new->user_ns))) {
>                 /* downgrade; they get no more than they had, and maybe l=
ess */
> @@ -960,7 +954,7 @@ int cap_bprm_creds_from_file(struct linux_binprm *bpr=
m, const struct file *file)
>         new->sgid =3D new->fsgid =3D new->egid;
>
>         /* File caps or setid cancels ambient. */
> -       if (has_fcap || is_setid)
> +       if (has_fcap || id_changed)
>                 cap_clear(new->cap_ambient);
>
>         /*
> @@ -993,7 +987,9 @@ int cap_bprm_creds_from_file(struct linux_binprm *bpr=
m, const struct file *file)
>                 return -EPERM;
>
>         /* Check for privilege-elevated exec. */
> -       if (is_setid ||
> +       if (id_changed ||
> +           !uid_eq(new->euid, old->uid) ||
> +           !gid_eq(new->egid, old->gid) ||
>             (!__is_real(root_uid, new) &&
>              (effective ||
>               __cap_grew(permitted, ambient, new))))
> --
> 2.41.0
>
