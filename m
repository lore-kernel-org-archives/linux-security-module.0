Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45942C47082
	for <linux-security-module@archiver.kernel.org>; Sat,  5 Jun 2021 18:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BA0961358
	for <linux-security-module@archiver.kernel.org>; Sat,  5 Jun 2021 18:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhFESZa (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 5 Jun 2021 14:25:30 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:44885 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhFESZa (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 5 Jun 2021 14:25:30 -0400
Received: by mail-lj1-f181.google.com with SMTP id d2so11861267ljj.11
        for <linux-security-module@vger.kernel.org>; Sat, 05 Jun 2021 11:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hWseLMsHC1Tl+tjltvawHbNPgfRx7qxCEi8/dkUNOU4=;
        b=dq91qTUDZfLAHHlQj01Xackwp7mLXGslcYSqKR8QjQWjay1MPlIiBx9Q2OjLRJv3Ny
         tUvoHIhp+fIOQUEt5cgx436HWwJytvd/+6hnvkb9my5cWuHI21RlTnevNOOSMWGTQ9Xp
         QlUNP5FJUEwnP+uHbMzVIztOiIoJLIajgm2Dk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hWseLMsHC1Tl+tjltvawHbNPgfRx7qxCEi8/dkUNOU4=;
        b=EswYbEh7rwNInTknhRpvhJNxX8WmeKLXgB/fZj7VKuruhXjbRupHG4ifdMI41n0AyR
         /GqiPtS/i3S9zerncCFSU57thM1PyQ/x4MukMA4ZsZxi0M3oFfzn4kg6uB57YiFYNgNz
         f21/qLLEA/lrOnFFeMMz9EWYFGT6HpqNik9Z4TkC8+TGcm2gtse/UDnG29TAMEJwkxYj
         SsH8FSbtsMKRD0/64rR9hh1FfSZ5qnY6G5G3lUjne9Xm+Hv8DAxNDqm8BHN6/j3JR7bB
         7kE34fmbWOZlOtotuY7l2xt8rtflNtTbUwPMBaZ5zX1rnvX959OfHrc98xSKqMypacQa
         N1XA==
X-Gm-Message-State: AOAM5312mbKWkUHsxzGl2u1MRVftxittDv1bl/I+t06RI53HjJ7Q9dVn
        akOsBgbhMtSNUXMNzsj2OvSnjiuqQHWgr5gAVCw=
X-Google-Smtp-Source: ABdhPJzHzNomLcxLkVhiWIMogBqTFgWCNK+YBXePUmaZmcHPQGN5pAeOQtYr807k6ztPyB8IOyBMQA==
X-Received: by 2002:a2e:7018:: with SMTP id l24mr8237572ljc.12.1622917345867;
        Sat, 05 Jun 2021 11:22:25 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id p20sm1142290ljn.86.2021.06.05.11.22.25
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Jun 2021 11:22:25 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id a1so9385946lfr.12
        for <linux-security-module@vger.kernel.org>; Sat, 05 Jun 2021 11:22:25 -0700 (PDT)
X-Received: by 2002:a05:6512:374b:: with SMTP id a11mr6305938lfs.377.1622917038058;
 Sat, 05 Jun 2021 11:17:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210517092006.803332-1-omosnace@redhat.com> <CAHC9VhTasra0tU=bKwVqAwLRYaC+hYakirRz0Mn5jbVMuDkwrA@mail.gmail.com>
 <01135120-8bf7-df2e-cff0-1d73f1f841c3@iogearbox.net> <CAHC9VhR-kYmMA8gsqkiL5=poN9FoL-uCyx1YOLCoG2hRiUBYug@mail.gmail.com>
 <c7c2d7e1-e253-dce0-d35c-392192e4926e@iogearbox.net> <CAHC9VhS1XRZjKcTFgH1+n5uA-CeT+9BeSP5jvT2+RE5ougLpUg@mail.gmail.com>
 <2e541bdc-ae21-9a07-7ac7-6c6a4dda09e8@iogearbox.net> <CAHC9VhT464vr9sWxqY3PRB4DAccz=LvRMLgWBsSViWMR0JJvOQ@mail.gmail.com>
 <3ca181e3-df32-9ae0-12c6-efb899b7ce7a@iogearbox.net> <CAHC9VhTuPnPs1wMTmoGUZ4fvyy-es9QJpE7O_yTs2JKos4fgbw@mail.gmail.com>
 <f4373013-88fb-b839-aaaa-3826548ebd0c@iogearbox.net> <CAHC9VhS=BeGdaAi8Ae5Fx42Fzy_ybkcXwMNcPwK=uuA6=+SRcg@mail.gmail.com>
 <c59743f6-0000-1b15-bc16-ff761b443aef@iogearbox.net> <CAHC9VhT1JhdRw9P_m3niY-U-vukxTWKTE9q6AMyQ=r_ohpPxMw@mail.gmail.com>
 <CAADnVQ+0bNtDj46Q8s-h=rqJgZz2JaGTeHpbmof3e7fBBQKuDQ@mail.gmail.com> <64552a82-d878-b6e6-e650-52423153b624@schaufler-ca.com>
In-Reply-To: <64552a82-d878-b6e6-e650-52423153b624@schaufler-ca.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 5 Jun 2021 11:17:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiUVqHN76YUwhkjZzwTdjMMJf_zN4+u7vEJjmEGh3recw@mail.gmail.com>
Message-ID: <CAHk-=wiUVqHN76YUwhkjZzwTdjMMJf_zN4+u7vEJjmEGh3recw@mail.gmail.com>
Subject: Re: [PATCH v2] lockdown,selinux: avoid bogus SELinux lockdown
 permission checks
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>,
        ppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, Jun 5, 2021 at 11:11 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> You have fallen into a common fallacy. The fact that the "code runs"
> does not assure that the "system works right". In the security world
> we face this all the time, often with performance expectations. In this
> case the BPF design has failed [..]

I think it's the lockdown patches that have failed. They did the wrong
thing, they didn't work,

The report in question is for a regression.

THERE ARE NO VALID ARGUMENTS FOR REGRESSIONS.

Honestly, security people need to understand that "not working" is not
a success case of security. It's a failure case.

Yes, "not working" may be secure. But security in that case is *pointless*.

              Linus
