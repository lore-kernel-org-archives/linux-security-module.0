Return-Path: <SRS0=XO9p=ND=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980C4C7112C
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Oct 2018 23:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C8C820824
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Oct 2018 23:51:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C8C820824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbeJXIQt (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 24 Oct 2018 04:16:49 -0400
Received: from mga05.intel.com ([192.55.52.43]:13774 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbeJXIQt (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 24 Oct 2018 04:16:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2018 16:51:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,418,1534834800"; 
   d="scan'208";a="85042340"
Received: from pwolsza-mobl1.ger.corp.intel.com ([10.249.254.37])
  by orsmga006.jf.intel.com with ESMTP; 23 Oct 2018 16:51:04 -0700
Date:   Wed, 24 Oct 2018 02:51:02 +0300 (EEST)
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
X-X-Sender: jsakkine@jsakkine-mobl1
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
cc:     linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH v4 0/7] add integrity and security to TPM2 transactions
In-Reply-To: <1540193596.3202.7.camel@HansenPartnership.com>
Message-ID: <alpine.DEB.2.21.1810240249180.8524@jsakkine-mobl1>
References: <1540193596.3202.7.camel@HansenPartnership.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

I would consider sending first a patch set that would iterate the existing
session stuff to be ready for this i.e. merge in two iterations 
(emphasis on the word "consider"). We can probably merge the groundwork
quite fast.

/Jarkko

On Mon, 22 Oct 2018, James Bottomley wrote:
> By now, everybody knows we have a problem with the TPM2_RS_PW easy
> button on TPM2 in that transactions on the TPM bus can be intercepted
> and altered.  The way to fix this is to use real sessions for HMAC
> capabilities to ensure integrity and to use parameter and response
> encryption to ensure confidentiality of the data flowing over the TPM
> bus.
>
> This patch series is about adding a simple API which can ensure the
> above properties as a layered addition to the existing TPM handling
> code.  This series now includes protections for PCR extend, getting
> random numbers from the TPM and data sealing and unsealing.  It
> therefore eliminates all uses of TPM2_RS_PW in the kernel and adds
> encryption protection to sensitive data flowing into and out of the
> TPM.
>
> In the third version I added data sealing and unsealing protection,
> apart from one API based problem which means that the way trusted keys
> were protected it's not currently possible to HMAC protect an authority
> that comes with a policy, so the API will have to be extended to fix
> that case
>
> In this fourth version, I tidy up some of the code and add more
> security features, the most notable is that we now calculate the NULL
> seed name and compare our calculation to the value returned in
> TPM2_ReadPublic, which means we now can't be spoofed.  This version
> also gives a sysfs variable for the null seed which userspace can use
> to run a key certification operation to prove that the TPM was always
> secure when communicating with the kernel.
>
> I've verified this using the test suite in the last patch on a VM
> connected to a tpm2 emulator.  I also instrumented the emulator to make
> sure the sensitive data was properly encrypted.
>
> James
>
> ---
>
>
> James Bottomley (7):
>  tpm-buf: create new functions for handling TPM buffers
>  tpm2-sessions: Add full HMAC and encrypt/decrypt session handling
>  tpm2: add hmac checks to tpm2_pcr_extend()
>  tpm2: add session encryption protection to tpm2_get_random()
>  trusted keys: Add session encryption protection to the seal/unseal
>    path
>  tpm: add the null key name as a tpm2 sysfs variable
>  tpm2-sessions: NOT FOR COMMITTING add sessions testing
>
> drivers/char/tpm/Kconfig              |    3 +
> drivers/char/tpm/Makefile             |    3 +-
> drivers/char/tpm/tpm-buf.c            |  191 ++++++
> drivers/char/tpm/tpm-chip.c           |    1 +
> drivers/char/tpm/tpm-sysfs.c          |   27 +-
> drivers/char/tpm/tpm.h                |  129 ++--
> drivers/char/tpm/tpm2-cmd.c           |  248 ++++---
> drivers/char/tpm/tpm2-sessions-test.c |  360 ++++++++++
> drivers/char/tpm/tpm2-sessions.c      | 1188 +++++++++++++++++++++++++++++++++
> drivers/char/tpm/tpm2-sessions.h      |   57 ++
> 10 files changed, 2027 insertions(+), 180 deletions(-)
> create mode 100644 drivers/char/tpm/tpm-buf.c
> create mode 100644 drivers/char/tpm/tpm2-sessions-test.c
> create mode 100644 drivers/char/tpm/tpm2-sessions.c
> create mode 100644 drivers/char/tpm/tpm2-sessions.h
>
> -- 
> 2.16.4
>
>
