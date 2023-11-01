Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A109C4167B
	for <linux-security-module@archiver.kernel.org>; Wed,  1 Nov 2023 21:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344907AbjKAVY3 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 1 Nov 2023 17:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343876AbjKAVY3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 1 Nov 2023 17:24:29 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A275A111
        for <linux-security-module@vger.kernel.org>; Wed,  1 Nov 2023 14:24:23 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-d9a518d66a1so259479276.0
        for <linux-security-module@vger.kernel.org>; Wed, 01 Nov 2023 14:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1698873862; x=1699478662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7oIjKKXU3vKXWkTgvEG3gpUXCjmHHGsAvQcTo6R0FD0=;
        b=R4xnOPLKaI+tCa64q+2horpDURT1wpeZRQ54SBRSYpKIgu9H45SXqyD4ZsE3ah7YCO
         LF8zXCkvhQn3Sj9srqiuRc6MlutfsGBvy0BndhWE8kcq+FdUCelRao3vm1htyAMj5EUb
         as1zH1LqRv8ISPJRMq1wABBYijzisHyP2VumIuk/pXlAvE2VB078T1cSfN4J8/7bxX77
         RAR3pe6Xd8HsemWuBLBmu0BxFvukO3SFdfNV4Bw7v+942BIYUyAfmFVNL7jvf1J+PkLD
         lisTuM4LQ2/3gu9MU93xOuWYgbpj1+0EMS8Jx41UnDbN/u9AmIlQqt0CckBF6D6L8W/R
         oHug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698873862; x=1699478662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7oIjKKXU3vKXWkTgvEG3gpUXCjmHHGsAvQcTo6R0FD0=;
        b=uEinQjsuRl9SrJ+L6pkH5WRb+DpMkaGlmNDuvD5Jo7ruPTuGUYeJw4xAZ+YKpPZJoi
         endADHNf2GsjWBdnqC6E6L0WWT2NI/B/Q7xxpZzt88QLZeRlJWSKIErGndDFVeWxeVXL
         hK3bF9CVCCSHUJWvTUee6eJimoOFMHYcKHWuTtT2Wq9+oJzmwzSo795WkEbCPEpPMKCV
         4qahy06cFrvRT8m/V0hrb7BpTJijn4JDWcdj/t+X1y6zqPnbPf4waCpxQx+7uUGcx3TM
         VJ3MigvmsrMNKZ1s8I/ptv0RK3Oh9Z1+bAeKdZaJotgfPTP9GPLCuYJPR9V7a4gJBiHP
         ld9Q==
X-Gm-Message-State: AOJu0Ywf45oELLAn+OzfL6ygIkHa3WEwtE+aYK3vi4Fund2DWawMMwV5
        Nzpsjh38TZPQ/q2RDwebQ6pxq9FFzsSNc942VxcTE6g0Fu/LDu0=
X-Google-Smtp-Source: AGHT+IEYC1MlxdLGHjJNLDqyo1bzzCzULZ6Kl2GwcjozA5pyWzWeAXQBtfeMCcOEcKrjU2nrz1slFTfWYMCaTn43cKw=
X-Received: by 2002:a25:7311:0:b0:d9a:d16f:dddf with SMTP id
 o17-20020a257311000000b00d9ad16fdddfmr14303709ybc.24.1698873862473; Wed, 01
 Nov 2023 14:24:22 -0700 (PDT)
MIME-Version: 1.0
References: <20231024213525.361332-4-paul@paul-moore.com>
In-Reply-To: <20231024213525.361332-4-paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 1 Nov 2023 17:24:11 -0400
Message-ID: <CAHC9VhQwwqji4m3mXLVzy6cY8G5ObbH3pv+AgsunQypi84cX1w@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] LSM syscall tweaks
To:     linux-security-module@vger.kernel.org
Cc:     selinux@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Oct 24, 2023 at 5:39=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> Three rather small LSM patches to address some minor issues found during
> the review of the latest LSM syscall patchset that now lives in the
> lsm/next-queue tree.
>
> I'm marking these as RFC patches as they have yet to be properly tested,
> but I'm building a kernel now to do that and I'll report back when testin=
g
> has completed.  In the meantime, reviews and ACKs are appreciated.

I went ahead and merged these into lsm/dev-staging and rebased the
branch on Linus' latest to incorporate the syscall additions in his
tree.  As the merge window is open, I did not do the corresponding
update to the lsm/next branch, that will be updated when the merge
window is closed and -rc1 is released.

--=20
paul-moore.com
