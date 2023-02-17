Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70130C6379F
	for <linux-security-module@archiver.kernel.org>; Fri, 17 Feb 2023 16:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjBQQUj (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 17 Feb 2023 11:20:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjBQQUU (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 17 Feb 2023 11:20:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56836F3F8
        for <linux-security-module@vger.kernel.org>; Fri, 17 Feb 2023 08:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676650737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KGNvKVanzVRQGRVqRAA4tIqC9UQ9qVAYLdRdmeyMsg4=;
        b=NDPTax4BnwABJYPFxBucS2rz9XX88mPrDEqNHuoyfmIL4d5v5Dz2uF6GSsY8s42IKhlQUH
        xEpIBETEBggFeQMwUUF6JpSxfkmoGcZyM/tXRj6x6RwQFXq/xFUaxjzKFYV9a43AZHotu+
        bVawq2duhBnXzKLuaew+WM1rjOmcqTw=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-226-SyZF67w2M861_OyJqse6tg-1; Fri, 17 Feb 2023 11:18:55 -0500
X-MC-Unique: SyZF67w2M861_OyJqse6tg-1
Received: by mail-pj1-f70.google.com with SMTP id qa16-20020a17090b4fd000b00233c6b388ddso545488pjb.5
        for <linux-security-module@vger.kernel.org>; Fri, 17 Feb 2023 08:18:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KGNvKVanzVRQGRVqRAA4tIqC9UQ9qVAYLdRdmeyMsg4=;
        b=uJBeZAtJP+WfqDBfddmlT98c2BBNVQ+OCHJCa5MQiuG9dGMdymlk1wV3ewj9+ghc2F
         tbgbm7lYGT1fjWOu0jwaC1f+OMnhPKiB8lCnBjCGmIVYDrU5n4Rw28bgpP+Hw2LWTseB
         2BZRmLTMXXEaSTCymqTQsoHLaQtF5BXS+pkw5Kg/s5VMzQEBATIjCUQzXUkFbosSEE4M
         nTZg6snBtc9oYgFgKZhsjhqHz/6Zz8TmtDwNPZD8Q6l/7KNZ5fdkROzwTlV37s6Sbh5F
         ofFzSS/c7QArwftWM61i7JWyYOlNWEqdFKd/dTwgQIhQ4YnYsxa73WpTwEb0oFXpLQvX
         U2Bg==
X-Gm-Message-State: AO0yUKW2QenP3SirwBToVMFsMgOD6SDdxYCUx50CfFmTLlggkydnhj0D
        ec2qLbvvGT/ER1hevGi93/qjyMTdq+Ojp7ePfPCKrAeqdc6OSqbHyTnsSsWPQBaRIpcUD3n3iRF
        +wc7u7YJHw5ZDn2ZhWyVieoYDTU/IEMfgTYD35/jiJaE+E5WZ5P4i
X-Received: by 2002:a17:90b:2d86:b0:231:20d9:2f7 with SMTP id sj6-20020a17090b2d8600b0023120d902f7mr1657348pjb.109.1676650734845;
        Fri, 17 Feb 2023 08:18:54 -0800 (PST)
X-Google-Smtp-Source: AK7set+B3fHtimDstl0RYgS+DqQZw/5C8OZXA2WsyEyzZMlNWcURkViXO7TbtDrHrdXbaDO75OBivKna0S8j+MhiBkY=
X-Received: by 2002:a17:90b:2d86:b0:231:20d9:2f7 with SMTP id
 sj6-20020a17090b2d8600b0023120d902f7mr1657338pjb.109.1676650734617; Fri, 17
 Feb 2023 08:18:54 -0800 (PST)
MIME-Version: 1.0
References: <20230215131807.293556-1-omosnace@redhat.com> <20230215124747.6f8df3c4675517eacf1e9a39@linux-foundation.org>
 <87a61d7fvq.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87a61d7fvq.fsf@email.froward.int.ebiederm.org>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 17 Feb 2023 17:18:42 +0100
Message-ID: <CAFqZXNuescrj3bY8FnK71f4JSXvnptvVoQhqH1eBrJ=PTYoAMQ@mail.gmail.com>
Subject: Re: [PATCH] kernel/sys.c: fix and improve control flow in __sys_setres[ug]id()
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Feb 16, 2023 at 5:11 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Andrew Morton <akpm@linux-foundation.org> writes:
>
> > On Wed, 15 Feb 2023 14:18:07 +0100 Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> >> 1. First determine if CAP_SET[UG]ID is required and only then call
> >>    ns_capable_setid(), to avoid bogus LSM (SELinux) denials.
> >
> > Can we please have more details on the selinux failures?  Under what
> > circumstances?  What is the end-user impact?
>
> It is puzzling the structure with having the capability check first
> dates to 2.1.104 (when a hand coded test for root was replaced
> with capable(CAP_SETID).  Which means the basic structure and logic
> of the code is even older than that.

I don't find it that puzzling - either the code structure predates the
moment LSMs were plugged into capable() (and no one did an audit of
existing callers at that time) or it was written without awareness
that capable() may have side effects (which is not surprising, since
it is not documented properly).

--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

