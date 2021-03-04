Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A102C433E0
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Mar 2021 10:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B1A664F0A
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Mar 2021 10:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238230AbhCDKBf (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 4 Mar 2021 05:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238113AbhCDKBM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 4 Mar 2021 05:01:12 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73C8C06175F
        for <linux-security-module@vger.kernel.org>; Thu,  4 Mar 2021 02:00:31 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 18so33621280lff.6
        for <linux-security-module@vger.kernel.org>; Thu, 04 Mar 2021 02:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R+fyz1Gmo60Jzev6gG0weSOoqYLjk+pWR3oPV5MKoDA=;
        b=lCDW9qJOuKrhpjESaUjTrpzFc1bcy7QBYhT7TcfsnuwLoRMbe1vBr6ymXsligO+5jG
         sTneNJj8Lo/s0urIihtY1H8SXSXSMc0VPdePAkij11jLBKd6FP7z75Hhs/Q9YwntF3TE
         G22+pN90TDJgrRLb6J7+yM0URNfEbiQvrrFK/DTy8p1Br8WUQY/D81lv+oS6NhRELZMp
         XkyXefNOX+vyFG1WYPbOIOHFaqe+4SYCxjv0b/xioHR1/1QcZEtdOx1Occz4q/dBYc2P
         2GGiiDVv7cvyezNdlPriPrhRL76yr8WAKE4nqpuFVw1UnJhcafnu1jt7dyRunIGH6Kvc
         jmYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R+fyz1Gmo60Jzev6gG0weSOoqYLjk+pWR3oPV5MKoDA=;
        b=EDDS4rqW9nmP+7b/8o/nPlo9NwVaFHaPooJ2MtxZNbF1NVDbOXisW6Den6/HnGXxtB
         T6wMAXJ3133tqhuDwCAgyoymisUC8a42xGYiHNyIfeyQCg8jAAs8Mye67xUCZTBpr64W
         zp8YK1JPyk8QygOGNrKPB7hPMRXMDx0Jq8x5BeU7Nw70elBt0C4HNh8Hbg6o+4iZE0KL
         InP76dbos5rzFJ50j3M7oF0y+OQiHFIfWRi/nfqRaKnl+74f0+5NsaLxpB6Baqu6xmwq
         MSwznIvMujKme4kLM8LKlctOQCp+P15qAg2njlmo/ftB44NDM2GcGIEpxBdidLzSFqZr
         MgsA==
X-Gm-Message-State: AOAM532mXBRLSB31Bt73YHqL4aDq6mQ/sxTLPePY7lp+37bg0GMzikhJ
        twC54dXkS4v0QMe+NlYq1NLOUEDnCLE39N6CA8XaAg==
X-Google-Smtp-Source: ABdhPJwXlOd8DBkLy9Zlmb+SghsS4EzhmtWT2+RyLbpljz0AiTWuutSp5GiA//NnHMof1wzIFvt/4DAQincSik0zAuE=
X-Received: by 2002:ac2:4d9b:: with SMTP id g27mr1920444lfe.113.1614852030131;
 Thu, 04 Mar 2021 02:00:30 -0800 (PST)
MIME-Version: 1.0
References: <20210301131127.793707-1-sumit.garg@linaro.org>
In-Reply-To: <20210301131127.793707-1-sumit.garg@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 4 Mar 2021 15:30:18 +0530
Message-ID: <CAFA6WYO4HHhtymaUzmkuaCZybTAWBQ=4K9Dez1pe1kqo3AJhuA@mail.gmail.com>
Subject: Re: [PATCH v9 0/4] Introduce TEE based Trusted Keys support
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <jejb@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Janne Karhunen <janne.karhunen@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Markus Wamser <Markus.Wamser@mixed-mode.de>,
        Luke Hinds <lhinds@redhat.com>,
        Elaine Palmer <erpalmer@us.ibm.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        op-tee@lists.trustedfirmware.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Jarkko,

On Mon, 1 Mar 2021 at 18:41, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Add support for TEE based trusted keys where TEE provides the functionality
> to seal and unseal trusted keys using hardware unique key. Also, this is
> an alternative in case platform doesn't possess a TPM device.
>
> This patch-set has been tested with OP-TEE based early TA which is already
> merged in upstream [1].
>
> [1] https://github.com/OP-TEE/optee_os/commit/f86ab8e7e0de869dfa25ca05a37ee070d7e5b86b
>
> Changes in v9:
> 1. Rebased to latest tpmdd/master.
> 2. Defined pr_fmt() and removed redundant tags.
> 3. Patch #2: incorporated misc. comments.
> 4. Patch #3: incorporated doc changes from Elaine and misc. comments
>    from Randy.
> 5. Patch #4: reverted to separate maintainer entry as per request from
>    Jarkko.
> 6. Added Jarkko's Tested-by: tag on patch #2.

It looks like we don't have any further comments on this patch-set. So
would you be able to pick up this patch-set?

-Sumit

>
> Changes in v8:
> 1. Added static calls support instead of indirect calls.
> 2. Documented trusted keys source module parameter.
> 3. Refined patch #1 commit message discription.
> 4. Addressed misc. comments on patch #2.
> 5. Added myself as Trusted Keys co-maintainer instead.
> 6. Rebased to latest tpmdd master.
>
> Changes in v7:
> 1. Added a trusted.source module parameter in order to enforce user's
>    choice in case a particular platform posses both TPM and TEE.
> 2. Refine commit description for patch #1.
>
> Changes in v6:
> 1. Revert back to dynamic detection of trust source.
> 2. Drop author mention from trusted_core.c and trusted_tpm1.c files.
> 3. Rebased to latest tpmdd/master.
>
> Changes in v5:
> 1. Drop dynamic detection of trust source and use compile time flags
>    instead.
> 2. Rename trusted_common.c -> trusted_core.c.
> 3. Rename callback: cleanup() -> exit().
> 4. Drop "tk" acronym.
> 5. Other misc. comments.
> 6. Added review tags for patch #3 and #4.
>
> Changes in v4:
> 1. Pushed independent TEE features separately:
>   - Part of recent TEE PR: https://lkml.org/lkml/2020/5/4/1062
> 2. Updated trusted-encrypted doc with TEE as a new trust source.
> 3. Rebased onto latest tpmdd/master.
>
> Changes in v3:
> 1. Update patch #2 to support registration of multiple kernel pages.
> 2. Incoporate dependency patch #4 in this patch-set:
>    https://patchwork.kernel.org/patch/11091435/
>
> Changes in v2:
> 1. Add reviewed-by tags for patch #1 and #2.
> 2. Incorporate comments from Jens for patch #3.
> 3. Switch to use generic trusted keys framework.
>
> Sumit Garg (4):
>   KEYS: trusted: Add generic trusted keys framework
>   KEYS: trusted: Introduce TEE based Trusted Keys
>   doc: trusted-encrypted: updates with TEE as a new trust source
>   MAINTAINERS: Add entry for TEE based Trusted Keys
>
>  .../admin-guide/kernel-parameters.txt         |  12 +
>  .../security/keys/trusted-encrypted.rst       | 171 ++++++--
>  MAINTAINERS                                   |   8 +
>  include/keys/trusted-type.h                   |  53 +++
>  include/keys/trusted_tee.h                    |  16 +
>  include/keys/trusted_tpm.h                    |  29 +-
>  security/keys/trusted-keys/Makefile           |   2 +
>  security/keys/trusted-keys/trusted_core.c     | 358 +++++++++++++++++
>  security/keys/trusted-keys/trusted_tee.c      | 317 +++++++++++++++
>  security/keys/trusted-keys/trusted_tpm1.c     | 366 ++++--------------
>  10 files changed, 981 insertions(+), 351 deletions(-)
>  create mode 100644 include/keys/trusted_tee.h
>  create mode 100644 security/keys/trusted-keys/trusted_core.c
>  create mode 100644 security/keys/trusted-keys/trusted_tee.c
>
> --
> 2.25.1
>
