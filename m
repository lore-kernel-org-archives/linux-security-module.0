Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39FCC43217
	for <linux-security-module@archiver.kernel.org>; Thu, 20 Oct 2022 15:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbiJTPo7 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 20 Oct 2022 11:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiJTPo6 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 20 Oct 2022 11:44:58 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EEC159701
        for <linux-security-module@vger.kernel.org>; Thu, 20 Oct 2022 08:44:54 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id f205so76287yba.2
        for <linux-security-module@vger.kernel.org>; Thu, 20 Oct 2022 08:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vuJ1OX3Cxr4MI7P448IfdHAHrYdLDVJPbpwIxu/boEU=;
        b=xMxRHb6kucYGsW9hgAzpoA9Lp+fP7/3igVJMrDYXimIwAFBIhogm6Ny0iqNRwWAd6M
         QCRLVyks3/AwZIbTclS1429iwxEVUnzp7Ve/+6cep979/rEg8jj7z4FrLSCNPwvZzBX5
         eYXfZv3ZYsHno6Rcwm9krsK06MTBhCt/tO62c/ZEbDyQCCJG1JgYELb5fvPl5ku03T2U
         qX51NYl7WbDfvxqxuLPCRh1G/eI4QWC9LaloVz8Efve0N5Y5TAFYTBe3lS+Bf4/oJcX1
         ae634PdCsN/+fDy7ZLl1PPCnK2wfmPKYp8PKPXjFYocmVwBRzJy6tML39FHZs5qMT4Ry
         jlDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vuJ1OX3Cxr4MI7P448IfdHAHrYdLDVJPbpwIxu/boEU=;
        b=whxCiSds29LE+eFtlp2KcwBBSH3rPCwJ0jJ/GGgsQJCs5i1e3ptvH7YaRN/SD1NTtP
         l3BXwotsnx8JmdsZIIITdDWLnVtfrnQdSUeJlM6AqdnESdbXQDL68z/5W2TYWeFnD0HE
         3X7cPqmFo9FAGZ9EadryWL6IFQCpsovvHpNyBn0PQwg1iGiaGneS41MOq1XgW8WFyNcl
         FTXle2aCDJJVM+Iq/Eq9KIXZYCmcBuf7ST/gD3CCRoG8PYriWWYR8br35jQkBxBZGaDk
         Kj88SyJrqmoJuOTiRdk2U82xk/P7SKJzqv1YZ33QIfnQ50eFANBZ3lSDYjuAX4tVuwjN
         HRGw==
X-Gm-Message-State: ACrzQf29nbJCDCtIX/ebdXa6EPOA6lcnKCacENIqrqGVWuok+5ELQO05
        QfrLLXC2h9HH9nPUll9755lw3bmYEX2W/LcFZNY+
X-Google-Smtp-Source: AMsMyM5/43dxXX5gedL3EoAC+ilNlRScxaa0bWqmfjUQl7AhYvjk8ffyfXpADkAas0i8D4N5gYdy7izZJXYwLEv6TwQ=
X-Received: by 2002:a05:6902:724:b0:6c0:1784:b6c7 with SMTP id
 l4-20020a056902072400b006c01784b6c7mr11983384ybt.15.1666280693355; Thu, 20
 Oct 2022 08:44:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220927195421.14713-1-casey@schaufler-ca.com> <20220927195421.14713-7-casey@schaufler-ca.com>
In-Reply-To: <20220927195421.14713-7-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 20 Oct 2022 11:44:41 -0400
Message-ID: <CAHC9VhQbr1zgyvzM9zB97+rzO-Rcy6CUt_3-54ED-SEanVWyRQ@mail.gmail.com>
Subject: Re: [PATCH v38 06/39] LSM: lsm_self_attr syscall for LSM self attributes
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, linux-security-module@vger.kernel.org,
        linux-audit@redhat.com, jmorris@namei.org, selinux@vger.kernel.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Sep 27, 2022 at 3:57 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Create a system call lsm_self_attr() to provide the security
> module maintained attributes of the current process. Historically
> these attributes have been exposed to user space via entries in
> procfs under /proc/self/attr.

Hi Casey,

I had hoped to get to review these patches earlier this week, I know
you are very anxious to see something happen here, but unfortunately
that didn't work out and I'm now in a position of limited network
access and time for a bit.  I will do my best to at least comment on
the new syscall related additions, but thankfully you've already
started to get some good comments from others so I'm hopeful that will
help you keep moving forward.

One comment I did want to make, and it's important: please separate
the LSM syscall patches from the LSM stacking patches.  While the
stacking patches will obviously be dependent on the syscall patches,
the syscall patches should not be dependent on stacking.  However, the
LSM syscall patches must be designed from the start to support
multiple, simultaneous LSMs.

Thanks.

-- 
paul-moore.com
