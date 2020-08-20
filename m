Return-Path: <SRS0=ujXN=B6=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64920C433DF
	for <linux-security-module@archiver.kernel.org>; Thu, 20 Aug 2020 00:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43061208C7
	for <linux-security-module@archiver.kernel.org>; Thu, 20 Aug 2020 00:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HgQNMTIz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgHTAfU (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 19 Aug 2020 20:35:20 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57026 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726646AbgHTAfT (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 19 Aug 2020 20:35:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597883717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MWnHjLON1AfOs3QMZm9Z3/r0rb/4p0ijKhFTvUBOc+k=;
        b=HgQNMTIzYSFrqs9nCJQprjzbA61ylZBMx1hwaMUyTQiJY+4pGXKU3S0HF/O+Ot8gbYcojf
        eDaPu7/Zk1Heue65f030aTeI3zjz+nMExJL2NGR3zJlyp0+RI933jbbxJjQ5MN/EzkGMN1
        N3BZmRh4lj6PVUijARfUxog7+/faycI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-sRiWdmhHPzisqpybIIuAHg-1; Wed, 19 Aug 2020 20:35:16 -0400
X-MC-Unique: sRiWdmhHPzisqpybIIuAHg-1
Received: by mail-ej1-f71.google.com with SMTP id i4so186833ejk.9
        for <linux-security-module@vger.kernel.org>; Wed, 19 Aug 2020 17:35:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MWnHjLON1AfOs3QMZm9Z3/r0rb/4p0ijKhFTvUBOc+k=;
        b=tQholtDk/qwA5rS+0hRva3XwJgpPzFniy7doqGOg2gjYpg/WB/EIlvUr4yqCGGFhCm
         I60gJPV9l/19uH7sw9dU+joIrDJ23ght5Ywje/Ll5uAWQHnqEe36kJewmDOV9Zwa0WUK
         oGNnURTGkc6C5MgFjIlhJH5aZawiLsspcpDO9pWPpzFuKyrfg+pXCqV9RVkVquxEaSBS
         V/2bj0Q1Kt4kbvT4cwCV8gjLJq0FZi0Yw+gpOfkoytqxP75Vqn9QXDsBll1CT+shvjpi
         oBbr3FQt/06rPYBXRWxBW47u6iEQcWnw/Ed8iXAOyuClsaTSdMh6giP9HhWfsNm5j7ZS
         cccA==
X-Gm-Message-State: AOAM531XCKEWlNc/BuR1dVGTjhJ9G2/95le8Nrf48uPerOPsBmR+kdkS
        IURVyIQqKtSKQdSALueHECJVFYJXjPBx+/tD2LKH6gUhK4LqsQt9azbbQ8rT91H7oLVYnx3ij9V
        OK417u+0/7UjMJ3i7/UKAGNmXMREJq/DVZIjNB32xzZ5z198arjIo
X-Received: by 2002:a17:906:a0c5:: with SMTP id bh5mr865246ejb.120.1597883714929;
        Wed, 19 Aug 2020 17:35:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7eXB6HBV617/T7RupL6xoWk4Q/Xd1WoVjayR5ltC7LorRr4B5FkqEg13RK1ed3/MHQ5trENdPQOFI5AxyD+0=
X-Received: by 2002:a17:906:a0c5:: with SMTP id bh5mr865230ejb.120.1597883714728;
 Wed, 19 Aug 2020 17:35:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAE4VaGD8sKqUgOxr0im+OJgwrLxbbXDaKTSqpyAGRx=rr9isUg@mail.gmail.com>
 <202008191626.1420C63231@keescook>
In-Reply-To: <202008191626.1420C63231@keescook>
From:   Jirka Hladky <jhladky@redhat.com>
Date:   Thu, 20 Aug 2020 02:35:04 +0200
Message-ID: <CAE4VaGAGHNj0rWmTN4r5xJuN-ty2xYAsFxWwKEAod6tvMqjpUA@mail.gmail.com>
Subject: Re: init_on_alloc/init_on_free boot options
To:     Kees Cook <keescook@chromium.org>
Cc:     Alexander Potapenko <glider@google.com>,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jhladky@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Thanks a lot for the clarification! I was scratching my head if it
makes sense to enable both options simultaneously.


On Thu, Aug 20, 2020 at 1:36 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Aug 20, 2020 at 12:18:33AM +0200, Jirka Hladky wrote:
> > Could you please help me to clarify the purpose of init_on_alloc=1
> > when init_on_free is enabled?
>
> It's to zero memory at allocation time. :) (They are independent
> options.)
>
> > If I get it right, init_on_free=1 alone guarantees that the memory
> > returned by the page allocator and SL[AU]B is initialized with zeroes.
>
> No, it's guarantees memory freed by the page/slab allocators are zeroed.
>
> > What is the purpose of init_on_alloc=1 in that case? We are zeroing
> > memory twice, or am I missing something?
>
> If you have both enabled, yes, you will zero twice. (In theory, if you
> have any kind of Use-After-Free/dangling pointers that get written
> through after free and before alloc, those contents wouldn't strictly be
> zero at alloc time without init_on_alloc. But that's pretty rare.
>
> I wouldn't expect many people to run with both options enabled;
> init_on_alloc is more performance-friendly (i.e. cache-friendly), and
> init_on_free minimizes the lifetime of stale data in memory.
>
> It appears that the shipping kernel defaults for several distros (Ubuntu,
> Arch, Debian, others?) and devices (Android, Chrome OS, others?) are using
> init_on_alloc=1. Will Fedora and/or RedHat be joining this trend?  :)
>
> --
> Kees Cook
>


-- 
-Jirka

