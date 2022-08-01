Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7D4C00144
	for <linux-security-module@archiver.kernel.org>; Mon,  1 Aug 2022 22:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235418AbiHAWdl (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 1 Aug 2022 18:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235423AbiHAWdk (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 1 Aug 2022 18:33:40 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F056C45F4C
        for <linux-security-module@vger.kernel.org>; Mon,  1 Aug 2022 15:33:38 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id g20-20020a9d6a14000000b0061c84e679f5so9203892otn.2
        for <linux-security-module@vger.kernel.org>; Mon, 01 Aug 2022 15:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LI7JfBTHXcIfr/9UgMaMzqcZcXHkE1NiQIHzTU9OMbY=;
        b=cF+PM2YAd/AUT5qzQ0nJgW7ok1vFg9j5ZWOyJvGxFUYr7Zvy6AanzGkLbB529Gl+Qc
         YO0AcazHdcSnFyDrtq047WoUQLzvGI1DZh5TKK7xC0VpxBOn4CICGP0cnP5x/zklP9Qi
         99CZwd4H+SfwuCwqCcvmMHs1IXVcieCMIfit0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LI7JfBTHXcIfr/9UgMaMzqcZcXHkE1NiQIHzTU9OMbY=;
        b=128dfMoCbU4IB2pAchhmtWOVc5fCsn1KHILtOwY1RBOQkBtvcIbkn3OyNqVbGBM/mX
         TUVYjhiEqO89rKyn79QY+fy3GY6G9AaWb6+eQ1msWnP1U8D1/qikJ2uIP/g1ZQ9HjhFv
         2+njNhcrFlw6dYWr9YfH97ykdgAuaDt5V+7a3QQP8fwe930bsQI9/RHWj4ym8U1JJSuj
         UaH1ojR97yfBky43wIkYmP03K2JTfu4WzGUcyfx7QOPFxj/QH4/PgUGecKg35SuclDPf
         6gc8e6r+fY2y1W4kPMMUKT1xAWeSm142GWVANmg2oKjhuZ5lbdmTO4uycNb2HR/sXwlg
         2p1g==
X-Gm-Message-State: AJIora842mUViFipBOaWRKJBcum/iOUClly7LEbxmX4TCbczIH4N0tJH
        Mx4N9c2Qe1Bj4m0w2i4NmHelUgooSX6F+w==
X-Google-Smtp-Source: AGRyM1vp0FX/qCTBctctV0Qn35kt3ree3BkgJLrcOAMbbNzCteaNsRAHZFvSPY7/QAQwVAYgys3NFA==
X-Received: by 2002:a9d:be6:0:b0:61c:88fb:2063 with SMTP id 93-20020a9d0be6000000b0061c88fb2063mr6549551oth.69.1659393218188;
        Mon, 01 Aug 2022 15:33:38 -0700 (PDT)
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com. [209.85.160.43])
        by smtp.gmail.com with ESMTPSA id e37-20020a056820062500b004288e69cac2sm2970989oow.23.2022.08.01.15.33.38
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 15:33:38 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-10bd4812c29so15303667fac.11
        for <linux-security-module@vger.kernel.org>; Mon, 01 Aug 2022 15:33:38 -0700 (PDT)
X-Received: by 2002:a05:6808:14d4:b0:33b:1489:8752 with SMTP id
 f20-20020a05680814d400b0033b14898752mr7607300oiw.174.1659393206929; Mon, 01
 Aug 2022 15:33:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220504232102.469959-1-evgreen@chromium.org> <20220506160807.GA1060@bug>
 <CAE=gft6m75T0UC2DBhfFhuSMW6TK7aatD_04sQ18WosgGVsATw@mail.gmail.com>
 <CAJZ5v0gxq=EA_WWUiCR_w8o87iTHDR7OC5wi=GRBaAQS2ofd5w@mail.gmail.com>
 <CAE=gft6V6RLc-d4AOuRUVU2u1jMGghDRSrFqiCqMCLxemui8Pw@mail.gmail.com> <CAE=gft5OYAgosqmwNkk=Cwoooeg93Njmnzfz=gwCaLB0Ts+=sw@mail.gmail.com>
In-Reply-To: <CAE=gft5OYAgosqmwNkk=Cwoooeg93Njmnzfz=gwCaLB0Ts+=sw@mail.gmail.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 1 Aug 2022 15:32:50 -0700
X-Gmail-Original-Message-ID: <CAE=gft6sPkhNcz7+fJuDzQo2f8fM_0Wv_OWC9W2LyvXd6M6zeQ@mail.gmail.com>
Message-ID: <CAE=gft6sPkhNcz7+fJuDzQo2f8fM_0Wv_OWC9W2LyvXd6M6zeQ@mail.gmail.com>
Subject: Re: [PATCH 00/10] Encrypted Hibernation
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>,
        Matthew Garrett <mgarrett@aurora.tech>,
        Daniil Lunev <dlunev@google.com>, zohar@linux.ibm.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-integrity@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Hao Wu <hao.wu@rubrik.com>, James Morris <jmorris@namei.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Len Brown <len.brown@intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        "Serge E. Hallyn" <serge@hallyn.com>, axelj <axelj@axis.com>,
        keyrings@vger.kernel.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Jun 16, 2022 at 8:42 AM Evan Green <evgreen@chromium.org> wrote:
>
> On Tue, May 17, 2022 at 10:34 AM Evan Green <evgreen@chromium.org> wrote:
> >
> > Hi Rafael,
> >
> > On Tue, May 17, 2022 at 9:06 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Mon, May 9, 2022 at 6:44 PM Evan Green <evgreen@chromium.org> wrote:
> > > >
> > > > On Fri, May 6, 2022 at 9:08 AM Pavel Machek <pavel@ucw.cz> wrote:
> > > > >
> > > > > Hi!
> > > > >
> > > > > > We are exploring enabling hibernation in some new scenarios. However,
> > > > > > our security team has a few requirements, listed below:
> > > > > > 1. The hibernate image must be encrypted with protection derived from
> > > > > >    both the platform (eg TPM) and user authentication data (eg
> > > > > >    password).
> > > > > > 2. Hibernation must not be a vector by which a malicious userspace can
> > > > > >    escalate to the kernel.
> > > > >
> > > > > Can you (or your security team) explain why requirement 2. is needed?
> > > > >
> > > > > On normal systems, trusted userspace handles kernel upgrades (for example),
> > > > > so it can escalate to kernel priviledges.
> > > > >
> > > >
> > > > Our systems are a little more sealed up than a normal distro, we use
> > > > Verified Boot [1]. To summarize, RO firmware with an embedded public
> > > > key verifies that the kernel+commandline was signed by Google. The
> > > > commandline includes the root hash of the rootfs as well (where the
> > > > modules live). So when an update is applied (A/B style, including the
> > > > whole rootfs), assuming the RO firmware stayed RO (which requires
> > > > physical measures to defeat), we can guarantee that the kernel,
> > > > commandline, and rootfs have not been tampered with.
> > > >
> > > > Verified boot gives us confidence that on each boot, we're at least
> > > > starting from known code. This makes it more challenging for an
> > > > attacker to persist an exploit across reboot. With the kernel and
> > > > modules verified, we try to make it non-trivial for someone who does
> > > > manage to gain root execution once from escalating to kernel
> > > > execution. Hibernation would be one obvious escalation route, so we're
> > > > hoping to find a way to enable it without handing out that easy
> > > > primitive.
> > > >
> > > > [1] https://www.chromium.org/chromium-os/chromiumos-design-docs/verified-boot/
> > >
> > > So I guess this really is an RFC.
> >
> > Yes, I suppose it is.
> >
> > >
> > > Honestly, I need more time to go through this and there are pieces of
> > > it that need to be looked at other people (like the TPM-related
> > > changes).
> >
> > No problem, thanks for the reply to let me know. I expect some back
> > and forth in terms of what should be hidden behind abstractions and
> > where exactly things should live. But I wanted to get this out to
> > upstream as early as I could, just to get initial reactions on the
> > overall concept and design. Looking forward to hearing your thoughts
> > when you get a chance, and let me know if there are others I should be
> > adding that I've missed.
>
> Gentle bump in case this dropped off of radars, I'd still appreciate
> any feedback folks had on this series.

One more bump here, as we'd really love to get encrypted hibernation
to a form upstream would accept if at all possible. We were
considering landing this in our Chrome OS tree for now, then coming
back in a couple months with a "we've been baking this ourselves and
it's going so great, oooh yeah". I'm not sure if upstream would find
that compelling or not. But in any case, some guidance towards making
this more upstream friendly would be well appreciated.

One thing I realized in attempting to pick this myself is that the
trusted key blob format has moved to ASN.1. So I should really move
the creation ticket to the new ASN.1 format (if I can figure out the
right OID for that piece), which would allow me to drop a lot of the
ugly stuff in tpm2_unpack_blob(). Maybe if I get no other comments
I'll work on that and resend.

-Evan
