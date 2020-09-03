Return-Path: <SRS0=7Ydo=CM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18ACDC433E2
	for <linux-security-module@archiver.kernel.org>; Thu,  3 Sep 2020 21:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E427A20639
	for <linux-security-module@archiver.kernel.org>; Thu,  3 Sep 2020 21:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="RVaVhV2P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgICVtn (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 3 Sep 2020 17:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgICVtl (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 3 Sep 2020 17:49:41 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0368DC061244
        for <linux-security-module@vger.kernel.org>; Thu,  3 Sep 2020 14:49:40 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id b12so4133835edz.11
        for <linux-security-module@vger.kernel.org>; Thu, 03 Sep 2020 14:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tRdD44ooa252jPQTr3SlD5eHHLG1Cfiq4c2JyyoJvFI=;
        b=RVaVhV2PnuNIhb7EuI34tMbUlxG3nkUEWnUarjqDQCqYcG8PR0gDAAmJd2Xcn8eLju
         Q0qGoNRJIwdEpmMghFs5rNOnvEAE2CAEJb17YYGRikKJYpHhg1dEik6vc9yspme5rFIZ
         mYziqD88HjZvMjMGKGI7A4JgK3QFqMznJXn+TnTOdxgVSi6eAEFp/Tm5b9nQN2F3w+BR
         PcKW0tgpQocaRgsRC+9fOBXOI0S/WTwdfRvh9b0FGwwJJGEXKxBEhbR6uKJK7KHU1fy8
         bMoHvyWiVmRfyrFqCrusTHXmln7JYujXESjRx8CPCDhf8GAEgBSt3LAc+kehAqhqfTSz
         kk5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tRdD44ooa252jPQTr3SlD5eHHLG1Cfiq4c2JyyoJvFI=;
        b=rNWjNR+2Zcsj9W6HPxd/DdUsCFZ5l+vNhCGHJVcDMuEjNM8rlyeNX6i4o0XYrqcUjr
         2ddAOS7bM474lc7eJcd7EnQnJLi4W0+AvGAzq+Dvwzc1jZA4m6Z4aAQvmej+pwwu7xfH
         gIj2A21itqj4KoqHy+gHTcgz+gzkLoW8yW5oUM0O8CJa0YGLxlZyTyEiQV/QYkyPCwLx
         5ro1VdHpUo0ckBiiulCU5LlHYHqXZ6RO/vtVM80DX4dGbiHaaJ9N2HfNkdpv+nQ5+loC
         wqQpxUMX88sRxs17Y31FdR0vbsI0u1X2MBEBJK/jN7KPMm5AkukJUcsoByJ/XflxXvy1
         bibQ==
X-Gm-Message-State: AOAM5338gzx9i6jLV7FWEyb3F9RMtL7nqWpEar3kVTbX7uPG2q9rIJw3
        UYfH6Hfg351V28Z3b5TULdDcB5g2iRXDCpdTOFf0
X-Google-Smtp-Source: ABdhPJwOpksQCOYSRfyTuYdZhy0UiaEWTCEBitsjcs0peI2vbaOLiz+D5IVwdQU+cX0QqHXlH0jLjwIfQI1mYqVLRco=
X-Received: by 2002:a50:8e17:: with SMTP id 23mr5303949edw.31.1599169779286;
 Thu, 03 Sep 2020 14:49:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200826145247.10029-1-casey@schaufler-ca.com>
 <20200826145247.10029-21-casey@schaufler-ca.com> <alpine.LRH.2.21.2009040231550.1484@namei.org>
In-Reply-To: <alpine.LRH.2.21.2009040231550.1484@namei.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 3 Sep 2020 17:49:28 -0400
Message-ID: <CAHC9VhRoaB=R15jiwGHTnJHvR4+SiiVjEhL1FeGn6z6b6W+hkA@mail.gmail.com>
Subject: Re: [PATCH v20 20/23] Audit: Add new record for multiple process LSM attributes
To:     James Morris <jmorris@namei.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Sep 3, 2020 at 12:32 PM James Morris <jmorris@namei.org> wrote:
> On Wed, 26 Aug 2020, Casey Schaufler wrote:
>
> > Create a new audit record type to contain the subject information
> > when there are multiple security modules that require such data.
> > This record is linked with the same timestamp and serial number.
> > The record is produced only in cases where there is more than one
> > security module with a process "context".
> >
> > Before this change the only audit events that required multiple
> > records were syscall events. Several non-syscall events include
> > subject contexts, so the use of audit_context data has been expanded
> > as necessary.
> >
> > Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> > Cc: linux-audit@redhat.com
>
> Paul, can you review/ack the audit changes?

I did a previous version at some point in the past, I'll take a look
at v20 tomorrow or this weekend.

-- 
paul moore
www.paul-moore.com
