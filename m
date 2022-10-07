Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 503E4C4332F
	for <linux-security-module@archiver.kernel.org>; Fri,  7 Oct 2022 17:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiJGRn3 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 7 Oct 2022 13:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiJGRn2 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 7 Oct 2022 13:43:28 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6E0D8EFA
        for <linux-security-module@vger.kernel.org>; Fri,  7 Oct 2022 10:43:26 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id t79so6360728oie.0
        for <linux-security-module@vger.kernel.org>; Fri, 07 Oct 2022 10:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=//pU+B4CdEHUXnP14JIGltVIuBGKM3zOSsugyiB6BLI=;
        b=aHQGkwWBLhml96bIzFmZ3ubLuJK0cbQjbPIxDHZsY02++EcR84DjhhKisldOYgGml+
         Q2wVg57JqSSM6P7+cEzqN+jfWdRlJ/XgWZy267JqBPKYOOkZjRLq0wxB4sa4fG5W6S9J
         Ycd6grWzP00JbXR9jtKiQBt5JnIiX8C+RUOkWEQdL6j6F8ALGJGPR/xzjfBLDuxwmWb2
         PZ9wjCGHYt2mde+t/P5gagAOoT+bgKHyNOL9FGpuNik3o3hNDti/HlufPjG6KrRUedtD
         LAfzXCoEXyjHUkCHMNeMjbZ4gEnup9ob88tgcBXlhDVmbUlH9oTbB787lf130onzR2E3
         gCuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=//pU+B4CdEHUXnP14JIGltVIuBGKM3zOSsugyiB6BLI=;
        b=mVQq9JtJDiN21CppjmRTigX51vXp+8xRyee8efs5Np722SoWqU9xgSNWnrUYXNOly9
         fw3ij20F0RjPUPP8UNAsSjHhe+Lv3yX7wcXPa1m4xaMPVGT36YK4uoKeLX1uQz3onEDO
         1ZNQpyWjjcmPCW/7pf+7wcYTZ0pE1meB/dL1b9ddXicoV723fRMEwyVnjWrhi++aFbpb
         kXpwheofDRcDlB+0fAMaCzLaWE5u3TJYiRuSAZXAOQjxtsDPdXyCiEU7QdqIR4n61ygo
         2HNpUtQbsBJspE1d4to1bJcPQC5pXq2fqQ/TJBiKBQ4rBq+WBS8kF0ptfoY+aGXikm23
         ts7Q==
X-Gm-Message-State: ACrzQf2TYze6+2SN0nDfn4O/jNp/EUmGTM9zurOsvN7UlOOYZtGslRzM
        rc2gVOZcGpzoezPZrS5z5e8n8e6eFCXkv52XpZi6
X-Google-Smtp-Source: AMsMyM7RUzL2i9yHohtKY32yxs0duk7SA4vdOvoa1QxpjpNPWjJAIUwj3y8/0uSe2v0sVmSE5cLeJzawMX66Y6K/7rI=
X-Received: by 2002:a05:6808:218d:b0:354:b8c:f47f with SMTP id
 be13-20020a056808218d00b003540b8cf47fmr3248241oib.172.1665164605928; Fri, 07
 Oct 2022 10:43:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhTGE1cf_WtDn4aDUY=E-m--4iZXWiNTwPZrP9AVoq17cw@mail.gmail.com>
In-Reply-To: <CAHC9VhTGE1cf_WtDn4aDUY=E-m--4iZXWiNTwPZrP9AVoq17cw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 7 Oct 2022 13:43:15 -0400
Message-ID: <CAHC9VhT2LK_P+_LuBYDEHnkNkAX6fhNArN_N5bF1qwGed+Kyww@mail.gmail.com>
Subject: Re: SO_PEERSEC protections in sk_getsockopt()?
To:     Martin KaFai Lau <martin.lau@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Oct 5, 2022 at 4:44 PM Paul Moore <paul@paul-moore.com> wrote:
>
> Hi Martin,
>
> In commit 4ff09db1b79b ("bpf: net: Change sk_getsockopt() to take the
> sockptr_t argument") I see you wrapped the getsockopt value/len
> pointers with sockptr_t and in the SO_PEERSEC case you pass the
> sockptr_t:user field to avoid having to update the LSM hook and
> implementations.  I think that's fine, especially as you note that
> eBPF does not support fetching the SO_PEERSEC information, but I think
> it would be good to harden this case to prevent someone from calling
> sk_getsockopt(SO_PEERSEC) with kernel pointers.  What do you think of
> something like this?
>
>   static int sk_getsockopt(...)
>   {
>     /* ... */
>     case SO_PEERSEC:
>       if (optval.is_kernel || optlen.is_kernel)
>         return -EINVAL;
>       return security_socket_getpeersec_stream(...);
>     /* ... */
>   }

Any thoughts on this Martin, Alexei?  It would be nice to see this
fixed soon ...

-- 
paul-moore.com
