Return-Path: <SRS0=szIC=CC=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A70C433DF
	for <linux-security-module@archiver.kernel.org>; Mon, 24 Aug 2020 20:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CB982067C
	for <linux-security-module@archiver.kernel.org>; Mon, 24 Aug 2020 20:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VLcaG2KY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgHXUsT (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 24 Aug 2020 16:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbgHXUsS (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 24 Aug 2020 16:48:18 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AB7C0613ED
        for <linux-security-module@vger.kernel.org>; Mon, 24 Aug 2020 13:48:18 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id c12so7342364qtn.9
        for <linux-security-module@vger.kernel.org>; Mon, 24 Aug 2020 13:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b0dMTDRnUhEkAHYVdYfn/08Q1o/9RvThNxCcV4uJXNE=;
        b=VLcaG2KY6jHt9fT2ogXrqKUrUhejLEzg0rK3zHcMZV2x0Sra8cq30NHNTaqkxYa3uU
         1AxeiTm0UAp/H3r3msDyVfGyB/H/kDzAOH7sPQbOYunttGhMmNjsdX1Ba0Z0Xr0t4g2M
         2KCIvdPgRdidAomVX4YqxOlN+P6H+iros1IYsrjRBX9VeuIra7PUIR58JnK2Xj4acFSn
         HoI+6ztMjuGtqgWgTLI/5vl30i5iNz+xlYKnkootHzYq2sVOYbgz/BUgE6UajSmY3YNx
         /ZArGdO10+wGlPlTfrIqpE3NpHIBIveApv8etYZW1LuLtxciyw04QDZhr9D/SOEaJh3D
         gq0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b0dMTDRnUhEkAHYVdYfn/08Q1o/9RvThNxCcV4uJXNE=;
        b=Gyvy1fHeIOhZOA68N0ZiY5u+lDKN8IRGH3dim2I+sXQptq9HbvyobtHWSqLfDEn+aT
         Pk8ryOzzPANfT+tvsXdgPc4UnW53ggNDqHrkmZNCddKzpSbkPQaJFryA3d/fhklFJTab
         MvN0gyk1bgHlcGwAfwNPnko2nPdOHPze++ZNuW9Ffpd42yRaY77OXgikyxqi6nJj7XEB
         UUD+KYSJTvrfmPntimmiMlWF+J+CBgeB0e7c7nMuSO9KyGWUBu5ck5GJ3qYyyO51uH8T
         WEsw6gpkoZc4bLa/XNZj6QNKIjlfn9dSbcRkB+f8j1VXKEU+zqqm31cGM2VZPiLGqdzU
         8IhQ==
X-Gm-Message-State: AOAM5327m7wYMN+pG11fbuDYM43P3t5HIarIRnvYqW71PMvLVBCtOVvM
        oQQTC5FgQ4toFqjCI6StHWR991E1zQNBkdNKTFaQMQ==
X-Google-Smtp-Source: ABdhPJwcsOixxkTv5vVNuzhXuPxECYRzO2S6EH/ImCIblX+d1aHrhrEXN56+g0qRu8t4UjSaMjPITlDuPV4fCldNK6s=
X-Received: by 2002:aed:20cb:: with SMTP id 69mr6721963qtb.106.1598302097162;
 Mon, 24 Aug 2020 13:48:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200824204501.1707957-1-khazhy@google.com>
In-Reply-To: <20200824204501.1707957-1-khazhy@google.com>
From:   Khazhismel Kumykov <khazhy@google.com>
Date:   Mon, 24 Aug 2020 13:48:05 -0700
Message-ID: <CACGdZYK7cEmS=WMAvo5PWv04nFBhTuFm6cbOnQ+xUXqs-9_6xA@mail.gmail.com>
Subject: Re: [PATCH] block: grant IOPRIO_CLASS_RT to CAP_SYS_NICE
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Serge Hallyn <serge@hallyn.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000c71f5a05ada5b418"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

--000000000000c71f5a05ada5b418
Content-Type: text/plain; charset="UTF-8"

On Mon, Aug 24, 2020 at 1:45 PM Khazhismel Kumykov <khazhy@google.com> wrote:
>
> CAP_SYS_ADMIN is too broad, and ionice fits into CAP_SYS_NICE's grouping.
>
> Retain CAP_SYS_ADMIN permission for backwards compatibility.
>
> Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
> ---
>  block/ioprio.c                  | 2 +-
>  include/uapi/linux/capability.h | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/block/ioprio.c b/block/ioprio.c
> index 77bcab11dce5..4572456430f9 100644
> --- a/block/ioprio.c
> +++ b/block/ioprio.c
> @@ -69,7 +69,7 @@ int ioprio_check_cap(int ioprio)
>
>         switch (class) {
>                 case IOPRIO_CLASS_RT:
> -                       if (!capable(CAP_SYS_ADMIN))
> +                       if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_NICE))
yikes, sorry for the spam
>                                 return -EPERM;
>                         /* fall through */
>                         /* rt has prio field too */
> diff --git a/include/uapi/linux/capability.h b/include/uapi/linux/capability.h
> index 395dd0df8d08..c6ca33034147 100644
> --- a/include/uapi/linux/capability.h
> +++ b/include/uapi/linux/capability.h
> @@ -288,6 +288,8 @@ struct vfs_ns_cap_data {
>     processes and setting the scheduling algorithm used by another
>     process. */
>  /* Allow setting cpu affinity on other processes */
> +/* Allow setting realtime ioprio class */
> +/* Allow setting ioprio class on other processes */
>
>  #define CAP_SYS_NICE         23
>
> --
> 2.28.0.297.g1956fa8f8d-goog
>

--000000000000c71f5a05ada5b418
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPBgYJKoZIhvcNAQcCoIIO9zCCDvMCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggxpMIIEkjCCA3qgAwIBAgINAewckktV4F6Q7sAtGDANBgkqhkiG9w0BAQsFADBMMSAwHgYDVQQL
ExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UEAxMK
R2xvYmFsU2lnbjAeFw0xODA2MjAwMDAwMDBaFw0yODA2MjAwMDAwMDBaMEsxCzAJBgNVBAYTAkJF
MRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSEwHwYDVQQDExhHbG9iYWxTaWduIFNNSU1FIENB
IDIwMTgwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCUeobu8FdB5oJg6Fz6SFf8YsPI
dNcq4rBSiSDAwqMNYbeTpRrINMBdWuPqVWaBX7WHYMsKQwCOvAF1b7rkD+ROo+CCTJo76EAY25Pp
jt7TYP/PxoLesLQ+Ld088+BeyZg9pQaf0VK4tn23fOCWbFWoM8hdnF86Mqn6xB6nLsxJcz4CUGJG
qAhC3iedFiCfZfsIp2RNyiUhzPAqalkrtD0bZQvCgi5aSNJseNyCysS1yA58OuxEyn2e9itZJE+O
sUeD8VFgz+nAYI5r/dmFEXu5d9npLvTTrSJjrEmw2/ynKn6r6ONueZnCfo6uLmP1SSglhI/SN7dy
L1rKUCU7R1MjAgMBAAGjggFyMIIBbjAOBgNVHQ8BAf8EBAMCAYYwJwYDVR0lBCAwHgYIKwYBBQUH
AwIGCCsGAQUFBwMEBggrBgEFBQcDCTASBgNVHRMBAf8ECDAGAQH/AgEAMB0GA1UdDgQWBBRMtwWJ
1lPNI0Ci6A94GuRtXEzs0jAfBgNVHSMEGDAWgBSP8Et/qC5FJK5NUPpjmove4t0bvDA+BggrBgEF
BQcBAQQyMDAwLgYIKwYBBQUHMAGGImh0dHA6Ly9vY3NwMi5nbG9iYWxzaWduLmNvbS9yb290cjMw
NgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIzLmNybDBn
BgNVHSAEYDBeMAsGCSsGAQQBoDIBKDAMBgorBgEEAaAyASgKMEEGCSsGAQQBoDIBXzA0MDIGCCsG
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
BQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wUQYIKwYBBQUHAQEE
RTBDMEEGCCsGAQUFBzAChjVodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc3Nt
aW1lY2EyMDE4LmNydDAfBgNVHSMEGDAWgBRMtwWJ1lPNI0Ci6A94GuRtXEzs0jA/BgNVHR8EODA2
MDSgMqAwhi5odHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2NhL2dzc21pbWVjYTIwMTguY3JsMA0G
CSqGSIb3DQEBCwUAA4IBAQAzGsyTMuMEs+rU0JhN7+X62InoLA+QLAozxi+mmLGmfS48HalmbNSM
50i9IOpsIW0GqjrLgilzP7b04OWA0eGsQ2PzobSd/6yLpFvdU+R52Iyu6/IVcCoEcWj11PYvmtMp
SZrCvtwvCj+zfJSxNqLmOhITBB1uGneHUHjwTEK87WDqGVcm43pwBMHZ8qMziJdVf8MbKPm4w6a9
1zewg0bTPT33PFWgCFIsqvTcQPEKoL3Kj8e/DBz1DgFhw4WkwfmzmnLamf93T+t9TU+iQdSESxgT
NC8D2u/lHre/+I8qQ3tgofQC+AomdFoGhr+nQj+6O1Sv8BKB1ArDiku4umqVMYICYTCCAl0CAQEw
XzBLMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEhMB8GA1UEAxMYR2xv
YmFsU2lnbiBTTUlNRSBDQSAyMDE4AhABBw5QEQ1RT42XN3T1kVOEMA0GCWCGSAFlAwQCAQUAoIHU
MC8GCSqGSIb3DQEJBDEiBCBWBKq8RqkPlI/7iXWOAUxnsI6i06kb7X3mEsafog/RKDAYBgkqhkiG
9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMDA4MjQyMDQ4MTdaMGkGCSqGSIb3
DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcN
AwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAE
ggEAkpt4H4JcBhl8DYOinmZBG6ajppMHs6OcIONbbzUL8B5DTc/F8C29kwJw8wd2cVXxn2oxvmro
KqAtSOMqmnxiZzMoxtLfnWPPmLxN1zpWtebfBxxoBGYuWlzuU88VIYxhkzgHBwDTaySj4Od4Zc5c
7SGAA68brkgzGXpytlAEXps4iN9r08OfwkC+Uw0WkL4xmaTk9XeQNz7gN6yo70StFpKKQk+7TVRX
oyicYWljQU7HNZkhUJRyW2c0hW23H8/XJc4rSfafg/Yd1xlLOltO0gbPUOTfzRv5qiML63T2T/6k
OE/eOOafIj/WJagycYPSZz5ccn/nTGB80OZBvD0wZA==
--000000000000c71f5a05ada5b418--
