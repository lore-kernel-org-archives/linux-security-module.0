Return-Path: <SRS0=o9Ra=WJ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAABAC32753
	for <linux-security-module@archiver.kernel.org>; Tue, 13 Aug 2019 23:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 763012070D
	for <linux-security-module@archiver.kernel.org>; Tue, 13 Aug 2019 23:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565737576;
	bh=UYu26GUQAaKNlccIn4jPZ2pz2hbDX6W5aP6WZ+L37CI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=jQgsOA41UrndEZMr5hn6XVT0c1xn7OKeZuHaoY9BqmLShO8uTzg9R21aXgkmaQ26N
	 556G9IiuVjms/eBdJuzha62M0daqYAIYB7OuE+DGbD9Sf6GkCXD+VZLOZ+EIFp2VZI
	 OTQGkWJ65BCs5quqUlUqXaRmOG1PbB+Ec5an/a9o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbfHMXGP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 13 Aug 2019 19:06:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:34196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727412AbfHMXGP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 13 Aug 2019 19:06:15 -0400
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C26420874
        for <linux-security-module@vger.kernel.org>; Tue, 13 Aug 2019 23:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565737573;
        bh=UYu26GUQAaKNlccIn4jPZ2pz2hbDX6W5aP6WZ+L37CI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=y0d/aeA/oHe7Ek9Oh0h0yfiYACeb5Phg6xTSU1ohEkYF/bR32GSZS2EapOSxaweNi
         UusU+zxqOPAy6AcE5QacsqFQf8lH8PQZ4g28vhaMjjn//bb9r20NBhrO/DVTjsMK3B
         H6NHRXiaNrBdqOT8uleZa79VQrgww+EOSzM7Tnus=
Received: by mail-wm1-f42.google.com with SMTP id i63so2811446wmg.4
        for <linux-security-module@vger.kernel.org>; Tue, 13 Aug 2019 16:06:13 -0700 (PDT)
X-Gm-Message-State: APjAAAXQIWVZ1ydiaFSqhv6NtYyAdvpmP7Kd+mUZv4TGHFbqskcHTV5u
        ESqvqP6jAyV2vOeG2K4PGGuBwllS5NFNhadojaxNdg==
X-Google-Smtp-Source: APXvYqzgctiSJ0eW17obIPLwzTtaflh0LjZKHtQoMzK/pi06oFlrGOU2Do83ItsTLqtVbfPkz5Pqf+2slTU2GsNMazE=
X-Received: by 2002:a7b:c4d2:: with SMTP id g18mr5105868wmk.79.1565737571802;
 Tue, 13 Aug 2019 16:06:11 -0700 (PDT)
MIME-Version: 1.0
References: <5A2FCD7E-7F54-41E5-BFAE-BB9494E74F2D@fb.com> <CALCETrU7NbBnXXsw1B+DvTkfTVRBFWXuJ8cZERCCNvdFG6KqRw@mail.gmail.com>
 <CALCETrUjh6DdgW1qSuSRd1_=0F9CqB8+sNj__e_6AHEvh_BaxQ@mail.gmail.com>
 <CALCETrWtE2U4EvZVYeq8pSmQjBzF2PHH+KxYW8FSeF+W=1FYjw@mail.gmail.com>
 <EE7B7AE1-3D44-4561-94B9-E97A626A251D@fb.com> <CALCETrXX-Jeb4wiQuL6FUai4wNMmMiUxuLLh_Lb9mT7h=0GgAw@mail.gmail.com>
 <20190805192122.laxcaz75k4vxdspn@ast-mbp> <CALCETrVtPs8gY-H4gmzSqPboid3CB++n50SvYd6RU9YVde_-Ow@mail.gmail.com>
 <20190806011134.p5baub5l3t5fkmou@ast-mbp> <CALCETrXEHL3+NAY6P6vUj7Pvd9ZpZsYC6VCLXOaNxb90a_POGw@mail.gmail.com>
 <20190813215823.3sfbakzzjjykyng2@ast-mbp>
