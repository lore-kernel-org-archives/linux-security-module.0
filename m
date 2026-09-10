Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3678D3DA5C1
	for <linux-security-module@vger.kernel.org>; Thu, 10 Sep 2026 07:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789026776; cv=none; b=rEgNV0Let3y80aDY8FulR4Dg2cmPR/ocLZanmmPqlBU/XjYnitaPaeS7gx/1KyNvMJHXpb8s1eGXm5w4ZfidoTfh+/IAz5MDbFAI4vCsvsu3ctIVi+5NPXQVNCrIjZNDeKDA9QnrPPE8e/cZ5RQMdHNn8SIO1gaorLlvZ+9NK+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789026776; c=relaxed/simple;
	bh=CsLIGHHO8YWAldmY8Naazy7NOx7PZIBpEJmR+iBDvqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=hSYdsD9hwqMso57w4sVhk5ZbzI9wZaMXC3hEgcQoQ5MUGAEV43v1JyauAKmZpB8T6aoe3W766+6yQD5v/Gul5y/XwlO7Whi6wLKBjK80nCcsZ9uoouh5UQpqH39jt+1ZF5udh9PrJzv+17/reKw4PtdNqZj/py88Dr8blyKmSZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bj7oyrmZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bj7oyrmZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789026774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3zdat3lb+JFaceCjEvZhP3kP5xpKa4RbvpVHW8sS2v0=;
	b=Bj7oyrmZVR9i5l09nENsd3Ehvh1j3A2xi86XHNxDhT2mXfcs28L+dK0JMaxFshMm+uMCQc
	fz6AHrQiwN9Xhrs5sCE+zujaXCYbysPtvW7J6lc57gJpca2oQK99xiD0i0ePdB2B0WUr1N
	tsTj5H6qdt7jIgjOS1H8BnCmJLCX6h8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-vi-dAUwTOiy4byBvfAzH2A-1; Thu, 10 Sep 2026 03:52:52 -0400
X-MC-Unique: vi-dAUwTOiy4byBvfAzH2A-1
X-Mimecast-MFC-AGG-ID: vi-dAUwTOiy4byBvfAzH2A_1789026772
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-495474a5fbcso67982155e9.1
        for <linux-security-module@vger.kernel.org>; Thu, 10 Sep 2026 00:52:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789026771; x=1789631571;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3zdat3lb+JFaceCjEvZhP3kP5xpKa4RbvpVHW8sS2v0=;
        b=bcQcDozH8Wm5T/pmrhbAYHSMNeBm19dRVWpQv5U/4iump70dLKBobOzoc4BBPrG9RM
         tb7kKvZ7UNmqa51Fiix7VCkG/PgRT/rIfchnmCfQ0yB6rLA6l1LXhxLRbXkN0gt/VP2z
         6N6g1PVsKBXN8N6Eo1wJDcMQuvHJMBSJ7dlQ6UCet38R3nhmrQ8D/miES8moEVV4vye+
         rhZ7bu4NeGl1PMXmhNltpgJON5R1qRJIrdO1UUNowCg65l6sxycHuk1Mqi1Ge0dDAg6q
         u7KGrcv6ELN/hwnS/xrPoP7foKNYd6jjOdxyYYHvXE4SCgobdOy3+HYFTIhtyo8ftaqx
         SzKw==
X-Forwarded-Encrypted: i=1; AKwUvBz4IF6vvu+QCrZVCWiuOwqX+SYPb7UIuNAy0jh1SeUvKBPVbFur2KyC92XIsUiaov/p9ToxYxFWnnIhT8XaizRzX0zuOjU=@vger.kernel.org
X-Gm-Message-State: AFuF++nW8SrXTTejp4+bY1SH1H2w8hVY/4rl8RPHDroaJPHLRX0bBPHl
	mjJ4yN4scxH/TGhaJSZON1reiwCgiMot5iLv1Roqsu3BCqnAeKhcYqV95ayd+vuBvWKDtwBWBF4
	XwowB5zCVTL5rcBkQ2tMPCslb/aySAGg6a+iGrGJL38brqYAIxDop+BvXilYHb8Pp5ecEETVsJt
	8rbg==
