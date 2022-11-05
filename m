Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6734C433FE
	for <linux-security-module@archiver.kernel.org>; Sat,  5 Nov 2022 05:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbiKEFdS (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 5 Nov 2022 01:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKEFdR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 5 Nov 2022 01:33:17 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517FD2528E
        for <linux-security-module@vger.kernel.org>; Fri,  4 Nov 2022 22:33:17 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id v81so7222078oie.5
        for <linux-security-module@vger.kernel.org>; Fri, 04 Nov 2022 22:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aR8uguTZL9jZw1fc4k9+f4P4lDL3duef3vksGnsGPM8=;
        b=3QuVcTOViDa7VYaFrEvGhfLp2EeLO+S894goiEFWJ48lFxh7tOqMJCLsBIFt+QCiI2
         O/Q+HXHxO8gv46E3caRAzqLfr+SsKIupaJIExYN2rH+Qo9q1MkfPu7Hg5PzpjmIH6EYA
         3v/DyMsAFE0A9tkBEQctrrq1SedpxVFPoGAUTP4VP6AOO+w2WNTPraY+CAwSXjduuQTH
         Pqq+thYYc2NGFh/6SvvJzr7vdIf9NaEyBUEtltL3hw2mk5xvjVqvFl9eweY8jdp/2gco
         aXFlAsiXC88o8nyDuOrZ7ZLrJYAlnDTY9qTEPEXa3dF8ByoO89do77XhN2gZX2uf2nNE
         1BrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aR8uguTZL9jZw1fc4k9+f4P4lDL3duef3vksGnsGPM8=;
        b=Q0bZtU+dfSpI708P+qVFlsSU+rbtT8J9iii3wBgUy0cmUBLzOpWwHWkTdCG0YvQ9u/
         79tURUfNuWhMjWR5gCv69b9zxXEIqe8VXkNj/y39KMu7Jc7CpPeIvituDL9ivKwEOpf9
         xNChFQb4XkWboA1hbm7shZUzSrSPIfi/Pc3CVRgSqqB9586dlWBcWErbJWOkKoZDmha9
         AyY8m3maYELxSp3nrS6mSSGvmKprEN0TBD47hL5JLSZMAXxwN9F9s8TZrIDzFNboLLEt
         MkmC2J0+6jAneSR4gVfbzjIDO66A6klBkLgLdUOv0tfsOa/IZUjVhbM5CrUFCPqxRiXc
         3cQw==
X-Gm-Message-State: ACrzQf3QIBRuA+X4FbJMFN6JwwCY8snP6Gr4TLhcZiGRSrV/uN0f3KJw
        wWlklyTvLKXIcscLZWhUlJVvRbzCZniYkjD16Wp2
X-Google-Smtp-Source: AMsMyM4pgf/ihEzbB99QMBcHqY1U1Cv3agmFLtye9H6hkIreZnl053o6x2eFA5PCbr5dqSlXqv3N0Hl9PfOjzzmhpZE=
X-Received: by 2002:a05:6808:1525:b0:35a:57ef:83b0 with SMTP id
 u37-20020a056808152500b0035a57ef83b0mr174498oiw.172.1667626396707; Fri, 04
 Nov 2022 22:33:16 -0700 (PDT)
MIME-Version: 1.0
References: <20221031112536.4177761-1-cuigaosheng1@huawei.com>
 <CALQRfL4Ws255bv_ptCt1qS3cbxjwUsawxAuTyV1pnLwg+70_NQ@mail.gmail.com>
 <20221101043023.GA7631@mail.hallyn.com> <CAHC9VhSMFgifrUdMvogne+DC+gx_B9dW5mGsNZ8vstHpUsupOQ@mail.gmail.com>
 <20221103132434.GA30946@mail.hallyn.com>
In-Reply-To: <20221103132434.GA30946@mail.hallyn.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sat, 5 Nov 2022 01:33:05 -0400
Message-ID: <CAHC9VhS4-e-OphfCyaSmRDRA0_3t+ZjtdOStNeddJ5xRaD1E7g@mail.gmail.com>
Subject: Re: [PATCH] capabilities: fix undefined behavior in bit shift for CAP_TO_MASK
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     "Andrew G. Morgan" <morgan@kernel.org>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        akpm@linux-foundation.org, ezk@cs.sunysb.edu,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Nov 3, 2022 at 9:24 AM Serge E. Hallyn <serge@hallyn.com> wrote:
> Ok, thanks.
>
> I wouldn't mind putting up a capability tree if number of patches were
> going to start ramping up, but historically that has not been worth it.

Don't ever let me stop you from setting up a capability tree, but
yeah, I understand why it probably wouldn't be very useful.  As long
as you keep doing the reviews, ACKs, etc. I don't mind carrying the
capability patches in the LSM tree; merging stuff is usually the easy
part of the job.

-- 
paul-moore.com