In-Reply-To: <20190813215823.3sfbakzzjjykyng2@ast-mbp>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 13 Aug 2019 16:06:00 -0700
X-Gmail-Original-Message-ID: <CALCETrVT-dDXQGukGs5S1DkzvQv9_e=axzr_GyEd2c4T4z8Qng@mail.gmail.com>
Message-ID: <CALCETrVT-dDXQGukGs5S1DkzvQv9_e=axzr_GyEd2c4T4z8Qng@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/4] bpf: unprivileged BPF access via /dev/bpf
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Kees Cook <keescook@chromium.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Jann Horn <jannh@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Aug 13, 2019 at 2:58 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Aug 06, 2019 at 10:24:25PM -0700, Andy Lutomirski wrote:
> > >
> > > Inside containers and inside nested containers we need to start processes
> > > that will use bpf. All of the processes are trusted.
> >
> > Trusted by whom?  In a non-nested container, the container manager
> > *might* be trusted by the outside world.  In a *nested* container,
> > unless the inner container management is controlled from outside the
> > outer container, it's not trusted.  I don't know much about how
> > Facebook's containers work, but the LXC/LXD/Podman world is moving
> > very strongly toward user namespaces and maximally-untrusted
> > containers, and I think bpf() should work in that context.
>
> agree that containers (namespaces) reduce amount of trust necessary
> for apps to run, but the end goal is not security though.
> Linux has become a single user system.
> If user can ssh into the host they can become root.
> If arbitrary code can run on the host it will be break out of any sandbox.

I would argue that this is a reasonable assumption to make if you're
designing a system using Linux, but it's not a valid assumption to
make as kernel developers.  Otherwise we should just give everyone
CAP_SYS_ADMIN and call it a day.  There really is a difference between
root and non-root.

> Containers are not providing the level of security that is enough
> to run arbitrary code. VMs can do it better, but cpu bugs don't make it easy.
> Containers are used to make production systems safer.
> Some people call it more 'secure', but it's clearly not secure for
> arbitrary code and that is what kernel.unprivileged_bpf_disabled allows.
> When we say 'unprivileged bpf' we really mean arbitrary malicious bpf program.
> It's been a constant source of pain. The constant blinding, randomization,
> verifier speculative analysis, all spectre v1, v2, v4 mitigations
> are simply not worth it. It's a lot of complex kernel code without users.

Seccomp really will want eBPF some day, and it should work without
privilege.  Maybe it should be a restricted subset of eBPF, and
Spectre will always be an issue until dramatically better hardware
shows up, but I think people will want the ability for regular
programs to load eBPF seccomp programs.

> Hence I prefer this /dev/bpf mechanism to be as simple a possible.
> The applications that will use it are going to be just as trusted as systemd.

I still don't understand your systemd example.  systemd --users is not
trusted systemwide in any respect.  The main PID 1 systemd is root.
No matter how you dice it, granting a user systemd instance extra bpf
access is tantamount to granting the user extra bpf access in general.

It sounds to me like you're thinking of eBPF as a feature a bit like
unprivileged user namespaces: *in principle*, it's supposed to be safe
to give any unprivileged process the ability to use it, and you
consider security flaws in it to be bugs worth fixing.  But you think
it's a large attack surface and that most unprivileged programs
shouldn't be allowed to use it.  Is that reasonable?


>
> > > To solve your concern of bypassing all capable checks...
> > > How about we do /dev/bpf/full_verifier first?
> > > It will replace capable() checks in the verifier only.
> >
> > I'm not convinced that "in the verifier" is the right distinction.
> > Telling administrators that some setting lets certain users bypass
> > bpf() verifier checks doesn't have a clear enough meaning.
>
> linux is a single user system. there are no administrators any more.
> No doubt, folks will disagree, but that game is over.
> At least on bpf side it's done.
>
> > I propose,
> > instead, that the current capable() checks be divided into three
> > categories:
>
> I don't see a use case for these categories.
> All bpf programs extend the kernel in some way.
> The kernel vs user is one category.
> Conceptually CAP_BPF is enough. It would be similar to CAP_NET_ADMIN.
> When application has CAP_NET_ADMIN it covers all of networking knobs.
> There is no use case that would warrant fine grain CAP_ROUTE_ADMIN,
> CAP_ETHTOOL_ADMIN, CAP_ETH0_ADMIN, etc.
> Similarly CAP_BPF as the only knob is enough.
> The only disadvantage of CAP_BPF is that it's not possible to
> pass it from one systemd-like daemon to another systemd-like daemon.
> Hence /dev/bpf idea and passing file descriptor.
>
> > This type of thing actually fits quite nicely into an idea I've been
> > thinking about for a while called "implicit rights". In very brief
> > summary, there would be objects called /dev/rights/xyz, where xyz is
> > the same of a "right".  If there is a readable object of the right
> > type at the literal path "/dev/rights/xyz", then you have right xyz.
> > There's a bit more flexibility on top of this.  BPF could use
> > /dev/rights/bpf/maptypes/lpm and
> > /dev/rights/bpf/verifier/bounded_loops, for example.  Other non-BPF
> > use cases include a biggie:
> > /dev/rights/namespace/create_unprivileged_userns.
> > /dev/rights/bind_port/80 would be nice, too.
>
> The concept of "implicit rights" is very nice and I'm sure it will
> be a good fit somewhere, but I don't see why use it in bpf space.
> There is no use case for fine grain partition of bpf features.
>
