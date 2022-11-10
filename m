Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B9AC43219
	for <linux-security-module@archiver.kernel.org>; Thu, 10 Nov 2022 00:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbiKJAaT (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 9 Nov 2022 19:30:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbiKJAaR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 9 Nov 2022 19:30:17 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C0713D2A
        for <linux-security-module@vger.kernel.org>; Wed,  9 Nov 2022 16:30:16 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id b2so1149388eja.6
        for <linux-security-module@vger.kernel.org>; Wed, 09 Nov 2022 16:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nlqLQiiaOaZsIVqPkpURbCqECGxlhLAGf8/oZgDPEwg=;
        b=TibEJ/dS9oqIAlyw0U4d9Y17tk1l/5W9NiA/VJLZylVbn2FOy3zk5VI/yoCYNAuGoE
         Oc/Um2qfEuVCzsSWM/0hQdPyYt1cE7yzSxpdx7nS7ovvnFNjrDg/SO+IHB7dUcl1WCSg
         iWprIbuqzyqir3yxeR8YrLGkhepBTjIioA0E0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nlqLQiiaOaZsIVqPkpURbCqECGxlhLAGf8/oZgDPEwg=;
        b=qHyQjKPcSxG/qkgEk8Dv0h5P5e652KbkiOSOtJZWYn62HXEJN9WFxUVw5m0SUak/1L
         lDqs26bLsqEaoSdUP5btcLaP1Og/wfRYki6ovwD2c7Vk8Wf57mXP3y5jlH7imDlkwozy
         n8ChqveZX9SqnZxSF2kXQXUXa8JZbkVZIfEZ1aL5+YfOZZ8E3oz4ZtFoXZbHibKJwrdv
         rECpdfUx6YvsSraapnugPp6zPqnt69jhsf66Rzz1lyfGUv5jUQ099tjp2mKgTmEaLOo8
         WnjqC7spaDZREfrvBUJmqqh+dcaHE8kQsOHr7a6bHRrw9xi56zl/daLGlhI0IbWluCPt
         PU3A==
X-Gm-Message-State: ACrzQf1cVQzGjQ6v0oA+ISTXjJzxMNhATKM4Pe3//UpY7WychOEyi3ha
        wPEj1iy7PXT20NbHxLpzdXnDMJxA+C+tZQ==
X-Google-Smtp-Source: AMsMyM53DseQ4wO+iunP+7pFFdyVJjmZP2oScOvDazsKe9fKTvwEyzBRHhYG4d4pO4b8F2iHTKkiOQ==
X-Received: by 2002:a17:907:70a:b0:741:78ab:dce5 with SMTP id xb10-20020a170907070a00b0074178abdce5mr59424936ejb.527.1668040214882;
        Wed, 09 Nov 2022 16:30:14 -0800 (PST)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id n21-20020a056402061500b004615f7495e0sm7687504edv.8.2022.11.09.16.30.13
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 16:30:14 -0800 (PST)
Received: by mail-wr1-f41.google.com with SMTP id k8so162479wrh.1
        for <linux-security-module@vger.kernel.org>; Wed, 09 Nov 2022 16:30:13 -0800 (PST)
X-Received: by 2002:adf:e44f:0:b0:236:59a3:c5a8 with SMTP id
 t15-20020adfe44f000000b0023659a3c5a8mr40946801wrm.396.1668040203082; Wed, 09
 Nov 2022 16:30:03 -0800 (PST)
MIME-Version: 1.0
References: <20221103180120.752659-1-evgreen@chromium.org> <20221103105558.v4.4.Ieb1215f598bc9df56b0e29e5977eae4fcca25e15@changeid>
 <202211041132.E8CB636@keescook> <CAE=gft4+KHVd_cNApo6EcTtxSDQDNB-nPXdus-0K8pQdWF+tiw@mail.gmail.com>
In-Reply-To: <CAE=gft4+KHVd_cNApo6EcTtxSDQDNB-nPXdus-0K8pQdWF+tiw@mail.gmail.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 9 Nov 2022 16:29:26 -0800
X-Gmail-Original-Message-ID: <CAE=gft6O6WFbVL4mQ6trS4UkfkvNEFcUT0eN+6QAsXbf6DLdvQ@mail.gmail.com>
Message-ID: <CAE=gft6O6WFbVL4mQ6trS4UkfkvNEFcUT0eN+6QAsXbf6DLdvQ@mail.gmail.com>
Subject: Re: [PATCH v4 04/11] security: keys: trusted: Include TPM2 creation data
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-pm@vger.kernel.org, rjw@rjwysocki.net, gwendal@chromium.org,
        apronin@chromium.org, Pavel Machek <pavel@ucw.cz>,
        Matthew Garrett <mgarrett@aurora.tech>,
        linux-integrity@vger.kernel.org, jejb@linux.ibm.com,
        zohar@linux.ibm.com, dlunev@google.com,
        Eric Biggers <ebiggers@kernel.org>,
        Ben Boeckel <me@benboeckel.net>, jarkko@kernel.org,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Nov 7, 2022 at 12:11 PM Evan Green <evgreen@chromium.org> wrote:
>
> On Fri, Nov 4, 2022 at 11:33 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Thu, Nov 03, 2022 at 11:01:12AM -0700, Evan Green wrote:
> > > In addition to the private key and public key, the TPM2_Create
> > > command may also return creation data, a creation hash, and a creation
> > > ticket. These fields allow the TPM to attest to the contents of a
> > > specified set of PCRs at the time the trusted key was created. Encrypted
> > > hibernation will use this to ensure that PCRs settable only by the
> > > kernel were set properly at the time of creation, indicating this is an
> > > authentic hibernate key.
> > >
> > > Encode these additional parameters into the ASN.1 created to represent
> > > the key blob. The new fields are made optional so that they don't bloat
> > > key blobs which don't need them, and to ensure interoperability with
> > > old blobs.
> > >
> > > Signed-off-by: Evan Green <evgreen@chromium.org>
> >
> > There's a lot of open-coded math for the bounds checking. I didn't
> > immediately see any problems, but it'd be nice if there was a way to
> > hook a fuzzer up to this, or at least write some KUnit tests to check
> > boundary conditions explicitly.
> >
> > Reviewed-by: Kees Cook <keescook@chromium.org>
>
> Thank you! Yes, agreed about all the bounds checking. I could probably
> pull out the "check for src + 2 > end, then get_unaligned_be16()" into
> a helper function. Let me see if that makes things look better or ends
> up looking the same.

A helper function cleaned this up nicely, so I'll send that in the
next spin but not yet pick up your reviewed tag.
