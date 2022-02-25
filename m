Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 861C0C433F5
	for <linux-security-module@archiver.kernel.org>; Fri, 25 Feb 2022 02:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiBYC7L (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 24 Feb 2022 21:59:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233202AbiBYC7L (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 24 Feb 2022 21:59:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 22E5D20A957
        for <linux-security-module@vger.kernel.org>; Thu, 24 Feb 2022 18:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645757919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CauoURgUZ4v50QCANyExBUMWNUuGIGlFYqjgg6YLGL0=;
        b=DFTtIq8lrmgUXhU1EZ6px9SNO+EeSGsVBYnqr7/hQBYS3a960WEv4f9MTz6aEHCWlHt6jU
        tdR86WkPYy7TC/qJFG+o61dI18vdret/G7COICNVtsuw9/Gp6weff1W/CeKYHlZU5F5aEi
        582VAzJIcugUQ0888Z2gXNqyR3Y84UA=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-224-sxXPoNpJOXCYEGjwZJuyvw-1; Thu, 24 Feb 2022 21:58:37 -0500
X-MC-Unique: sxXPoNpJOXCYEGjwZJuyvw-1
Received: by mail-pg1-f200.google.com with SMTP id t18-20020a63dd12000000b00342725203b5so1944711pgg.16
        for <linux-security-module@vger.kernel.org>; Thu, 24 Feb 2022 18:58:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CauoURgUZ4v50QCANyExBUMWNUuGIGlFYqjgg6YLGL0=;
        b=ccxCNTauzm2hs7VSA7FEv9Jwhj7hNwPWPqzirWQHih8UyasA+q2XBeVIqEW3vfxrpx
         N3k245yfYVQoDMWyMiIYOI+xmfK2jp+tTTCCbfHIOxs+wDog/GvVX101tcFS9fpkFq4C
         p0sNCe1R/wofD9R3dbv4RDhkAE37kdL3oJqb3MIIV8fdOFncICj9WIbZFlrwpJDUfntG
         mAcjH2Xub1EMXiBgX9go38RIen3L8v3YsYl9cI0mahkEIK5ODE0RAqGDmykDv7dW+Cj0
         wdbIs5YGS4g8LDus8QeHCT2rs6uZY/TUZo/82suE6+zuvVdEH3XN/XCWglwvlkv8WwZ6
         CEnw==
X-Gm-Message-State: AOAM531okOTSStc5R/KM/xvcp74+Kab0sWwA9T3LiivVP3O7/JjCHnly
        WW7rFF9Wj4kGQpQC1JZG2CsZKvYHG5bd4Me1Vy52t0gIWo/lkMZ9YNkSEAD3CnDcKrIufnLEY5l
        b6nu9dC6Qz67WGMMa2ye+5Rw+DSN/No3stK+c
X-Received: by 2002:a17:903:244a:b0:150:25d1:d2ff with SMTP id l10-20020a170903244a00b0015025d1d2ffmr1997051pls.70.1645757916657;
        Thu, 24 Feb 2022 18:58:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzOGBViVIjSEs20HiGON+uKIVzSeyomY20qDxZXbhJhU+z/NsaHHhe2vINl/rCk0vkgrzDJ8Q==
X-Received: by 2002:a17:903:244a:b0:150:25d1:d2ff with SMTP id l10-20020a170903244a00b0015025d1d2ffmr1997024pls.70.1645757916338;
        Thu, 24 Feb 2022 18:58:36 -0800 (PST)
Received: from xz-m1.local ([94.177.118.52])
        by smtp.gmail.com with ESMTPSA id z5-20020a056a00240500b004e15d39f15fsm891513pfh.83.2022.02.24.18.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 18:58:35 -0800 (PST)
Date:   Fri, 25 Feb 2022 10:58:26 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Axel Rasmussen <axelrasmussen@google.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Serge Hallyn <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>
Subject: Re: [PATCH] userfaultfd, capability: introduce CAP_USERFAULTFD
Message-ID: <YhhF0jEeytTO32yt@xz-m1.local>
References: <20220224181953.1030665-1-axelrasmussen@google.com>
 <fd265bb6-d9be-c8a3-50a9-4e3bf048c0ef@schaufler-ca.com>
 <CAJHvVcgbCL7+4bBZ_5biLKfjmz_DKNBV8H6NxcLcFrw9Fbu7mw@mail.gmail.com>
 <0f74f1e4-6374-0e00-c5cb-04eba37e4ee3@schaufler-ca.com>
MIME-Version: 1.0
In-Reply-To: <0f74f1e4-6374-0e00-c5cb-04eba37e4ee3@schaufler-ca.com>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Feb 24, 2022 at 04:39:44PM -0800, Casey Schaufler wrote:
> What I'd want to see is multiple users where the use of CAP_USERFAULTD
> is independent of the use of CAP_SYS_PTRACE. That is, the programs would
> never require CAP_SYS_PTRACE. There should be demonstrated real value.
> Not just that a compromised program with CAP_SYS_PTRACE can do bad things,
> but that the programs with CAP_USERFAULTDD are somehow susceptible to
> being exploited to doing those bad things. Hypothetical users are just
> that, and often don't materialize.

I kind of have the same question indeed..

The use case we're talking about is VM migration, and the in-question
subject is literally the migration process or thread.  Isn't that a trusted
piece of software already?

Then the question is why the extra capability (in CAP_PTRACE but not in
CAP_UFFD) could bring much risk to the system.  Axel, did I miss something
important?

Thanks,

-- 
Peter Xu

