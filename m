Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6637415C15E
	for <linux-security-module@vger.kernel.org>; Fri,  2 Aug 2024 15:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722611974; cv=none; b=hBITx96ouY4IGYnPLrQB3DlkyNZqcdH86UbQq1Zc/RCh5MlCU+Am/ra6VXCJjy0NpMinAJLAWA3due/VpsUr6rxBSXnxueW1Z1V25Th9OSPbyJgdZ5P48yGwxmrIjw71+br7PttFcq3z+8V58jS5pLUKTYEWFufSSOciF9LnIVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722611974; c=relaxed/simple;
	bh=yf3/DcLNflmZVVdGmRQQ3m5ZTvXvQqIBueCI1PWXdwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qwKjnJ4s33Wjnse/27F63WFgd+KqnK9h4SCV8KoTTOwNeVwXbHrWr97RiOWQrhBB7x9gzukxglkpgbFQTDTZ4h8KSBCyyc858zsKtmhQomsVpU5u0eBnVIgx8ByQwmqvwIkxBJKjxIbVRtRCoqNs++VibFTsCkABGHevi0ibsBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BKvudFLM; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BKvudFLM"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5d5e97b8a22so3475575eaf.2
        for <linux-security-module@vger.kernel.org>; Fri, 02 Aug 2024 08:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722611970; x=1723216770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hVQxTJ6XiBlo2K6vivKGyjwtwzsISazu9ikSPPmJl/k=;
        b=BKvudFLMgRl2q3rvuTbFgJvNchsosRZK4tIukjujKRw1dEr89Jz2GO8z9IurlGrvcP
         Wjh5ti/uV11DwSPsTUIGYK5qVo/QekWR6Xhk9lcbuWearkuOEX6HWZgDHlTSIrsdYDah
         xjdBbMymQPfOrplba70BKcxbvLeHMSmEFbKGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722611970; x=1723216770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hVQxTJ6XiBlo2K6vivKGyjwtwzsISazu9ikSPPmJl/k=;
        b=hQHVPqWaMHh0P20g3kjUoiRrGuz3nq26LTDNJxuCyY150YKwPzr4jECqV/bn/D2oOI
         EdChGzxACQOJ6w7k0dFQw+ZciXc00vD+Bn3nj3tGtg8OM3jEWi7dfKaqeZfDH+Lv3E72
         evApx0InaVzW3h+PruUOsqr+6sOTzehjexs7QJ3TSOkFzbfc1HvPwZUFMeUEHO3BL4o9
         ijUfBfWKvp5d2IRjEROKu4i9/ZW+lsrkJRLi+893fGJ0rJXjk8PBJw5/EU5GuO1Sox3q
         U+xvXMCMHaaDoJyYlLtCYEG2Kzns0AjQe74rMx7UiNdxkiupkXauioxz0CjYMK2Ukrm8
         fzJg==
X-Gm-Message-State: AOJu0YwKr0cGjioHxr6SIvn2xeq16ttkS91rPSLz03HW9Zey5ZgfTeOL
	clZogKvZp+W141R84FZHgqIN75iG8/pz9fMHwSREeX87KQctvobWj3HZj5aVpWwzcEJd92lJc0o
	=
X-Google-Smtp-Source: AGHT+IGhBXi0P/Q9pqRshhZ4KpoWiGJDWcupJwZt/d9vqt2tuLI/AE/iLjxcDlizFLsNxatFGXIffA==
X-Received: by 2002:a05:6820:502:b0:5d5:c805:acae with SMTP id 006d021491bc7-5d663ac5c0emr5113495eaf.5.1722611970044;
        Fri, 02 Aug 2024 08:19:30 -0700 (PDT)
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com. [209.85.160.47])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5d757196f9fsm354107eaf.11.2024.08.02.08.19.29
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Aug 2024 08:19:29 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2689f749649so390854fac.0
        for <linux-security-module@vger.kernel.org>; Fri, 02 Aug 2024 08:19:29 -0700 (PDT)
X-Received: by 2002:a05:6870:b025:b0:25e:24b:e65b with SMTP id
 586e51a60fabf-26891f23fc9mr4898926fac.42.1722611968742; Fri, 02 Aug 2024
 08:19:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718202359.127482-1-jettrink@chromium.org>
