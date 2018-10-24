Return-Path: <SRS0=JlTe=NE=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04181C67863
	for <linux-security-module@archiver.kernel.org>; Wed, 24 Oct 2018 09:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE9462081B
	for <linux-security-module@archiver.kernel.org>; Wed, 24 Oct 2018 09:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="izqPPpmc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE9462081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbeJXR7c (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 24 Oct 2018 13:59:32 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:45706 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726792AbeJXR7c (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 24 Oct 2018 13:59:32 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 491918EE0FC;
        Wed, 24 Oct 2018 02:32:09 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tSyPsx0K3ty8; Wed, 24 Oct 2018 02:32:08 -0700 (PDT)
Received: from [172.20.48.127] (unknown [62.232.21.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 7B4568EE055;
        Wed, 24 Oct 2018 02:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1540373528;
        bh=jPeodUDWE+9OlzSRgUFT0beChpUR8WGIlrr8Q2nsoAY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=izqPPpmcEE/Q8CoysV2Tg1oWwOUFMvLW9t3Y2dcuqZekej2oDAAeH/Np0YrCXRoCL
         usM+tnq57sTqGbN0vEACtwTzgnA+ACrmyG4E3nrfIFrr0RvRNhLkepDbvysyNxEE1t
         O3JNzUe1G+qg6buChq2+K9zCVCWno2JGTqrmIuHs=
Message-ID: <1540373514.3008.45.camel@HansenPartnership.com>
Subject: Re: [PATCH v4 2/7] tpm2-sessions: Add full HMAC and encrypt/decrypt
 session handling
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 24 Oct 2018 10:31:54 +0100
In-Reply-To: <alpine.DEB.2.21.1810232239140.8524@jsakkine-mobl1>
References: <1540193596.3202.7.camel@HansenPartnership.com>
         <1540193787.3202.10.camel@HansenPartnership.com>
         <alpine.DEB.2.21.1810232239140.8524@jsakkine-mobl1>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, 2018-10-24 at 02:48 +0300, Jarkko Sakkinen wrote:
> On Mon, 22 Oct 2018, James Bottomley wrote:
> > [...]

I'll tidy up the descriptions.

> These all sould be combined with the existing session stuff inside
> tpm2-cmd.c and not have duplicate infrastructures. The file name
> should be tpm2-session.c (we neither have tpm2-cmds.c).

You mean move tpm2_buf_append_auth() into the new sessions file as well
... sure, I can do that.

[...]
> > +
> > +/*
> > + * assume hash sha256 and nonces u, v of size SHA256_DIGEST_SIZE
> > but
> > + * otherwise standard KDFa.  Note output is in bytes not bits.
> > + */
> > +static void KDFa(u8 *key, int keylen, const char *label, u8 *u,
> > +		 u8 *v, int bytes, u8 *out)
> 
> Should this be in lower case? I would rename it as tpm_kdfa().

This one is defined as KDFa() in the standards and it's not TPM
specific (although some standards refer to it as KDFA).  I'm not averse
to making them tpm_kdfe() and tpm_kdfa() but I was hoping that one day
the crypto subsystem would need them and we could move them in there
because KDFs are the new shiny in crypto primitives (TLS 1.2 started
using them, for instance).

> > +{
> > +	u32 counter;
> > +	const __be32 bits = cpu_to_be32(bytes * 8);
> > +
> > +	for (counter = 1; bytes > 0; bytes -= SHA256_DIGEST_SIZE,
> > counter++,
> > +		     out += SHA256_DIGEST_SIZE) {
> 
> Only one counter is actually used for anything so this is overly
> complicated and IMHO it is ok to call the counter just 'i'. Maybe
> just:
> 
> for (i = 1; (bytes - (i - 1) * SHA256_DIGEST_SIZE) > 0; i++) {
> 
> > +		SHASH_DESC_ON_STACK(desc, sha256_hash);
> > +		__be32 c = cpu_to_be32(counter);
> > +
> > +		hmac_init(desc, key, keylen);
> > +		crypto_shash_update(desc, (u8 *)&c, sizeof(c));
> > +		crypto_shash_update(desc, label, strlen(label)+1);
> > +		crypto_shash_update(desc, u, SHA256_DIGEST_SIZE);
> > +		crypto_shash_update(desc, v, SHA256_DIGEST_SIZE);
> > +		crypto_shash_update(desc, (u8 *)&bits,
> > sizeof(bits));
> > +		hmac_final(desc, key, keylen, out);
> > +	}
> > +}
> > +
> > +/*
> > + * Somewhat of a bastardization of the real KDFe.  We're assuming
> > + * we're working with known point sizes for the input parameters
> > and
> > + * the hash algorithm is fixed at sha256.  Because we know that
> > the
> > + * point size is 32 bytes like the hash size, there's no need to
> > loop
> > + * in this KDF.
> > + */
> > +static void KDFe(u8 z[EC_PT_SZ], const char *str, u8 *pt_u, u8
> > *pt_v,
> > +		 u8 *keyout)
> > +{
> > +	SHASH_DESC_ON_STACK(desc, sha256_hash);
> > +	/*
> > +	 * this should be an iterative counter, but because we
> > know
> > +	 *  we're only taking 32 bytes for the point using a
> > sha256
> > +	 *  hash which is also 32 bytes, there's only one loop
> > +	 */
> > +	__be32 c = cpu_to_be32(1);
> > +
> > +	desc->tfm = sha256_hash;
> > +	desc->flags = CRYPTO_TFM_REQ_MAY_SLEEP;
> > +
> > +	crypto_shash_init(desc);
> > +	/* counter (BE) */
> > +	crypto_shash_update(desc, (u8 *)&c, sizeof(c));
> > +	/* secret value */
> > +	crypto_shash_update(desc, z, EC_PT_SZ);
> > +	/* string including trailing zero */
> > +	crypto_shash_update(desc, str, strlen(str)+1);
> > +	crypto_shash_update(desc, pt_u, EC_PT_SZ);
> > +	crypto_shash_update(desc, pt_v, EC_PT_SZ);
> > +	crypto_shash_final(desc, keyout);
> > +}
> > +
> > +static void tpm_buf_append_salt(struct tpm_buf *buf, struct
> > tpm_chip *chip,
> > +				struct tpm2_auth *auth)
> 
> Given the complexity of this function and some not that obvious
> choices in the implementation (coordinates), it would make sense to
> document this function.

I'll try to beef up the salting description

> > +{
> > +	struct crypto_kpp *kpp;
> > +	struct kpp_request *req;
> > +	struct scatterlist s[2], d[1];
> > +	struct ecdh p = {0};
> > +	u8 encoded_key[EC_PT_SZ], *x, *y;
> 
> Why you use one character variable name 'p' and longer name
> 'encoded_key'?
> 
> > +	unsigned int buf_len;
> > +	u8 *secret;
> > +
> > +	secret = kmalloc(EC_PT_SZ, GFP_KERNEL);
> > +	if (!secret)
> > +		return;
> > +
> > +	p.curve_id = ECC_CURVE_NIST_P256;
> 
> Could this be set already in the initialization?

I'm never sure about designated initializers, but I think, after
looking them up again, it will zero fill unmentioned elements.

> > +
> > +	/* secret is two sized points */
> > +	tpm_buf_append_u16(buf, (EC_PT_SZ + 2)*2);
> 
> White space missing. Should be "(EC_PT_SZ + 2) * 2". The comment is a
> bit obscure (maybe, do not have any specific suggestion how to make
> it less obscure).
> 
> > +	/*
> > +	 * we cheat here and append uninitialized data to form
> > +	 * the points.  All we care about is getting the two
> > +	 * co-ordinate pointers, which will be used to overwrite
> > +	 * the uninitialized data
> > +	 */
> 
> "unitialized data" != "random data"
> 
> Why doesn't it matter here?

Because, as the comment says, it eventually gets overwritten by running
ecdh to derive the two co-ordinates.  (pointers to these two
uninitialized areas are passed into the ecdh destination sg list).

> > +	tpm_buf_append_u16(buf, EC_PT_SZ);
> > +	x = &buf->data[tpm_buf_length(buf)];
> > +	tpm_buf_append(buf, encoded_key, EC_PT_SZ);
> > +	tpm_buf_append_u16(buf, EC_PT_SZ);
> > +	y = &buf->data[tpm_buf_length(buf)];
> > +	tpm_buf_append(buf, encoded_key, EC_PT_SZ);
> 
> The points have matching coordinates. Is that ok?

What points?  At the moment all we have are two pointers (x and y) to
uninitialized data areas.

> > +	sg_init_table(s, 2);
> > +	sg_set_buf(&s[0], x, EC_PT_SZ);
> > +	sg_set_buf(&s[1], y, EC_PT_SZ);

Here is the code where we set the output SG list of the crypto ecdh to
the areas x and y point to.

> > +
> > +	kpp = crypto_alloc_kpp("ecdh", CRYPTO_ALG_INTERNAL, 0);
> > +	if (IS_ERR(kpp)) {
> > +		dev_err(&chip->dev, "crypto ecdh allocation
> > failed\n");
> > +		return;
> > +	}
> > +
> > +	buf_len = crypto_ecdh_key_len(&p);
> > +	if (sizeof(encoded_key) < buf_len) {
> > +		dev_err(&chip->dev, "salt buffer too small needs
> > %d\n",
> > +			buf_len);
> > +		goto out;
> > +	}
> 
> In what situation this can happen? Can sizeof(encoded_key) >=
> buf_len?

Yes, but only if someone is trying to crack your ecdh.  One of the
security issues in ecdh is if someone makes a very specific point
choice (usually in the cofactor space) that has a very short period,
the attacker can guess the input to KDFe.  In this case if TPM genie
provided a specially crafted attack EC point, we'd detect it here
because the resulting buffer would be too short.

> > +	crypto_ecdh_encode_key(encoded_key, buf_len, &p);
> > +	/* this generates a random private key */
> > +	crypto_kpp_set_secret(kpp, encoded_key, buf_len);
> > +
> > +	/* salt is now the public point of this private key */
> > +	req = kpp_request_alloc(kpp, GFP_KERNEL);
> > +	if (!req)
> > +		goto out;
> > +	kpp_request_set_input(req, NULL, 0);
> > +	kpp_request_set_output(req, s, EC_PT_SZ*2);
> > +	crypto_kpp_generate_public_key(req);
> > +	/*
> > +	 * we're not done: now we have to compute the shared
> > secret
> > +	 * which is our private key multiplied by the tpm_key
> > public
> > +	 * point, we actually only take the x point and discard
> > the y
> > +	 * point and feed it through KDFe to get the final secret
> > salt
> > +	 */
> > +	sg_set_buf(&s[0], chip->ec_point_x, EC_PT_SZ);
> > +	sg_set_buf(&s[1], chip->ec_point_y, EC_PT_SZ);
> > +	kpp_request_set_input(req, s, EC_PT_SZ*2);
> > +	sg_init_one(d, secret, EC_PT_SZ);
> > +	kpp_request_set_output(req, d, EC_PT_SZ);
> > +	crypto_kpp_compute_shared_secret(req);
> > +	kpp_request_free(req);
> > +
> > +	/* pass the shared secret through KDFe for salt */
> > +	KDFe(secret, "SECRET", x, chip->ec_point_x, auth->salt);
> 
> How is the label chosen?

It's mandated in the TPM standards.

> > + out:
> > +	crypto_free_kpp(kpp);
> > +}
> 
> In general this function should have a clear explanation what it does
> and maybe less these one character variables but instead variables
> with more documenting names. Explain in high level what algorithms
> are used and how the salt is calculated.

I'll try, but this is a rather complex function.

> > +
> > +/**
> > + * tpm_buf_append_hmac_session() append a TPM session element
> > + * @buf: The buffer to be appended
> > + * @auth: the auth structure allocated by
> > tpm2_start_auth_session()
> > + * @attributes: The session attributes
> > + * @passphrase: The session authority (NULL if none)
> > + * @passphraselen: The length of the session authority (0 if none)
> 
> The alignment.

the alignment of what?

> > + *
> > + * This fills in a session structure in the TPM command buffer,
> > except
> > + * for the HMAC which cannot be computed until the command buffer
> > is
> > + * complete.  The type of session is controlled by the
> > @attributes,
> > + * the main ones of which are TPM2_SA_CONTINUE_SESSION which means
> > the
> > + * session won't terminate after tpm_buf_check_hmac_response(),
> > + * TPM2_SA_DECRYPT which means this buffers first parameter should
> > be
> > + * encrypted with a session key and TPM2_SA_ENCRYPT, which means
> > the
> > + * response buffer's first parameter needs to be decrypted
> > (confusing,
> > + * but the defines are written from the point of view of the TPM).
> 
> In the commit message it would be probably relevant to acknowledge
> that only the first parameter can be encrypted/decrypted.

OK.

> > + *
> > + * Any session appended by this command must be finalized by
> > calling
> > + * tpm_buf_fill_hmac_session() otherwise the HMAC will be
> > incorrect
> > + * and the TPM will reject the command.
> > + *
> > + * As with most tpm_buf operations, success is assumed because
> > failure
> > + * will be caused by an incorrect programming model and indicated
> > by a
> > + * kernel message.
> > + */
> > +void tpm_buf_append_hmac_session(struct tpm_buf *buf, struct
> > tpm2_auth *auth,
> > +				 u8 attributes, u8 *passphrase,
> > +				 int passphraselen)
> 
> Would prefer underscore between the words.

You mean passphrase_len?  OK.

> > +{
> > +	u8 nonce[SHA256_DIGEST_SIZE];
> > +	u32 len;
> > +
> > +	/*
> > +	 * The Architecture Guide requires us to strip trailing
> > zeros
> > +	 * before computing the HMAC
> > +	 */
> > +	while (passphrase && passphraselen > 0
> > +	       && passphrase[passphraselen - 1] == '\0')
> > +		passphraselen--;
> 
> Why there would be trailing zeros?

Because TPM 1.2 mandated zero padded fixed size passphrases so the TPM
2.0 standard specifies a way of converting these to variable size
strings by eliminating the zero padding.

James

