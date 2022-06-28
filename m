Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CA4C433EF
	for <linux-security-module@archiver.kernel.org>; Tue, 28 Jun 2022 15:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347969AbiF1POe (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 28 Jun 2022 11:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347957AbiF1POd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 28 Jun 2022 11:14:33 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946162DA9A
        for <linux-security-module@vger.kernel.org>; Tue, 28 Jun 2022 08:14:32 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1048b8a38bbso17418133fac.12
        for <linux-security-module@vger.kernel.org>; Tue, 28 Jun 2022 08:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=j8onA5YycLKvgtR2+Db5ek4DglhDGyf/OLtfUjKRawU=;
        b=u6WOgNzk0OTDG+9CtSE/K6ru5P4/825Mxogdf7Dswt+4t/A0V9RTEQu1NpcqxbuOa3
         B4hqvjDfLFtBTP9KYVkOi3g7QlsZKUQzgD92kVESgJJxK+jXkXcvybUWXvwj/VmqoDIl
         5xxDbbSUpmnkaQOKd5z4WWRNePbFeh98woYL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=j8onA5YycLKvgtR2+Db5ek4DglhDGyf/OLtfUjKRawU=;
        b=Tgh5RBMM2baEIw1NERRUrDCyysXhvxZFN6WIOP2vHeh4MCfma9xhnl9m0aXuCM0lKF
         ZiCVvQhOZDNJb1KfDNd83/hfOO/cKUheaQb5NhS8iV9a6Ck6INhOYY06AeuVhijhOPKT
         M7ICbAGIkZomvL7+6C042IO/+mJYQP7H0vZoAWU6mq8B6xoEIWg9Px7cXtD83RJSymaU
         6VomSm814VcnbM8GJbOv/lDO6jZ1t0rsQpt0c0H1YjwUsSjkVsfYcDFeMvwZq54TIbzp
         GXjKfkf3LiIoENnIAb0PIPxjaDK8y1Ow6039+yvf7HccyhNJ8yr+TSgELLleuK+duzrY
         OKvQ==
X-Gm-Message-State: AJIora9T3YftsLhW/pCtz6RauD557oqhNk6IXS/amqsL6mJputn251mF
        tkENmK9QsFFoO3eli8OjnUzVSw==
X-Google-Smtp-Source: AGRyM1uLW59VDfTdcT1rmoKGVRJWZs1FpMlfYJhdMO+WliY5H3oO1o0ddfaCifkp3pHZhBu467hUdQ==
X-Received: by 2002:a05:6870:8195:b0:101:9342:bf1a with SMTP id k21-20020a056870819500b001019342bf1amr37752oae.149.1656429271809;
        Tue, 28 Jun 2022 08:14:31 -0700 (PDT)
Received: from [192.168.0.41] ([184.4.90.121])
        by smtp.gmail.com with ESMTPSA id x18-20020a056830409200b0060aeccf6b44sm8167298ott.41.2022.06.28.08.14.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 08:14:31 -0700 (PDT)
Message-ID: <9ae473c4-cd42-bb45-bce2-8aa2e4784a43@cloudflare.com>
Date:   Tue, 28 Jun 2022 10:14:29 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 0/2] Introduce security_create_user_ns()
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Christian Brauner <brauner@kernel.org>, kpsingh@kernel.org,
        revest@chromium.org, jackmanb@chromium.org, ast@kernel.org,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, jmorris@namei.org, serge@hallyn.com,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com
References: <20220621233939.993579-1-fred@cloudflare.com>
 <ce1653b1-feb0-1a99-0e97-8dfb289eeb79@schaufler-ca.com>
 <b72c889a-4a50-3330-baae-3bbf065e7187@cloudflare.com>
 <CAHC9VhSTkEMT90Tk+=iTyp3npWEm+3imrkFVX2qb=XsOPp9F=A@mail.gmail.com>
 <20220627121137.cnmctlxxtcgzwrws@wittgenstein>
 <CAHC9VhSQH9tE-NgU6Q-GLqSy7R6FVjSbp4Tc4gVTbjZCqAWy5Q@mail.gmail.com>
 <6a8fba0a-c9c9-61ba-793a-c2e0c2924f88@iogearbox.net>
 <CAHC9VhQQJH95jTWMOGDB4deS=whSfnaF_e73zoabOOeHJMv+0Q@mail.gmail.com>
 <685096bb-af0a-08c0-491a-e176ac009e85@schaufler-ca.com>
From:   Frederick Lawler <fred@cloudflare.com>
In-Reply-To: <685096bb-af0a-08c0-491a-e176ac009e85@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 6/27/22 6:18 PM, Casey Schaufler wrote:
> On 6/27/2022 3:27 PM, Paul Moore wrote:
>> On Mon, Jun 27, 2022 at 6:15 PM Daniel Borkmann <daniel@iogearbox.net> 
>> wrote:
>>> On 6/27/22 11:56 PM, Paul Moore wrote:
>>>> On Mon, Jun 27, 2022 at 8:11 AM Christian Brauner 
>>>> <brauner@kernel.org> wrote:
>>>>> On Thu, Jun 23, 2022 at 11:21:37PM -0400, Paul Moore wrote:
>>>> ...
>>>>
>>>>>> This is one of the reasons why I usually like to see at least one LSM
>>>>>> implementation to go along with every new/modified hook.  The
>>>>>> implementation forces you to think about what information is 
>>>>>> necessary
>>>>>> to perform a basic access control decision; sometimes it isn't always
>>>>>> obvious until you have to write the access control :)
>>>>> I spoke to Frederick at length during LSS and as I've been given to
>>>>> understand there's a eBPF program that would immediately use this new
>>>>> hook. Now I don't want to get into the whole "Is the eBPF LSM hook
>>>>> infrastructure an LSM" but I think we can let this count as a 
>>>>> legitimate
>>>>> first user of this hook/code.
>>>> Yes, for the most part I don't really worry about the "is a BPF LSM a
>>>> LSM?" question, it's generally not important for most discussions.
>>>> However, there is an issue unique to the BPF LSMs which I think is
>>>> relevant here: there is no hook implementation code living under
>>>> security/.  While I talked about a hook implementation being helpful
>>>> to verify the hook prototype, it is also helpful in providing an
>>>> in-tree example for other LSMs; unfortunately we don't get that same
>>>> example value when the initial hook implementation is a BPF LSM.
>>> I would argue that such a patch series must come together with a BPF
>>> selftest which then i) contains an in-tree usage example, ii) adds BPF
>>> CI test coverage. Shipping with a BPF selftest at least would be the
>>> usual expectation.
>> I'm not going to disagree with that, I generally require matching
>> tests for new SELinux kernel code, but I was careful to mention code
>> under 'security/' and not necessarily just a test implementation :)  I
>> don't want to get into a big discussion about it, but I think having a
>> working implementation somewhere under 'security/' is more
>> discoverable for most LSM folks.
> 
> I agree. It would be unfortunate if we added a hook explicitly for eBPF
> only to discover that the proposed user needs something different. The
> LSM community should have a chance to review the code before committing
> to all the maintenance required in supporting it.
> 
> Is there a reference on how to write an eBPF security module?

There's a documentation page that briefly touches on a BPF LSM 
implementation [1].

> There should be something out there warning the eBPF programmer of the
> implications of providing a secid_to_secctx hook for starters.
> 

Links:
1. https://docs.kernel.org/bpf/prog_lsm.html?highlight=bpf+lsm#

