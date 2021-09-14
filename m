Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630A9C433F5
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Sep 2021 15:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48715610F9
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Sep 2021 15:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbhINPCd (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 14 Sep 2021 11:02:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32085 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234038AbhINPCc (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 14 Sep 2021 11:02:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631631675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f4doVZdRhwwzGkMFAoRi2PUNaC9z4kzqnDQ6De1+mEk=;
        b=FzOzCcVx0IKFdxc7Yp4zj+OD4RfPEq8AnBvFx7Ai5FLctFKDm3zjx6YZjthjdBbdkAaSaI
        76FTSlXHxOpoFxOKS5/79Im+Dglm3fDyky4YgQI01LXRQMSYCpALA3UB93cAezROx4dTZT
        PRQpXrE1+wbqL50aQwyDeZQuCPsU4OI=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-600-Y-_CA39QPoCiKHtvkorOZw-1; Tue, 14 Sep 2021 11:01:13 -0400
X-MC-Unique: Y-_CA39QPoCiKHtvkorOZw-1
Received: by mail-io1-f69.google.com with SMTP id w7-20020a5e9707000000b005c3adb2571fso16557765ioj.3
        for <linux-security-module@vger.kernel.org>; Tue, 14 Sep 2021 08:01:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f4doVZdRhwwzGkMFAoRi2PUNaC9z4kzqnDQ6De1+mEk=;
        b=WHmTgkewn3IMsFeV2F+j/FJXxkMxdNh49+pnlTVz/trA15eDq/p+bKgR6rjFO2yrBq
         LCrO9j2eKsMpI/tO5/gxSuILb8VEEV8TyPwu8cmMP/31RmSTCC56tPLuaAYEB8wA5jTD
         wCmEa9WSKtegTrZ3IzGlws+gP6+qrhlFbDLi6IO4qmVGyeDVEyDN5zwd9TCz2BMzAfGL
         RaIDqoc68emBmJ+ugXl3AzCOdz25rjb6/pyBaX0Z1ViK9KYCQNeY9jNZSGpM9vKoB9p9
         /cZnHiiHngpFU9RSKalcQoDu1WJj+R52wHS8nOrAk2TyyEsGe7m1J+dJj62kjd/jyBN0
         TYQQ==
X-Gm-Message-State: AOAM531AWBHdxEZZ6rEI9dAj0M4IKtjUbAzBEnw3aQKirY55CU16h6xh
        jhFhHLoWoC/oJk6M/x4Tsn59whe6lseMWEHFuer2clBU4/viE/DfwL8Iyx1VAbd4zkAbzW5JPGV
        e6mlzl/uRxs+YwuGduiHgv6/4MtttDPdBH/Jd85/LnAv30o677QfT
X-Received: by 2002:a05:6e02:1b88:: with SMTP id h8mr12302661ili.29.1631631672724;
        Tue, 14 Sep 2021 08:01:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyaAeiekMMKeZruAEeYbCxZpJjpmCzKAy5WCzmfRtD8PhxXBHVBLZZb+MFaozIMIyxqQwE9MVbD21EwvnT+xp8=
X-Received: by 2002:a05:6e02:1b88:: with SMTP id h8mr12302560ili.29.1631631671531;
 Tue, 14 Sep 2021 08:01:11 -0700 (PDT)
MIME-Version: 1.0
References: <79dcd300-a441-cdba-e523-324733f892ca@schaufler-ca.com>
 <YTEEPZJ3kxWkcM9x@redhat.com> <YTENEAv6dw9QoYcY@redhat.com>
 <3bca47d0-747d-dd49-a03f-e0fa98eaa2f7@schaufler-ca.com> <YTEur7h6fe4xBJRb@redhat.com>
 <1f33e6ef-e896-09ef-43b1-6c5fac40ba5f@schaufler-ca.com> <YTYr4MgWnOgf/SWY@work-vm>
 <496e92bf-bf9e-a56b-bd73-3c1d0994a064@schaufler-ca.com> <YUCa6pWpr5cjCNrU@redhat.com>
 <CAPL3RVHB=E_s1AW1sQMEgrLYJ8ADCdr=qaKsDrpYjVzW-Apq8w@mail.gmail.com> <YUCybaYK/0RLvY9J@redhat.com>
In-Reply-To: <YUCybaYK/0RLvY9J@redhat.com>
From:   Bruce Fields <bfields@redhat.com>
Date:   Tue, 14 Sep 2021 11:01:00 -0400
Message-ID: <CAPL3RVGXWtakCS9bvE60gWp0tcsduJFKfoU4aoqANRgp7HvFow@mail.gmail.com>
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

On Tue, Sep 14, 2021 at 10:32 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> open_by_handle_at() requires CAP_DAC_READ_SEARCH.

Or some sort of access to the network.  If you can send rpc requests
to the nfs server that appear to be from someone with access to the
export, you can guess filehandles that allow access to objects under
that directory.  You'll need access to particular objects, but you
won't need read or lookup access to the directory.

You can prevent that if you set things up right, but these
filehandle-issues are poorly understood, and people often forget to
take them into account.

--b.

> And if you have
> CAP_DAC_READ_SEARCH, you don't need to even guess file handles. You
> should be able to read/search through all directories, IIUC.
>
> So how does one make sure that shared directory on host is not
> accessible to unprivileged entities. If making directory accessible
> to root only is weaker security, what are the options for stronger
> security.

