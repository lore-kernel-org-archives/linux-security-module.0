Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F06C43334
	for <linux-security-module@archiver.kernel.org>; Tue, 28 Jun 2022 15:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345863AbiF1PMH (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 28 Jun 2022 11:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347608AbiF1PME (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 28 Jun 2022 11:12:04 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4508C2CC89
        for <linux-security-module@vger.kernel.org>; Tue, 28 Jun 2022 08:11:58 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id r82so8898446oig.2
        for <linux-security-module@vger.kernel.org>; Tue, 28 Jun 2022 08:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=r3T/Vv9JYSOoPod+m53QhPFgDxt80YZRfCW/0xTpL5E=;
        b=BBUiogqF5aD42O+to2up8XXG99jnen4vcvT4q3uQtZWs7+5mzSEKSYODAdtIflRbLE
         IPFqk4z92H9szCzlWLxTFzC+B3jy/j1V0h6mT51YkeeSnTTnN4sVfQJRfOFkpq2E1/u3
         etXfIGWfuoS2l3wqhkFH0Jw1FohRaZbf9LZsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=r3T/Vv9JYSOoPod+m53QhPFgDxt80YZRfCW/0xTpL5E=;
        b=xvCnT0QYJE+JAaDstfVI4ZuFHtymwwre5CmrFP3S5c4ulHcijwHQ72B6ThjtyBPHhT
         H7q/2w+yqToKnlHOU4f3Yp1kXrXBFH2KfZ+hG9SV244zjUWmAvC37T2lehAWkAjCHy30
         kUKmgk6LNEmKKDhVeNIHYLxviJQu1INwxJ7h4hENEUKHqDgVx9NZg1rcnCBlY1wjZTXo
         ToFjeLMpLZ7VYn1Y+Mz7Wm7Hp4+JpOecXhbR1l/npt+kTaQDiKOHSbOw4oYkHyG11V0m
         3MWNoRmWzAJpVzcY/Tm1ryTfKruFrRNO1YAM7CymxHjJy/aOtEyZgVscdfcGlVjFFozd
         DUhg==
X-Gm-Message-State: AJIora8eng+w4PwkGOFtCdUm77M+qQXalBH3L3ZAT+G1VxSa6wytdl9D
        187vonWx9e/xhfVdFKTuzDSuIg==
X-Google-Smtp-Source: AGRyM1tODMgw6IwHCo3Y/vl7DX4YsQjJs6rmWSkZYVGx9VjVR30VT0v1uSVo/UfRSgUjW8RYxxJ21g==
X-Received: by 2002:a05:6808:9b9:b0:335:7039:8756 with SMTP id e25-20020a05680809b900b0033570398756mr65082oig.212.1656429117444;
        Tue, 28 Jun 2022 08:11:57 -0700 (PDT)
Received: from [192.168.0.41] ([184.4.90.121])
        by smtp.gmail.com with ESMTPSA id w12-20020a056870a2cc00b000f33624baa4sm9103814oak.18.2022.06.28.08.11.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 08:11:56 -0700 (PDT)
Message-ID: <edc5164b-8e02-2588-1c5b-d917049f666a@cloudflare.com>
Date:   Tue, 28 Jun 2022 10:11:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 0/2] Introduce security_create_user_ns()
Content-Language: en-US
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Paul Moore <paul@paul-moore.com>,
        Christian Brauner <brauner@kernel.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>, kpsingh@kernel.org,
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
From:   Frederick Lawler <fred@cloudflare.com>
In-Reply-To: <6a8fba0a-c9c9-61ba-793a-c2e0c2924f88@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 6/27/22 5:15 PM, Daniel Borkmann wrote:
> On 6/27/22 11:56 PM, Paul Moore wrote:
>> On Mon, Jun 27, 2022 at 8:11 AM Christian Brauner <brauner@kernel.org> 
>> wrote:
>>> On Thu, Jun 23, 2022 at 11:21:37PM -0400, Paul Moore wrote:
>>
>> ...
>>
>>>> This is one of the reasons why I usually like to see at least one LSM
>>>> implementation to go along with every new/modified hook.  The
>>>> implementation forces you to think about what information is necessary
>>>> to perform a basic access control decision; sometimes it isn't always
>>>> obvious until you have to write the access control :)
>>>
>>> I spoke to Frederick at length during LSS and as I've been given to
>>> understand there's a eBPF program that would immediately use this new
>>> hook. Now I don't want to get into the whole "Is the eBPF LSM hook
>>> infrastructure an LSM" but I think we can let this count as a legitimate
>>> first user of this hook/code.
>>
>> Yes, for the most part I don't really worry about the "is a BPF LSM a
>> LSM?" question, it's generally not important for most discussions.
>> However, there is an issue unique to the BPF LSMs which I think is
>> relevant here: there is no hook implementation code living under
>> security/.  While I talked about a hook implementation being helpful
>> to verify the hook prototype, it is also helpful in providing an
>> in-tree example for other LSMs; unfortunately we don't get that same
>> example value when the initial hook implementation is a BPF LSM.
> 
> I would argue that such a patch series must come together with a BPF
> selftest which then i) contains an in-tree usage example, ii) adds BPF
> CI test coverage. Shipping with a BPF selftest at least would be the
> usual expectation.

Sounds good. I'll add both a eBPF selftest and SELinux implementation 
for v2.

> 
> Thanks,
> Daniel

