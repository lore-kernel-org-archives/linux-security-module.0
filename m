Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3410BC4167B
	for <linux-security-module@archiver.kernel.org>; Fri,  9 Dec 2022 17:41:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiLIRlv (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 9 Dec 2022 12:41:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiLIRls (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 9 Dec 2022 12:41:48 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDB18C6AE
        for <linux-security-module@vger.kernel.org>; Fri,  9 Dec 2022 09:41:44 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so5670583pjj.4
        for <linux-security-module@vger.kernel.org>; Fri, 09 Dec 2022 09:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZFm1mHWqGIzhe+rb1eJUuw0XvgXopgBYaEtqlXPVfz0=;
        b=hKQY4J/pRm6CWAMtVWIamF1UR1S5ytG4Q0dHLvMKrbYlyUycxPoWBv9Nvh4aE85080
         MWzlNOjWwFO925vt2GUNcS/9BsF/orNKSvNrMiJHpxpXZP/fsRzj2P95wFaUt+bI8jC4
         HKRo33TkZwcuRzKPFMZ/Et6g/CaKhLpD6XEakiYyIPyXFiTK9hpXRej8x43ZakzvAdnu
         cc2uWLlT8LDekFoJ0DodzV9KIG5fEqwrWeJJE5FFSWTew4hhwEfHkkmQuMbzZJ1BkUaR
         /AoTD8PntICNQW80RuAfzK6ZOG6OUwhJeXxnL+Z8dW9hRID7YD/0yMk+1SSU/RwDz4Iv
         IAeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZFm1mHWqGIzhe+rb1eJUuw0XvgXopgBYaEtqlXPVfz0=;
        b=TIBZz8BPt6Scj4o0plhACqEgG7maz5DZE4k6nR1Av2yazUbjSBzpZVmjxb+pBpO9CG
         qlmz7r+LehV+CWuOCS2b8SldnTKi7xiyGnMnqmJYWI/8WogleqdmWsNA0qk4URF6buO9
         /JQ/TP/oJp7ae4YQyIUBG81vJaAVJWGEAaJee/z/e3TH3l9S4pJGCTjtnpx/lWNUvL80
         TrPlENXPg/qmEdL/IyKRiKsXKj+Yxaiwe8LUOZ2Ts/Xp0GCGiCSdFrwlnoXeMiBl/WAZ
         EPo/hQVXFQLS1iL0FvhGoEBzm90KRq+D4c/E/JGDGB8tjBS8DSTuTj+2HbVMlHk3zW0g
         7BFQ==
X-Gm-Message-State: ANoB5pnuAiJPeRYtkDoIHnQnufoYcVfw7FlCiLKi35yqCwr5fJthaTHv
        15fBOCPfdn26pLhERlRTdJ5O9yK70DuwRu9rAVR7
X-Google-Smtp-Source: AA0mqf42Th/ALMFAQak9uQXYbmo+LSPCJ2qrOZQ93/pWBADQWGsh/kyFsqjnomlO+PB/OJ41SRslxU9sOKyJx0wF70I=
X-Received: by 2002:a17:90b:2743:b0:20d:4173:faf9 with SMTP id
 qi3-20020a17090b274300b0020d4173faf9mr108635116pjb.147.1670607703640; Fri, 09
 Dec 2022 09:41:43 -0800 (PST)
MIME-Version: 1.0
References: <20221209082936.892416-1-roberto.sassu@huaweicloud.com> <20221209082936.892416-2-roberto.sassu@huaweicloud.com>
In-Reply-To: <20221209082936.892416-2-roberto.sassu@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 9 Dec 2022 12:41:32 -0500
Message-ID: <CAHC9VhSz6b9AcpKzAn2Lz_9SW0yNqiQ0Ub8fXytFy7sSBmXipQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] doc: Fix fs_context_parse_param description in mount_api.rst
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     corbet@lwn.net, casey@schaufler-ca.com, omosnace@redhat.com,
        john.johansen@canonical.com, kpsingh@kernel.org,
        bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Dec 9, 2022 at 3:30 AM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Align with the description of fs_context_parse_param in lsm_hooks.h, which
> seems the right one according to the code.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  Documentation/filesystems/mount_api.rst | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

I'm going to leave this patch as a "hold" for right now.  The existing
text is arguably not great, but I'm not really in love with the
replacement text taken from the LSM hook comments; given the merge
window opens in a couple of days, we don't have much time to fiddle
with the wording so let's just hold this for a little bit.

These comment corrections (which are very welcome!) have also reminded
me that we really should move the hook comment blocks out of the
header file and into security.c like every other kernel function.
This should help increase their discoverability while also making it
easier to maintain the comments over time.  I'm going to post a first
pass at this as soon as the merge window closes, and once that is done
we can do further work to cleanup the descriptions and add more detail
(including notes both for the other kernel subsystems that call the
hooks and the LSM devs who provide implementations).

-- 
paul-moore.com
