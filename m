Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92E7331EBD
	for <linux-security-module@vger.kernel.org>; Wed, 24 Jun 2026 18:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782326558; cv=pass; b=bL1axMN2AMuC5rownHXKRRvZX2bFa6/f+hq8i5Nqn6XjNF98QoEKQIFxCNAGdZQsRso/8HIrbRSb/Ab4rA9mau2Tk/kkte0BvSX9JZASfHPLyH9lUdSGFol/yZCxJ2cd+Dzu1INrGd8oG+WVN8WrLKQ6U4Wa97eZ5T7ucYiy2yY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782326558; c=relaxed/simple;
	bh=PsUg4uC/wyz5+OzrTgGXCpBTf91PDcDV1VUDtXNnlKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RGHbNqVUEfXM5wb71QQagSq5ubU3VqoY4NchZYVMqho4VvHBUPhlYBWKGSiQZGOOJXaoPRtLYnEmp/ywZqwjv13f54aw6+2mLBRRh6TgnAYaclJ59s+FkzTrX4YkVExm3z1rsS5f3GYshOTX728byPFqi3nCJ1UxwZgyAf1/qJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=gjN365O6; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="gjN365O6"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-37d46e0d246so837056a91.2
        for <linux-security-module@vger.kernel.org>; Wed, 24 Jun 2026 11:42:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782326556; cv=none;
        d=google.com; s=arc-20240605;
        b=fLeTVFAmhzW+TUoJFJ6JUYoKEcGxZltqSHlM+7iEZfdD+IgpTtFMdaNEaL25OFuhA+
         N54ULYsRRtHQp/8pnQkH/kRamooGiGUwmKg7LPIvdCSWV+IzulOAZ3EKdo85zDIZgLdY
         xwHccIoPcHHzIIUKVoto4swpBvMo7bxhYnu6zPMJZU/TUG7mUPyqdSsrcQWz/gR2HYkX
         ua7FiTWYjY3fIgh/kLNUfXk4PUs0B/sg/jWM5ZHdkvxLL12yg8VG5cCJ5wT+p3cOp0Ab
         yl1sld7HTsubN2pXyrtPUppkFkqyhO7pKH4E5S3dAsvMHU2MrIMdtxhBQSplDIlMTka6
         jG8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EhtPGe1fQIj+dTbS/uj+ZYpI6PapyTZIuf9fBO08h7M=;
        fh=hDnbmKJ9IbgRUdv8BnYJmcg4Xi9+13Pndko9w7ycft8=;
        b=h2C4gihoCMbc5xa9sPx8jyRBnoRxURLZjIMx2qj/x8HZHlBJhZynvyD0JvkkPLidNL
         5kVM9KJ4a3wIqQwpMxNpXtvyR/JtpQC0p01A1mXdFRQg5rxHytb5BG/Qi4Og1sPnHiHi
         zQXZXtWwvUM6XcrLJMziuZ/dIpp815zu+wcEWx7zsuIengrHh05MSJIbmtCVKBRbT0X7
         T13zsf8TUNjtUK+0rkvoboSjtlQ7XqzE/0XFnMIx4lswqv9yY/gRHxYvqJmwUElmwsni
         zoe6Tj3b4ZyGxSPGsUNc7WZ391OtIHazcl0tuPoj9dCVK30vaLfL2yR9jq+dT/EqVJXb
         txlQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1782326556; x=1782931356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EhtPGe1fQIj+dTbS/uj+ZYpI6PapyTZIuf9fBO08h7M=;
        b=gjN365O6j3CiZczrHvrN/KUaOdlnAJYGKXUr2oHmsNYpJFtW1ZefusKsvu0+K0GLhP
         JaVsBEPMSl9fB31TUdRKbmBUHGytqTlAT3C6NWERFOlqvHQZVttQTOgdYM5IWst/FvLE
         5uwjYf3Ca53GhyjQm8HezQG5TlpQDf9brdT5BN7iW9OPRnYDZALb+RCIiF5Yqt7NbHSA
         p+Oxt9TKd94T4zQF13KSO07rm6sRwWf8wFnyeqQlMFR9xU2gxy1qLFkR+2IcQmLCiqiM
         p5iZm0yPMrjSBgRr50vZRqgn8l+b67K8k1bEOPmailsXujs9/gyH4FZdglrnoCoStTeD
         HiYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782326556; x=1782931356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EhtPGe1fQIj+dTbS/uj+ZYpI6PapyTZIuf9fBO08h7M=;
        b=iXnn6hPSy+E64zZISgi6FQN0+gHzkiD+3x39IApeVIWDjfN2kdYwDCMCUlFkZu8sem
         8bJZK8khh9IsbpXh8NR0D8F6LhOG8KGnLOd2FcpSOp05a5waGFRCOBOLOcwnvpV470ak
         8mmVTM6rXSlp5n8LoPX9AFHjEhPmxOOSvP+0EVxxXp684EYgPLUw+9E+70dBuIaTBRVC
         G8UUjlViNKPspflPtTMPTB9KApDS98aPiFtR9dJnjJifnvB5tf3G89WXCioOvhKjXLZ1
         svPJJ9/glIOF8GkAs0LMM4JTQaVXPrXPqywq8KuCNUT/2tu87Mju1MpwiRElL0JjEHsE
         RxZA==
