Return-Path: <SRS0=Re8g=SL=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24121C10F0E
	for <linux-security-module@archiver.kernel.org>; Tue,  9 Apr 2019 16:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6FF02084C
	for <linux-security-module@archiver.kernel.org>; Tue,  9 Apr 2019 16:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g55M3HTb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbfDIQvG (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 9 Apr 2019 12:51:06 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:33086 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbfDIQvG (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 9 Apr 2019 12:51:06 -0400
Received: by mail-vk1-f193.google.com with SMTP id x194so3625402vke.0
        for <linux-security-module@vger.kernel.org>; Tue, 09 Apr 2019 09:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NxnZbHwHubpNIgpah9U2ewhbtY55fWGlzvBw7C3ceyQ=;
        b=g55M3HTbJl2nGEzdInj5BhFDcFCYRLfErTmcVhRIKpELhgbSj1X0w+TOoFf1DFOgqR
         nIGQIBLYgfVZ+MMYY4lH3twSib14DZF0k8XARdzkZRAIBTpeHR/3dGqo20XTMY71f9aN
         xChEflprCQ3jjqkj+kT06bR8oVnOtXhtNLeEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NxnZbHwHubpNIgpah9U2ewhbtY55fWGlzvBw7C3ceyQ=;
        b=U5dhQ9Bez/J6PbPSoA2KirNV53AaiJEEza79b/gBLXXrAggvg+5e+THI0iopKO2HcQ
         UHhTSAERX/IaRZlZenxdAVQ7FdmV22V1m+8onu5NRRLUxG5+MjWWS+UvYUnY0nzs5gU6
         dgZPaXolFox3A1SEb4OA6vc4gFGLkRvunUikB8IAXJDRjIWrkFkYs5KcJKZkPjORcdWF
         dxLmsnv1J8WszMz1CijkHjoIeiStksHAXRDezujL4QvqbfKrQzooufP3zk6gUabC5dlb
         VyF9piQS4nJHNyE6rBONvufgIPqFKIXx0lJDM7upaaymCm46cUlJby61NqAy4fqWYPFJ
         yCuQ==
X-Gm-Message-State: APjAAAU/CjJrKvIm97T2GWJ1F6i5qQ4Y+CUqW9OVA6yPCdgC0FHjEiNA
        dcJMLxQNh5feuPc5SUDN9vHaMw7K8z4=
X-Google-Smtp-Source: APXvYqytolaFtVLX/++K5YzhSKfs4OSN6DOtcEXT3RphIMsqDay7TZn1IOBChXFFH5dbYleKqWb1WQ==
X-Received: by 2002:a1f:1284:: with SMTP id 126mr20490716vks.72.1554828664808;
        Tue, 09 Apr 2019 09:51:04 -0700 (PDT)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id w184sm16058940vkd.0.2019.04.09.09.51.03
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 09:51:03 -0700 (PDT)
Received: by mail-vs1-f45.google.com with SMTP id o10so7631964vsp.12
        for <linux-security-module@vger.kernel.org>; Tue, 09 Apr 2019 09:51:03 -0700 (PDT)
X-Received: by 2002:a67:f04e:: with SMTP id q14mr21174654vsm.133.1554828663194;
 Tue, 09 Apr 2019 09:51:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1554485409.git.rdna@fb.com> <CAGXu5jJGC1kB-0e3DimBSprcgEBnWRB=i287g-9T5a-RidFqBg@mail.gmail.com>
 <20190406170257.qlptcrfth2rb3rxo@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20190406170257.qlptcrfth2rb3rxo@ast-mbp.dhcp.thefacebook.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 9 Apr 2019 09:50:50 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJTCjE6FiqPgnSZbp1rzNs35RV-bXXg=+Nu5bO7v1Ac0g@mail.gmail.com>
Message-ID: <CAGXu5jJTCjE6FiqPgnSZbp1rzNs35RV-bXXg=+Nu5bO7v1Ac0g@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 00/21] bpf: Sysctl hook
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrey Ignatov <rdna@fb.com>,
        Network Development <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Roman Gushchin <guro@fb.com>, kernel-team <kernel-team@fb.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, Apr 6, 2019 at 10:03 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sat, Apr 06, 2019 at 09:43:50AM -0700, Kees Cook wrote:
> > On Fri, Apr 5, 2019 at 12:36 PM Andrey Ignatov <rdna@fb.com> wrote:
> > > BPF_CGROUP_SYSCTL hook is placed before calling to sysctl's proc_handler so
> > > that accesses (read/write) to sysctl can be controlled for specific cgroup
> > > and either allowed or denied, or traced.
> >
> > This sounds more like an LSM than BPF.
>
> not at all. the key difference is being cgroup scoped.
> essentially for different containers.

Okay, works for me. I was looking at it from the perspective of
something providing resource access control policy, which usually
falls into the LSM world.

> bpf prog is attached to this hook in a particular cgroup
> and executed for sysctls for tasks that belong to that cgroup.

So it's root limiting root-in-a-container? Nice to have some
boundaries there, for sure.

> > Can the BPF be removed (or rather,
> > what's the lifetime of such BPF?)
>
> same as all other cgroup-bpf hooks.
> Do you have a specific concern or just asking how life time of programs
> is managed?
> High level description of lifetime is here:
> https://facebookmicrosites.github.io/bpf/blog/2018/08/31/object-lifetime.html

I'm mostly curious about the access control stacking. i.e. can
in-container root add new eBPF to its own cgroup, and if so, can it
undo the restrictions already present? (I assume it can't, but figured
I'd ask...)

-- 
Kees Cook
