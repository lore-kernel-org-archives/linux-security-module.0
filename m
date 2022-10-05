Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E13C433FE
	for <linux-security-module@archiver.kernel.org>; Wed,  5 Oct 2022 18:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbiJESy4 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 5 Oct 2022 14:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbiJESyy (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 5 Oct 2022 14:54:54 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A2617E3D
        for <linux-security-module@vger.kernel.org>; Wed,  5 Oct 2022 11:54:51 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id q10so18616286oib.5
        for <linux-security-module@vger.kernel.org>; Wed, 05 Oct 2022 11:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qFz8bcXSm8NKx+cQ2WBeXMjTdSUy3qZJoPO+EKQrt+k=;
        b=NgFXCEoOwxhznFgovrwNaSKvGa6GrTCOnIddMQRVCb83LQHPPOqAQigJIqyEA6Mu9U
         2op2a7Ahuy/CUAf5CiVfnXr3zzMZQcbrbZ+Ya2KCsxmxB/NBv+f7R4h7bK3Db/Bb/ZhC
         mycMkLuYRZGr8SBQPoJVFxfkwMQN1keAVyeXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qFz8bcXSm8NKx+cQ2WBeXMjTdSUy3qZJoPO+EKQrt+k=;
        b=vugBvD8yWPEnRGLtuLgedhMKMHDyv8Mnp2yH+KGQ37p9U2xRKXZIyX2STuyW09t6UN
         c1XZL53h0eyJWkRVrNHz5qCsmpPN6jLWUfeV7a0vC82+lppuyN5FSWxnbF1TGRuxXw1d
         kBQxFc0zCaLoBhxT+6K+Fh8wzDP2eDKPLgNfmaBLVcu7IEMLA0/fdgwcVF/0CbEwUe9g
         XlsjjAGzzElx9XR5xM700unGZAISfsSBQsoU1kHW9UQbLoivG+puJcxBSQnURUhee2Y9
         8SNOr2n+ShNI9MMKof07EY52BuUphHonB1JbFnvEeMD0BAJRmVQmOGxCVfZ4hUBpprI0
         1t6A==
X-Gm-Message-State: ACrzQf04FCiJHeLy7f0WFHCL+jtYrWc1qLRULJyRE0YbvyF+e5EvVECN
        js5WVAAE6vLFW6KHDf8elcACp7izIDAW+Q==
X-Google-Smtp-Source: AMsMyM63yJl60N+H2XgKEmu7AqSTG0T/ReuOGCYXZoT5o8eds1hWo3nau3MWuDpAiTTQvagluAKLOA==
X-Received: by 2002:a05:6808:1186:b0:351:99bf:876c with SMTP id j6-20020a056808118600b0035199bf876cmr616448oil.54.1664996089471;
        Wed, 05 Oct 2022 11:54:49 -0700 (PDT)
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com. [209.85.160.54])
        by smtp.gmail.com with ESMTPSA id x131-20020acae089000000b00350743ac8eesm4652236oig.41.2022.10.05.11.54.48
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Oct 2022 11:54:48 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-131dda37dddso19944586fac.0
        for <linux-security-module@vger.kernel.org>; Wed, 05 Oct 2022 11:54:48 -0700 (PDT)
X-Received: by 2002:a05:6870:c888:b0:12c:7f3b:d67d with SMTP id
 er8-20020a056870c88800b0012c7f3bd67dmr569402oab.229.1664996088058; Wed, 05
 Oct 2022 11:54:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhShpEVTuogj4h74PxbEeTUNn4odo8SE6GBvb6sGUM0LHw@mail.gmail.com>
 <87sfk3mim9.fsf@email.froward.int.ebiederm.org> <CAHk-=wiCqicQrnQPeHbDF7ECKHk_ceYzZK5dYq7y5nZTZhpB8g@mail.gmail.com>
 <87r0zmigx6.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87r0zmigx6.fsf@email.froward.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 5 Oct 2022 11:54:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wihQGNanXu3aeN12rsq+2K9BDkZEij-9HWtbVxFbXg1rw@mail.gmail.com>
Message-ID: <CAHk-=wihQGNanXu3aeN12rsq+2K9BDkZEij-9HWtbVxFbXg1rw@mail.gmail.com>
Subject: Re: [GIT PULL] LSM patches for v6.1
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Oct 5, 2022 at 5:39 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> We already have /proc/sys/user/max_user_namespaces.  It is a per userns
> control so you can run it in as fine grain as you like.  A little
> cumbersome perhaps but real.

It's not that it's cumbersome.

It's that it is *USELESS*.

Sure, it limits the memory footprint of somebody who does the
fork-bomb equivalent of user namespaces, but that's the least of the
problems.

Just think of normal users. They'd want a limited number of user
namespaces for things like sandboxing (whether google chrome or
whatever).

So distros do want to allow people a few of them.

But they want to be able to do so in a *controlled* manner. Not a "ok,
this user can create five user namespaces and do whatever they want in
them". Because we've had the issues where some kernel part has gotten
things wrong, and thought "local NS root means root" or similar.

So it's not about the number of namespaces. AT ALL. It's about *who*
and *what* does them.

> I don't know.  I tried to have the conversation and Paul shut it down.

I really get the feeling that the problem here is that you're not even
acknowledging the whole issue to begin with, since you mention that
"max_user_namespaces" not once, but twice in the email.

> It would be the easiest thing in the world in security_capable to
> ask is this a trusted app, if not the answer is no.

Isn't this *literally* what security_create_user_ns() would basically be doing?

IOW, letting the LSM just say "this app is trusted to create a new
user namespace".

And that is what the LSM model is literally designed for. Because the
kernel doesn't inherently know "I trust this app". It doesn't know the
difference between "google-chrome" and "l33t-crack3r". It needs some
kind of external set of rules.

See?

               Linus
