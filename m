Return-Path: <SRS0=R80q=QB=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E428C282C6
	for <linux-security-module@archiver.kernel.org>; Fri, 25 Jan 2019 01:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 194CC218CD
	for <linux-security-module@archiver.kernel.org>; Fri, 25 Jan 2019 01:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfAYBFX (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 24 Jan 2019 20:05:23 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37605 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728024AbfAYBFX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 24 Jan 2019 20:05:23 -0500
Received: by mail-qt1-f196.google.com with SMTP id t33so9011805qtt.4
        for <linux-security-module@vger.kernel.org>; Thu, 24 Jan 2019 17:05:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=6z/fHP5/ilN8QbHMM/7kZXl6+veIrNyjFA9+zA4zaik=;
        b=pLCF0TPVvvmdF7cYqR5WZM4DinHkCIca+AySh8h3owZ326kicvxfwIN9hxRjJL56AH
         nKI4o8xO1TwREcioyV3XLBQm4CeelJDlEV76m301U9FyxiB98K+SNY/tTcGaOJZHWqkr
         LIDGVBvPoB1CxJP44e0jhEW6hoJRUP0MDb25WJ/mBBI3+D3lBzd1dMXViw+2CXdekdmM
         dYYDx8J8bMoa5xucQzISS2LfURYoZNGar9UFSfdsrCaBCxeW1R5CFnzNIXD3W8fLBanm
         3W4e/lE85x3n026ihWLWaMZA2nyMmobTkwJ8fTKC2M+viTZU2ERAx+1ww1Qk9X/zt6cj
         k7sg==
X-Gm-Message-State: AJcUukcrMxxW7f5y6t6PIM8nnaeMlP0Znbwa2zJM+3H7jLU+SojI2mzg
        KTlSFMelAEtLJaWEgGOVexecfA==
X-Google-Smtp-Source: ALg8bN5pvy1aV6x2BV/MwJOYIn0FSPCBOsSfdSEjegXEOQwiLJ6MyCtxIUFbpjPYQmjZMGO9e39fHQ==
X-Received: by 2002:a0c:ef03:: with SMTP id t3mr8177008qvr.148.1548378322026;
        Thu, 24 Jan 2019 17:05:22 -0800 (PST)
Received: from localhost (ip72-223-3-97.ph.ph.cox.net. [72.223.3.97])
        by smtp.gmail.com with ESMTPSA id q54sm76147530qtb.64.2019.01.24.17.05.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 17:05:21 -0800 (PST)
Date:   Thu, 24 Jan 2019 18:05:19 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Peter Huewe <PeterHuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: Re: [PATCH v10 00/17] Remove nested TPM operations
Message-ID: <20190125010519.4tqcno4iaha4ww7r@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
References: <20190116212342.24524-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190116212342.24524-1-jarkko.sakkinen@linux.intel.com>
User-Agent: NeoMutt/20180716
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed Jan 16 19, Jarkko Sakkinen wrote:
>Make the changes necessary to detach TPM space code and TPM activation
>code out of the tpm_transmit() flow because of both of these can cause
>nested tpm_transmit() calls. The nesteds calls make the whole flow hard
>to maintain, and thus, it is better to just fix things now before this
>turns into a bigger mess.
>
>v10:
>* Use void pointers to avoid unnecessary casts in functions paramaters
>  where it makes sense.
>
>v9:
>* Fixed again tpm_try_get_ops().
>* Added missing reviewed-by's.
>
>v8:
>* Re-add the check for ret < 0 after calling tpm_try_transmit() that
>  was dropped by mistake while moving code.
>* Fix error fallback for tpm_try_get_ops() when tpm_chip_start()
>  fails.
>
>v7:
>*  Reorganize series so that more trivial and self-contained changes are
>   in the head.
>
>v6:
>* When tpm_validate_commmand() was moved to tpm2-space.c, the struct for
>  the TPM header was incorrectly declared as struct tpm_input_header.
>* Fix return value in tpm_validate_command().
>
>v5:
>* Add the missing rev's from Stefan Berger.
>
>v4:
>* Return 0 from pcrs_show() when tpm1_pcr_read() fails.
>* Fix error handling flow in tpm_try_transmit().
>* Replace struct tpm_input_header and struct tpm_output_header with
>  struct tpm_header.
>
>v3:
>* Encapsulate power gating code to tpm_chip_start() and tpm_chip_stop().
>* Move TPM power gating code and locking to tpm_try_get_ops() and
>  tpm_put_ops().
>* Call power gating code directly in tpm_chip_register() and
>  tpm2_del_space().
>
>v2:
>* Print tpm2_commit_space() error inside tpm2_commit_space()
>* Error code was not printed when recv() callback failed. It is
>  fixed in this version.
>* Added a patch that removes @space from tpm_transmit().
>* Fixed a regression in earlier series. Forgot to amend the change
>  from the staging area that renames NESTED to UNLOCKED in tpm2-space.c.
>Jarkko Sakkinen (17):
>  tpm: use tpm_buf in tpm_transmit_cmd() as the IO parameter
>  tpm: fix invalid return value in pubek_show()
>  tpm: return 0 from pcrs_show() when tpm1_pcr_read() fails
>  tpm: print tpm2_commit_space() error inside tpm2_commit_space()
>  tpm: declare struct tpm_header
>  tpm: access command header through struct in tpm_try_transmit()
>  tpm: encapsulate tpm_dev_transmit()
>  tpm: call tpm2_flush_space() on error in tpm_try_transmit()
>  tpm: clean up tpm_try_transmit() error handling flow
>  tpm: move tpm_validate_commmand() to tpm2-space.c
>  tpm: move TPM space code out of tpm_transmit()
>  tpm: remove @space from tpm_transmit()
>  tpm: use tpm_try_get_ops() in tpm-sysfs.c.
>  tpm: remove TPM_TRANSMIT_UNLOCKED flag
>  tpm: introduce tpm_chip_start() and tpm_chip_stop()
>  tpm: take TPM chip power gating out of tpm_transmit()
>  tpm: remove @flags from tpm_transmit()
>
> drivers/char/tpm/tpm-chip.c       | 109 ++++++++++++
> drivers/char/tpm/tpm-dev-common.c |  45 ++++-
> drivers/char/tpm/tpm-interface.c  | 264 ++++++------------------------
> drivers/char/tpm/tpm-sysfs.c      | 138 ++++++++++------
> drivers/char/tpm/tpm.h            |  64 +++-----
> drivers/char/tpm/tpm1-cmd.c       |  28 +---
> drivers/char/tpm/tpm2-cmd.c       |  72 +++-----
> drivers/char/tpm/tpm2-space.c     |  91 +++++++---
> drivers/char/tpm/tpm_i2c_atmel.c  |   5 +-
> drivers/char/tpm/tpm_vtpm_proxy.c |  12 +-
> drivers/char/tpm/xen-tpmfront.c   |   2 +-
> 11 files changed, 409 insertions(+), 421 deletions(-)
>
>-- 
>2.19.1
>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
