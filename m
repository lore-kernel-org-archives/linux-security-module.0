Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399B0C25B47
	for <linux-security-module@archiver.kernel.org>; Tue, 24 Oct 2023 21:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbjJXVSQ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 24 Oct 2023 17:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbjJXVSQ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 24 Oct 2023 17:18:16 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DD910CE
        for <linux-security-module@vger.kernel.org>; Tue, 24 Oct 2023 14:18:13 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5a822f96aedso50184087b3.2
        for <linux-security-module@vger.kernel.org>; Tue, 24 Oct 2023 14:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1698182293; x=1698787093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+7K+2OOKRnfkjBzyGpE+ajFvwH2s9IHk84LfHeNYPAM=;
        b=ItnEKPy+rcDYJr8KyZg3sixq2MjqqM4/UjjM+881iQAvCvUDmwD/d4rKntquVLp9Jp
         H0IiP4x1IA8Hk12H/mhl6ypEzgunfHfhMiE88HiwoAvdEmZbrh60uFijqG2BBnpuxJK7
         YBNiyr001OnKwjEyhA3IRgjL3lN3Jx2xckdbGGURFhhoRHl5ixjE8WG2oQdfpS3uadqT
         IsNwPSpmJ264fiDFsgvMNzeRN7XLNi2qcFLoPbt2i6axYIPI9bw9BhRAP97RdK+QastM
         3+CV0PlKcxYc98XY6ET5La9125hFL1adLcPftp9sMMimAjaivt3g7TiFDbWEGl5ewq6T
         OM9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698182293; x=1698787093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+7K+2OOKRnfkjBzyGpE+ajFvwH2s9IHk84LfHeNYPAM=;
        b=oxpH0jpH0lwKo9qyGToITbZRSfgCWDWWIso5oodLEmHKZwCHXKHZUJ9zsmjyVmLjO0
         5Gtu+bn+n0pJfDDGmwqCyfsYeabYUGWlj3nT1N4cMxFDPvNXZDYPXeekU82uADFg9yjr
         S2Bp6G/imxXkXu2vF55zzq1nCZMP8e1vWu1yCJhQsw1/QdIxn0nEGEXlOtlNxNg8luDF
         bvCPiczPj2io8eDzkK0ncJQlBJdY1sDwuMqb6wEgtWfqveVQMX68YNf8n17Wz86iPf/Z
         eXblu2SH0PLRN53mueEXSasnol/EBhjxN2w7sL8Zyasr7djhHRYE8Q/2Czb6bAutpsii
         ETuA==
X-Gm-Message-State: AOJu0YwuZdvWfqaPqapU+m5rNBWX5eWFvMJBFB4PONvbVj6d8DoHV5Xv
        iTJrzkM+Daz6BQeO7uzAAIDPOCcGX0bsCsZ3eN5oiudQO8T0e9JqTg==
X-Google-Smtp-Source: AGHT+IFRhpA6BI6z9iD2Zk4e3KPckEzKi48gs6eSsOyJy4OmzSowP4DOIALXwszPcXTfrl7c8TsWD3fSrKMCW6tzkhA=
X-Received: by 2002:a81:480c:0:b0:5a9:117d:ddbc with SMTP id
 v12-20020a81480c000000b005a9117dddbcmr10760939ywa.15.1698182293010; Tue, 24
 Oct 2023 14:18:13 -0700 (PDT)
MIME-Version: 1.0
References: <20231018215032.348429-2-paul@paul-moore.com> <72a92e27855af2291273209d328e1b79f3b61663.camel@huaweicloud.com>
 <1764a96f-6d24-4585-a24b-667a5ea075c3@schaufler-ca.com> <f47097f8-3391-42a7-b8b5-81e1be2d8e68@huaweicloud.com>
 <88f4f464-ac09-4c93-95f4-fe4546b78a08@schaufler-ca.com>
In-Reply-To: <88f4f464-ac09-4c93-95f4-fe4546b78a08@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 24 Oct 2023 17:18:02 -0400
Message-ID: <CAHC9VhSVcfsCM6GjxJrSPCXV3PYRahXJi5HiNyKGCt8f_fOpmA@mail.gmail.com>
Subject: Re: [PATCH] lsm: drop LSM_ID_IMA
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        linux-security-module@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Oct 23, 2023 at 11:48=E2=80=AFAM Casey Schaufler <casey@schaufler-c=
a.com> wrote:
> On 10/23/2023 8:20 AM, Roberto Sassu wrote:
> > On 10/20/2023 11:56 PM, Casey Schaufler wrote:
> >> On 10/19/2023 1:08 AM, Roberto Sassu wrote:
> >>> On Wed, 2023-10-18 at 17:50 -0400, Paul Moore wrote:
> >>>> When IMA becomes a proper LSM we will reintroduce an appropriate
> >>>> LSM ID, but drop it from the userspace API for now in an effort
> >>>> to put an end to debates around the naming of the LSM ID macro.
> >>>>
> >>>> Signed-off-by: Paul Moore <paul@paul-moore.com>
> >>> Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>
> >>>
> >>> This makes sense according to the new goal of making 'ima' and 'evm' =
as
> >>> standalone LSMs.
> >>>
> >>> Otherwise, if we took existing LSMs, we should have defined
> >>> LSM_ID_INTEGRITY, associated to DEFINE_LSM(integrity).
> >>>
> >>> If we proceed with the new direction, I will add the new LSM IDs as
> >>> soon as IMA and EVM become LSMs.
> >>
> >> This seems right to me. Thank You.
> >
> > Perfect! Is it fine to assign an LSM ID to 'ima' and 'evm' and keep
> > the 'integrity' LSM to reserve space in the security blob without LSM
> > ID (as long as it does not register any hook)?
>
> That will work, although it makes me wonder if all the data in the 'integ=
rity' blob
> is used by both IMA and EVM. If these are going to be separate LSMs they =
should probably
> have their own security blobs. If there is data in common then an 'integr=
ity' blob can
> still makes sense.

Users interact with IMA and EVM, not the "integrity" layer, yes?  If
so, I'm not sure it makes sense to have an "integrity" LSM, we should
just leave it at "IMA" and "EVM".

--=20
paul-moore.com
