Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1013C3F6B0
	for <linux-security-module@archiver.kernel.org>; Wed,  3 Aug 2022 02:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235541AbiHCCkr (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 2 Aug 2022 22:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233385AbiHCCkq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 2 Aug 2022 22:40:46 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1CA3335C
        for <linux-security-module@vger.kernel.org>; Tue,  2 Aug 2022 19:40:46 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id h188so18228012oia.13
        for <linux-security-module@vger.kernel.org>; Tue, 02 Aug 2022 19:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=dJ9RyKWE5FBwVhzJS/Ney0KLGBUDYNi42Whw7jsCqTk=;
        b=Pb2Eej0xmH23y/cqzxJPqY7hR1X5oZDSF3Ij3l5/RGclHhaIy+1giMDCyH6E97NFtw
         W7X8k0+rOQNq7e1b+QP8yaXoPmf+qMf6CRY+OtEnlKXjnb7XFhgGh/463kRiVyWF7sEJ
         2ks+XT7DASO3j70gCiOwsvZl/c6VaVseb8He8FApS/vdEXrmKVJeJd/HpZoNtO2dQoWS
         W23yk7KbilvyYWCQg4K3FoK0MopX7hfo/gsWWqE8RR8xXHUj0N4MpYTT/v/7R+B6NDmZ
         17+OATGNanpWeQa72PZc4UUaEZpBHSPUuYebvjMsZgMHlQPnGOk0Ou0b6zPKA9p7+yFe
         Zefg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=dJ9RyKWE5FBwVhzJS/Ney0KLGBUDYNi42Whw7jsCqTk=;
        b=0uVYwE2mZCwKy6c3YjyZSxhgv/o8NY2BelDHwjZ6FzYPTh1k8X3LlRVHfb5xU/INp0
         wXLSAlhWBs6fRBoRE979AqNkxJFYmf8YcsI9knl/2dn3g5VYJnXoQq0IX8SbmTRBAfdY
         DKGcTsCxyTmBbIHBQ8UU9Yj/DJMhDrmlenis3j9b0c1qn/IuXwEDHHEYEYq4OjIqyDYH
         SHpcRXuu66qWrab0K4pG5qPYLJ5p1eNggub5QDXChsV4Y56PUn1HbaPwY5DSDgCQL3CE
         yXESsVeIGq2J6MudIfLv5NWieTRWFpuwGxIwmjVO7FFkAiLEHbNOnQCE3e+TE7etrGmT
         I8YA==
X-Gm-Message-State: ACgBeo1cs9cg2I/DYehNenLIlle0oA8oCskX6cg4mVWWiHDK0f2tkw/H
        dye3HJgsqG8He4VRCRxpwxPJ/wi5I3SHCQc1r7WA
X-Google-Smtp-Source: AA6agR5+3/8/YLolArypjH7JH1LqPE7ZmK02/QYNQW0OMSF5rhL00CxWaT/Z0tNJLAoc36IeOmsIxl5nMMQQIu3vF8c=
X-Received: by 2002:a05:6808:2389:b0:33a:cbdb:f37a with SMTP id
 bp9-20020a056808238900b0033acbdbf37amr962169oib.136.1659494445502; Tue, 02
 Aug 2022 19:40:45 -0700 (PDT)
MIME-Version: 1.0
References: <791e13b5-bebd-12fc-53de-e9a86df23836.ref@schaufler-ca.com>
 <791e13b5-bebd-12fc-53de-e9a86df23836@schaufler-ca.com> <CAHC9VhSF8hWg=7tbFiCrizNF61vpwJcU3793LcStiu-anW4i1g@mail.gmail.com>
 <2642904.mvXUDI8C0e@x2>
In-Reply-To: <2642904.mvXUDI8C0e@x2>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 2 Aug 2022 22:40:34 -0400
Message-ID: <CAHC9VhR0mhUp-dnyP3uE5ALS6Dt43k6xQ_LVYw+QVjC5LG3qqA@mail.gmail.com>
Subject: Re: LSM stacking in next for 6.1?
To:     Steve Grubb <sgrubb@redhat.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>, linux-audit@redhat.com,
        John Johansen <john.johansen@canonical.com>,
        SElinux list <selinux@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Aug 2, 2022 at 10:34 PM Steve Grubb <sgrubb@redhat.com> wrote:
> On Tuesday, August 2, 2022 8:56:21 PM EDT Paul Moore wrote:
> >  I can tell you that I've never been really excited about the /proc
> >  changes, and believe it or not I've been thinking about those a fair
> >  amount since James asked me to start maintaining the LSM.
>
> Why do we not have auid and sessionid in /proc/<pid>/status  ?
>
> This has been needed for 10 - 15 years.

Nice thread hijack, but I believe you already know the answer to your
question Steve: submit a patch for review.

-- 
paul-moore.com
