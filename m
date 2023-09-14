Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B24EDE9A0
	for <linux-security-module@archiver.kernel.org>; Thu, 14 Sep 2023 09:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237231AbjINJop (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 14 Sep 2023 05:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237554AbjINJoc (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 14 Sep 2023 05:44:32 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256F2210B
        for <linux-security-module@vger.kernel.org>; Thu, 14 Sep 2023 02:44:03 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99de884ad25so105378466b.3
        for <linux-security-module@vger.kernel.org>; Thu, 14 Sep 2023 02:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1694684642; x=1695289442; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fpyUSA4zqMpJvFIRfLkgjwyN5TLcHnhqRritAX1SXxg=;
        b=Y94vGfTPOkhD5b7nXKflpOfEAbD00UKQYbeBzkQMrM69c6ARXeuJXId8LjBubaOUYe
         5Yex09MY80gCm0lnPqfVYdEmPtcBJ8i8PUclyrmS/ASRRmUISLS9uroYY65kBseOtVzQ
         n/BAFc+Ss0SrJBDRw8PO/RWPyDKVaY5ms/oOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694684642; x=1695289442;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fpyUSA4zqMpJvFIRfLkgjwyN5TLcHnhqRritAX1SXxg=;
        b=pH5HxRdN334Wk55P448PyztvN73UHtKoZM4PS5FOYNuUtCAT0wgWIQ/wdTNAew1nf3
         8vKR0c44+O8Dv1VL3f+spE8PyoicxMSPSVsNz48ZUQqa4bF7Cs+mSxeZkyUS0+cCCj12
         4IaWcRhy67mevcrqut+8dh0u90fIOqKXyzw6rFiGBFPUnAIHRuANlPEDacDHBHDKZfw+
         9ChbCtjalM6hlthvukg3dM23HMODvs/DKKuMgIQl/kUln4LorzlZ/JBLwHh4Z/B446/v
         d4yS/LJRpkrbCTPau8in4Sz8IzXI0h7ELsppSAEuws8nCP8hRvdpAycBzGq+xeIOAGJh
         bYrg==
X-Gm-Message-State: AOJu0Yz+PazM9nYfgyixgKkYpSpZMXG7i645+gpdWyWB6K1IVJTA1R3Z
        8K3DQ8xNxvhbk1qywvh/sjGvV4bH3ubI8trcCXLbOg==
X-Google-Smtp-Source: AGHT+IEyolZjfGkJMmzniA571qSWAQ1BD87u/IWRMEO++M7nad1th1Wn2dPp8AwzT6FUIh4dPaRcViOPJcnRyrmQYX0=
X-Received: by 2002:a17:907:77c2:b0:99b:f58d:1c49 with SMTP id
 kz2-20020a17090777c200b0099bf58d1c49mr3978899ejc.53.1694684642180; Thu, 14
 Sep 2023 02:44:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230913152238.905247-1-mszeredi@redhat.com> <20230913152238.905247-2-mszeredi@redhat.com>
 <20230914-himmel-imposant-546bd73250a8@brauner> <CAJfpegv8ZVyyZN7ppSYMD4g8i7rAP1_5UBxzSo869_SKmFhgvw@mail.gmail.com>
 <20230914-jeweiligen-normung-47816c153531@brauner>
In-Reply-To: <20230914-jeweiligen-normung-47816c153531@brauner>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 14 Sep 2023 11:43:50 +0200
Message-ID: <CAJfpeguJ+H7HkZOgZrJ7VmTY_GhQ5uqueZH+DL9EuEeX5kgXQw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] add unique mount ID
To:     Christian Brauner <brauner@kernel.org>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, 14 Sept 2023 at 11:36, Christian Brauner <brauner@kernel.org> wrote:
>
> > Yes, one concern is that humans confuse the old and the new ID.
> >
> > I also think it makes sense to allow the new interfaces to look up the
> > mount based on either the old or the new ID.   But I could be wrong
>
> Hm, mount id recycling may happen so quickly that for service restarts
> with a lot of mounts this becomes mostly useless...

Agreed.  The old ID is mostly useful for human interaction.

>
> > there, since that might encourage bad code.  Maybe the new interface
> > should only use take the new ID, which means no mixed use of
> > /proc/$$/mountinfo and statmnt/listmnt.
>
> ... so I think that is indeed the better way of doing things. There's no
> need to encourage userspace to mix both identifiers.

Okay.

But I'd still leave the 2^32 offset for human confusion avoidance.

Thanks,
Miklos
