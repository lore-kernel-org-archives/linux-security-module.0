Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D454C05027
	for <linux-security-module@archiver.kernel.org>; Fri, 17 Feb 2023 16:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbjBQQPc (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 17 Feb 2023 11:15:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbjBQQPH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 17 Feb 2023 11:15:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D1E6EB8F
        for <linux-security-module@vger.kernel.org>; Fri, 17 Feb 2023 08:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676650461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u7A6kRVX9USFvrSe+YUq3qxqmtep/gOesQK4GbyltR4=;
        b=gVOlzoemAkJh1SvRpFQFK6110NR5uk/PUWYOD2fgXy2HxDq1MMaRCE98/UX3F3s1m9tqRz
        MfhsdXhNjUfnp86wQaSRHkMXy9qT8hgmxHMdE82CEjPaj3LlMa+46Mx0MM62UZbtB2hWvN
        RpOWHj0+Xl9qchNzkmgdmV47q11QMCo=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-315-mjpq5__tOEullAN18oV36A-1; Fri, 17 Feb 2023 11:14:20 -0500
X-MC-Unique: mjpq5__tOEullAN18oV36A-1
Received: by mail-pf1-f197.google.com with SMTP id x25-20020aa793b9000000b005a8ad1228d4so706699pff.10
        for <linux-security-module@vger.kernel.org>; Fri, 17 Feb 2023 08:14:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u7A6kRVX9USFvrSe+YUq3qxqmtep/gOesQK4GbyltR4=;
        b=fGTD1mmNRWW6RPPnNBvRZlt6gvxF6xFvtO6P1bCTTvYkEdrR82bqV1oZ4avtSsoYc9
         Im7aYgBCL0xqKHNSwdh230N/O8/wdXO4AurdFepu5wHAET0YFUCbZWj9uWt5+MD6hoSf
         hAP01wzYXqtw6itICeRT3fh9clcr9p5txst1zyCCSYdyfK5dZh3FMVTxEvobv3h7vKeg
         1wwkXi0hO97L3eKgwhzq3SCZk+dDVqPRhzs9mWTv+BZFUwpTDHkWZU6rSAa1/wMdlqFL
         gDYWjgfcHJh5+QwCRIYrLCXLncIQfPu7fiqHVEYWmzWIbyuS6g3Rd3cjhlmVbRv7gAvq
         ogiw==
X-Gm-Message-State: AO0yUKXxqWFuN7ZNNzmF3CqTKygaZjBhzh2O+V7jw9pY0ALaM1KEQryT
        4BFVsrSV1+BciPwkaKLZWSonR68vsaVzl+AnTyyq2p4s114c/OykQV9agSnLymhRYMLo0MCKrtl
        c/6szxGNC+jpm3SOw24+SzRFcPQeg7l5gw3tvOj0lBdzfkCFNbPGILTpEIqCn
X-Received: by 2002:a17:90b:2d86:b0:231:20d9:2f7 with SMTP id sj6-20020a17090b2d8600b0023120d902f7mr1654052pjb.109.1676650458681;
        Fri, 17 Feb 2023 08:14:18 -0800 (PST)
X-Google-Smtp-Source: AK7set8tohgmQvChINWAF1kGtAV+Sq+F9YMF564KXupouv9JfMhUKwddcZOA0loNKhsyYDpLmFpTD2XWH016z1I4u04=
X-Received: by 2002:a17:90b:2d86:b0:231:20d9:2f7 with SMTP id
 sj6-20020a17090b2d8600b0023120d902f7mr1654048pjb.109.1676650458370; Fri, 17
 Feb 2023 08:14:18 -0800 (PST)
MIME-Version: 1.0
References: <20230215131807.293556-1-omosnace@redhat.com> <20230215124747.6f8df3c4675517eacf1e9a39@linux-foundation.org>
In-Reply-To: <20230215124747.6f8df3c4675517eacf1e9a39@linux-foundation.org>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 17 Feb 2023 17:14:05 +0100
Message-ID: <CAFqZXNsP8zrQ=trMqLE09T5P-poeDPAVLj_YkTc1NpEDn4c_Sw@mail.gmail.com>
Subject: Re: [PATCH] kernel/sys.c: fix and improve control flow in __sys_setres[ug]id()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Feb 15, 2023 at 9:47 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed, 15 Feb 2023 14:18:07 +0100 Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> > 1. First determine if CAP_SET[UG]ID is required and only then call
> >    ns_capable_setid(), to avoid bogus LSM (SELinux) denials.
>
> Can we please have more details on the selinux failures?  Under what
> circumstances?  What is the end-user impact?
>
> Because a fix for "bogus LSM (SELinux) denials" sounds like something
> which should be backported into earlier kernels, but there simply isn't
> sufficient information here for others to decide on this.

Fair point. I will send a v2 with a more detailed explanation.

-- 
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

