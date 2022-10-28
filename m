Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4970EECAAA1
	for <linux-security-module@archiver.kernel.org>; Fri, 28 Oct 2022 10:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbiJ1KlD (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 28 Oct 2022 06:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbiJ1Kkc (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 28 Oct 2022 06:40:32 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B9957567
        for <linux-security-module@vger.kernel.org>; Fri, 28 Oct 2022 03:40:27 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-12c8312131fso5835026fac.4
        for <linux-security-module@vger.kernel.org>; Fri, 28 Oct 2022 03:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tyImlhW5U/w4r3CMUcSsRxgN2Bc9Db0y6N98q/2n1E0=;
        b=6wl2xAI8Kw/bybkWUSqlJIkmtYMiO4vD8mzAOrtLGcat04/Lbo+hGTkyu7kEq2Vc7B
         ZEuWK/Q8Vr/gceFj85auLDbm9HdgImFszZUfz1pHT+caIJAEplOxJgekjZVmPm34tS1d
         P2Y/qZ1tNywM4IezQYvWpRkZQEqdveIFqYi/IMGB997KzqqfGl1DB7+Ewn8FwVuonimt
         Xk0P/XZVX2l+ZyLi1uB6qhKhyQAS/8zrluRwRq5IR38ZGf10cszvxPmDQA4YWzB4hp3k
         rKcTycSPuAtizgAjzym08hOwvsUXIjsiAKExxUD3eWc5FKh+4K5HBnJ9yR93K5j6RApi
         Z8rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tyImlhW5U/w4r3CMUcSsRxgN2Bc9Db0y6N98q/2n1E0=;
        b=i+388rtTHT3KFFbX95qScg2DS6JGVUZ/rlADbyVv5nBGd5aZqpcTPVHCcwDLQkdTum
         cco2LVWQ2bI9+qZ2lHy/CUTRfitrj11obcwpLqVHI57q3wG8cCMqB6eM0bVpSHDvUVmK
         agFR4r19vf+qW+kSv02x8vlw8pUyiynco6CAQD8SbGK9k+G2zajDIrfMyFA4HK4KMJno
         hImSOpxzSu54RZmNoejF0vXkM5dxvFuEesHw0IqXsPES3ioIOsBF8/3kDjMP08+ZZffv
         tjlqhPk9E3v0ociAz1SqEXEx/SzYP5n2rZqgjDsS9pkXTiWsF5xULo2hJRRVDQZry3nb
         SJFA==
X-Gm-Message-State: ACrzQf32OnDUslM97zX00gQdLRnwIetQ9ARjg5/58vTaU0u9J/nZbRgr
        rETUEacfOC1jc0avDodTp55bQOyEyUrpMILILjbNXWw8K+7E
X-Google-Smtp-Source: AMsMyM4ZevGFeBpqW+DJ8S3551bIe2a35cE4Xe2RC2CsugCmZ45K57nKjHHFzt6+kh9nP6Z+ExWMYg0XY8SA8MF3fIw=
X-Received: by 2002:a05:6870:f299:b0:13b:ad21:934d with SMTP id
 u25-20020a056870f29900b0013bad21934dmr8665556oap.172.1666953626712; Fri, 28
 Oct 2022 03:40:26 -0700 (PDT)
MIME-Version: 1.0
References: <20221026010634.2936-1-liubo03@inspur.com>
In-Reply-To: <20221026010634.2936-1-liubo03@inspur.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 28 Oct 2022 06:40:15 -0400
Message-ID: <CAHC9VhT7-tHw=Pn-Ha=6T2X8E4U3wjxDOGFKcJAS2zx7XP-Wrg@mail.gmail.com>
Subject: Re: [PATCH v2] audit: Fix some kernel-doc warnings
To:     Bo Liu <liubo03@inspur.com>
Cc:     jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Oct 25, 2022 at 9:06 PM Bo Liu <liubo03@inspur.com> wrote:
>
> The current code provokes some kernel-doc warnings:
>     security/lsm_audit.c:198: warning: Function parameter or member 'ab' not described in 'dump_common_audit_data'
>
> Signed-off-by: Bo Liu <liubo03@inspur.com>
> ---
>  security/lsm_audit.c | 1 +
>  1 file changed, 1 insertion(+)

Merged into lsm/next, thanks.

-- 
paul-moore.com
