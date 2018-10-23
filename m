Return-Path: <SRS0=XO9p=ND=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBB1C46475
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Oct 2018 10:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E27B3207DD
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Oct 2018 10:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AkGw8u+v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E27B3207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728960AbeJWSbK (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 23 Oct 2018 14:31:10 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:33689 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729006AbeJWSbJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 23 Oct 2018 14:31:09 -0400
Received: by mail-io1-f66.google.com with SMTP id l25-v6so506766ioj.0
        for <linux-security-module@vger.kernel.org>; Tue, 23 Oct 2018 03:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4Tv2EGbKZdg+Y7fx+ddBCa34X7mu4KVtVnJFMpnx0Xs=;
        b=AkGw8u+vUKT55bLIt0y+4HvD9BUQafuVz1OaPVHQHXytLYKVHDNW86rAo3nvsvuiVN
         CjuVUlXtukmjblDAh5dRofmkFehKD1nFkKkiWh/8W9WHwiJbbuYObGgakejBIYeyYzXQ
         F4wWkG2GjUdKYpMTyEgacPEGsTNwvlb/Hi50Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4Tv2EGbKZdg+Y7fx+ddBCa34X7mu4KVtVnJFMpnx0Xs=;
        b=chX5qJ52EBFmweIHBAQ1nUdebHOxFUxeSIRf4hzTdSYQTEbDCakvbeanXp/sU3t9qf
         o3JnfEfpYBFz/s9xglyJVTLhpI8Vtr0Hzdzkd6enH0FAAikCMUjy94mSt3VKYm0s2lbB
         Q3rRD3qQkLNyl4IdnQ5nwy2a9RZwgAb3VK3qR23w8dCZBXWbr+RCvdynuTPqOf73bTXk
         j1EBREKdN3HwMXF3n5cdVQiEUblOPiCXEx2MproHZJhLElOhM2u7P6Zpyd3vaz1a0XVI
         s4WNfv4CSKdVLnzXL76NC7cwaWNXUR3OEf4VNsiu1R0cBdTT6QqmR13upLcidD9VDuV9
         VZRQ==
X-Gm-Message-State: AGRZ1gLF4KYCO7Xsy6Wjs1moHfLLxWD6WoRgFBZ9aV5iZ8zN/tIAm0zt
        UvnKMk2djN54BGb0lggLMAfwjZn/GGqDCUwezusNzg==
X-Google-Smtp-Source: AJdET5fO+o6NnHi/zF1ym7Bw8/0GcHFMeDQrsXOlOJJ6xQdcSlAVFn18nMAvoJcVxICAxdV5DOmjG7iPBWt+s0sn/+w=
X-Received: by 2002:a6b:be83:: with SMTP id o125-v6mr11125789iof.173.1540289305349;
 Tue, 23 Oct 2018 03:08:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:5910:0:0:0:0:0 with HTTP; Tue, 23 Oct 2018 03:08:24
 -0700 (PDT)
In-Reply-To: <1540278091.3347.9.camel@HansenPartnership.com>
References: <1540193596.3202.7.camel@HansenPartnership.com>
 <1540193787.3202.10.camel@HansenPartnership.com> <CAKv+Gu-gYLY1vmtgFC0MTkBfsAkPz658ELaGW78MbD=6ROrLFQ@mail.gmail.com>
 <1540278091.3347.9.camel@HansenPartnership.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 23 Oct 2018 07:08:24 -0300
Message-ID: <CAKv+Gu8T8yGEu2GWWKzLXR=wgd=mYHcTYLrD69_zpaddQK3Zxw@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] tpm2-sessions: Add full HMAC and encrypt/decrypt
 session handling
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 23 October 2018 at 04:01, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
> On Mon, 2018-10-22 at 19:19 -0300, Ard Biesheuvel wrote:
> [...]
>> > +static void hmac_init(struct shash_desc *desc, u8 *key, int
>> > keylen)
>> > +{
>> > +       u8 pad[SHA256_BLOCK_SIZE];
>> > +       int i;
>> > +
>> > +       desc->tfm = sha256_hash;
>> > +       desc->flags = CRYPTO_TFM_REQ_MAY_SLEEP;
>>
>> I don't think this actually does anything in the shash API
>> implementation, so you can drop this.
>
> OK, I find crypto somewhat hard to follow.  There were bits I had to
> understand, like when I wrote the CFB implementation or when I fixed
> the ECDH scatterlist handling, but I've got to confess, in time
> honoured tradition I simply copied this from EVM crypto without
> actually digging into the code to understand why.
>

Yeah, it is notoriously hard to use, and we should try to improve that.

>>  However, I take it this means that hmac_init() is never called in
>> contexts where sleeping is not allowed? For the relevance of that,
>> please see below.
>
> Right, these routines are always called as an adjunct to a TPM
> operation and TPM operations can sleep, so we must at least have kernel
> thread context.
>
> [...]
>> > +       /* encrypt before HMAC */
>> > +       if (auth->attrs & TPM2_SA_DECRYPT) {
>> > +               struct scatterlist sg[1];
>> > +               u16 len;
>> > +               SKCIPHER_REQUEST_ON_STACK(req, auth->aes);
>> > +
>> > +               skcipher_request_set_tfm(req, auth->aes);
>> > +               skcipher_request_set_callback(req,
>> > CRYPTO_TFM_REQ_MAY_SLEEP,
>> > +                                             NULL, NULL);
>> > +
>>
>> Your crypto_alloc_skcipher() call [further down] does not mask out
>> CRYPTO_ALG_ASYNC, and so it permits asynchronous implementations to
>> be selected. Your generic cfb template only permits synchronous
>> implementations, since it wraps the cipher directly (which is always
>> synchronous). However, we have support in the tree for some
>> accelerators that implement cfb(aes), and those will return
>> -EINPROGRESS when invoking crypto_skcipher_en/decrypt(req), which you
>> are not set up to handle.
>>
>> So the simple solution is to call 'crypto_alloc_skcipher("cfb(aes)",
>> 0, CRYPTO_ALG_ASYNC)' below instead.
>>
>> However, I would prefer it if we permit asynchronous skciphers here.
>> The reason is that, on a given platform, the accelerator may be the
>> only truly time invariant AES implementation that is available, and
>> since we are dealing with the TPM, a bit of paranoia does not hurt.
>> It also makes it easier to implement it as a [time invariant] SIMD
>> based asynchronous skcipher, which are simpler than synchronous ones
>> since they don't require a non-SIMD fallback path for calls from
>> contexts where the SIMD unit may not be used.
>>
>> I have already implemented cfb(aes) for arm64/NEON. I will post the
>> patch after the merge window closes.
>>
>> > +               /* need key and IV */
>> > +               KDFa(auth->session_key, SHA256_DIGEST_SIZE
>> > +                    + auth->passphraselen, "CFB", auth->our_nonce,
>> > +                    auth->tpm_nonce, AES_KEYBYTES +
>> > AES_BLOCK_SIZE,
>> > +                    auth->scratch);
>> > +               crypto_skcipher_setkey(auth->aes, auth->scratch,
>> > AES_KEYBYTES);
>> > +               len = tpm_get_inc_u16(&p);
>> > +               sg_init_one(sg, p, len);
>> > +               skcipher_request_set_crypt(req, sg, sg, len,
>> > +                                          auth->scratch +
>> > AES_KEYBYTES);
>> > +               crypto_skcipher_encrypt(req);
>>
>> So please consider replacing this with something like.
>>
>> DECLARE_CRYPTO_WAIT(wait); [further up]
>> skcipher_request_set_callback(req, CRYPTO_TFM_REQ_MAY_SLEEP,
>>                               crypto_req_done, &wait);
>> crypto_wait_req(crypto_skcipher_encrypt(req), &wait);
>
> Sure, I can do this ... the crypto skcipher handling was also cut and
> paste, but I forget where from this time.  So what I think you're
> asking for is below as the incremental diff?  I've tested this out and
> it all works fine in my session testing environment (and on my real
> laptop) ... although since I'm fully sync, I won't really have tested
> the -EINPROGRESS do the wait case.
>

Yes that looks fine. I will try to test this on one of my arm64
systems, but it may take me some time to get around to it.

In any case,

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org> # crypto API parts

>
> diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
> index 422c3ec64f8c..bbd3e8580954 100644
> --- a/drivers/char/tpm/tpm2-sessions.c
> +++ b/drivers/char/tpm/tpm2-sessions.c
> @@ -165,7 +165,6 @@ static void hmac_init(struct shash_desc *desc, u8 *key, int keylen)
>         int i;
>
>         desc->tfm = sha256_hash;
> -       desc->flags = CRYPTO_TFM_REQ_MAY_SLEEP;
>         crypto_shash_init(desc);
>         for (i = 0; i < sizeof(pad); i++) {
>                 if (i < keylen)
> @@ -244,7 +243,6 @@ static void KDFe(u8 z[EC_PT_SZ], const char *str, u8 *pt_u, u8 *pt_v,
>         __be32 c = cpu_to_be32(1);
>
>         desc->tfm = sha256_hash;
> -       desc->flags = CRYPTO_TFM_REQ_MAY_SLEEP;
>
>         crypto_shash_init(desc);
>         /* counter (BE) */
> @@ -445,7 +443,6 @@ void tpm_buf_fill_hmac_session(struct tpm_buf *buf, struct tpm2_auth *auth)
>         auth->ordinal = head->ordinal;
>
>         desc->tfm = sha256_hash;
> -       desc->flags = CRYPTO_TFM_REQ_MAY_SLEEP;
>
>         cc = be32_to_cpu(head->ordinal);
>
> @@ -514,10 +511,11 @@ void tpm_buf_fill_hmac_session(struct tpm_buf *buf, struct tpm2_auth *auth)
>                 struct scatterlist sg[1];
>                 u16 len;
>                 SKCIPHER_REQUEST_ON_STACK(req, auth->aes);
> +               DECLARE_CRYPTO_WAIT(wait);
>
>                 skcipher_request_set_tfm(req, auth->aes);
>                 skcipher_request_set_callback(req, CRYPTO_TFM_REQ_MAY_SLEEP,
> -                                             NULL, NULL);
> +                                             crypto_req_done, &wait);
>
>                 /* need key and IV */
>                 KDFa(auth->session_key, SHA256_DIGEST_SIZE
> @@ -529,7 +527,7 @@ void tpm_buf_fill_hmac_session(struct tpm_buf *buf, struct tpm2_auth *auth)
>                 sg_init_one(sg, p, len);
>                 skcipher_request_set_crypt(req, sg, sg, len,
>                                            auth->scratch + AES_KEYBYTES);
> -               crypto_skcipher_encrypt(req);
> +               crypto_wait_req(crypto_skcipher_encrypt(req), &wait);
>                 /* reset p to beginning of parameters for HMAC */
>                 p -= 2;
>         }
> @@ -755,7 +753,6 @@ int tpm_buf_check_hmac_response(struct tpm_buf *buf, struct tpm2_auth *auth,
>          * with rphash
>          */
>         desc->tfm = sha256_hash;
> -       desc->flags = CRYPTO_TFM_REQ_MAY_SLEEP;
>         crypto_shash_init(desc);
>         /* yes, I know this is now zero, but it's what the standard says */
>         crypto_shash_update(desc, (u8 *)&head->return_code,
> @@ -786,10 +783,11 @@ int tpm_buf_check_hmac_response(struct tpm_buf *buf, struct tpm2_auth *auth,
>         if (auth->attrs & TPM2_SA_ENCRYPT) {
>                 struct scatterlist sg[1];
>                 SKCIPHER_REQUEST_ON_STACK(req, auth->aes);
> +               DECLARE_CRYPTO_WAIT(wait);
>
>                 skcipher_request_set_tfm(req, auth->aes);
>                 skcipher_request_set_callback(req, CRYPTO_TFM_REQ_MAY_SLEEP,
> -                                             NULL, NULL);
> +                                             crypto_req_done, &wait);
>
>                 /* need key and IV */
>                 KDFa(auth->session_key, SHA256_DIGEST_SIZE
> @@ -801,7 +799,7 @@ int tpm_buf_check_hmac_response(struct tpm_buf *buf, struct tpm2_auth *auth,
>                 sg_init_one(sg, p, len);
>                 skcipher_request_set_crypt(req, sg, sg, len,
>                                            auth->scratch + AES_KEYBYTES);
> -               crypto_skcipher_decrypt(req);
> +               crypto_wait_req(crypto_skcipher_decrypt(req), &wait);
>         }
>
>   out:
> @@ -965,7 +963,6 @@ static int parse_create_primary(struct tpm_chip *chip, u8 *data)
>         tmp = resp;
>         /* now we have the public area, compute the name of the object */
>         desc->tfm = sha256_hash;
> -       desc->flags = CRYPTO_TFM_REQ_MAY_SLEEP;
>         put_unaligned_be16(TPM2_ALG_SHA256, chip->tpmkeyname);
>         crypto_shash_init(desc);
>         crypto_shash_update(desc, resp, len);
