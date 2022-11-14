Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D93C433FE
	for <linux-security-module@archiver.kernel.org>; Mon, 14 Nov 2022 16:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237841AbiKNQiz (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 14 Nov 2022 11:38:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237924AbiKNQij (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 14 Nov 2022 11:38:39 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A949959A
        for <linux-security-module@vger.kernel.org>; Mon, 14 Nov 2022 08:33:45 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id k2so29754514ejr.2
        for <linux-security-module@vger.kernel.org>; Mon, 14 Nov 2022 08:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fdHhTpZNmQxUEi2mbASnWXi91JoJlz5SqgpuzvGvbqs=;
        b=Ck1gj2RHs6kKr8eo0lLZILNZm9cTLBmDBgd3gbZIiMsgfnGD3JCQsqadXh2xLzzWDB
         1lPmOGx9KUAFcKRtzpsAkB/jzN2nyVsb7J2RGxm+IgmxzSWRs+xzhCPqnycw71njMhHU
         0JqDeR+Ls0TsMcPMDlQtzx7Tuxw277l1DoPnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fdHhTpZNmQxUEi2mbASnWXi91JoJlz5SqgpuzvGvbqs=;
        b=DryD0BAJT2J5HYvxpNj4tAW8f07QVTE+pE/EvLg/Ju3TavTlcYVCBOzQE7TV702xrE
         nND9+omP9gTPEo1xXimiECYVrrYK2pLWcc4cz2HSS0FvlNp1niHe92a0UKmZVF40QeU0
         gEKfjZXSHmxFShwTyNT7gJZdt0ApYLN3NGZNIx1k0rZ+LyFdV4HsqiypgfiupjKOvftV
         F2tXeh1eV0boooFbuZ37ArkCG/NicGjSA1xj/DBJNY69OMc50wbM/XpqBuUSwp5bmZ82
         47POSo29st2wYNd1lMc4OoPeK/nOwTwwzSVzulljdX/Bb6xyinDjbaBV/3Stj2a93v1J
         4fqg==
X-Gm-Message-State: ANoB5pmmrKx4d4AykdTe5TmrsTaPRQCBPb5Fm3vCpf598TIQKHQszjf1
        oAetkpXyhiHFBAB0sBUuz0yaI3oOQXD4RQ==
X-Google-Smtp-Source: AA0mqf6EDAgU9uivT/+eGW1dSiOADrKYfbRBvJnkfEQ0RTnfPhj5yhjDMLbZzzX4FjYQEAMfOTaWCQ==
X-Received: by 2002:a17:906:c299:b0:782:55de:4fcf with SMTP id r25-20020a170906c29900b0078255de4fcfmr10888774ejz.85.1668443623764;
        Mon, 14 Nov 2022 08:33:43 -0800 (PST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id e20-20020a170906315400b0077b2b0563f4sm4420633eje.173.2022.11.14.08.33.43
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 08:33:43 -0800 (PST)
Received: by mail-wm1-f43.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so8330963wmb.0
        for <linux-security-module@vger.kernel.org>; Mon, 14 Nov 2022 08:33:43 -0800 (PST)
X-Received: by 2002:a05:600c:4e0e:b0:3cf:87c6:890b with SMTP id
 b14-20020a05600c4e0e00b003cf87c6890bmr8708365wmq.194.1668443611668; Mon, 14
 Nov 2022 08:33:31 -0800 (PST)
MIME-Version: 1.0
References: <20221111231636.3748636-1-evgreen@chromium.org>
 <20221111151451.v5.4.Ieb1215f598bc9df56b0e29e5977eae4fcca25e15@changeid>
 <Y3FfhrgvBNey6T7V@sol.localdomain> <ff23b4e24222037959c2a784496c7ee91024e6c5.camel@linux.ibm.com>
In-Reply-To: <ff23b4e24222037959c2a784496c7ee91024e6c5.camel@linux.ibm.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 14 Nov 2022 08:32:55 -0800
X-Gmail-Original-Message-ID: <CAE=gft63-jdKqKmepB+LXPm6WUWSnz+CMWcWWnyN1y-EnS4kVg@mail.gmail.com>
Message-ID: <CAE=gft63-jdKqKmepB+LXPm6WUWSnz+CMWcWWnyN1y-EnS4kVg@mail.gmail.com>
Subject: Re: [PATCH v5 04/11] security: keys: trusted: Include TPM2 creation data
To:     jejb@linux.ibm.com
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-kernel@vger.kernel.org,
        corbet@lwn.net, linux-integrity@vger.kernel.org,
        gwendal@chromium.org, dianders@chromium.org, apronin@chromium.org,
        Pavel Machek <pavel@ucw.cz>, Ben Boeckel <me@benboeckel.net>,
        rjw@rjwysocki.net, Kees Cook <keescook@chromium.org>,
        dlunev@google.com, zohar@linux.ibm.com,
        Matthew Garrett <mgarrett@aurora.tech>, jarkko@kernel.org,
        linux-pm@vger.kernel.org, David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sun, Nov 13, 2022 at 7:32 PM James Bottomley <jejb@linux.ibm.com> wrote:
>
> On Sun, 2022-11-13 at 13:20 -0800, Eric Biggers wrote:
> > On Fri, Nov 11, 2022 at 03:16:29PM -0800, Evan Green wrote:
> > > diff --git a/security/keys/trusted-keys/tpm2key.asn1
> > > b/security/keys/trusted-keys/tpm2key.asn1
> > > index f57f869ad60068..608f8d9ca95fa8 100644
> > > --- a/security/keys/trusted-keys/tpm2key.asn1
> > > +++ b/security/keys/trusted-keys/tpm2key.asn1
> > > @@ -7,5 +7,18 @@ TPMKey ::= SEQUENCE {
> > >         emptyAuth       [0] EXPLICIT BOOLEAN OPTIONAL,
> > >         parent          INTEGER ({tpm2_key_parent}),
> > >         pubkey          OCTET STRING ({tpm2_key_pub}),
> > > -       privkey         OCTET STRING ({tpm2_key_priv})
> > > +       privkey         OCTET STRING ({tpm2_key_priv}),
> > > +       ---
> > > +       --- A TPM2B_CREATION_DATA struct as returned from the
> > > TPM2_Create command.
> > > +       ---
> > > +       creationData    [1] EXPLICIT OCTET STRING OPTIONAL
> > > ({tpm2_key_creation_data}),
> > > +       ---
> > > +       --- A TPM2B_DIGEST of the creationHash as returned from the
> > > TPM2_Create
> > > +       --- command.
> > > +       ---
> > > +       creationHash    [2] EXPLICIT OCTET STRING OPTIONAL
> > > ({tpm2_key_creation_hash}),
> > > +       ---
> > > +       --- A TPMT_TK_CREATION ticket as returned from the
> > > TPM2_Create command.
> > > +       ---
> > > +       creationTk      [3] EXPLICIT OCTET STRING OPTIONAL
> > > ({tpm2_key_creation_tk})
> > >         }
> >
> > The commit that added this file claimed:
> >
> >         "The benefit of the ASN.1 format is that it's a standard and
> > thus the
> >         exported key can be used by userspace tools
> > (openssl_tpm2_engine,
> >         openconnect and tpm2-tss-engine"
> >
> > Are these new fields in compliance with whatever standard that was
> > referring to?
>
> Not really, no.  The current use case (and draft standard) is already
> using [1] for policies and [2] for importable keys:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/jejb/openssl_tpm2_engine.git/tree/doc/draft-bottomley-tpm2-keys.xml
>
> I'm actually planning to use [3] for signed policies.  There's no
> reason why you can't use [4] though.  Since the creation data, hash and
> ticket are likely used as a job lot, it strikes me they should be a
> single numbered optional sequence instead of individually numbered,
> since you're unlikely to have one without the others.

Thanks, I was hoping James might pipe up and tell me what to do.
Grouping them as a single numbered optional sequence sounds reasonable
to me. Is your draft too far along to squeeze this in? If it is and
I'm on my own to draft up and submit this, I would definitely
appreciate any pointers on getting started you might have.

I notice the draft and the code seem to be out of alignment. I'm
unfamiliar with this process, is the idea to get through all the
iterations and land the standard, then fix up the code? What happens
to existing data handed out in the old format?

-Evan
