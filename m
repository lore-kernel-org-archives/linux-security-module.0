Return-Path: <SRS0=uW8r=DU=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B75C83014
	for <linux-security-module@archiver.kernel.org>; Tue, 13 Oct 2020 02:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F13320678
	for <linux-security-module@archiver.kernel.org>; Tue, 13 Oct 2020 02:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="TBcwAfss";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="TBcwAfss"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbgJMBDm (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 12 Oct 2020 21:03:42 -0400
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:43932 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727950AbgJMBDm (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 12 Oct 2020 21:03:42 -0400
X-Greylist: delayed 335 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Oct 2020 21:03:41 EDT
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 71CD71280606;
        Mon, 12 Oct 2020 17:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1602550686;
        bh=nbQ1CDoSn294pE1sw8CK2+ECGhZdnj5Vl/PP6DgpkMA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=TBcwAfss8IXbR6MoAvkjSpxA9lUvtg0gX7/IYm0MwF9BTgrP3r5l/owiN7qssYN5q
         0q9yK4BAod5msY69rQAjkKeGClagHI0FGuLXWKVYWYdzgZ8HbRN/HyzuV/rNAPk4TU
         odtrTwXJr6gNHw7Sgt6VXRc5goYeFKQct/92VSWw=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id aYc40rcVWBG3; Mon, 12 Oct 2020 17:58:06 -0700 (PDT)
Received: from jarvis.int.hansenpartnership.com (c-73-35-198-56.hsd1.wa.comcast.net [73.35.198.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 3F3A812805AB;
        Mon, 12 Oct 2020 17:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1602550686;
        bh=nbQ1CDoSn294pE1sw8CK2+ECGhZdnj5Vl/PP6DgpkMA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=TBcwAfss8IXbR6MoAvkjSpxA9lUvtg0gX7/IYm0MwF9BTgrP3r5l/owiN7qssYN5q
         0q9yK4BAod5msY69rQAjkKeGClagHI0FGuLXWKVYWYdzgZ8HbRN/HyzuV/rNAPk4TU
         odtrTwXJr6gNHw7Sgt6VXRc5goYeFKQct/92VSWw=
Message-ID: <b56dd2e9f3934e24f08005b9c5588c54b4837ff6.camel@HansenPartnership.com>
Subject: Re: [PATCH v3 3/3] KEYS: trusted: Reserve TPM for seal and unseal
 operations
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>, stable@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>,
        kernel test robot <lkp@intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Alexey Klimov <aklimov@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KEYS-TRUSTED" <keyrings@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>
Date:   Mon, 12 Oct 2020 17:58:04 -0700
In-Reply-To: <20201013002815.40256-4-jarkko.sakkinen@linux.intel.com>
References: <20201013002815.40256-1-jarkko.sakkinen@linux.intel.com>
         <20201013002815.40256-4-jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, 2020-10-13 at 03:28 +0300, Jarkko Sakkinen wrote:
[...]
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 8f4ff39f51e7..f0ebce14d2f8 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -397,6 +397,10 @@ static inline u32 tpm2_rc_value(u32 rc)
>  #if defined(CONFIG_TCG_TPM) || defined(CONFIG_TCG_TPM_MODULE)
>  
>  extern int tpm_is_tpm2(struct tpm_chip *chip);
> +extern __must_check int tpm_try_get_ops(struct tpm_chip *chip);
> +extern void tpm_put_ops(struct tpm_chip *chip);
> +extern ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct
> tpm_buf *buf,
> +				size_t min_rsp_body_length, const char
> *desc);
>  extern int tpm_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
>  			struct tpm_digest *digest);
>  extern int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
> @@ -410,7 +414,18 @@ static inline int tpm_is_tpm2(struct tpm_chip
> *chip)
>  {
>  	return -ENODEV;
>  }
> -
> +static inline int tpm_try_get_ops(struct tpm_chip *chip)
> +{
> +	return -ENODEV;
> +}
> +static inline void tpm_put_ops(struct tpm_chip *chip)
> +{
> +}
> +static inline ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct
> tpm_buf *buf,
> +				       size_t min_rsp_body_length,
> const char *desc)
> +{
> +	return -ENODEV;
> +}
>  static inline int tpm_pcr_read(struct tpm_chip *chip, int pcr_idx,

I don't think we want this, do we?  That's only for API access which
should be available when the TPM isn't selected.  Given that get/put
are TPM critical operations, they should only appear when inside code
where the TPM has already been selected.  If they appear outside TPM
selected code, I think we want the compile to fail, which is why we
don't want these backup definitions.

James


