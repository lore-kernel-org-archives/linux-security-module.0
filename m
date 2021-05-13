Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D72C433ED
	for <linux-security-module@archiver.kernel.org>; Thu, 13 May 2021 14:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2C3061435
	for <linux-security-module@archiver.kernel.org>; Thu, 13 May 2021 14:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234711AbhEMOzR (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 13 May 2021 10:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234850AbhEMOy2 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 13 May 2021 10:54:28 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE0AC06138B
        for <linux-security-module@vger.kernel.org>; Thu, 13 May 2021 07:53:17 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id k15so8845824pgb.10
        for <linux-security-module@vger.kernel.org>; Thu, 13 May 2021 07:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=3Q3G7UFAS/HZlfXSpy2j5hYo1FB3/TVxpPwfbdZ4cOA=;
        b=zZiuChDcorTWPtlQXsQlK0vCNOiL+pcmY/j1Ms9VNDWMmTDHOsAxzqf12ePiEl6js4
         UX3eOLPvgoG2RfeVs2ZG3dthcCC0p1THPrh2m1gEwiQ5gG7DT+/l938lNx2GPkmy68cZ
         dWPKBf3jZ6FCCNcHcU3Z0SLalStQZvJwMFKPaDb0SZ2wBuuEZiKSoBlZHOOtxX2RjR7W
         +7B+H9z44QGKCdM+Ozf10eqAgyNt6mjjE0gNxR1bxyszYWdOBqO+U3Wkn1qfK9DunKf6
         YuXR5XCQMS5IbcOd4LWukvNJwmEIIpPP3NYHOhTP8/Vi87NLd6vSVUv4j92a2pXtON6b
         zBqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=3Q3G7UFAS/HZlfXSpy2j5hYo1FB3/TVxpPwfbdZ4cOA=;
        b=uc69dMKJ5HXOTkhg3pl1zgGXAIqcFdLRsuWnGR0LygFIAQuvmNssGykC/fp+4qFOMR
         DqS5KJgCS+IpAU9SnqV3FivCIN2i1nVEy0dNeRNUHnN/TqWblWLivA4wLtRiwO4nTayE
         WEPI8uftY+XtOcOCvDdGICAplpjxh/hUdPIaydn8zEAfCuFXiYGHhvW5B0bXOYP7v1fH
         OimmzvWUCpajSkuvzJIjHPJybiSAh5LgI0Eg3Vcd7PgFZlPqpHmqz4YFGXnkYWQFoILU
         1BGVVQPEYtIS1aea1odDVYlZJrJs+sMcvKZMAtT3oimQ/NqTOOUg7P5BtmpukZw0LD3R
         ds5w==
X-Gm-Message-State: AOAM530iXboy/LxKWpaYXml/LOmALYrIzLF6jPl8ELQwrd2q/uBJlvGm
        PrQZvVhGLKfLjUrzeHe+TupB7w==
X-Google-Smtp-Source: ABdhPJzSuz21HzHkRIZwlmWxyLSlEHrN4uwpzI2y/aZz/zNThtrhPQTk9PMtQAHHmaK1U9Jt5G6HVQ==
X-Received: by 2002:a65:638e:: with SMTP id h14mr27198087pgv.108.1620917597311;
        Thu, 13 May 2021 07:53:17 -0700 (PDT)
Received: from smtpclient.apple ([2601:646:c200:1ef2:59b7:4731:1e3c:b03f])
        by smtp.gmail.com with ESMTPSA id z23sm2722135pjh.44.2021.05.13.07.53.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 May 2021 07:53:16 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH bpf-next seccomp 10/12] seccomp-ebpf: Add ability to read user memory
Date:   Thu, 13 May 2021 07:53:15 -0700
Message-Id: <B541CF0E-3410-4CA3-93E4-670052C5FC11@amacapital.net>
References: <CABqSeAR9rgARxYGYUVZQgZ0a-wqZxy-qeoVpu495XHxpj0Ku=A@mail.gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        containers@lists.linux.dev, bpf <bpf@vger.kernel.org>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        LSM List <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Austin Kuo <hckuo2@illinois.edu>,
        Claudio Canella <claudio.canella@iaik.tugraz.at>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jann Horn <jannh@google.com>,
        Jinghao Jia <jinghao7@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Kees Cook <keescook@chromium.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tom Hromatka <tom.hromatka@oracle.com>,
        Will Drewry <wad@chromium.org>
In-Reply-To: <CABqSeAR9rgARxYGYUVZQgZ0a-wqZxy-qeoVpu495XHxpj0Ku=A@mail.gmail.com>
To:     YiFei Zhu <zhuyifei1999@gmail.com>
X-Mailer: iPhone Mail (18E212)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


> On May 12, 2021, at 10:26 PM, YiFei Zhu <zhuyifei1999@gmail.com> wrote:
>=20
> =EF=BB=BFOn Wed, May 12, 2021 at 5:36 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>> Typically the verifier does all the checks at load time to avoid
>> run-time overhead during program execution. Then at attach time we
>> check that attach parameters provided at load time match exactly
>> to those at attach time. ifindex, attach_btf_id, etc fall into this categ=
ory.
>> Doing something similar it should be possible to avoid
>> doing get_dumpable() at run-time.
>=20
> Do you mean to move the check of dumpable to load time instead of
> runtime? I do not think that makes sense. A process may arbitrarily
> set its dumpable attribute during execution via prctl. A process could
> do set itself to non-dumpable, before interacting with sensitive
> information that would better not be possible to be dumped (eg.
> ssh-agent does this [1]). Therefore, being dumpable at one point in
> time does not indicate anything about whether it stays dumpable at a
> later point in time. Besides, seccomp filters are inherited across
> clone and exec, attaching to many tasks with no option to detach. What
> should the load-time check of task dump-ability be against? The
> current task may only be the tip of an iceburg.
>=20
> [1] https://github.com/openssh/openssh-portable/blob/2dc328023f60212cd2950=
4fc05d849133ae47355/ssh-agent.c#L1398
>=20
>=20

First things first: why are you checking dumpable at all?  Once you figure o=
ut why and whether it=E2=80=99s needed, you may learn something about what t=
ask to check.

I don=E2=80=99t think checking dumpable makes any sense.=