X-Forwarded-Encrypted: i=1; AHgh+RrCL74GOv+ek+9G0deEC/5YnC1UCc6RK7nzrH2gEIB019ql+S+MyhEZYXyCjKNoX3PWOtBnzY4lBK4Pr+Qv1z5bxljKYTM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0O8Dx+eEeh1hO5Mif7jOU9G0XSSRaXv14NIE7xBWw0gihFQLR
	18cJzrHj1lD12APW95SVIjP5HVn+hUybdbI63I8AKGqXR/woOu9nvxgWVTnoswl/gJkNr5R5KXA
	Oolukk5wn8p1g+VE0FzQReSGZFEUAkK0pxB0bk1bJuGZh4wl33f7poCgS
X-Gm-Gg: AfdE7cnu0/eygH7p4hYxiTjUHrBsjDfodZNicFDu11YPPc4b8n4Ep48UXDAA5AAHPWY
	sjBZuplB6oazvnmMz0mS6D4PhyO6zO+oktwQXJpgPLn0yK9PT6a8VWCGof2IWRydAaff4rqeWlZ
	p0svscvoq9MqeP5zKKHQxegfmbKcVLi+0SigdeUwDkO4k7TD6caN7Pe1tRlvzoz0C8x3M9vP1cm
	DgsDqMS3/ZHhR2Tg1jg81Nbab6MmSjA379XOBS27RyIU6JkQeviw0w0wnMex+z6jYvLf0nw
X-Received: by 2002:a17:90b:1807:b0:35b:9894:f6f9 with SMTP id
 98e67ed59e1d1-37dd0dd1110mr10343576a91.18.1782326555869; Wed, 24 Jun 2026
 11:42:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624140301.93421-1-daniel@iogearbox.net> <20260624140301.93421-2-daniel@iogearbox.net>
 <CAHC9VhRar1x7kyjhgdmJ=Mfz4Msarv=wQ1821v723CaVdk1uTA@mail.gmail.com> <603d0f6f-bf02-48ec-af90-f16a239bad85@iogearbox.net>
In-Reply-To: <603d0f6f-bf02-48ec-af90-f16a239bad85@iogearbox.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 24 Jun 2026 14:42:23 -0400
X-Gm-Features: AVVi8CfjPQkADRUQ0uU9dicbj-tSuGC4ZlBnhMVmSksuabP2UbQh_BF41ZPMx94
Message-ID: <CAHC9VhTF6_VaSm0uOjW1eV05CvsaaL+2jimVuPTXHeLGEQcMPg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/5] bpf: Verify signed loader metadata at
 load time
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: ast@kernel.org, kpsingh@kernel.org, James.Bottomley@hansenpartnership.com, 
	bboscaccy@linux.microsoft.com, memxor@gmail.com, 
	torvalds@linux-foundation.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 24, 2026 at 11:37=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.=
