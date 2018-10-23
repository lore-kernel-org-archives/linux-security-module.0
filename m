Return-Path: <SRS0=XO9p=ND=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058F3C67863
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Oct 2018 19:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB6B4204EC
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Oct 2018 19:16:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB6B4204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbeJXDlT (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 23 Oct 2018 23:41:19 -0400
Received: from mga17.intel.com ([192.55.52.151]:54108 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728099AbeJXDlT (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 23 Oct 2018 23:41:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2018 12:16:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,417,1534834800"; 
   d="scan'208";a="97915303"
Received: from pwolsza-mobl1.ger.corp.intel.com ([10.249.254.37])
  by fmsmga002.fm.intel.com with ESMTP; 23 Oct 2018 12:16:32 -0700
Date:   Tue, 23 Oct 2018 22:16:31 +0300 (EEST)
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
X-X-Sender: jsakkine@jsakkine-mobl1
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
cc:     linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH v4 1/7] tpm-buf: create new functions for handling TPM
 buffers
In-Reply-To: <1540193734.3202.9.camel@HansenPartnership.com>
Message-ID: <alpine.DEB.2.21.1810232214210.8524@jsakkine-mobl1>
References: <1540193596.3202.7.camel@HansenPartnership.com> <1540193734.3202.9.camel@HansenPartnership.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, 22 Oct 2018, James Bottomley wrote:
> This separates out the old tpm_buf_... handling functions from static
> inlines into tpm.h and makes them their own tpm-buf.c file.  It also
> adds handling for tpm2b structures and also incremental pointer
> advancing parsers.
>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

Would also prefer simply "tpm:" tag e.g. (in all of the commits actually
in this series but I remark it just here).

"tpm: create new tpm_buf_functions for parsing and TPM2B"

/Jarkko