X-Gm-Gg: AYBFou3wy3Z8WDCATJL1Bcvbx7CVaM3W1xr4uHALEIHgVHoeP8afz9B+5xCL4JEhi8R
	TdscuCZGBSc1PGadmkalfzJwnS0BRv5TYFytGLgB+r1PAMrOzTHeIMumFk54IpZH8YoKX2lmFUk
	IpU+ug0loBrS3Y/Rhp/GXL32qiDImgZYMweNYkyQdVejZaNH6HSK8VEkzXwa7PHhihECo/yMtRt
	R9jvX/wuDoBSB9HHrmBBY9FTL+AYHS0RZkIO/cQxwiU10AjbkDFxzFLrfXmzAVYnj5orAHBTbaZ
	Fa01/gZSfxW+d3HHqLHKXZ2JOgz8XAT5LuDhbCGubRJ0WnvxBFE+vKL/u4DRJ0jxbhOnJZpzda/
	jLcpBW7DyfkK4FCxKcSPG6JFMP4lBjseSxkhN7WOzgblXBQ==
X-Received: by 2002:a05:600c:1991:b0:49d:1842:f001 with SMTP id 5b1f17b1804b1-49d1842f00dmr150578165e9.14.1789026771622;
        Thu, 10 Sep 2026 00:52:51 -0700 (PDT)
X-Received: by 2002:a05:600c:1991:b0:49d:1842:f001 with SMTP id 5b1f17b1804b1-49d1842f00dmr150577875e9.14.1789026771102;
        Thu, 10 Sep 2026 00:52:51 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it. [79.53.30.11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883be709sm48847267f8f.21.2026.09.10.00.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 00:52:50 -0700 (PDT)
Date: Thu, 10 Sep 2026 09:52:38 +0200
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
Message-ID: <aqJhkjPdib-MQTCT@sgarzare-redhat>
References: <20260901205809.2028454-1-jarkko@kernel.org>
 <apfoKo-BdwaLXtkT@sgarzare-redhat>
 <aqHIwoKcEWeI_yjs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aqHIwoKcEWeI_yjs@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2J_Uu4CtZgRceJGkMgrXxN65WoMoia6XFX2BaljX0BI_1789026772
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Sep 09, 2026 at 11:59:46PM +0300, Jarkko Sakkinen wrote:
>On Wed, Sep 02, 2026 at 11:24:16AM +0200, Stefano Garzarella wrote:
>> On Tue, Sep 01, 2026 at 11:58:06PM +0300, Jarkko Sakkinen wrote:
>> > tpm2_load_cmd() does boundary checks against the ASN.1 size i.e.,
>> > payload->blob_len. Address this by passing the decoded blob size to
>> > tpm2_load_cmd(), and use it for the boundary checks.
>> >
>> > Cc: stable@vger.kernel.org # v5.13+
>> > Fixes: f2219745250f ("security: keys: trusted: use ASN.1 TPM2 key format for the blobs")
>> > Reported-by: co+6a581c4284f721d4@bugs.sh
>> > Closes: https://bugs.sh/b/6a581c4284f721d4/
>> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>> > ---
>> > security/keys/trusted-keys/trusted_tpm2.c | 12 +++++++-----
>> > 1 file changed, 7 insertions(+), 5 deletions(-)
>> >
>> > diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
>> > index 67225dd562a9..01f18bb37047 100644
>> > --- a/security/keys/trusted-keys/trusted_tpm2.c
>> > +++ b/security/keys/trusted-keys/trusted_tpm2.c
>> > @@ -99,7 +99,7 @@ struct tpm2_key_context {
>> >
>> > static int tpm2_key_decode(struct trusted_key_payload *payload,
>> > 			   struct trusted_key_options *options,
>> > -			   u8 **buf)
>> > +			   u8 **buf, unsigned int *blob_len)
>> > {
>> > 	int ret;
>> > 	struct tpm2_key_context ctx;
>> > @@ -120,6 +120,7 @@ static int tpm2_key_decode(struct trusted_key_payload *payload,
>>
>> 	blob = kmalloc(ctx.priv_len + ctx.pub_len + 4, GFP_KERNEL);
>>
>> Pre-existing, but is `+ 4` here useless?
>
>I checked this through in detail.
>
>It should not be like that given that callbacks tpm2_key_{pub,priv}
>provide the length of TPM2B_PUBLIC and TPM2B_PRIVATE.
>
>Thus, it is a bug introduced by f2219745250f ("security: keys: trusted:
>use ASN.1 TPM2 key format for the blobs")

Yep, agree. Do you want me to send a fix?

Thanks,
Stefano

