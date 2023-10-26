Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADE0C25B67
	for <linux-security-module@archiver.kernel.org>; Thu, 26 Oct 2023 16:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjJZQgT (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 26 Oct 2023 12:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbjJZQgP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 26 Oct 2023 12:36:15 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C801AA
        for <linux-security-module@vger.kernel.org>; Thu, 26 Oct 2023 09:36:13 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-586753b0ab0so611891eaf.0
        for <linux-security-module@vger.kernel.org>; Thu, 26 Oct 2023 09:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1698338172; x=1698942972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pxwXYwMyt0FwHK5OUsvzf3Vr4fO6GxIghkhPLs2Amdc=;
        b=WRosmtEcLHBEWAWKLDmdhUvVsCvv9zDOU5tq+JF0npcqgd/7awDpVc4eiqgrP+U1II
         stGbJhLa/8/F3GtxC9rnoirdmjaCPnFTSginSZDP8l+h6TAyh82I93Ey0jaBm+0MxTU0
         M1DaWNU2+CXebhKajiJ+qy682z345RS4VRsn5HqewiMIhHETfnuuBOoOpbEidgdUP4Aj
         8T2YJpUmUe6jLwRgsA+8tcZTMFggzFfzH7kiptC1FOlEB+yIIJbXYSiKF7aobt1oTsOh
         7r/x83aNx+7WLRbN6X3343KlKJe9bHDNnkzD6fvBlZ9m+NohGSbgcir2lDXiBj6c+N3V
         VN6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698338172; x=1698942972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pxwXYwMyt0FwHK5OUsvzf3Vr4fO6GxIghkhPLs2Amdc=;
        b=njrBe7fR0FlJPH6i1+htHHkbtRPj0KAC9UZWOjNSXXhmsCqKaP/7tGXTcPMskK/7ZA
         H9P5nBsYxzgWApH3+cmPIAdcqqJHq9UvJNCvrjKKQPcGWT+QHBpPMbGWdO0jxdGxeJaM
         oLTHPjwnfLicYAK4W976IasWLZsFfU1MMmGrpvyuOgxqKrvRynnekLp3cfKGDW/TUE/x
         E3liJsX+uLVCsKtQhRIqoGsAi41HJXK9jnx12taLm9iffJsXViJKRVjqphMJ3vxDlg1y
         K0E4ibnFvolKu4hFXMh4F/MBLE6cILrltgyNz3vCltnaAvEbls3Rh8mqYcYCg9gjEJUz
         zeJg==
X-Gm-Message-State: AOJu0Yz66u7d1I0zEIwi0De8agELy2of67lqETNIWhvBLZ/Yd/s55xXE
        3bLVaeOQtGfCkQDFxMBJsA+qYZH/gNacwvzsW8X2
X-Google-Smtp-Source: AGHT+IEY3fApkDMaJbueyLpDliFh0pY6UiBcW7rNvFIgWkKAVzTXB5oZvPhkWACAtTHooiKMKO1OlWhVfNclqgBazKw=
X-Received: by 2002:a05:6870:d3cb:b0:1e9:d8a4:5523 with SMTP id
 l11-20020a056870d3cb00b001e9d8a45523mr58414oag.41.1698338172444; Thu, 26 Oct
 2023 09:36:12 -0700 (PDT)
MIME-Version: 1.0
References: <20231026090259.362945-1-roberto.sassu@huaweicloud.com>
 <dd0f6611c7b46f3cecee2b84681c45b1.paul@paul-moore.com> <447298d65b497fb1a7f8d47c4f1a3137eba24511.camel@huaweicloud.com>
 <CAHC9VhSMVpEvLwWvBCgz0EMEb=DG_AZ7fenVUk5vPM=v5c6kYQ@mail.gmail.com>
In-Reply-To: <CAHC9VhSMVpEvLwWvBCgz0EMEb=DG_AZ7fenVUk5vPM=v5c6kYQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 26 Oct 2023 12:36:01 -0400
Message-ID: <CAHC9VhQW1mi5Z72cia7sqC7jERcCxO93xZJnvER=e7U6RqNFxQ@mail.gmail.com>
Subject: Re: [PATCH] security: Don't yet account for IMA in LSM_CONFIG_COUNT calculation
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Oct 26, 2023 at 11:59=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
> On Thu, Oct 26, 2023 at 11:12=E2=80=AFAM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> > On Thu, 2023-10-26 at 10:48 -0400, Paul Moore wrote:
> > > On Oct 26, 2023 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
> > > >
> > > > Since IMA is not yet an LSM, don't account for it in the LSM_CONFIG=
_COUNT
> > > > calculation, used to limit how many LSMs can invoke security_add_ho=
oks().
> > > >
> > > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > > ---
> > > >  security/security.c | 1 -
> > > >  1 file changed, 1 deletion(-)
> > >
> > > Merged into lsm/dev-staging, thanks!
> >
> > Welcome!
> >
> > Could you please also rebase lsm/dev-staging, to move ab3888c7198d
> > ("LSM: wireup Linux Security Module syscalls") after f7875966dc0c
> > ("tools headers UAPI: Sync files changed by new fchmodat2 and
> > map_shadow_stack syscalls with the kernel sources")?
>
> Let me look into that, as long as it doesn't blow up the stuff in
> lsm/dev (I don't think it would), I'll go ahead and rebase to v6.6-rc4
> which should resolve the syscall numbering conflict.
>
> FWIW, I also hit the same problem with my kernel-secnext builds, if
> you're using those RPMs you'll find it's already resolved there.

That wasn't very messy so I've rebased lsm/dev-staging to v6.6-rc4 and
regenerated lsm/next.  If you notice any problems please let me know.

--=20
paul-moore.com
