Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10DD5C56201
	for <linux-security-module@archiver.kernel.org>; Wed, 18 Nov 2020 21:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A66AD246B8
	for <linux-security-module@archiver.kernel.org>; Wed, 18 Nov 2020 21:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LdWAuOsT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgKRVVH (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 18 Nov 2020 16:21:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbgKRVVE (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 18 Nov 2020 16:21:04 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D62C0613D4;
        Wed, 18 Nov 2020 13:21:03 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id w10so3358067ilq.5;
        Wed, 18 Nov 2020 13:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Etsjq+atvaozZ+ERSgtIVMrYT2G/1liabm/HjElDckw=;
        b=LdWAuOsT2+8S0Uq0EX06VC4iDDAKgvi5Nd0xlYtsLBoiAPSqnrYFpMqP2L9P/nVP9Z
         dO+ubwVAeeDke/8+NpAImqZ1koHIFfKT5kUcygzTzLBfDG07gOT4+kZAmsZUE89joGeq
         Y6N4rQajwaCdkit6skDQxegyVc5+JyVtEtiBsWkOwD3eWBFqkRO37D7S/DI4gdsJDcNd
         AuBl7Cdm3QPgr1dZVeEW2HvGHPkRd4bKaTivTVOsunkE2Fv4BnJYrnHjNn01vtI5dMU9
         LXDnpOr2j/RispsjAK66RSgHlImnCGTS2OJJTGQIlGhcHn6vnWiPuciWe9S22/So4MXl
         XIzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Etsjq+atvaozZ+ERSgtIVMrYT2G/1liabm/HjElDckw=;
        b=BfAgD9OoE6TPNkeROLwvixEmuDiez9rrH2WhBN3VYE4FlztkxqNXeuKTJSPB6qNAdS
         UIxRkIIgAyD+NBhbEf7xlrqIgTYR0W+3HM2W6K4ZFq3XT2PDo/PJx0HljkK78+sAQfAI
         6X3o5vxac+hq3dsdpF/2T16++48nnF/bZsr8+FSBQeYDxw/b2kg9qU/va05J1B0Ql7Lg
         LVW1v1LKA93S9qZFMvhFQZ+5m+6t9KG/H3MKH0rT8s+dEcobt7l9JjFqU7bcY2muNsri
         4XVpuayavfgjNtOQ5Q4sHmCNdenazYbeBHpv3zbr5c/kzqj6dulCiaK7OsNg0l2pDqm9
         wJ9Q==
X-Gm-Message-State: AOAM5339mYgLeGJdHxzD/Li1oW1RTMulVRsvko4+1S3WMUxQKmEFoyVq
        LMMN9dF64wKUGcokTXQNBDzBH59rpB9A2IsRPgdcAIb7OyI=
X-Google-Smtp-Source: ABdhPJy3aX/SP8FQyuznKG5zkWe7Evxf9h9w1nHdSYM6wRWsXR8UhZrJbO0+BDwsxoT4CdlgxSkDGzopMSCxP1wmfu8=
X-Received: by 2002:a92:6410:: with SMTP id y16mr17620180ilb.126.1605734463244;
 Wed, 18 Nov 2020 13:21:03 -0800 (PST)
MIME-Version: 1.0
References: <20201111104409.1530957-1-a.nogikh@gmail.com>
In-Reply-To: <20201111104409.1530957-1-a.nogikh@gmail.com>
From:   Aleksandr Nogikh <a.nogikh@gmail.com>
Date:   Thu, 19 Nov 2020 00:20:52 +0300
Message-ID: <CADpXja_NZqMomnHfzRRNE97LwP4WYZY4Z1egeFiCjwSbea-Urg@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] security: add fault injection to LSM hooks
To:     jmorris@namei.org
Cc:     "Serge E. Hallyn" <serge@hallyn.com>, akinobu.mita@gmail.com,
        Andrey Konovalov <andreyknvl@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@google.com>, casey@schaufler-ca.com,
        penguin-kernel@i-love.sakura.ne.jp,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org, mortonm@chromium.org,
        Aleksandr Nogikh <nogikh@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, 11 Nov 2020 at 13:44, Aleksandr Nogikh <a.nogikh@gmail.com> wrote:
>
> From: Aleksandr Nogikh <nogikh@google.com>
>
> Fault injection capabilities[Documentation/fault-injection/fault-injection.rst]
> facilitate testing of the stability of the Linux kernel by providing
> means to force a number of kernel interfaces to return error
> codes. This patch series proposes adding such fault injection
> capability into LSM hooks.
>
> The intent is to make it possible to test whether the existing kernel
> code properly handles negative return values of LSM hooks. Syzbot
> [https://github.com/google/syzkaller/blob/master/docs/syzbot.md] will
> automatically do that with the aid of instrumentation tools once these
> changes are merged.
[...]

James, can you please take another look at the series? Are there
enough reviewed-bys now?

--
Best Regards,
Aleksandr
