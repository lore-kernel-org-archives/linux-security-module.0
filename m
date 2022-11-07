Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33B7C433FE
	for <linux-security-module@archiver.kernel.org>; Mon,  7 Nov 2022 20:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbiKGUMi (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 7 Nov 2022 15:12:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232824AbiKGUM3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 7 Nov 2022 15:12:29 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13DD2AE21
        for <linux-security-module@vger.kernel.org>; Mon,  7 Nov 2022 12:12:28 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id q9so33314284ejd.0
        for <linux-security-module@vger.kernel.org>; Mon, 07 Nov 2022 12:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=enMdjmIsSbUUYGb+RiHPQULVTIcs0r1uA7QvgYehDfo=;
        b=cK5mzUepaprD41nCiRUmaLmzTIgcnNw5msQaClmACmYhAcO7XK6rJUBvOqZtgby6y8
         52QvjVVQH7ojFFZrM7qfAy0IdolyIX8knrA6IaYyvW21uhXHySccJ3/m2Wleu58EVtDt
         6MIVe9aRiDrWdsThdVgafQbhigdkLUk4g2knQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=enMdjmIsSbUUYGb+RiHPQULVTIcs0r1uA7QvgYehDfo=;
        b=2OvvQuGEKPWKLas/bW4Q3h9rRuW2vk970lEaaeDLuWi9zF7HPEY1echrgLey4IkGhG
         i+lnP7bkZ8GGPKWSB07TYREhrh16DSWD4+skW5axj0pSLCzdDrg/jqdjG9FYuQT0K6Ok
         d5ULYmNZzra6XmhCgDuQNxbdLAsy6vlpE91Dhyj3p2Rotn9bhZNmOnf5b2yIk6Zt8aSw
         LJepd2gMMjwZUINAe9KcTughGNw32ANTXUNsw1bD6ljcUTn709lIqU9jMlld6Ve/iFHE
         UX6WpxMVKgU/21JQXQgPSz7UJKTkTYYEQc1QmGxQtf1UmVHhSzLDkxtuCFpwQKnImrh7
         Utig==
X-Gm-Message-State: ACrzQf2uSKQiU4U0wHe0RDdJoWVMONQMdZDXZ3WSf46pznKIwdpj0RqB
        MzFwFssXBN8FFPxqL49Yx/eQ2ix8WTtNpQ==
X-Google-Smtp-Source: AMsMyM6UeabDDIAX6CgRixmsOuZyE5h90yWYzMgwOYUAqyrezPEEuaIxQWWzxNendMchL1Zk4S8APQ==
X-Received: by 2002:a17:906:c44:b0:7ae:749:1659 with SMTP id t4-20020a1709060c4400b007ae07491659mr28135680ejf.759.1667851946802;
        Mon, 07 Nov 2022 12:12:26 -0800 (PST)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id m15-20020a50ef0f000000b00461bacee867sm4632519eds.25.2022.11.07.12.12.25
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 12:12:26 -0800 (PST)
Received: by mail-wr1-f46.google.com with SMTP id y16so17835525wrt.12
        for <linux-security-module@vger.kernel.org>; Mon, 07 Nov 2022 12:12:25 -0800 (PST)
X-Received: by 2002:a5d:6dc3:0:b0:22a:bcc3:21c6 with SMTP id
 d3-20020a5d6dc3000000b0022abcc321c6mr34070892wrz.450.1667851934711; Mon, 07
 Nov 2022 12:12:14 -0800 (PST)
MIME-Version: 1.0
References: <20221103180120.752659-1-evgreen@chromium.org> <20221103105558.v4.4.Ieb1215f598bc9df56b0e29e5977eae4fcca25e15@changeid>
 <202211041132.E8CB636@keescook>
In-Reply-To: <202211041132.E8CB636@keescook>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 7 Nov 2022 12:11:38 -0800
X-Gmail-Original-Message-ID: <CAE=gft4+KHVd_cNApo6EcTtxSDQDNB-nPXdus-0K8pQdWF+tiw@mail.gmail.com>
Message-ID: <CAE=gft4+KHVd_cNApo6EcTtxSDQDNB-nPXdus-0K8pQdWF+tiw@mail.gmail.com>
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

On Fri, Nov 4, 2022 at 11:33 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Nov 03, 2022 at 11:01:12AM -0700, Evan Green wrote:
> > In addition to the private key and public key, the TPM2_Create
> > command may also return creation data, a creation hash, and a creation
> > ticket. These fields allow the TPM to attest to the contents of a
> > specified set of PCRs at the time the trusted key was created. Encrypted
> > hibernation will use this to ensure that PCRs settable only by the
> > kernel were set properly at the time of creation, indicating this is an
> > authentic hibernate key.
> >
> > Encode these additional parameters into the ASN.1 created to represent
> > the key blob. The new fields are made optional so that they don't bloat
> > key blobs which don't need them, and to ensure interoperability with
> > old blobs.
> >
> > Signed-off-by: Evan Green <evgreen@chromium.org>
>
> There's a lot of open-coded math for the bounds checking. I didn't
> immediately see any problems, but it'd be nice if there was a way to
> hook a fuzzer up to this, or at least write some KUnit tests to check
> boundary conditions explicitly.
>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Thank you! Yes, agreed about all the bounds checking. I could probably
pull out the "check for src + 2 > end, then get_unaligned_be16()" into
a helper function. Let me see if that makes things look better or ends
up looking the same.
-Evan
