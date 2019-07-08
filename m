Return-Path: <SRS0=y5yI=VF=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD728C606AC
	for <linux-security-module@archiver.kernel.org>; Mon,  8 Jul 2019 12:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8328F2086D
	for <linux-security-module@archiver.kernel.org>; Mon,  8 Jul 2019 12:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LTaOrKl0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729682AbfGHMlx (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 8 Jul 2019 08:41:53 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46860 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729342AbfGHMlx (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 8 Jul 2019 08:41:53 -0400
Received: by mail-lf1-f67.google.com with SMTP id z15so10799101lfh.13
        for <linux-security-module@vger.kernel.org>; Mon, 08 Jul 2019 05:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=01ZaodaDx7mKeMsXvB23tTxrXIayVtwHPEPEGKhS98A=;
        b=LTaOrKl0vSBgTH3p2sCQOsuKjJdFWmWnutde8wO+ePasoJh4cKjHrhnyXY6PgrHpLK
         85c5GiNIeepifFeyVzMroc3IGeQPvYJsPE6GANW/1Jz6ipZTGtmxG3AFWpis6U5nxM0u
         9SspHklbe19WcWvyMY9A/cnz9VTq1NQi6rZHvrJPOODA3+sTroEftiODx8+Z4PSbdSD4
         JVRSZGHXxPJYU60Nw/oKQHdhX3zqe+HPJGoKm9LfYUsR6VOgOnX1FU9++vR1/7k5B6Sl
         OqLGlWgWVOugSqujh54KMPW29ELbJauzph1ezjbkSCh758w6oq8hSl80Vsbq8YXvfFGx
         5fqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=01ZaodaDx7mKeMsXvB23tTxrXIayVtwHPEPEGKhS98A=;
        b=g83AFwaLY+TsWCZNbEFseOokhAJvwptmW1KHup/huWzvqojWgHb64MEQzapoQIWt2r
         9owzGVCwCcevRir8Sz6DuEeXN5iTtJvWpOoQLuPTD0DuGwQppeOnE2aS3H2oMqZWla++
         LhQqSmTup3RY+OWY2b0OsoGTOd9tDDqrjA11EQtbSatn1Ej7wXN/MOliUlfGDOjr4aIA
         VgSmC4RndqM06PqFUKSNnUwq6gVu4+h0W3QFN+CWzmz6FkXqkFM5wuRYm637/RKScq58
         ZDb+GREpx/iSZm4LmjAi4u35oALy9W+se/68pRaDZ6ul1kWX19sdtsLRn3Xhi9+5hu8A
         52fA==
X-Gm-Message-State: APjAAAWrZClMFqDhTQBPkTQkQnRYmqygQfFmiKSjen4lSSP4vxAqauPo
        OOYyLqmj8eRyjU+AJUf1+TPTd9QTG9fOImJfHvvXyw==
X-Google-Smtp-Source: APXvYqxE30q0tSSJMu3guI09sH2bs/UqlCraWFjUE/V1BMcubjJgN2dhMofOAQnk/QVFVER9j12WU8+boVM3eecRu6U=
X-Received: by 2002:ac2:5c42:: with SMTP id s2mr8772526lfp.61.1562589711198;
 Mon, 08 Jul 2019 05:41:51 -0700 (PDT)
MIME-Version: 1.0
References: <1560421833-27414-1-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1560421833-27414-1-git-send-email-sumit.garg@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 8 Jul 2019 18:11:39 +0530
Message-ID: <CAFA6WYPn3HB6BRocKmKTR+ZPE=Fav5w1TUdRgmLp-NkYobp3rw@mail.gmail.com>
Subject: Re: [RFC 0/7] Introduce TEE based Trusted Keys support
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     corbet@lwn.net, dhowells@redhat.com, jejb@linux.ibm.com,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>, jmorris@namei.org,
        serge@hallyn.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tee-dev@lists.linaro.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Jens,

On Thu, 13 Jun 2019 at 16:01, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Add support for TEE based trusted keys where TEE provides the functionality
> to seal and unseal trusted keys using hardware unique key. Also, this is
> an alternative in case platform doesn't possess a TPM device.
>
> This series also adds some TEE features like:
>
> Patch #1, #2 enables support for registered kernel shared memory with TEE.
>

Would you like to pick up Patch #1, #2 separately? I think both these
patches add independent functionality and also got reviewed-by tags
too.


-Sumit

> Patch #3 enables support for private kernel login method required for
> cases like trusted keys where we don't wan't user-space to directly access
> TEE service to retrieve trusted key contents.
>
> Rest of the patches from #4 to #7 adds support for TEE based trusted keys.
>
> This patch-set has been tested with OP-TEE based pseudo TA which can be
> found here [1].
>
> Looking forward to your valuable feedback/suggestions.
>
> [1] https://github.com/OP-TEE/optee_os/pull/3082
>
> Sumit Garg (7):
>   tee: optee: allow kernel pages to register as shm
>   tee: enable support to register kernel memory
>   tee: add private login method for kernel clients
>   KEYS: trusted: Introduce TEE based Trusted Keys
>   KEYS: encrypted: Allow TEE based trusted master keys
>   doc: keys: Document usage of TEE based Trusted Keys
>   MAINTAINERS: Add entry for TEE based Trusted Keys
>
>  Documentation/security/keys/tee-trusted.rst      |  93 +++++
>  MAINTAINERS                                      |   9 +
>  drivers/tee/optee/call.c                         |   7 +
>  drivers/tee/tee_core.c                           |   6 +
>  drivers/tee/tee_shm.c                            |  16 +-
>  include/keys/tee_trusted.h                       |  84 ++++
>  include/keys/trusted-type.h                      |   1 +
>  include/linux/tee_drv.h                          |   1 +
>  include/uapi/linux/tee.h                         |   2 +
>  security/keys/Kconfig                            |   3 +
>  security/keys/Makefile                           |   3 +
>  security/keys/encrypted-keys/masterkey_trusted.c |  10 +-
>  security/keys/tee_trusted.c                      | 506 +++++++++++++++++++++++
>  13 files changed, 737 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/security/keys/tee-trusted.rst
>  create mode 100644 include/keys/tee_trusted.h
>  create mode 100644 security/keys/tee_trusted.c
>
> --
> 2.7.4
>
