Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61D134753C
	for <linux-security-module@vger.kernel.org>; Wed, 22 Apr 2026 21:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776892900; cv=none; b=oPg7ZUMeEOCbwzAJhk3azLnOL6JzkM5MoeKwcbs9cAcUvMSrYMm0m7kEHxsiPMJAqG0t9lVcmoZoUHqFK/StP4yxTFw9mRnormYvFJSIs9ZQ43U8oucm6Uts5x0HdndAGpJXWmTTpIVE6/157hxCa5bKlprvjoH0yOGdPimdRGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776892900; c=relaxed/simple;
	bh=KPRY0fkxHMLTF3O/yj9zF8b/7ZTyEnmsZn+VdomZ93Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SNWzXTFOQF+IUAGTggvSK75yCQzCM7UIrA4SVP+rLrgg5etiVzqbAfjv9P792y0sfomTyfV8Ojbwn3RTaokYL2g8I0flg4w8isO335039p+Fh9MExRjCSjVrTqREFxrrCWKDNJGhRHL2tnVKCqrodcdjbG269Mo6V5TGh47FWBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQpD0gAV; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQpD0gAV"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43fe3e22e33so3933213f8f.0
        for <linux-security-module@vger.kernel.org>; Wed, 22 Apr 2026 14:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776892897; x=1777497697; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VIqhSvTbP9eYNsUt9ndTviLgqiJ7f2q8IuPj176SOag=;
        b=QQpD0gAV4cWy8DAhArbx0owXs7JAx5bYtbEg3WutWGLC3e7fnRnh4R9xooMr2P6kNu
         VK490X2QqCvPSSRjJdZRhRbIvP6ykH0bDn4RVVB8yJOj4Z+iMotNr73MdsiFdlYYyE8O
         c6XX2Bvf7jwZzgxyDQRhR+gBoLR6FRZfDO3m+9r8VLtS3Mc42CsENQPLoVOc2DgwqVve
         T5CgFRnC6p2rcYDGnGbD3PKI6rhgqJMvWJjOKl07W4TIEXChcHls6l9KKsA2Xmk5fFAx
         jnT8+/gSGHs2fxgUYmbkVtlNW8eUw2mtQJUDWqXvxOiaja7i5O8y8T8hFlKhYBQAcC0j
         o3XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776892897; x=1777497697;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VIqhSvTbP9eYNsUt9ndTviLgqiJ7f2q8IuPj176SOag=;
        b=SNltqADeY7I/p9Sb1EaphA5ShHF+VdAVIKMHNEohBum0aZAZJ/+WL8SrEkceYg3qkB
         LTGLHNXlodPJcUBIzMcWlhxBwV9p5op1r1oRZpriAzSTqW86QKmyVAFJHdIVgx6TbLyV
         g76xcAs9e4dIFZ9vnHajhSdExwGnKY3wr8u4fERGr/gs8E8Zrpuiw7uekeMd7Wt4XvWF
         qKFEsDTsINlict2yigGpHV0UXoprfg2hQnaL6I3I/wI0DbEIkHgoAixBEAgBjAgz7ElP
         kbXirMhtfbm2n1j5Q30ExtImgsv/fHtDQ/RY+aQoskL/4Z/GDO9NwCvUxkg7bgYHcBXN
         tVdA==
X-Forwarded-Encrypted: i=1; AFNElJ/iFz5n3CdlgAPDvgCQyoxPK62VuVLc7cL4DbzQvLBkaXZy6EJ0Dl6OZbkqkQjE5KdiMd5kaAvS1CbwhhXTffAcg5Is+lw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+rj/sAmCk56w6uB1dqeAqcMGnTXfAOIGMjLZ93Lm188N6DkJJ
	GzWYU/kQpUGGa4wCD6GvKmmgc6gdrzjV9kmejeDzLJfaeEgwiqK2MXQS
X-Gm-Gg: AeBDies0oi/1Z1d4qaVoELmAwyFgO4MX322yo/6qbApDDFR9qXuKtZNkq7WcGd2xS23
	J6cRRJrNsIMqGTSFqhsU9SEgsUimZOsqe+Mr2bX1bQClwRfQeFNizYAnhEP8pr5M2/PayVm5+Dz
	Hdmii8cXJMv4GKwENYrd50CBmyxKIICZHc/8iukiMLVeSxsRHtii8Z33j1RvvYgCW03E/QQdTT8
	gmmIx96E2XHeryZ4wetpJ4RQ2WYNdxh/tSca2CXFF2EeROWdmN5R/LyJcjTEAKwzpCReg+6ILOM
	Viue686S2aGLdwmq4YJgg1kvnSH11V3SCwccIE+V29rpjw0RjxiSzQDRwSH5CH5iF7pll/psRl6
	xDg39aZ6QQSAWbhxHoeTUYA13aeo8s+eRjutTxOPXUpI0TCuz+SsqBULFU3/6tt4BL49fE9sMnu
	GwTPqT2ISIPwm54abJqJP6FhCK72VkgpADVa1nwaz+5pt3vx5Zk7DfRIoaNsI=