In-Reply-To: <20240718202359.127482-1-jettrink@chromium.org>
From: Jett Rink <jettrink@chromium.org>
Date: Fri, 2 Aug 2024 09:19:17 -0600
X-Gmail-Original-Message-ID: <CAK+PMK4yBkqpfJdcQ5M93DKB1-7Wn4zJmx6VmqNghogJJhDa6A@mail.gmail.com>
Message-ID: <CAK+PMK4yBkqpfJdcQ5M93DKB1-7Wn4zJmx6VmqNghogJJhDa6A@mail.gmail.com>
Subject: Re: [PATCH v2] tpm: Add new device/vendor ID 0x50666666
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-security-module@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Could I get some feedback on this patch please? Is there something I
am not doing correctly?

-Jett

On Thu, Jul 18, 2024 at 2:24=E2=80=AFPM Jett Rink <jettrink@chromium.org> w=
rote:
>
> Accept another DID:VID for the next generation Google TPM. This TPM
> has the same Ti50 firmware and fulfills the same interface.
>
> Signed-off-by: Jett Rink <jettrink@chromium.org>
> ---
>
> Changes in v2:
> Patchset 2 applies cleanly
>
>  drivers/char/tpm/tpm_tis_i2c_cr50.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_t=
is_i2c_cr50.c
> index adf22992138e..b50005ccfc5e 100644
> --- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
> +++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
> @@ -31,7 +31,8 @@
>  #define TPM_CR50_TIMEOUT_SHORT_MS      2               /* Short timeout =
during transactions */
>  #define TPM_CR50_TIMEOUT_NOIRQ_MS      20              /* Timeout for TP=
M ready without IRQ */
>  #define TPM_CR50_I2C_DID_VID           0x00281ae0L     /* Device and ven=
dor ID reg value */
> -#define TPM_TI50_I2C_DID_VID           0x504a6666L     /* Device and ven=
dor ID reg value */
> +#define TPM_TI50_DT_I2C_DID_VID                0x504a6666L     /* Device=
 and vendor ID reg value */
> +#define TPM_TI50_OT_I2C_DID_VID                0x50666666L     /* Device=
 and vendor ID reg value */
>  #define TPM_CR50_I2C_MAX_RETRIES       3               /* Max retries du=
e to I2C errors */
>  #define TPM_CR50_I2C_RETRY_DELAY_LO    55              /* Min usecs betw=
een retries on I2C */
>  #define TPM_CR50_I2C_RETRY_DELAY_HI    65              /* Max usecs betw=
een retries on I2C */
> @@ -741,14 +742,18 @@ static int tpm_cr50_i2c_probe(struct i2c_client *cl=
ient)
>         }
>
>         vendor =3D le32_to_cpup((__le32 *)buf);
> -       if (vendor !=3D TPM_CR50_I2C_DID_VID && vendor !=3D TPM_TI50_I2C_=
DID_VID) {
> +       if (vendor !=3D TPM_CR50_I2C_DID_VID &&
> +           vendor !=3D TPM_TI50_DT_I2C_DID_VID &&
> +           vendor !=3D TPM_TI50_OT_I2C_DID_VID) {
>                 dev_err(dev, "Vendor ID did not match! ID was %08x\n", ve=
ndor);
>                 tpm_cr50_release_locality(chip, true);
>                 return -ENODEV;
>         }
>
>         dev_info(dev, "%s TPM 2.0 (i2c 0x%02x irq %d id 0x%x)\n",
> -                vendor =3D=3D TPM_TI50_I2C_DID_VID ? "ti50" : "cr50",
> +                vendor =3D=3D TPM_CR50_I2C_DID_VID    ? "cr50" :
> +                vendor =3D=3D TPM_TI50_DT_I2C_DID_VID ? "ti50 DT" :
> +                                                    "ti50 OT",
>                  client->addr, client->irq, vendor >> 16);
>         return tpm_chip_register(chip);
>  }
> --
> 2.45.2.1089.g2a221341d9-goog
>
