Return-Path: <SRS0=8CgQ=QF=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44AE1C282D0
	for <linux-security-module@archiver.kernel.org>; Tue, 29 Jan 2019 17:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09F2C214DA
	for <linux-security-module@archiver.kernel.org>; Tue, 29 Jan 2019 17:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="IG4kaNEQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfA2RGF (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 29 Jan 2019 12:06:05 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:45700 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727196AbfA2RGF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 29 Jan 2019 12:06:05 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 2DEB48EE241;
        Tue, 29 Jan 2019 09:06:04 -0800 (PST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GEwfT4-fIohK; Tue, 29 Jan 2019 09:06:03 -0800 (PST)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 411998EE0EF;
        Tue, 29 Jan 2019 09:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1548781563;
        bh=BM8s9fQWQTb++WNcfjYTF6x0VHGb6CNsqNj7D7Wy+B0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=IG4kaNEQM6g9ot/iOG/rMay5AJpjYvLYWxTXFlVRLjCjyN2Nh0qCKteY4EiNV0KDt
         dw6BpVVCUz/GejXPLkyDiOxOwAdwxge6jTP/qq+XPn+bcB0NLizzekh+Wx9p9FXBcl
         E6MBYpm+ja/egGvrZUyAFz4r9KdLdw9zUHzKo1QE=
Message-ID: <1548781561.2888.33.camel@HansenPartnership.com>
Subject: Re: [PATCH v10 08/17] tpm: call tpm2_flush_space() on error in
 tpm_try_transmit()
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        Peter Huewe <PeterHuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>, stable@vger.kernel.org
Date:   Tue, 29 Jan 2019 09:06:01 -0800
In-Reply-To: <20190116212342.24524-9-jarkko.sakkinen@linux.intel.com>
References: <20190116212342.24524-1-jarkko.sakkinen@linux.intel.com>
         <20190116212342.24524-9-jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, 2019-01-16 at 23:23 +0200, Jarkko Sakkinen wrote:
[...]
> -	rc = tpm2_commit_space(chip, space, ordinal, buf, &len);
> +out_space:
> +	if (rc)
> +		tpm2_flush_space(chip);
> +	else
> +		rc = tpm2_commit_space(chip, space, ordinal, buf,
> &len);

I don't think this is quite right.  tpm2_flush_space only flushes the
handles it knows about and those are the ones from before the TPM
operation was attempted.  If the operation has altered the internal
state we could miss a created handle in this flush and it would
effectively reside forever in the TPM.  We should be able to rely on
the TPM preserving the original state if it returns an error, so I
think your patch works for that part.  However rc is also set to
-EFAULT on a transmission error and if that's on the receive path, the
TPM may have changed state before the error occurred.

If the object is to move the TPM back to where it was before the error
occurred, even in the case of transmit errors, then I think we need to
invent a new kind of flush that queries the current TPM state and then
flushes everything.

James

