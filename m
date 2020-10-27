Return-Path: <SRS0=YDB1=EC=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5689BC4363A
	for <linux-security-module@archiver.kernel.org>; Tue, 27 Oct 2020 17:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F367E20878
	for <linux-security-module@archiver.kernel.org>; Tue, 27 Oct 2020 17:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A/3G8fUm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1820236AbgJ0ReC (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 27 Oct 2020 13:34:02 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:32906 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1820226AbgJ0ReB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 27 Oct 2020 13:34:01 -0400
Received: by mail-io1-f67.google.com with SMTP id p15so2446840ioh.0
        for <linux-security-module@vger.kernel.org>; Tue, 27 Oct 2020 10:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SaQbFGzEXNDGk1pZ4O1HsiR48TwG2ZRAen3YJtUpq54=;
        b=A/3G8fUm4hjh/JNx8o769i7ImwXATsmSdZoFysVH+hTEn09YeG1uyFFpeCn9l4Y3QZ
         E9FwO0tv0Hn7ECi9YFN/WkZ6wkFSzJUpllCTq9RKuTOpdWQkLbj70z4FBUO6sP2boo7r
         8IN1fqW0KUXvWFCgKYXBfEJtgkn9dQxx5+xj8ji/algFHoUPZPEdrmi1EXpVhnXDt/x0
         i95X0GuNUTNdXr98dPdGgoC48aS5kZLi7Ayuh25mscPYdb4TlVHHxrCwA0pTWDyJkCgD
         Bmw1oWaq/eCJ111W8bYH78WPCqpwh6KjxtDfb3AzhPmx07qkK69vRuvWpq/Xvbi+wTwX
         JrCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SaQbFGzEXNDGk1pZ4O1HsiR48TwG2ZRAen3YJtUpq54=;
        b=eFug+BSZYVdo3Qj/eC7K8a6L6Jt1sGTqWG4cq0avMVJ0Mxo2kCMKaRVnBw0fFyQGTw
         X4dEFUdJZZqMKtbjBbSLY2bOEzBRGCMfaKiBPeImX++Ac5Efy1eGT5s7UNq9pMTgvXRg
         9AAcZsuyYbivGKvr5Bc2/v2QrHwu57UV3CwFKLkS2m56AtWoG+rWOu14lNhHdzeeQZdz
         Wkuy8885vA+CJrSXDkmUgvftJOJ/vIByeIlhqVxUbiMZwj0sf3hRJkP/OnyitYFH3y+J
         RMEDzP818nMTwnZHr06Oulck67XtGpJtcWcbMKwRZqT8ZaERyWZZWeRF/HG/lZkblLDL
         lr7Q==
X-Gm-Message-State: AOAM532OX2NLkhW55A4A1x7dj/l60NnzObbGPJNxOuXP2RXK+NIUURUn
        rYiIOX+I/1n25EgF2NcjrEwAlPE3kt4Oq9etVXxPRQ==
X-Google-Smtp-Source: ABdhPJye65RQMw9dAti1BJvaSSspi0uCYaHX7hyM/GwNKLEo1SeOFQdV2ZoBchXt+qbnNBIhjttZed76F0Oty2xyKIw=
X-Received: by 2002:a05:6602:2181:: with SMTP id b1mr3170150iob.172.1603820039871;
 Tue, 27 Oct 2020 10:33:59 -0700 (PDT)
MIME-Version: 1.0
References: <20201026125227.54520-1-a.nogikh@gmail.com> <20201026125227.54520-3-a.nogikh@gmail.com>
 <CAC5umyjZn+gtO=u8GhptVggzodbY-vnk9NNTOqyZyUW2up2ASQ@mail.gmail.com>
In-Reply-To: <CAC5umyjZn+gtO=u8GhptVggzodbY-vnk9NNTOqyZyUW2up2ASQ@mail.gmail.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Tue, 27 Oct 2020 20:33:48 +0300
Message-ID: <CANp29Y7sDaxrw+0wEVU0vo56AhKFRvbQSGeRc168gs6S8iK_-g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/2] docs: add fail_lsm_hooks info to fault-injection.rst
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     Aleksandr Nogikh <a.nogikh@gmail.com>, jmorris@namei.org,
        serge@hallyn.com, Andrey Konovalov <andreyknvl@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>, keescook@google.com,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Oct 27, 2020 at 6:31 PM Akinobu Mita <akinobu.mita@gmail.com> wrote:
>
[...]
> In addition to this global one, what do you think about per-hook fault
> injection,
> i.e. /sys/kernel/debug/fail_lsm_hooks/<FUNC>/retval ?

I was thinking about this, but decided to begin with a simple version
that could definitely be useful in practice (for syzbot/syzkaller it is just
necessary to have a fault injection capability that will be triggered via
fail-nth). If per-hook fault injection can also be useful to someone, I
can try to add it as well.

> In this case, we need a fault_attr for each hook. (Maybe, we can use the same
> technique that is used to define security_hook_heads).

Yes, that technique should help to implement the feature in a very concise
way. Thanks for the suggestion.
