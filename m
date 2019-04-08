Return-Path: <SRS0=KU/V=SK=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E102DC10F13
	for <linux-security-module@archiver.kernel.org>; Mon,  8 Apr 2019 17:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B06BA20883
	for <linux-security-module@archiver.kernel.org>; Mon,  8 Apr 2019 17:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m1qMCOsB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbfDHRPD (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 8 Apr 2019 13:15:03 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:35305 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728664AbfDHRPD (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 8 Apr 2019 13:15:03 -0400
Received: by mail-vk1-f193.google.com with SMTP id g24so3211361vki.2
        for <linux-security-module@vger.kernel.org>; Mon, 08 Apr 2019 10:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QNWxSEIPMq1gVan1P/8rBi8me5fnDngA88A2J0wyez0=;
        b=m1qMCOsBlIXzuJ74McEigabTnfzq67MTjoovacD7MOq/P0+rxbTH4vODORI4YzPR5j
         NtVORIrqXgx/HssokPsVYjSdzPVPx7BNl4fGDIgkMqW0+P+1QdcND5mNUDMOVQumgn0r
         LyNd5ragFy+2K5g5Samd3XvtJo44OWd91QKbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QNWxSEIPMq1gVan1P/8rBi8me5fnDngA88A2J0wyez0=;
        b=WJVk84tUEdNuDS0AUbUoWUOdLoH0U3JReyWIoKaNvJmho4Vxb952SY5kAOrTv8gbTN
         TijWUn6bKVVbozoTMk3GCbEeIDdmqa8zTnac3PykzFGB93EanxZyR6S0R74kzjk6gpfo
         XbN32eZywwzGMDtr6sPKQc94v4SD0MySiqjrBEIkl2a1g7WGeqTFgMSvzNj8rbriBxCk
         F3C1tqz1AnjXIGlqkMQsFzlbB9WZ7Ht+WJllYCHfe1WVKxGwSvmn4AVEUu7GD8mcaR5T
         mf4YH9LbHoMmHa/GtvZOG+dX5pGR1lvSxAe//tjTxpPf3ANPvqlehT31zELQZ4EQsomE
         blVA==
X-Gm-Message-State: APjAAAUtiiNciOavgdev8zmW0K3DoDtx43B9y1bbDq2qwqOMPWYw6Cy7
        k8dToAU1FnxECz5WHwcmDeJYkSjSrOA=
X-Google-Smtp-Source: APXvYqz3ZiQLnzkF9CJi0AapWR/0QSbE9FBrcxLPbIAiI5AAfVDc9cqZJfDOMinWEghTFFsWOcx6Qg==
X-Received: by 2002:a1f:a4d:: with SMTP id 74mr17197182vkk.13.1554743701603;
        Mon, 08 Apr 2019 10:15:01 -0700 (PDT)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id u6sm23820733vke.54.2019.04.08.10.14.58
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 10:14:59 -0700 (PDT)
Received: by mail-vs1-f54.google.com with SMTP id o10so5473605vsp.12
        for <linux-security-module@vger.kernel.org>; Mon, 08 Apr 2019 10:14:58 -0700 (PDT)
X-Received: by 2002:a67:7e12:: with SMTP id z18mr18237223vsc.82.1554743697591;
 Mon, 08 Apr 2019 10:14:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190308132701.133598-1-glider@google.com> <20190308132701.133598-3-glider@google.com>
 <497b1201-b2ae-5e0c-d191-ff1830d92fc1@redhat.com>
In-Reply-To: <497b1201-b2ae-5e0c-d191-ff1830d92fc1@redhat.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 8 Apr 2019 10:14:45 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJUWKiyW-_ygHpg9rJc7wQ2XTzjH71CtJfdefLu2zZHEg@mail.gmail.com>
Message-ID: <CAGXu5jJUWKiyW-_ygHpg9rJc7wQ2XTzjH71CtJfdefLu2zZHEg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] initmem: introduce CONFIG_INIT_ALL_HEAP
To:     Laura Abbott <labbott@redhat.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sandeep Patil <sspatil@android.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Apr 8, 2019 at 9:43 AM Laura Abbott <labbott@redhat.com> wrote:
> I've looked at doing something similar in the past (failing to find
> the thread this morning...) and while this will work, it has pretty
> serious performance issues. It's not actually the poisoning which
> is expensive but that turning on debugging removes the cpu slab
> which has significant performance penalties.
>
> I'd rather go back to the proposal of just poisoning the slab
> at alloc/free without using SLAB_POISON.

I still agree this would make the most sense. Fundamentally it's not a
debugging feature.

-- 
Kees Cook
