Return-Path: <SRS0=lnE7=U2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA438C4321A
	for <linux-security-module@archiver.kernel.org>; Thu, 27 Jun 2019 23:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76C2E2084B
	for <linux-security-module@archiver.kernel.org>; Thu, 27 Jun 2019 23:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561677804;
	bh=kXB0eS8pT4D+hcUPC2PR+0kOliEd8dU5IchIN1Hskt8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=HmhjkEAC01C2GOf0AK6xRQZmKWbvEau9DEY6SozkjOWDQtaOJVHXksumUwLNKGnan
	 AeoPzB/9PJPtwJEdqditUV/XU8i7F/Bicni6pMdPf8qvjpObxp0k/+G5pT6Fc0eTzr
	 K15xR+BGYrhGPIVZAexDr3BUG9l1uHb7mIhpGU9M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfF0XXY (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 27 Jun 2019 19:23:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:47458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbfF0XXX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 27 Jun 2019 19:23:23 -0400
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E109B216FD
        for <linux-security-module@vger.kernel.org>; Thu, 27 Jun 2019 23:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561677803;
        bh=kXB0eS8pT4D+hcUPC2PR+0kOliEd8dU5IchIN1Hskt8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Rzq1Mbzi52Cqr9tKPeg9PIx8m2rEDwxZVowrCg4wXtLlpuP3Jtc9v39mqsgGyUHQK
         B2+ijaiqQJoVHPKsrkPR0z6M98vReMp2FiiOoxvRob9yvo2r8Pc/wvGfzpI3jaEGyw
         a2EWhBxJIOcI/YW0Ql/gicAhLgjR8qyIc6OQWpyA=
Received: by mail-wr1-f53.google.com with SMTP id k11so4324413wrl.1
        for <linux-security-module@vger.kernel.org>; Thu, 27 Jun 2019 16:23:22 -0700 (PDT)
X-Gm-Message-State: APjAAAU+SrOVQRz09mcPnrxgmnstPtMV72KnFpxVj1nP8s1grDDlu8wG
        XGbBEE/vYMWH0Q+KPi6yIdyqHHcQBDO7PO788+KB5g==
X-Google-Smtp-Source: APXvYqzjr/QH+PIoGqS71dCctuNtbCVXYhiRJONwF8d9fXg29Z5HH0Te+o3LGa7ZOuGFyx26xlvsCSwEDCX8Q8cBEy0=
X-Received: by 2002:a5d:6a42:: with SMTP id t2mr5110416wrw.352.1561677801383;
 Thu, 27 Jun 2019 16:23:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190621011941.186255-1-matthewgarrett@google.com>
 <20190621011941.186255-25-matthewgarrett@google.com> <CALCETrVUwQP7roLnW6kFG80Cc5U6X_T6AW+BTAftLccYGp8+Ow@mail.gmail.com>
 <alpine.LRH.2.21.1906270621080.28132@namei.org> <6E53376F-01BB-4795-BC02-24F9CAE00001@amacapital.net>
 <bce70c8b-9efd-6362-d536-cfbbcf70b0b7@tycho.nsa.gov> <alpine.LRH.2.21.1906280332500.17363@namei.org>
 <de8b15eb-ba6c-847a-7435-42742203d4a5@tycho.nsa.gov> <CACdnJuuG8cR7h9v3pNcBKsxyckAzpKuBJs1GQxsz77jk5DRoQA@mail.gmail.com>
In-Reply-To: <CACdnJuuG8cR7h9v3pNcBKsxyckAzpKuBJs1GQxsz77jk5DRoQA@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 27 Jun 2019 16:23:10 -0700
X-Gmail-Original-Message-ID: <CALCETrU7JVH7LR3d_=s-O=b2bjevTLw2rSm5g50UjaUB2PTY5A@mail.gmail.com>
Message-ID: <CALCETrU7JVH7LR3d_=s-O=b2bjevTLw2rSm5g50UjaUB2PTY5A@mail.gmail.com>
Subject: Re: [PATCH V33 24/30] bpf: Restrict bpf when kernel lockdown is in
 confidentiality mode
To:     Matthew Garrett <mjg59@google.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        James Morris <jmorris@namei.org>,
        Andy Lutomirski <luto@kernel.org>,
        linux-security@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Network Development <netdev@vger.kernel.org>,
        Chun-Yi Lee <jlee@suse.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Jun 27, 2019 at 4:16 PM Matthew Garrett <mjg59@google.com> wrote:
>
> On Thu, Jun 27, 2019 at 1:16 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > That would only allow the LSM to further lock down the system above the
> > lockdown level set at boot, not grant exemptions for specific
> > functionality/interfaces required by the user or by a specific
> > process/program. You'd have to boot with lockdown=none (or your
> > lockdown=custom suggestion) in order for the LSM to allow anything
> > covered by the integrity or confidentiality levels.  And then the kernel
> > would be unprotected prior to full initialization of the LSM, including
> > policy load.
> >
> > It seems like one would want to be able to boot with lockdown=integrity
> > to protect the kernel initially, then switch over to allowing the LSM to
> > selectively override it.
>
> One option would be to allow modules to be "unstacked" at runtime, but
> there's still something of a problem here - how do you ensure that
> your userland can be trusted to load a new policy before it does so?
> If you're able to assert that your early userland is trustworthy
> (perhaps because it's in an initramfs that's part of your signed boot
> payload), there's maybe an argument that most of the lockdown
> integrity guarantees are unnecessary before handoff - just using the
> lockdown LSM to protect against attacks via kernel parameters would be
> sufficient.

I think that, if you don't trust your system enough to avoid
compromising itself before policy load, then your MAC policy is more
or less dead in the water.  It seems to be that it ought to be good
enough to boot with lockdown=none and then have a real policy loaded
along with the rest of the MAC policy.  Or, for applications that need
to be stricter, you accept that MAC policy can't override lockdown.
