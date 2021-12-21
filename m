Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA83C433F5
	for <linux-security-module@archiver.kernel.org>; Tue, 21 Dec 2021 01:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbhLUBNX (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 20 Dec 2021 20:13:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbhLUBNX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 20 Dec 2021 20:13:23 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4BBC06173F
        for <linux-security-module@vger.kernel.org>; Mon, 20 Dec 2021 17:13:22 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id f3so201710qtf.6
        for <linux-security-module@vger.kernel.org>; Mon, 20 Dec 2021 17:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ImhGZNgWQ6RSPs0/MNgkgB9bxoki7Hld1WRDVZLnPFc=;
        b=VLRYoqQphPkZHC7/mVdrVwi4JRSSX4/EcZlF/HwnA+2dvfr3EppJPZ0e75yD6cqvEi
         eOOQayG7v6CLJSO53F9A8v4Beerdugi4zsWwEkWCVp+xAlxnAkkspTMCvrUz76/T6Zs+
         fpFvNNWUkhq3CV0yI7aAkxmYtxbTVL+jvEjbZrT+D/4sT/o85ScW0wzk69lPb7ReIPAn
         eDC7+AxN83mEdK/4zPzRTGcyBGPMEaWrGVvLD0wwyUil1aii0qxF1Hty6R7Jn5cwydtA
         SNtMHDoxHQN6uHtWj9SKDLtXPDB5YielKtH/KMqWLBH+2xVv5wFuCBXfq2FxvLRwf12Q
         FL3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ImhGZNgWQ6RSPs0/MNgkgB9bxoki7Hld1WRDVZLnPFc=;
        b=6/UFjTkJ4WQZISnIUndFueTbqWQmzmF7rMTXMM+VX7PQH1w2wt9iVsdWkDrQuKBzhe
         H0HWMmU1c1YcVhgxE64vRV4oO2KGkQK7WSLBFe+Ta/7bTf3t+6veqlVOHRxgbnGphMNe
         SDsFVHbQsAFHUGhO9JHa83UO+k/YX1cug0QnFtOwK5j5AAw6v11LS5l9bkC24T3D+1Qn
         ZZiGSBANGl8YAsbUw5kbODXbkSWRWa8AXRamay7DV9xDsMQcKLAxQZ36eusnTzAgHmLW
         wtxE43hYBaMLKe3n5qxLpzBuSjRKhS8MwKpXWElvUVkqFzkP6LjDmmJauRUoyNU0KvJd
         U9zg==
X-Gm-Message-State: AOAM5302wRCPL3yW7QmrkxBgSfwvzjAY9KvIEdbYzUuMuXPT8031Jq/m
        EIXSTJ+hBnuPR2vfaJCSh8pQ3Q==
X-Google-Smtp-Source: ABdhPJw+4sRAzJSi3LnPVoLw1Dt7Bkx+hmVXajl3aaZlbjv5jLRVbLeuQXoICu0pNeKnjSZ3FNLWJw==
X-Received: by 2002:ac8:45d2:: with SMTP id e18mr621640qto.112.1640049202009;
        Mon, 20 Dec 2021 17:13:22 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id b9sm15854858qtb.53.2021.12.20.17.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 17:13:21 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mzTiS-006yyf-C9; Mon, 20 Dec 2021 21:13:20 -0400
Date:   Mon, 20 Dec 2021 21:13:20 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Tyrel Datwyler <tyreld@linux.ibm.com>, jarkko@kernel.org,
        peterhuewe@gmx.de, linux-integrity@vger.kernel.org,
        Korrapati.Likhitha@ibm.com, pavrampu@in.ibm.com,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, gcwilson@us.ibm.com,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] tpm: Fix kexec crash due to access to ops NULL pointer
 (powerpc)
Message-ID: <20211221011320.GM6467@ziepe.ca>
References: <20211212012804.1555661-1-stefanb@linux.ibm.com>
 <1052cd36-1b85-5d36-045f-5c5bf9f0fc4e@linux.ibm.com>
 <d9eafa8f-4006-4bc2-c09b-6b02a14c6ef3@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d9eafa8f-4006-4bc2-c09b-6b02a14c6ef3@linux.ibm.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Dec 20, 2021 at 08:05:58PM -0500, Stefan Berger wrote:

> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index ddaeceb7e109..4cb908349b31 100644
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -473,15 +473,8 @@ static void tpm_del_char_device(struct tpm_chip *chip)
>         mutex_unlock(&idr_lock);
> 
>         /* Make the driver uncallable. */
> -       down_write(&chip->ops_sem);
> -       if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> -               if (!tpm_chip_start(chip)) {
> -                       tpm2_shutdown(chip, TPM2_SU_CLEAR);
> -                       tpm_chip_stop(chip);
> -               }
> -       }
> -       chip->ops = NULL;
> -       up_write(&chip->ops_sem);
> +       if (chip->ops)

ops cannot be read without locking

Jason
