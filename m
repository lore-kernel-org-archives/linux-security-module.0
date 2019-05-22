Return-Path: <SRS0=vdt1=TW=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B839C282CE
	for <linux-security-module@archiver.kernel.org>; Wed, 22 May 2019 17:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D9062081C
	for <linux-security-module@archiver.kernel.org>; Wed, 22 May 2019 17:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558544927;
	bh=KwHz/SRjtllr+zkYrk6zVA1VtRKBkaAPNxi83l4/ZRw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=JptWtnjbdftXfW/6N/VyKBB+Y5gA8mAibqtYYlBb77SFy5jLIGA5b2+DSZ5THC0hE
	 /OQsUFld73PAcxgB97pdIrL5lFGkrz32P7g2/LyjWJRxIGBAlbXyPOpN83bCOw+ewL
	 lsUL0a9tFvqCIwB+m3Aa1LkiKVm/sANNaWTZtU98=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729500AbfEVRIq (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 22 May 2019 13:08:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:52286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727975AbfEVRIq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 22 May 2019 13:08:46 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 225292081C
        for <linux-security-module@vger.kernel.org>; Wed, 22 May 2019 17:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558544925;
        bh=KwHz/SRjtllr+zkYrk6zVA1VtRKBkaAPNxi83l4/ZRw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1pdRS2Meoh8spHhkBCq2eiddUJ+I1CbE63gDNTFixwAHU3Osxquu20mS1v2gDmnu7
         jl5Qh7ljtjsOQYEcZJptolgEYemI9HeZOXxrtNAXM3ZchvL6yDF5hbQhf6ZNCrirJl
         wRuOi/eQQRMIrAcoldviMweKvdFsQm74wSbE8cTE=
Received: by mail-wr1-f50.google.com with SMTP id w13so3132531wru.11
        for <linux-security-module@vger.kernel.org>; Wed, 22 May 2019 10:08:45 -0700 (PDT)
X-Gm-Message-State: APjAAAWVVUiwsD2Bhr18SDY1wo5kagQj0h+09Oi50F2SwvB0kYGa8GI+
        HlpXDfzuaZLVeKQGkC7/VeYPtkXBCUzkKQOddjsnpw==
X-Google-Smtp-Source: APXvYqzUJFeL3A4F8e1U0DifJGWf4fKL7akHUj4IKk5WVPe77/AT0gQmaydBLr+DxXjYwzcYFgQ4BECKEOoaUL4vFHo=
X-Received: by 2002:adf:e90b:: with SMTP id f11mr2236592wrm.291.1558544923770;
 Wed, 22 May 2019 10:08:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190521224013.3782-1-matthewgarrett@google.com>
 <alpine.LRH.2.21.1905221203070.3967@namei.org> <CACdnJuuTR=Ut4giPKC=kdxgY9yPv8+3PZyEzuxvON3Jr_92XnQ@mail.gmail.com>
In-Reply-To: <CACdnJuuTR=Ut4giPKC=kdxgY9yPv8+3PZyEzuxvON3Jr_92XnQ@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 22 May 2019 10:08:32 -0700
X-Gmail-Original-Message-ID: <CALCETrVow8U=xhQdJt8kSMX16Lf0Mstf3+QxY4iz4DHVp=PYWA@mail.gmail.com>
Message-ID: <CALCETrVow8U=xhQdJt8kSMX16Lf0Mstf3+QxY4iz4DHVp=PYWA@mail.gmail.com>
Subject: Re: [RFC] Turn lockdown into an LSM
To:     Matthew Garrett <mjg59@google.com>
Cc:     James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, May 22, 2019 at 9:49 AM Matthew Garrett <mjg59@google.com> wrote:
>
> On Tue, May 21, 2019 at 7:40 PM James Morris <jmorris@namei.org> wrote:
> > An LSM could also potentially implement its own policy for the hook.
>
> That was my plan. Right now the hook just gets an ASCII description of
> the reason for the lockdown - that seems suboptimal for cases like
> SELinux. What information would you want? My initial thinking was to
> just have a stable enum of lockdown reasons that's in the UAPI headers
> and then let other LSM tooling consume that, but I haven't spent
> enough time with the internals of SELinux to know if there'd be a more
> attractive solution.

I may be in the minority here, but I see this issue as a significant
downside of making lockdown more flexible.  If we stick with just
"this may violate integrity" and "this may violate confidentiality",
then the ABI surface is nice and narrow.  If we start having a big
uapi list of things that might qualify for lockdown, we need to worry
about compatibility issues.

This isn't purely theoretical.  Lockdown has some interesting
interactions with eBPF.  I don't want to be in a situation where v1 of
lockdown has a few eBPF hooks, but a later update improves the eBPF vs
lockdown interaction so that you can do more with eBPF on a locked
down kernel.  But now any such change has to worry about breaking the
lockdown LSM ABI.

And I still think it would be nice to have some credible use case for
a more fine grained policy than just the tri-state.  Having a lockdown
policy of "may not violate kernel confidentiality except using
kprobes" may be convenient, but it's also basically worthless, since
kernel confidentiality is gone.

All this being said, I do see one big benefit for LSM integration:
SELinux or another LSM could allow certain privileged tasks to bypass
lockdown.  This seems fine, except that there's potential nastiness
where current->cred isn't actually a valid thing to look at in the
current context.


So I guess my proposal is: use LSM, but make the hook very coarse
grained: int security_violate_confidentiality(const struct cred *) and
int security_violate_integrity(const struct cred *).

--Andy
