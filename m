Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A3B415F15
	for <linux-security-module@vger.kernel.org>; Wed,  2 Sep 2026 09:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788341071; cv=none; b=KCN/pbrES0yfBxn3HVtuWPAtgRGIXzuKm//dlhMk3rCs8iLUSjkkgy+Kk1Qg9g6KEh2cQ6UNnjpSe25UQRWrSMuSgY3L1uJq316lZLHjqaUwVaL5wzJdX/8IndW/Jcw6qOlY5JhEjPH9EUktbDhrfDqdJB7gAZJYU2/DAstnis4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788341071; c=relaxed/simple;
	bh=dv1csfbz3+AfIisrDWKM/LTeMZoRYy6BRCz9NaDNXI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Gyghh/K4JvM230u3Fvh8vX8xsC97zOn/1RiEDJkHSxhW9DdVCtyUbGQDEMtUtK0axjE+Gdiy3q1JQziOHsk+foq4APCAYWqLklV/7JEj8AScK/6mhQI+zXtl8dEUkXf1Pzm3SemsceURtxdk4OXEOggcNf9rY6ug21qmq7yqL0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JKq3y80G; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JKq3y80G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788341069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8QzyTGdGmNYHVJq7S368eFIeE6Ma1yvkdBRAoiX3kKc=;
	b=JKq3y80GGzy/4a2q9DTco9ZvVXFH1KWiCcsckBIp6/qddhR3mlyTXa2hMTVb9BhzMTxfGB
	NvE3LN7xu1svN/tTuoMBu0bzAE3ktrZ6wjV6zBQZmHhrw1r7NSj0SvWdEE5mLMvq42ooSp
	HM2gRJW3MAt7116N04XHcvX7suiksFg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-a8nXD-NBM1WH6mKXnZkRvA-1; Wed, 02 Sept 2026 05:24:25 -0400
X-MC-Unique: a8nXD-NBM1WH6mKXnZkRvA-1
X-Mimecast-MFC-AGG-ID: a8nXD-NBM1WH6mKXnZkRvA_1788341064
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4843d9ab895so768464f8f.0
        for <linux-security-module@vger.kernel.org>; Wed, 02 Sep 2026 02:24:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788341064; x=1788945864;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8QzyTGdGmNYHVJq7S368eFIeE6Ma1yvkdBRAoiX3kKc=;
        b=BA0USej1pnveEPQGlPI700zDGBwRu6eVfSfpK3r7qmPUNYFKvMWaSazAmVRepR+NVW
         U8ALJowGwT+jFSm2mADQjbQv/qoaj68EXHUGtyDVBMRmKFsS4WKcQgW0MAt0idhqgq3+
         1lSAp5+rhVGy+WyP7WdhbGO6wtR/LDusKJuzC/4H0XiMXkTdOdxvak1vpmhr8XcQ2LWM
         WYFhnnH6tva38OVz/3Uiujtiduhw1Y90zlBYB7d8VEY5xYXFeowktj+9b8HM+ib37OBT
         +JORo2tCHz2Gyc1YeqCSsqQIMT6aewj5FC10FjPOmIM1paPBuYzMh01b4nGpYywjZ7tE
         lfHA==
X-Forwarded-Encrypted: i=1; AKwUvBwUpInAQttRnVIMyPN0/80cdEYv1cYnYbxNPad32I1HS7508ONWXIi9fyqZMdNqq72Rrrov3J+PvmRC5sVRhayz2VTaK9c=@vger.kernel.org
X-Gm-Message-State: AFuF++mcVufTAt/Nl381yNIKBAjy6wBrDZZJhjn1FBceONdDw/zsKGkj
	WR5XkRq50+bEHxH4hIW8sBEjZDoSGKPbMemLLCKF5fnqMksFiJvGouge77FgWFcQ8YipVX7jtzC
	KNmABzS5EpWbJkc86uZN8ZKGoz3CjPXqLFV2GdnA60xGQXGHby1MB2P7LSfjiXeFe53COT1f9vq
	mATg==
X-Gm-Gg: AYBFou1dvKptZcgR1gxj/RQ5wmqFvbQwwsz7MULOenQQ/CtOpGHVVGhRA+D8KirCZ/b
	3Ir/LWdcmNrZ4kaxoHIUhV4M1uGABgKxJTNJBfGSg/YKE5RZV1n9LH/7K/M1Ga7inXcHU4tOKEa
	EuU2TiVxxO+sLuIjELIzoarzdj1QRTlsmUwHyKhLJUyjKNrjOfzC+aAhipeXzj7p6uE5WH3YJ7T
	EOFRKRd0877aKzyVh9N4dOi+PImcp+xOg8du52FFuxCYh/HnaO2Egq7Q9BxDOVJnfw2+UjzpU2h
	fuhMJCFPh0w9Z3CdythRzIlWMTC9i/DHoUYHaHiLOWIjtgO+Y8ATL7zb6f/6Yn7GHu1fuYAOiQc
	TdQKiZkLlDNMh4RrCGLmds9NtiDiuCaYhmWZNTW49es/keQ==
