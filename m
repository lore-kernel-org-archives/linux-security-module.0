Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6043C2F3C0D
	for <linux-security-module@vger.kernel.org>; Wed, 13 Aug 2025 09:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755078569; cv=none; b=ED+uzdVj/UeJ3AuR5Eykn4Vcb8rvkGwXVW02Qmn2ccz41tBiMgTOt64zF4z8HPkZpZ5CVY/Y0+dKyYSqWoRp06w6ipUhM93iCgbI+QYlmWJb2RlHzYFIMqm3An/RZuiwGDHm0vbzQgdIC4W0LshzN8lbGFsCPsmsg0eAtHHuwDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755078569; c=relaxed/simple;
	bh=NP3KKQGvrB5FZ4Mm8fwUtOraNCd8kzfjoSd78zW/yYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=glj4ci2nhYXZFfdjgUXGfAOqjN57WAgnfFGvt/9K1q4wUFG0186fuftTnJ6C/Mx4UPgfoYsnARw1Dg+dDjB17ESL9r1I4+qRD+Drd0Yrt2B3NtW2zSQksC7tcyCY9tVCwMjoEzqLpCqOpzYAkJA2mvE1HJZKfGNU7K9HZ4TYc6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bwP1FUQ0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bwP1FUQ0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755078566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lIKt8B5a5fREJqC9YkptqPGZ5xrxtlUSDpDJJV7uZwc=;
	b=bwP1FUQ0Dmc9pE4kP5ZiRoX7q2nK4/SjiPk/9hduiKmmBy1KqdgNSLjhS6KwFzIYLOgdHm
	MBuMQfVDUZuvvAXYIzh3FB6QB4fYumWsJ+9hgboipCqtzK/pcRW3D0ZllyKJOLtSEP9sfK
	1BNFIH5Uj/ObCtC1Cs8A/G2bPb4ySjo=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-oSvCuBHHMQGyG74co996Xw-1; Wed, 13 Aug 2025 05:49:25 -0400
X-MC-Unique: oSvCuBHHMQGyG74co996Xw-1
X-Mimecast-MFC-AGG-ID: oSvCuBHHMQGyG74co996Xw_1755078564
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3221297a302so290600a91.3
        for <linux-security-module@vger.kernel.org>; Wed, 13 Aug 2025 02:49:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755078564; x=1755683364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lIKt8B5a5fREJqC9YkptqPGZ5xrxtlUSDpDJJV7uZwc=;
        b=Kyhr3jm+RW+Zr1mOxw2AgFL3900jlXEEBk2nWlpgQtbXtfsUR95XAQYgXK9zomfzAg
         ChTRhOt1OI4ud7Kx5awdiDtosNVkC2hM7Izmkoz5Jn8VIzMbaTOwwUF0UnVWGwSQXifU
         wqGi+J4Fyi5jV+PqXGOXc5lNGnMxIa1witGMiBWyK3CZLkF6yrHQ/OYumBj6SjbwIYsV
         eXOIUu1rTyy3l+e4OFmNldo9tfeKnAB46tv8c1eA4RyCHfHoO5uZF3PaIbQoZbSWq2qb
         qltEbTwYZu7ObIP7XwRDlcXo4J79s2pOZ0dhUPLpcFA5G1+dB0nmphHL2hBF+Hs/eGnn
         XwMA==
X-Forwarded-Encrypted: i=1; AJvYcCVwk0Eq1LAgsVOfU8oLrpLRqkDLzpjdgnMdNaZNT2DHuBYpBScs6DtcZg3jeGs/AVXslc5bo+VCob+d7DTii8hXTzEuaNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzfsWIaHcwkBa390xm1nUuTbPXhNVMJuMnzHNLog21rWyC+xbs
	O2VTvpxP8umiqD3dhWTDgP6dGFiCZL8y3khM62HEU7APouS5bjRbKY+x/zm2PwHH5qbbwPKGJ92
	nMScDcW0RbU7JFnooxF2a6o8JxmlWryc6MNiawkwYJK7SSoJjyZncNQmbpGAXdlI3Z/UbHDdKBr
	rXJqNhCd6TJxhgktX+1FK4HCkLKp+zNoK/LuDUDo8VIsCeUqEXhslYbzuGQMBOUes=