X-Received: by 2002:a5d:5d88:0:b0:43d:7d6f:f535 with SMTP id ffacd0b85a97d-43fe3e10c0dmr36737857f8f.35.1776892896995;
        Wed, 22 Apr 2026 14:21:36 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4d6casm43578892f8f.32.2026.04.22.14.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 14:21:36 -0700 (PDT)
Date: Wed, 22 Apr 2026 23:21:35 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Lennart Poettering <lennart@poettering.net>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Shervin Oloumi <enlightened@google.com>,
	Tingmao Wang <m@maowtm.org>, kernel-team@cloudflare.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v1 02/11] security: Add LSM_AUDIT_DATA_NS for
 namespace audit records
Message-ID: <20260422.1136d63ef1ab@gnoack.org>
References: <20260312100444.2609563-1-mic@digikod.net>
 <20260312100444.2609563-3-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260312100444.2609563-3-mic@digikod.net>

On Thu, Mar 12, 2026 at 11:04:35AM +0100, Mickaël Salaün wrote:
> Add a new LSM audit data type LSM_AUDIT_DATA_NS that logs namespace
> information in audit records.  Two fields are provided, matching the
> field names of struct ns_common:
> 
> - ns_type: the CLONE_NEW* flag identifying the namespace type, logged in
>   hexadecimal.
> 
> - inum: the proc inode number identifying a specific namespace instance.
>   Namespace inode numbers are allocated by proc_alloc_inum() via
>   ida_alloc_max() bounded to UINT_MAX, so the value always fits in 32
>   bits.
> 
> A new audit data type is needed because no existing LSM_AUDIT_DATA_*
> type carries namespace information.  The closest alternatives (e.g.
> LSM_AUDIT_DATA_TASK or LSM_AUDIT_DATA_NONE with custom strings) would
> either lose the namespace type or require ad-hoc formatting that
> bypasses the structured audit data union.
> 
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Günther Noack <gnoack@google.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
>  include/linux/lsm_audit.h | 5 +++++
>  security/lsm_audit.c      | 4 ++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/include/linux/lsm_audit.h b/include/linux/lsm_audit.h
> index 382c56a97bba..6e20a56b8c22 100644
> --- a/include/linux/lsm_audit.h
> +++ b/include/linux/lsm_audit.h
> @@ -78,6 +78,7 @@ struct common_audit_data {
>  #define LSM_AUDIT_DATA_NOTIFICATION 16
>  #define LSM_AUDIT_DATA_ANONINODE	17
>  #define LSM_AUDIT_DATA_NLMSGTYPE	18
> +#define LSM_AUDIT_DATA_NS		19
>  	union 	{
>  		struct path path;
>  		struct dentry *dentry;
> @@ -100,6 +101,10 @@ struct common_audit_data {
>  		int reason;
>  		const char *anonclass;
>  		u16 nlmsg_type;
> +		struct {
> +			u32 ns_type;
> +			unsigned int inum;
> +		} ns;
>  	} u;
>  	/* this union contains LSM specific data */
>  	union {
> diff --git a/security/lsm_audit.c b/security/lsm_audit.c
> index 7d623b00495c..7f71a77c1c12 100644
> --- a/security/lsm_audit.c
> +++ b/security/lsm_audit.c
> @@ -403,6 +403,10 @@ void audit_log_lsm_data(struct audit_buffer *ab,
>  	case LSM_AUDIT_DATA_NLMSGTYPE:
>  		audit_log_format(ab, " nl-msgtype=%hu", a->u.nlmsg_type);
>  		break;
> +	case LSM_AUDIT_DATA_NS:
> +		audit_log_format(ab, " namespace_type=0x%x namespace_inum=%u",
> +				 a->u.ns.ns_type, a->u.ns.inum);
> +		break;
>  	} /* switch (a->type) */
>  }
>  
> -- 
> 2.53.0
> 

Reviewed-by: Günther Noack <gnoack3000@gmail.com>