X-Received: by 2002:a05:6000:454c:b0:485:1bcc:67f8 with SMTP id ffacd0b85a97d-4851bcc69c1mr3651060f8f.13.1788341064190;
        Wed, 02 Sep 2026 02:24:24 -0700 (PDT)
X-Received: by 2002:a05:6000:454c:b0:485:1bcc:67f8 with SMTP id ffacd0b85a97d-4851bcc69c1mr3650988f8f.13.1788341063712;
        Wed, 02 Sep 2026 02:24:23 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it. [79.53.30.11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448e80388sm6406811f8f.14.2026.09.02.02.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 02:24:22 -0700 (PDT)
Date: Wed, 2 Sep 2026 11:24:16 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, stable@vger.kernel.org, 
	co+6a581c4284f721d4@bugs.sh, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Jonathan McDowell <noodles@meta.com>, 
	Ross Philipson <ross.philipson@gmail.com>, Stefan Berger <stefanb@linux.ibm.com>, 
	Srish Srinivasan <ssrish@linux.ibm.com>, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KEYS: trusted: Fix tpm2_load_cmd() boundary check
Message-ID: <apfoKo-BdwaLXtkT@sgarzare-redhat>
References: <20260901205809.2028454-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260901205809.2028454-1-jarkko@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 72yfL8kWMhmtRPHaV2mL6EYNydgOWuK0g8CaHf-JnTo_1788341064
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Sep 01, 2026 at 11:58:06PM +0300, Jarkko Sakkinen wrote:
>tpm2_load_cmd() does boundary checks against the ASN.1 size i.e.,
>payload->blob_len. Address this by passing the decoded blob size to
>tpm2_load_cmd(), and use it for the boundary checks.
>
>Cc: stable@vger.kernel.org # v5.13+
>Fixes: f2219745250f ("security: keys: trusted: use ASN.1 TPM2 key format for the blobs")
>Reported-by: co+6a581c4284f721d4@bugs.sh
>Closes: https://bugs.sh/b/6a581c4284f721d4/
>Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>---
> security/keys/trusted-keys/trusted_tpm2.c | 12 +++++++-----
> 1 file changed, 7 insertions(+), 5 deletions(-)
>
>diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
>index 67225dd562a9..01f18bb37047 100644
>--- a/security/keys/trusted-keys/trusted_tpm2.c
>+++ b/security/keys/trusted-keys/trusted_tpm2.c
>@@ -99,7 +99,7 @@ struct tpm2_key_context {
>
> static int tpm2_key_decode(struct trusted_key_payload *payload,
> 			   struct trusted_key_options *options,
>-			   u8 **buf)
>+			   u8 **buf, unsigned int *blob_len)
> {
> 	int ret;
> 	struct tpm2_key_context ctx;
>@@ -120,6 +120,7 @@ static int tpm2_key_decode(struct trusted_key_payload *payload,

	blob = kmalloc(ctx.priv_len + ctx.pub_len + 4, GFP_KERNEL);

Pre-existing, but is `+ 4` here useless?

I'm not asking to fix here, just noticed while reviewing.
Maybe we can set *blob_len earlier and use it also in the kmalloc().
Not a strong opinion, that said this LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

	if (!blob)
> 		return -ENOMEM;
>
> 	*buf = blob;
>+	*blob_len = ctx.priv_len + ctx.pub_len;
> 	options->keyhandle = ctx.parent;
>
> 	memcpy(blob, ctx.priv, ctx.priv_len);
>@@ -384,10 +385,11 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
> 	int rc;
> 	u32 attrs;
>
>-	rc = tpm2_key_decode(payload, options, &blob);
>+	rc = tpm2_key_decode(payload, options, &blob, &blob_len);
> 	if (rc) {
> 		/* old form */
> 		blob = payload->blob;
>+		blob_len = payload->blob_len;
> 		payload->old_format = 1;
> 	} else {
> 		/* Bind for cleanup: */
>@@ -399,17 +401,17 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
> 		return -EINVAL;
>
> 	/* must be big enough for at least the two be16 size counts */
>-	if (payload->blob_len < 4)
>+	if (blob_len < 4)
> 		return -EINVAL;
>
> 	private_len = get_unaligned_be16(blob);
>
> 	/* must be big enough for following public_len */
>-	if (private_len + 2 + 2 > (payload->blob_len))
>+	if (private_len + 2 + 2 > blob_len)
> 		return -E2BIG;
>
> 	public_len = get_unaligned_be16(blob + 2 + private_len);
>-	if (private_len + 2 + public_len + 2 > payload->blob_len)
>+	if (private_len + 2 + public_len + 2 > blob_len)
> 		return -E2BIG;
>
> 	pub = blob + 2 + private_len + 2;
>-- 
>2.47.3
>