net> wrote:
> On 6/24/26 5:12 PM, Paul Moore wrote:
> > On Wed, Jun 24, 2026 at 10:03=E2=80=AFAM Daniel Borkmann <daniel@iogear=
box.net> wrote:
> [...]
> >>   include/linux/bpf_verifier.h |   1 +
> >>   kernel/bpf/syscall.c         |  76 +---------------
> >>   kernel/bpf/verifier.c        | 163 +++++++++++++++++++++++++++++++++=
+-
> >>   3 files changed, 165 insertions(+), 75 deletions(-)
> >
> > ...
> >
> >> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> >> index b44106c8ea75..026b61d78bdb 100644
> >> --- a/kernel/bpf/syscall.c
> >> +++ b/kernel/bpf/syscall.c
> >> @@ -3189,10 +3121,6 @@ static int bpf_prog_load(union bpf_attr *attr, =
bpfptr_t uattr, struct bpf_log_at
> >>          if (err < 0)
> >>                  goto free_prog;
> >>
> >> -       err =3D security_bpf_prog_load(prog, attr, token, uattr.is_ker=
nel);
> >> -       if (err)
> >> -               goto free_prog;
> >> -
> >>          /* run eBPF verifier */
> >>          err =3D bpf_check(&prog, attr, uattr, attr_log);
> >>          if (err < 0)
> >
> > We must preserve the existing location of the call into the
> > security_bpf_prog_load() hook as some users rely on this hook being
> > called *before* the verifier runs.
>
> Keep in mind that the verifier /at this point/ of the new location did
> _not_ verify anything. So there is no heavy-duty work happening yet at
> security_bpf_prog_load. The work that is done before security_bpf_prog_lo=
ad
> is basically setting up the env, initializing the verifier log, and doing
> the process_fd_array which is resolving the map/BTF objects. But it did
> not walk any instructions etc, so semantics of the security_bpf_prog_load
> hook did not change from a user PoV.

There is still a reasonable amount of work between the existing and
new call sites, and the existing location outside of bpf_check()
offers an additional robustness benefit that future verifier changes
are less likely to impact the hook.  If I'm completely honest, I also
need to consider the events of the past year and a half; I'm now much
less inclined to support LSM hook changes in the BPF subsystem because
I'm very concerned about our ability to revert/modify those changes in
the future if needed.  That doesn't mean I won't support LSM hook
changes in BPF, but such changes are going to need to have a *very*
strong advantage from a LSM perspective to offset the risk associated
with the current BPF subsystem.

Based on what I see in this patchset, the security_bpf_prog_load()
call should remain in the current location.  If you need an additional
hook after the bpf_prog_verify_signature() call I'm happy to work with
you on that.

I also have to bring up the same question I asked back in your v1
posting: have you discussed this signature approach with Alexei?  Your
patches abandon and remove KP's signature scheme in favor of what is
effectively Blaise's signature scheme from last fall; Alexei argued
very strongly against these changes in the past.  I'd hate to spend a
lot more time reviewing and discussing patches that Alexei is simply
going to NACK once again.

> >> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >> index 2abc79dbf281..9cd2b62da380 100644
> >> --- a/kernel/bpf/verifier.c
> >> +++ b/kernel/bpf/verifier.c
> >> @@ -19758,11 +19895,28 @@ int bpf_check(struct bpf_prog **prog, union =
bpf_attr *attr, bpfptr_t uattr,
> >>          ret =3D bpf_vlog_init(&env->log, attr_log->level, attr_log->u=
buf, attr_log->size);
> >>          if (ret)
> >>                  goto err_unlock;
> >> +       if (env->check_signature) {
> >> +               ret =3D bpf_prog_calc_tag(env->prog);
> >> +               if (ret < 0)
> >> +                       goto skip_full_check;
> >> +       }
> >>
> >>          ret =3D process_fd_array(env, attr, uattr);
> >>          if (ret)
> >>                  goto skip_full_check;
> >>
> >> +       if (env->check_signature) {
> >> +               ret =3D bpf_prog_verify_signature(env, attr, uattr.is_=
kernel);
> >> +               if (ret)
> >> +                       goto skip_full_check;
> >> +               signed_map_cnt =3D env->used_map_cnt;
> >> +       }
> >> +
> >> +       ret =3D security_bpf_prog_load(env->prog, attr, env->prog->aux=
->token,
> >> +                                    uattr.is_kernel);
> >> +       if (ret)
> >> +               goto skip_full_check;
> >
> > We can always create a new LSM hook for this call site, e.g.
> > security_bpf_prog_verify_signature(...).
> >
> >>          mark_verifier_state_clean(env);
> >>
> >>          if (IS_ERR(btf_vmlinux)) {

--=20
paul-moore.com
