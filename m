Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1613EB64D8
	for <linux-security-module@archiver.kernel.org>; Thu, 22 Jun 2023 08:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjFVIXv (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 22 Jun 2023 04:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjFVIXu (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 22 Jun 2023 04:23:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7722B1BE6
        for <linux-security-module@vger.kernel.org>; Thu, 22 Jun 2023 01:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687422180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cOdV54lATHdQofNik3EiTT9JXn7/yOoqOYzJfK/2WMg=;
        b=LFq6Z5HhcELIQmFR2PbMwW2FPmQFwdjQCYC7aA2Zt2p8lvjxXrr87+2byD3+xhLNtswfDA
        xTjoaevdPFzlwrVzCkj8/9K8qe34AVYBhvJ8nZOtx59qlYrpduP0fXbPGRQVJDyEB2rQDM
        4MuM4QHQaiegrKkpCOPg+HXwIwkRZnY=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-efxUL-FWO3KW66dkA7OJrA-1; Thu, 22 Jun 2023 04:22:58 -0400
X-MC-Unique: efxUL-FWO3KW66dkA7OJrA-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b479d12b31so38768391fa.3
        for <linux-security-module@vger.kernel.org>; Thu, 22 Jun 2023 01:22:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687422177; x=1690014177;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cOdV54lATHdQofNik3EiTT9JXn7/yOoqOYzJfK/2WMg=;
        b=a8+F5aasPQrLru+Qgjd4gId4G5EBklzL5ot4wXY8Ai5dWgXbri4/7sTVehXvx2BiEm
         QHNxz4NEPnwmE2RsTnSkt+wRBehTP47p+YD7J8GH7UJjKvNwZ6oAfWdnlZ0oiHvRO7JE
         xwJFcXIW9rR3BjEIr+aWSWZkCsBzy26LVHExLGdjyAbe+tdUI1R8gF6D5K98hYHp10s8
         rN6e5DGjSWTHVzZYkIFIvj0PDpW0bU6bNKq90wu0DRjVl3O0oMYveP1hU1uPGGR6kKwJ
         sCSbwipaiOMocquePBg14llWt4HFLlXvjTmSf5SAHo0Aki4w7q4ATNoCFIk5V4vfAE+x
         vSlg==
X-Gm-Message-State: AC+VfDyZ3T6dWfczKOorOkOPGl2gFqw9w4+5opgSRRkBvlnHh4Xups+Q
        33GaGY/RSrbke0DVnrK3EQwjSeY4oGT+R683Ub3IBzcN5bYdGf6jaWMDWA47sblQl79dX11XKE3
        X5H34tf0E1evX+8OSN3fxfUipYZmrkhaHOylg
X-Received: by 2002:a2e:9e1a:0:b0:2b4:6994:4758 with SMTP id e26-20020a2e9e1a000000b002b469944758mr7793316ljk.49.1687422177190;
        Thu, 22 Jun 2023 01:22:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6kL9nO6pSEzVdwiJ9K31Wh1ZkYByiwgzdl6D/jER5AVvmXPVS2TihUDhRl1icluMBU6YPxow==
X-Received: by 2002:a2e:9e1a:0:b0:2b4:6994:4758 with SMTP id e26-20020a2e9e1a000000b002b469944758mr7793302ljk.49.1687422176807;
        Thu, 22 Jun 2023 01:22:56 -0700 (PDT)
Received: from [192.168.0.12] ([78.18.22.70])
        by smtp.gmail.com with ESMTPSA id z7-20020a7bc7c7000000b003f90067880esm15439072wmk.47.2023.06.22.01.22.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 01:22:56 -0700 (PDT)
Message-ID: <5eb4264e-d491-a7a2-93c7-928b06ce264d@redhat.com>
Date:   Thu, 22 Jun 2023 09:22:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 bpf-next 00/18] BPF token
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <brauner@kernel.org>, lennart@poettering.net,
        cyphar@cyphar.com, kernel-team@meta.com
References: <20230607235352.1723243-1-andrii@kernel.org>
 <c1a8d5e8-023b-4ef9-86b3-bdd70efe1340@app.fastmail.com>
 <CAEf4BzazbMqAh_Nj_geKNLshxT+4NXOCd-LkZ+sRKsbZAJ1tUw@mail.gmail.com>
 <a73da819-b334-448c-8e5c-50d9f7c28b8f@app.fastmail.com>
 <CAEf4Bzb__Cmf5us1Dy6zTkbn2O+3GdJQ=khOZ0Ui41tkoE7S0Q@mail.gmail.com>
From:   Maryam Tahhan <mtahhan@redhat.com>
In-Reply-To: <CAEf4Bzb__Cmf5us1Dy6zTkbn2O+3GdJQ=khOZ0Ui41tkoE7S0Q@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 22/06/2023 00:48, Andrii Nakryiko wrote:
>
>>>> Giving a way to enable BPF in a container is only a small part of the overall task -- making BPF behave sensibly in that container seems like it should also be necessary.
>>> BPF is still a privileged thing. You can't just say that any
>>> unprivileged application should be able to use BPF. That's why BPF
>>> token is about trusting unpriv application in a controlled environment
>>> (production) to not do something crazy. It can be enforced further
>>> through LSM usage, but in a lot of cases, when dealing with internal
>>> production applications it's enough to have a proper application
>>> design and rely on code review process to avoid any negative effects.
>> We really shouldn’t be creating new kinds of privileged containers that do uncontained things.
>>
>> If you actually want to go this route, I think you would do much better to introduce a way for a container manager to usefully proxy BPF on behalf of the container.
> Please see Hao's reply ([0]) about his and Google's (not so rosy)
> experiences with building and using such BPF proxy. We (Meta)
> internally didn't go this route at all and strongly prefer not to.
> There are lots of downsides and complications to having a BPF proxy.
> In the end, this is just shuffling around where the decision about
> trusting a given application with BPF access is being made. BPF proxy
> adds lots of unnecessary logistical, operational, and development
> complexity, but doesn't magically make anything safer.
>
>    [0] https://lore.kernel.org/bpf/CA+khW7h95RpurRL8qmKdSJQEXNYuqSWnP16o-uRZ9G0KqCfM4Q@mail.gmail.com/
>
Apologies for being blunt, but  the token approach to me seems to be a 
work around providing the right level/classification for a pod/container 
in order to say you support unprivileged containers using eBPF. I think 
if your container needs to do privileged things it should have and be 
classified with the right permissions (privileges) to do what it needs 
to do.

The  proxy BPF on behalf of the container approach works for containers 
that don't need to do privileged BPF operations.

I have to say that  the `proxy BPF on behalf of the container` meets the 
needs of unprivileged pods and at the same time giving CAP_BPF to the 
applications meets the needs of these PODs that need to do 
privileged/bpf things without any tokens. Ultimately you are trusting 
these apps in the same way as if you were granting a token.


>>> So privileged daemon (container manager) will be configured with the
>>> knowledge of which services/containers are allowed to use BPF, and
>>> will grant BPF token only to those that were explicitly allowlisted.


