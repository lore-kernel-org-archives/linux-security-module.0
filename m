Return-Path: <SRS0=EupR=RE=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60EC1C43381
	for <linux-security-module@archiver.kernel.org>; Fri,  1 Mar 2019 01:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27E1820863
	for <linux-security-module@archiver.kernel.org>; Fri,  1 Mar 2019 01:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C9yRUYRY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732970AbfCABCM (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 28 Feb 2019 20:02:12 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:51557 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbfCABCM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 28 Feb 2019 20:02:12 -0500
Received: by mail-it1-f196.google.com with SMTP id e24so17735696itl.1
        for <linux-security-module@vger.kernel.org>; Thu, 28 Feb 2019 17:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kyWA6LJVhEFVYx4LUEOQTLJtowrXpkRK5QjNOqo2Emg=;
        b=C9yRUYRYVSCcJywu1iUcJnr1KvxUl92RYDGl8c7XPa4htdgF00yZoJ6ySChVY7hLcn
         NmpRPH0L/GRfV2+/2w4P7CbUbhVSm/KgeLacJeFDup0lDJ1m9m1+wGTIeVlL5j/D7kKv
         YZWKkYsDkqxddbEflyyDMJ/C6YwgbS5OXdtYfzqN+gSCp5UegLFaoxttRCdFn1Q1bt0F
         k714hSfdK0Fo1CUBIZQB2z8czcrmEpBwRYBb7grqw2T0RX1t+ICaFFmYp+oChypN9Kfw
         pkGCcgszEkrVOIJfqqYZuvSeDDSJfrMbZxGCo9ND4tGpRg4MfxNZXLQ8mQQZO4vA09lk
         rFpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kyWA6LJVhEFVYx4LUEOQTLJtowrXpkRK5QjNOqo2Emg=;
        b=qkUnA009TzOL+YYZ/4+IZ2E5ViaBN9KJQl4O0/Vf7p/1O+VbEg5ZDbmYOPBviYdaR2
         TF92OGiHxbvWRxPYwX1BnHVyBiMmcoeyBNb2+Y4yfd/smp0QBP6MuLr6/qa9CHRwLbgu
         FygIECYKLJCwTUun5wh7KEFw9w6NkFKIAYC4/pojIDJIg+MrB4QK/WYWUK7WLDrtM5Uy
         YfjJko0qyDrM2hYVZWzBZVLPM2JI1x9aCw8L6R4blsrU8kQTLNp2GtU1/YAKtbH5GvsP
         yb8HAocDjto2CLW5nM/q4zzXrfC2zv2jPVACmrln78Rnfj0aldwn7ugLLy9YwChGL1A+
         rNrw==
X-Gm-Message-State: APjAAAWbdU5btjsNZp33w9hccJdw4Yq6AZfwSv7E/4miOfGJfrbd2Eh0
        q3jOH25UtT8bDwgIalig0YC5+DYZNBLp1xFXYEu1JFi109s=
X-Google-Smtp-Source: APXvYqwFmqARuEtUErdlPV8RKpqQYnpfQuNNB1JiyXvc8dQjzZm418/n0bff9dbRdB6wNEcowWEP0gmfOMXaUq0+iZM=
X-Received: by 2002:a02:76c2:: with SMTP id z185mr1181579jab.102.1551402130537;
 Thu, 28 Feb 2019 17:02:10 -0800 (PST)
MIME-Version: 1.0
References: <CACdnJuvW47m3JvEcuEX1bsr+L2Ht9LDn_iCuPbHLOoaohOFW4Q@mail.gmail.com>
 <1551392438.10911.227.camel@linux.ibm.com> <CACdnJuvwnh0PKr5jUTm2h=P5-u-oLgBjvThX+DxcegShXReCdA@mail.gmail.com>
 <1551398720.10911.270.camel@linux.ibm.com>
In-Reply-To: <1551398720.10911.270.camel@linux.ibm.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 28 Feb 2019 17:01:59 -0800
Message-ID: <CACdnJutqg26pk5xnK2ii3ia9JabAnBptE3YQ3yLvVT93as666Q@mail.gmail.com>
Subject: Re: [PULL REQUEST] Lock down patches
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     jmorris@namei.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Feb 28, 2019 at 4:05 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> On Thu, 2019-02-28 at 15:13 -0800, Matthew Garrett wrote:
> > On Thu, Feb 28, 2019 at 2:20 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > > Where/when was this latest version of the patches posted?
> >
> > They should have followed this, but git-send-email choked on some
> > reviewed-by: lines so I'm just trying to sort that out.
>
> I'm a little perplexed as to why you would send a pull request, before
> re-posting the patches with the changes for review.

They should be there now. There's no substantive change to the
patches, other than having dropped a few from the series.

> > It's a little more complicated than this. We can't just rely on IMA
> > appraisal - it has to be based on digital signatures, and the existing
> > patch only made that implicit by enabling the secure_boot policy.
>
> Right, which is the reason the IMA architecture specific policy
> requires file signatures. [1][2]

The current patches seem to require ima signatures - shouldn't this
allow ima digests as long as there's an evm signature?

> > I
> > think we do want to integrate these, but there's a few things we need
> > to take into account:
> >
> > 1) An integrated solution can't depend on xattrs, both because of the
> > lagging support for distributing those signatures but also because we
> > need to support filesystems that don't support xattrs
>
> That's not a valid reason for preventing systems that do use IMA for
> verifying the kexec kernel image signature or kernel module signatures
> from enabling "lock down".  This just means that there needs to be
> some coordination between the different signature verification
> methods. [1][2]

I agree, but the current form of the integration makes it impossible
for anyone using an IMA-enabled kernel (but not using IMA) to do
anything unless they have IMA signatures. It's a problem we need to
solve, I just don't think it's a problem we need to solve before
merging the patchset.

> > 2) An integrated solution can't depend on the current secure_boot
> > policy because that requires signed IMA policy updates, but
> > distributions have no way of knowing what IMA policy end users require
>
> Both the "CONFIG_IMA_APPRAISE_REQUIRE_KEXEC_SIGS" and the IMA
> architecture policy rules persist after loading a custom policy.
>  Neither of them require loading or signing a custom policy.

The previous version of the lockdown patchset sets the secure_boot
policy when lockdown is enabled, which does require that any custom
policy be signed.

> > In any case, I do agree that we should aim to make this more
> > reasonable - having orthogonal signing code doesn't benefit anyone.
> > Once there's solid agreement on that we can extend this support.
> >
>
> Having multiple signature verification methods is going to be around
> for a while.  The solution is to coordinate the signature verification
> methods, without requiring both types of signatures. [1][2]

Agree, and once we have a solution to this we should integrate that
with lockdown. I don't think merging this first makes that any harder.
Importantly, this version of the patchset doesn't enable lockdown
automatically unless explicitly configured to do so, which means you
can build a lockdown kernel without interfering with IMA.
