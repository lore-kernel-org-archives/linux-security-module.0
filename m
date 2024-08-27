Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079D81C6F55
	for <linux-security-module@vger.kernel.org>; Tue, 27 Aug 2024 15:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724773735; cv=none; b=MYZU9Vge6MHJAEIohGcuAHIgV4fcUk3CNySQgp26PxoO+9aABu3oTya8J96QeowYiNXTEOLkGdV56lHrwFBNP+P/PruUWaSkwDxCtWkktCx46dhNaCP2BjoH0vpRWwep3ROFwBdYKthhIAN7Fjsgu1Xgy1J++f6SU8sZbnebWtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724773735; c=relaxed/simple;
	bh=yMIqIqsHc58PbYXTEzoWmcGe7WxkG66Dfoev7TszcS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NpiXHtDR8RQ0ELxpRfued48wFmHJ7Ui2K5vIzEVMfKJxW7B2Uu79VwTQ1EjLwZF9ktdR9X5aLKVLjT8FWpG/ADZ4pcLtOp4LJLt5Cqajyxlr2eu2mdiiBUdfYWath+eJvMR9Rvqd6ArrIT7BrKsstfsId6KirQwHl0pvf1RqIkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MdltamPQ; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MdltamPQ"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-39d47a9ffd5so19644325ab.2
        for <linux-security-module@vger.kernel.org>; Tue, 27 Aug 2024 08:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724773733; x=1725378533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MyZU/kJprJK+uVidaloko4y85cSY8MDsjFf1FeduaFk=;
        b=MdltamPQciG6RU3dSTnCanxGx2xuSZDcHIE0JQ7fNxJnrpJm5983BtfBWiO0MzihhN
         QxOXlUtBIbKr0ixV43oQmZW5+a8qSLYCpSh5mkObweiE4nyKGhHsy/0G+/eLpAIQbA0D
         F8pjxsgKEI26w0vtowJxpM+g1vS9bfzDLUsf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724773733; x=1725378533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MyZU/kJprJK+uVidaloko4y85cSY8MDsjFf1FeduaFk=;
        b=u2tEizish9YdZeLSo1lLNxtJS9HGD9XGpAEdh55DeqURxAjvrMyUquFfjETi8XVjjx
         xMBcSGCdn+DBfpKp7nefqQoK3xqOLGXu9FmpmhJy67ddg6PJ3f2u7rM3nFwiCSHKDFDH
         35/mZApMjSiE3ruDLaC3mPOS/fmz/I4udLxl+RLJJsfJwrwWWbPh6SJ+Yi4+cjQiDpnr
         y08bDbKERpxAzX2keBNLiQpuPgXiMNGVL2Q9EsUXhd9vwmYQqJ9Qw8+CiXNTok8E9KiD
         uunNHgnCKgU6Kof7ujuGEVJO/jeXfo5O3leCNsvG3O6A6Q6m773izVJlu75R9+jdHmA4
         4yOQ==
X-Gm-Message-State: AOJu0YxBy407dE3g737BuhDoo9Io647/v8g3R7pPL5SsJT812rBwJr0R
	4BHvs0UfAY1lJeGp4BiVAv6NauR2PT6tgVRovTJW3USioKoU4qUMLtx4voNjz2RfC9PwNPPRD/L
	a3pnD
X-Google-Smtp-Source: AGHT+IFratU3IMOoEgFZa13zQbCNM1TKm6ZgDQDvwWLHn8vTFnlb+Ug41G4qvr2ljHD7L4wRW0FjeA==
X-Received: by 2002:a05:6e02:1547:b0:374:a781:64b9 with SMTP id e9e14a558f8ab-39e3c989d00mr155011315ab.13.1724773732683;
        Tue, 27 Aug 2024 08:48:52 -0700 (PDT)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com. [209.85.214.172])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9ad54fe5sm8094169a12.65.2024.08.27.08.48.51
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 08:48:52 -0700 (PDT)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-202018541afso229785ad.1
        for <linux-security-module@vger.kernel.org>; Tue, 27 Aug 2024 08:48:51 -0700 (PDT)
X-Received: by 2002:a17:902:d4c6:b0:1fa:fe30:8fce with SMTP id
 d9443c01a7336-204e50afb1emr3053325ad.23.1724773730828; Tue, 27 Aug 2024
 08:48:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806165134.1692428-1-jettrink@chromium.org>
In-Reply-To: <20240806165134.1692428-1-jettrink@chromium.org>
From: Jett Rink <jettrink@chromium.org>
Date: Tue, 27 Aug 2024 09:48:39 -0600
X-Gmail-Original-Message-ID: <CAK+PMK62crXQurf1R3vQ=4mtC3pLCKUjA3Vw-qZggcK2ucdrBQ@mail.gmail.com>
Message-ID: <CAK+PMK62crXQurf1R3vQ=4mtC3pLCKUjA3Vw-qZggcK2ucdrBQ@mail.gmail.com>
Subject: Re: [PATCH v5] tpm: Add new device/vendor ID 0x50666666
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-security-module@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I just wanted to follow up to ensure this patch got accepted. Is there
anything else I need to do?

-Jett

On Tue, Aug 6, 2024 at 10:51=E2=80=AFAM Jett Rink <jettrink@chromium.org> w=
rote:
>
> Accept another DID:VID for the next generation Google TPM. This TPM
> has the same Ti50 firmware and fulfills the same interface.
>
> Suggested-by: Jarkko Sakkinen <jarkko@kernel.org>
> Signed-off-by: Jett Rink <jettrink@chromium.org>
> ---
>
> Changes in v5:
> Correct Suggested-by tag form.
>
> Changes in v4:
> Add Suggested-by tag. Sorry that I forget.
>
> Changes in v3:
> Refactor ternary operators into helper method.
>
> Changes in v2:
> Patchset 2 applies cleanly
>
>  drivers/char/tpm/tpm_tis_i2c_cr50.c | 30 ++++++++++++++++++++++++++---
>  1 file changed, 27 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_t=
is_i2c_cr50.c
> index adf22992138e..1f83cfe2724c 100644
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
> @@ -668,6 +669,27 @@ static const struct of_device_id of_cr50_i2c_match[]=
 =3D {
>  MODULE_DEVICE_TABLE(of, of_cr50_i2c_match);
>  #endif
>
> +/**
> + * tpm_cr50_vid_to_name() - Maps VID to name.
> + * @vendor:    Vendor identifier to map to name
> + *
> + * Return:
> + *     A valid string for the vendor or empty string
> + */
> +static const char *tpm_cr50_vid_to_name(u32 vendor)
> +{
> +       switch (vendor) {
> +       case TPM_CR50_I2C_DID_VID:
> +               return "cr50";
> +       case TPM_TI50_DT_I2C_DID_VID:
> +               return "ti50 DT";
> +       case TPM_TI50_OT_I2C_DID_VID:
> +               return "ti50 OT";
> +       default:
> +               return "";
> +       }
> +}
> +
>  /**
>   * tpm_cr50_i2c_probe() - Driver probe function.
>   * @client:    I2C client information.
> @@ -741,14 +763,16 @@ static int tpm_cr50_i2c_probe(struct i2c_client *cl=
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
> +                tpm_cr50_vid_to_name(vendor),
>                  client->addr, client->irq, vendor >> 16);
>         return tpm_chip_register(chip);
>  }
> --
> 2.46.0.rc2.264.g509ed76dc8-goog
>