X-Gm-Gg: ASbGncv4Hkrp/kef51TZtG+jN+m9zsuE2mH8/ggR2RjrNKL1/dykR20mr9OO/Gy0ms0
	c+UmTt1PmYaMLWPCwekBIRXRAE+kfRRa4vAursqJUQj5tHrJs4tlu8emA524xWArTxBKy0oEO5X
	DCYKcM8CaJKdsfOhQR4nI=
X-Received: by 2002:a17:90b:1811:b0:321:96da:79f9 with SMTP id 98e67ed59e1d1-321d0f1b96dmr2869593a91.34.1755078563548;
        Wed, 13 Aug 2025 02:49:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcLqSQXB6xECyrw7W8D2vfvgnrY+zlanbkaeDXJF2xKXTz66YsVZlNyzPL7EfhtlK+owKaLbjVtlAHUh32fko=
X-Received: by 2002:a17:90b:1811:b0:321:96da:79f9 with SMTP id
 98e67ed59e1d1-321d0f1b96dmr2869545a91.34.1755078562681; Wed, 13 Aug 2025
 02:49:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806143105.915748-1-omosnace@redhat.com> <aJP+/1VGbe1EcgKz@mail.hallyn.com>
 <aJaPQZqDIcT17aAU@mail.hallyn.com> <CAADnVQKY0z1RAJdAmRGbLWZxrJPG6Kawe6_qQHjoVM7Xz8CfuA@mail.gmail.com>
In-Reply-To: <CAADnVQKY0z1RAJdAmRGbLWZxrJPG6Kawe6_qQHjoVM7Xz8CfuA@mail.gmail.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Wed, 13 Aug 2025 11:49:10 +0200
X-Gm-Features: Ac12FXxzLEkTOcAZHe6tS71zzeJO07ew9tPCh0ENhIdqrL_wq2kP1qa_yiq-kjQ
Message-ID: <CAFqZXNtAfzFJtL3gG7ViEFOWoAE2VNrvCOA5DxqMmWt7z6g5Yg@mail.gmail.com>
Subject: Re: [PATCH] x86/bpf: use bpf_capable() instead of capable(CAP_SYS_ADMIN)
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, daniel.sneddon@linux.intel.com, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, alexandre.chartre@oracle.com, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, 
	selinux@vger.kernel.org, LSM List <linux-security-module@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: n_0TG99_LuEpKd4xOlPg-BuetWLZ2WtDOxS0QvXC4W8_1755078564
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 9, 2025 at 2:46=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Aug 8, 2025 at 4:59=E2=80=AFPM Serge E. Hallyn <serge@hallyn.com>=
 wrote:
> >
> > On Wed, Aug 06, 2025 at 08:18:55PM -0500, Serge E. Hallyn wrote:
> > > On Wed, Aug 06, 2025 at 04:31:05PM +0200, Ondrej Mosnacek wrote:
> > > > Don't check against the overloaded CAP_SYS_ADMINin do_jit(), but in=
stead
> > > > use bpf_capable(), which checks against the more granular CAP_BPF f=
irst.
> > > > Going straight to CAP_SYS_ADMIN may cause unnecessary audit log spa=
m
> > > > under SELinux, as privileged domains using BPF would usually only b=
e
> > > > allowed CAP_BPF and not CAP_SYS_ADMIN.
> > > >
> > > > Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2369326
> > > > Fixes: d4e89d212d40 ("x86/bpf: Call branch history clearing sequenc=
e on exit")
> > > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > >
> > > So this seems correct, *provided* that we consider it within the purv=
iew of
> > > CAP_BPF to be able to avoid clearing the branch history buffer.
>
> true, but...
>
> > >
> > > I suspect that's the case, but it might warrant discussion.
> > >
> > > Reviewed-by: Serge Hallyn <serge@hallyn.com>
> >
> > (BTW, I'm assuming this will get pulled into a BPF tree or something, a=
nd
> > doesn't need to go into the capabilities tree.  Let me know if that's w=
rong)
>
> Right.
> scripts/get_maintainer.pl arch/x86/net/bpf_jit_comp.c
> is your friend.
>
> Pls cc author-s of the commit in question in the future.
> Adding them now.
>
> > > > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_com=
p.c
> > > > index 15672cb926fc1..2a825e5745ca1 100644
> > > > --- a/arch/x86/net/bpf_jit_comp.c
> > > > +++ b/arch/x86/net/bpf_jit_comp.c
> > > > @@ -2591,8 +2591,7 @@ emit_jmp:
> > > >                     seen_exit =3D true;
> > > >                     /* Update cleanup_addr */
> > > >                     ctx->cleanup_addr =3D proglen;
> > > > -                   if (bpf_prog_was_classic(bpf_prog) &&
> > > > -                       !capable(CAP_SYS_ADMIN)) {
> > > > +                   if (bpf_prog_was_classic(bpf_prog) && !bpf_capa=
ble()) {
>
> This looks wrong for several reasons.
>
> 1.
> bpf_capable() and CAP_BPF in general applies to eBPF only.
> There is no precedent so far to do anything differently
> for cBPF when CAP_BPF is present.

That's not entirely true, see below.

> 2.
> commit log states that
> "privileged domains using BPF would usually only be allowed CAP_BPF
> and not CAP_SYS_ADMIN"
> which is true for eBPF only, since cBPF is always allowed for
> all unpriv users.
> Start chrome browser and you get cBPF loaded.

Processes using cBPF (via SO_ATTACH_FILTER) already can trigger a
CAP_BPF check - when the net.core.bpf_jit_harden sysctl is set to 1,
then the sequence sk_attach_filter() -> __get_filter() ->
bpf_prog_alloc() -> bpf_prog_alloc_no_stats() ->
bpf_jit_blinding_enabled() -> bpf_token_capable() happens for the same
iio-sensor-proxy syscall as the one that hits the CAP_SYS_ADMIN check.
Because of this we have already granted the BPF capability in
Fedora/RHEL SELinux policy to many domains that would usually run as
root and that use SO_ATTACH_FILTER. The logic being that they are
legitimately using BPF + without SELinux they would be fully
privileged (root) and they would pass that check + it seemed they
could otherwise lose some performance due to the hardening (though I'm
not sure now if it applies to cBPF, so this point could be moot) +
CAP_BPF doesn't grant any excess privileges beyond this (as opposed to
e.g. CAP_SYS_ADMIN). This is what I meant behind that commit log
statement, though I didn't remember the details, so I didn't state it
as clearly as I could have (my apologies).

Now this same usage started triggering the new plain CAP_SYS_ADMIN
check so I naturally assumed that changing it to bpf_capable() would
be the most logical solution (as it would let us keep the services
excluded from the hardening via CAP_BPF without granting the broad
CAP_SYS_ADMIN).

Is the fact that CAP_BPF check is reachable via cBPF use unexpected
behavior? If both cBPF and eBPF can be JIT'd and CAP_BPF is already
being used for the "exempt from JIT hardening" semantics in one place,
why should cBPF and eBPF be treated differently? In fact, shouldn't
the decision to apply the Spectre mitigation also take into account
the net.core.bpf_jit_harden sysctl even when the program is not cBPF?

> 3.
> glancing over bugzilla it seems that the issue is
> excessive audit spam and not related to CAP_BPF and privileges.
> If so then the fix is to use
> ns_capable_noaudit(&init_user_ns, CAP_SYS_ADMIN)
>
> 4.
> I don't understand how the patch is supposed to fix the issue.
> iio-sensor-proxy is probably unpriv. Why would it use CAP_BPF?
> It's using cBPF, so there is no reason for it to have CAP_BPF.
> So capable(CAP_BPF) will fail just like capable(CAP_SYS_ADMIN),
> but since CAP_BPF check was done first, the audit won't
> be printed, because it's some undocumented internal selinux behavior ?
> None of it is in the commit log :(

It is not unprivileged. It runs as root and without SELinux it would
have all capabilities allowed. If it were running without any
capabilities, then indeed there would be no SELinux checks.

> 5.
> And finally all that looks like a selinux bug.
> Just because something in the kernel is asking capable(CAP_SYS_ADMIN)
> there is no need to spam users with the wrong message:
> "SELinux is preventing iio-sensor-prox from using the 'sys_admin' capabil=
ities."
> iio-sensor-prox is not trying to use 'sys_admin' capabilities.
> cBPF prog will be loaded anyway, with or without BHB clearing.

Well, it depends... In this case the AVC denial informs us that the
kernel is making some decision depending on the capability and that a
decision should be made in the policy to allow or silence the access
vector. Even when the consequence is not a failure of the syscall, it
still may be useful to have the denial reported, since there is a
potential performance impact. OTOH, with CAP_SYS_ADMIN if the decision
is to not allow it, then silencing it via a dontaudit rule would
potentially hide other more critical CAP_SYS_ADMIN denials, so it's
hard to decide what is better - to silence this specific case in the
kernel vs. to let the user allow/silence the specific AV in the
policy...

--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

