Return-Path: <SRS0=Dufg=QI=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6655DC4151A
	for <linux-security-module@archiver.kernel.org>; Fri,  1 Feb 2019 18:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40FC221901
	for <linux-security-module@archiver.kernel.org>; Fri,  1 Feb 2019 18:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbfBASmS (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 1 Feb 2019 13:42:18 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34728 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728135AbfBASmS (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 1 Feb 2019 13:42:18 -0500
Received: by mail-qt1-f193.google.com with SMTP id r14so8767590qtp.1
        for <linux-security-module@vger.kernel.org>; Fri, 01 Feb 2019 10:42:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=fwFQnH9OuB2MvnyRpWht+yCfAp3mugwnL8IAAdrFt5M=;
        b=lcH861fqQfcyK9B50FRitXfHr5H4juoXQq01fg3HGJM5wi6MajNOTLOkzNjE97/Z28
         Hn/Cdo7cyjtE0t194d5f3g6NyAmj9QCP1M4IxKy+Kp3ewY1emYmmgMVfCOJT0/Hf97em
         +2SczkmqgZ5Xm8lvekpBmG/tqEAyuRc64sJMmAMEtvfqC3fNshIP0UbZoWq53xJo9c4A
         J6KXgIlqd2Y5QuS7zUvPSfKNoH4EqJRnM67q6dO6LBU2IH4QrlMSFBdI3jLTIJ7AaJCW
         3PjCViqF5u8sXhN3W/EHbBYVSDY+gZ3tBwZEkJNwrYUM4QGjpWd+DfS+RjXkBaWdsHrj
         uC4g==
X-Gm-Message-State: AJcUukfBu+HUsg/s4Vw3gA/yrBEVVR0GzKsf+gd8fn6Ui0RTnDbX/rjN
        BXBYCmR8hYHBb7ETmTJT9o9xfP5Uuy8=
X-Google-Smtp-Source: ALg8bN7HmZNiBvoGLrsOhjOmh62mH0+md5FzB0sceRpiXhf+0M+tFPz8q52CV0Ao8f9kG5OcDoyurA==
X-Received: by 2002:ac8:fd4:: with SMTP id f20mr41042364qtk.63.1549046536928;
        Fri, 01 Feb 2019 10:42:16 -0800 (PST)
Received: from localhost (ip72-223-3-97.ph.ph.cox.net. [72.223.3.97])
        by smtp.gmail.com with ESMTPSA id o21sm7689506qto.18.2019.02.01.10.42.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 10:42:16 -0800 (PST)
Date:   Fri, 1 Feb 2019 11:42:14 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        James Morris <jmorris@namei.org>,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: Re: [PATCH] tpm/tpm_crb: Avoid unaligned reads in crb_recv():
Message-ID: <20190201184214.aohoxqu7cyngehqk@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        James Morris <jmorris@namei.org>,
        Tomas Winkler <tomas.winkler@intel.com>
References: <20190201111949.14881-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190201111949.14881-1-jarkko.sakkinen@linux.intel.com>
User-Agent: NeoMutt/20180716
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri Feb 01 19, Jarkko Sakkinen wrote:
>The current approach to read first 6 bytes from the response and then tail
>of the response, can cause the 2nd memcpy_fromio() to do an unaligned read
>(e.g. read 32-bit word from address aligned to a 16-bits), depending on how
>memcpy_fromio() is implemented. If this happens, the read will fail and the
>memory controller will fill the read with 1's.
>
>This was triggered by 170d13ca3a2f, which should be probably refined to
>check and react to the address alignment. Before that commit, on x86
>memcpy_fromio() turned out to be memcpy(). By a luck GCC has done the right
>thing (from tpm_crb's perspective) for us so far, but we should not rely on
>that. Thus, it makes sense to fix this also in tpm_crb, not least because
>the fix can be then backported to stable kernels and make them more robust
>when compiled in differing environments.
>
>Cc: stable@vger.kernel.org
>Cc: Linus Torvalds <torvalds@linux-foundation.org>
>Cc: James Morris <jmorris@namei.org>
>Cc: Tomas Winkler <tomas.winkler@intel.com>
>Cc: Jerry Snitselaar <jsnitsel@redhat.com>
>Fixes: 30fc8d138e91 ("tpm: TPM 2.0 CRB Interface")
>Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>---
> drivers/char/tpm/tpm_crb.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
>index 36952ef98f90..7f47e43aa9f1 100644
>--- a/drivers/char/tpm/tpm_crb.c
>+++ b/drivers/char/tpm/tpm_crb.c
>@@ -288,18 +288,18 @@ static int crb_recv(struct tpm_chip *chip, u8 *buf, size_t count)
> 	unsigned int expected;
>
> 	/* sanity check */
>-	if (count < 6)
>+	if (count < 8)
> 		return -EIO;
>
> 	if (ioread32(&priv->regs_t->ctrl_sts) & CRB_CTRL_STS_ERROR)
> 		return -EIO;
>
>-	memcpy_fromio(buf, priv->rsp, 6);
>+	memcpy_fromio(buf, priv->rsp, 8);
> 	expected = be32_to_cpup((__be32 *) &buf[2]);
>-	if (expected > count || expected < 6)
>+	if (expected > count || expected < 8)
> 		return -EIO;
>
>-	memcpy_fromio(&buf[6], &priv->rsp[6], expected - 6);
>+	memcpy_fromio(&buf[8], &priv->rsp[8], expected - 8);
>
> 	return expected;
> }
>-- 
>2.17.1
>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
