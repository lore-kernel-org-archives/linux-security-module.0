Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D240CC7EE37
	for <linux-security-module@archiver.kernel.org>; Thu,  2 Mar 2023 19:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjCBTI3 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 2 Mar 2023 14:08:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjCBTIV (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 2 Mar 2023 14:08:21 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD8A31E36
        for <linux-security-module@vger.kernel.org>; Thu,  2 Mar 2023 11:08:15 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id y2so146380pjg.3
        for <linux-security-module@vger.kernel.org>; Thu, 02 Mar 2023 11:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1677784095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vdu6kOAJ1Ups+aUuKMhdxW9mbKAGnc9mpfEPZtQ5oYc=;
        b=QCBxot5UEe92USFtl63SUB/c1YdLVxScPQJ1P4QKkUVllAOjkExvExOlk22Y+cAPLp
         7weEoPvxZ0D+WDb8BBKIVp9dG4Qk6OQkdh8kKA3dGVcxvksE7MJCCR2RE4qhTXvYfGvU
         jgj/tDTwkb4LQQic+6FFlgFTo6sCZEIGs5slvhlNdP2IW3PkjwzxqzAKtaNvhqrh1ARk
         Fk945S48pTjqSBexPAR6DDMtcXU3MwN4FBw5DjJSxESA4tj2RXONXJlXtInGbuPs/1lK
         6Em3Vjg2pr05lfKVnhLnuoPez7jPU4XUgCaO4BKItyg6p/BwZcZW+iA8dgGN98E+y8bW
         DE3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677784095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vdu6kOAJ1Ups+aUuKMhdxW9mbKAGnc9mpfEPZtQ5oYc=;
        b=ui9yAgRtKR4Z5PiVVQ5z3XTm/blPQ3zYWNoWRGVLpAOc11Hj1VHtMJKCTweWpQoVKb
         PE7ijAgUZWocy5wGhaWLTie3yiKCGUdczIGt+gBmf6sAB0jc2OEHyNKnPmSVEDIZhlJZ
         ATv22hY5nPIQ7+dj17E2KzvuT+Nk3IlMv4T85KCpaoGo9FVe4cgptnT9YGfcmvWZFjS8
         j4kH2qBUEONdnYovb4kE8kmB//kAF94veDzUTYkaT519s4BsyAFbXVlrk8+StVvlfr6T
         o3X7xfXRSsKX+sxyvddJ+1a2rHF6OEpqVQh6wMIxnqmVGAKny2L7kTbUd4M75EW9IDpI
         tZvA==
X-Gm-Message-State: AO0yUKV6aWhPwwgcc+4BFhSVWKMinuTkuS7RBnDqpZqKoitS4Z5XNJ26
        Asy0RqnNLClDjQHFxR+CFYZiHGmYv+mngiB5He1QCz71kuVd
X-Google-Smtp-Source: AK7set9s3MxX+z1dx88uX1Fs1h5mTCDHnH5bToYcnqr8ZticQMwTWq2upjnKLw2DFG5CIW3NG3MUdlWUtltns+RDwxc=
X-Received: by 2002:a17:903:1d1:b0:19c:cb32:bfef with SMTP id
 e17-20020a17090301d100b0019ccb32bfefmr4510758plh.3.1677784095231; Thu, 02 Mar
 2023 11:08:15 -0800 (PST)
MIME-Version: 1.0
References: <1675119451-23180-1-git-send-email-wufan@linux.microsoft.com> <1675119451-23180-12-git-send-email-wufan@linux.microsoft.com>
In-Reply-To: <1675119451-23180-12-git-send-email-wufan@linux.microsoft.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 2 Mar 2023 14:08:04 -0500
Message-ID: <CAHC9VhRdm_xpXNQvSVO2hkx2js=_zzo2DiQ6PvEjAEet4OjxNw@mail.gmail.com>
Subject: Re: [RFC PATCH v9 11/16] ipe: add support for dm-verity as a trust provider
To:     Fan Wu <wufan@linux.microsoft.com>
Cc:     corbet@lwn.net, zohar@linux.ibm.com, jmorris@namei.org,
        serge@hallyn.com, tytso@mit.edu, ebiggers@kernel.org,
        axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org,
        eparis@redhat.com, linux-doc@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-block@vger.kernel.org,
        dm-devel@redhat.com, linux-audit@redhat.com,
        roberto.sassu@huawei.com, linux-kernel@vger.kernel.org,
        Deven Bowers <deven.desai@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jan 30, 2023 at 5:58=E2=80=AFPM Fan Wu <wufan@linux.microsoft.com> =
wrote:
>
> From: Deven Bowers <deven.desai@linux.microsoft.com>
>
> Allows author of IPE policy to indicate trust for a singular dm-verity
> volume, identified by roothash, through "dmverity_roothash" and all
> signed dm-verity volumes, through "dmverity_signature".
>
> Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
> Signed-off-by: Fan Wu <wufan@linux.microsoft.com>

...

> ---
>  security/ipe/Kconfig         |  20 +++++
>  security/ipe/Makefile        |   2 +
>  security/ipe/audit.c         |  24 ++++++
>  security/ipe/digest.c        | 144 +++++++++++++++++++++++++++++++++++
>  security/ipe/digest.h        |  26 +++++++
>  security/ipe/eval.c          | 103 +++++++++++++++++++++++++
>  security/ipe/eval.h          |  13 ++++
>  security/ipe/hooks.c         |  51 +++++++++++++
>  security/ipe/hooks.h         |   8 ++
>  security/ipe/ipe.c           |  15 ++++
>  security/ipe/ipe.h           |   4 +
>  security/ipe/policy.h        |   3 +
>  security/ipe/policy_parser.c |  16 ++++
>  13 files changed, 429 insertions(+)
>  create mode 100644 security/ipe/digest.c
>  create mode 100644 security/ipe/digest.h
>
> diff --git a/security/ipe/Kconfig b/security/ipe/Kconfig
> index ac4d558e69d5..16e835ce61b0 100644
> --- a/security/ipe/Kconfig
> +++ b/security/ipe/Kconfig
> @@ -15,3 +15,23 @@ menuconfig SECURITY_IPE
>           admins to reconfigure trust requirements on the fly.
>
>           If unsure, answer N.
> +
> +if SECURITY_IPE
> +menu "IPE Trust Providers"
> +
> +config IPE_PROP_DM_VERITY
> +       bool "Enable support for dm-verity volumes"
> +       depends on DM_VERITY && DM_VERITY_VERIFY_ROOTHASH_SIG
> +       default Y
> +       help
> +         This option enables the properties 'dmverity_signature' and
> +         'dmverity_roothash' in IPE policy. These properties evaluates
> +         to TRUE when a file is evaluated against a dm-verity volume
> +         that was mounted with a signed root-hash or the volume's
> +         root hash matches the supplied value in the policy.
> +
> +         If unsure, answer Y.

If you had both IPE and dm-verity enabled in your kernel build, is
there ever a case where you wouldn't want IPE_PROP_DM_VERITY?  I
suspect you can just have IPE and dm-verity select IPE_PROP_DM_VERITY
and not bother the user/admin with the additional Kconfig knob.

> +endmenu
> +
> +endif

--
paul-moore.com
