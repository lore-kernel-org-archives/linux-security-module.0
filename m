Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B41C433EF
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Sep 2021 13:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 651DD60E90
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Sep 2021 13:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbhINOAu (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 14 Sep 2021 10:00:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49855 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232989AbhINOAu (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 14 Sep 2021 10:00:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631627972;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kaya3EDVq+i2kEee2RcyRm9vp7G1d6PEMiE8V6O0cGg=;
        b=OoZkV1uoe7bBEP32yxu+BlkeeR9otGOqfoAKEkf/x0V8c3zncIOvd6xIdsaOKNXXHuhHkH
        Az2UOrSHlGjpsRjB78cooBtlL7K0MMuVbMhzwycrS5V3VbpbSG0XOsp16NCxG6xwn95B+l
        kR6wmbDU8wF2mVljXRBuh+FpQEzovQs=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-579-Kgrs4K-9MjaZ01DXBJh_Bg-1; Tue, 14 Sep 2021 09:59:31 -0400
X-MC-Unique: Kgrs4K-9MjaZ01DXBJh_Bg-1
Received: by mail-il1-f197.google.com with SMTP id b18-20020a92dcd2000000b00234edde2da9so4981767ilr.21
        for <linux-security-module@vger.kernel.org>; Tue, 14 Sep 2021 06:59:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kaya3EDVq+i2kEee2RcyRm9vp7G1d6PEMiE8V6O0cGg=;
        b=aGQ+xQRwow9ecZrs1FlePDRfbuN1Kp5Rvf3Pp1BCEQMIwj77WDUsz/ZujuJ9+GhDK/
         e/AeTLtU6XaCiRWpFPOIUSJ2lNICBCDaqgNEiJ5ZmfwJqLyE+Td0M8ArkjU/v8hcoyNx
         if9xWaubDid+UCNPuy6WCYSpWdUCUj/ZYUAeB7rOiO2/wzxwOn+yPTYlShPe1HRpsnSR
         SNEE4BXPTsOaJ1+e38ALxWDGCgxW7wGPebN3nKKo0QrKfHXyq+jYQuExZ1YyGITcnxHC
         gJrYNXT6nxfn6Ibc4YZfo0hYvwKZ8xTW8jdW1cJP9P9n6FbX1TjhbB4LOBrjwhR2k+LM
         IO+w==
X-Gm-Message-State: AOAM5314qikXyA3KeTwUsKJ2Bp0myNd+lFK6NRLfSqfWF6mDVdT1JDL0
        saIXvBgj+eVWnCDsUroxJJ6G82oL+VZBQGbpHbsK+PDHiBFs2iwIpon/Qxr+I7GopTtfeUcrcWh
        CwS9knN46C6USDRY2+2d0nNrinVzrf8OjqwasxE/G4jFxvrrSCkKf
X-Received: by 2002:a05:6638:1606:: with SMTP id x6mr14896502jas.25.1631627970920;
        Tue, 14 Sep 2021 06:59:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyykZ0VYVJ0bOaRFeN+fD5tTcAMHGgErQub0XJv3DCUagog8L0n472IWYdPHqWMZTwm1ZepJvhHcI2h2Lqcvw4=
X-Received: by 2002:a05:6638:1606:: with SMTP id x6mr14896484jas.25.1631627970753;
 Tue, 14 Sep 2021 06:59:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210902152228.665959-1-vgoyal@redhat.com> <79dcd300-a441-cdba-e523-324733f892ca@schaufler-ca.com>
 <YTEEPZJ3kxWkcM9x@redhat.com> <YTENEAv6dw9QoYcY@redhat.com>
 <3bca47d0-747d-dd49-a03f-e0fa98eaa2f7@schaufler-ca.com> <YTEur7h6fe4xBJRb@redhat.com>
 <1f33e6ef-e896-09ef-43b1-6c5fac40ba5f@schaufler-ca.com> <YTYr4MgWnOgf/SWY@work-vm>
 <496e92bf-bf9e-a56b-bd73-3c1d0994a064@schaufler-ca.com> <YUCa6pWpr5cjCNrU@redhat.com>
In-Reply-To: <YUCa6pWpr5cjCNrU@redhat.com>
From:   Bruce Fields <bfields@redhat.com>
Date:   Tue, 14 Sep 2021 09:59:19 -0400
Message-ID: <CAPL3RVHB=E_s1AW1sQMEgrLYJ8ADCdr=qaKsDrpYjVzW-Apq8w@mail.gmail.com>
Subject: Re: [PATCH v3 0/1] Relax restrictions on user.* xattr
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, virtio-fs@redhat.com,
        Daniel Walsh <dwalsh@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        LSM <linux-security-module@vger.kernel.org>,
        selinux@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        stephen.smalley.work@gmail.com,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Dave Chinner <david@fromorbit.com>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=bfields@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Sep 14, 2021 at 8:52 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> Same is the requirement for regular containers and that's why
> podman (and possibly other container managers), make top level
> storage directory only readable and searchable by root, so that
> unpriveleged entities on host can not access container root filesystem
> data.

Note--if that directory is on NFS, making it readable and searchable
by root is very weak protection, since it's often possible for an
attacker to guess filehandles and access objects without the need for
directory lookups.

--b.

