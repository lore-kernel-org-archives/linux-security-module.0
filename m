Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD49C07545
	for <linux-security-module@archiver.kernel.org>; Wed, 25 Oct 2023 13:14:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234967AbjJYNO6 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 25 Oct 2023 09:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344191AbjJYNO5 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 25 Oct 2023 09:14:57 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7707F184
        for <linux-security-module@vger.kernel.org>; Wed, 25 Oct 2023 06:14:54 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d9c687f83a2so5165573276.3
        for <linux-security-module@vger.kernel.org>; Wed, 25 Oct 2023 06:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1698239693; x=1698844493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6CrHvt4UKLHsJTJWppL1/cl7hwIF7jsKkGSVTj4BAQA=;
        b=Mq9+Xk8S10B9qmZrxxn5mQDGCmWGhL4Epsov6pHJpwa1JBaD5kHoVe1tz4f1lupC2C
         N3hwOoc2IGC/F0y5Y8sOM/QYzYh7t7sMQkYS9yBeMBE5QVYeJwIwu/QiHCSd9PXXghi+
         hryUH+nmes2f19xGDHFQb/pGe+JPdnzM1P8vi6f/jqX7Qa85zttrKrcM7R2oY2lpkdK8
         XZ20pp+q/KnDBd9xUo3ymuPhx9zvDKcLLFT6OLhQFTlyD5sGqYE2v13fUFOLW+zAZ9lG
         xCQMiGl1uX3CmIbuQfwei7M/8DLB7gt/j3dXsBdcsBKNK9dq8fkDVGhsEsq4SAW3fju8
         4YTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698239693; x=1698844493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6CrHvt4UKLHsJTJWppL1/cl7hwIF7jsKkGSVTj4BAQA=;
        b=HvgcZQPy/FPtwp/RVXo+2PhWKNA3FEJlSkU04Z3whTYbNkZGIx8LkolPSvSZb8aiXJ
         AOwYh9qp1c2YU6BunDPdfNxZY0k6TjFtRgHYcedXfcwhjGk12b2Vnd04fatfQVK9iU6T
         B0HqHdwKQndkClxPAHb5bgW/8Q3PWfZFt/Rx6xE2cbssUUk+hqoYoya91Q+OREvN5fJw
         boLctjZPQliRZpcBpQn/4ICkKMMk3m6ALs94wbMhwp/UKVJ4Lo4uGgE1oTEgKQvPf0cN
         yf7oo6Q4hnfdn3J4Lqf6D1s7yNQmezRpumFXriazTOkINVId11KRaJSMHkOWrYy+kSFB
         kPHQ==
X-Gm-Message-State: AOJu0YxGCB4qVQENrhwdsWgMbWlRSVZ3RqgopBk3k6YPzh1/0lGhg7fl
        9UAGQGtCOvtDrwSlKwsEWUAQjbBtWLIT/B1WGvOMxwFLdaYc8K4=
X-Google-Smtp-Source: AGHT+IFjJ2AMJ+YMbCCSrZFd6In20n3oGUGrpZT4pHiAecE25rn8JdAPgUHG27eXksqGQtVmcg563jGR7nGJt0C27cs=
X-Received: by 2002:a25:ade4:0:b0:d9a:be04:7fae with SMTP id
 d36-20020a25ade4000000b00d9abe047faemr15416874ybe.17.1698239693546; Wed, 25
 Oct 2023 06:14:53 -0700 (PDT)
MIME-Version: 1.0
References: <20231018215032.348429-2-paul@paul-moore.com> <72a92e27855af2291273209d328e1b79f3b61663.camel@huaweicloud.com>
 <1764a96f-6d24-4585-a24b-667a5ea075c3@schaufler-ca.com> <f47097f8-3391-42a7-b8b5-81e1be2d8e68@huaweicloud.com>
 <88f4f464-ac09-4c93-95f4-fe4546b78a08@schaufler-ca.com> <CAHC9VhSVcfsCM6GjxJrSPCXV3PYRahXJi5HiNyKGCt8f_fOpmA@mail.gmail.com>
 <93b2ea72-a9b1-4d50-bc4a-3d60d91dd44b@huaweicloud.com>
In-Reply-To: <93b2ea72-a9b1-4d50-bc4a-3d60d91dd44b@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 25 Oct 2023 09:14:42 -0400
Message-ID: <CAHC9VhQ3kKGWNUx=+vEZ58CUJo2YKVu4rrOjE+w5x9jKnP9MWA@mail.gmail.com>
Subject: Re: [PATCH] lsm: drop LSM_ID_IMA
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Oct 25, 2023 at 6:36=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> On 10/24/2023 11:18 PM, Paul Moore wrote:
> > On Mon, Oct 23, 2023 at 11:48=E2=80=AFAM Casey Schaufler <casey@schaufl=
er-ca.com> wrote:
> >> On 10/23/2023 8:20 AM, Roberto Sassu wrote:
> >>> On 10/20/2023 11:56 PM, Casey Schaufler wrote:
> >>>> On 10/19/2023 1:08 AM, Roberto Sassu wrote:
> >>>>> On Wed, 2023-10-18 at 17:50 -0400, Paul Moore wrote:
> >>>>>> When IMA becomes a proper LSM we will reintroduce an appropriate
> >>>>>> LSM ID, but drop it from the userspace API for now in an effort
> >>>>>> to put an end to debates around the naming of the LSM ID macro.
> >>>>>>
> >>>>>> Signed-off-by: Paul Moore <paul@paul-moore.com>
> >>>>> Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>
> >>>>>
> >>>>> This makes sense according to the new goal of making 'ima' and 'evm=
' as
> >>>>> standalone LSMs.
> >>>>>
> >>>>> Otherwise, if we took existing LSMs, we should have defined
> >>>>> LSM_ID_INTEGRITY, associated to DEFINE_LSM(integrity).
> >>>>>
> >>>>> If we proceed with the new direction, I will add the new LSM IDs as
> >>>>> soon as IMA and EVM become LSMs.
> >>>>
> >>>> This seems right to me. Thank You.
> >>>
> >>> Perfect! Is it fine to assign an LSM ID to 'ima' and 'evm' and keep
> >>> the 'integrity' LSM to reserve space in the security blob without LSM
> >>> ID (as long as it does not register any hook)?
> >>
> >> That will work, although it makes me wonder if all the data in the 'in=
tegrity' blob
> >> is used by both IMA and EVM. If these are going to be separate LSMs th=
ey should probably
> >> have their own security blobs. If there is data in common then an 'int=
egrity' blob can
> >> still makes sense.
> >
> > Users interact with IMA and EVM, not the "integrity" layer, yes?  If
> > so, I'm not sure it makes sense to have an "integrity" LSM, we should
> > just leave it at "IMA" and "EVM".
>
> The problem is who reserves and manages the shared integrity metadata.
> For now, it is still the 'integrity' LSM. If not, it would be IMA or EVM
> on behalf of the other (depending on which ones are enabled). Probably
> the second would not be a good idea.

I'm not certain that managing kernel metadata alone necessitates a LSM
ID token value.  Does "integrity" have any user visible "things" that
it would want to expose to userspace?

--=20
paul-moore.com
