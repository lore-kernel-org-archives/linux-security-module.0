Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57383258EDE
	for <linux-security-module@vger.kernel.org>; Tue, 23 Dec 2025 21:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766525374; cv=none; b=c/I1iUKa5TnrC/Z373IhztGe9Zeg6U3SPY7dctwFH47zppH1NvL6nv/X4dV3TjGsG7AnpMUlNbwfoeBiQtDLrpmWc441JcUoeqZq4atHwTh8PlnzegZ+bXrS5T7yjSWqSsoK+bO1X8LTUJ+9miGTnfGlGE9yCKe/+cU6vGK2sKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766525374; c=relaxed/simple;
	bh=iW9E9QekzfoKicUFj7o0PNd4l/mVVIzIJqmDd2lWIN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jhILnqYW447a/+RdIj4G6GoYcm8IMfN8ox1AFUL2W/xflLPEoGhN+N80j0kxwdUlulq8D11vVpfc26037FGrVRUu/0CUehRNLcgvKrIP7udqXZsn5XsvxHWoQ9Mi5qHH08CslL4Nysp9zKbgit0bRzCbjGu+Bxaf2fWEtI1bbVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kOPgmUl5; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOPgmUl5"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-64b791b5584so7734409a12.0
        for <linux-security-module@vger.kernel.org>; Tue, 23 Dec 2025 13:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766525371; x=1767130171; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OD09wrVqlVS1TyeipTgl4x50xKjaZrZMTH5oN5CXXNo=;
        b=kOPgmUl5yK4SUQ1oNDzPF5wf1vV2OD5Am/im1c60BMuG3lGze9sTXr54IELgCOIDWk
         YYtLCgJ1BPMrrPW2xEfpFXsBe5trN04JfJ40d8toat/50n1+oc8SPRvyofN/RnIlVG8A
         BkkxMHORzHHKPdBTXewaQUdVWxmN95Vj1Jid+Y1niEpMbPzNL7tbVeqhl9XeS7hcmJWH
         1FDM9gxE3+d6Qj5CxlBk8N9zLPMOPuWf72k296a55WpmXxG+uYJP63COCciCuN/HSQZq
         u2Db3HpmKP0S98PgGcs8Znep4yFALiKejJ1EnGVv/HLcCtuA0fLNP+OP1c55nx9upUj6
         YNmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766525371; x=1767130171;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OD09wrVqlVS1TyeipTgl4x50xKjaZrZMTH5oN5CXXNo=;
        b=K+AexJt7o0hmAJvvxyq14sAOUdf0r0xdAVxzZeAn3xqeEzCCQJvO2+jAcSjWTC/Tb9
         H4oTgE3oLhtu37OqufYjRRQaAONx8/glFb2Ulvsb51tO9zePL0Ok5/KjykYw6cP8uHEs
         GgedzVmIId4Ub4ubZi+YveZvgyswBZFDcdbOfFIXBmVjletI1p/nmap/rk7lbZMyOkJL
         vJ5qn6jWBBI2J9tupVzVFunQoHx96U1S2SiwbLyybMmvgR9zwTPPEyprbeDxygzHPEKq
         lPb9ZZBreTNdtyHkN0hcwydJOtX7tCKG7I+CKFQ4w5lZwXh/wIVUKbWyEkWojGbaZ8u2
         TJgg==
X-Gm-Message-State: AOJu0YzWVxoFLMBuYEE3ZI0PU/4WrHE6NCswSAdG5sfZW88mMYH08kCJ
	o/aAcfmcfgokXjruQ0Q7fwy2KjR8SbFMr38gRjWyG6bR9lulfRhKskYCI5Qq8Q==
X-Gm-Gg: AY/fxX7EU4+Lh3WoUJkyfNukYoz7N8NV4d/jBxwXzgBjxuwgvjzyfaHpiWjlUxsOqr2
	6daW4aqQ6u2S2s74s76p+efPCSouXFyhk+TMUX+FTmN6ZywzsEk6Z1kOLC0/MFLZiypIvrClx/Z
	0faiC7eNn6VEf9pgHSiCYhgoYijmX5JB+I/yBu2IlRDR42qXGi5Bjjx05WeB76h4giLKGbj7qkN
	3J75C4EuJXocpcfDXYpXXRRv6W06r0FrQ6a7NDgQnHWSwygFQRmEqNomgaw4bl41GiMwFBoYthd
	+5dbhqM11rpWg4Tt94eyLEjxwQyOgw9cl6JDrkleLKWF0nN11rFLGV7kwbeHiJLrTBqyuXP6GIA
	Egw6NXpXVioNMhNoU+jV4BkKrgHewR6UeuzBymwcx+P1wXgICfmDgerViz9dDNBpwdH01mi09lH
	vqHFVPmH2vgM0Yc6vXB01qF8NAWY2LYqPVmSmj
X-Google-Smtp-Source: AGHT+IHQt91970uKpr/ZoNUhPPkj+j0yN1vCueWqH+GAq/XyUnN1MfWWGbhyORNKYlFvwH4dTxvaMw==
X-Received: by 2002:aa7:d70f:0:b0:64b:6bcf:96b2 with SMTP id 4fb4d7f45d1cf-64b8ecb3df7mr10853513a12.29.1766525370633;
        Tue, 23 Dec 2025 13:29:30 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b916b3b35sm15078734a12.30.2025.12.23.13.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 13:29:30 -0800 (PST)
Date: Tue, 23 Dec 2025 22:29:28 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org
Subject: Re: [PATCH v1 4/5] landlock: Fix spelling
Message-ID: <20251223.9ef440eda3f2@gnoack.org>
References: <20251219193855.825889-1-mic@digikod.net>
 <20251219193855.825889-4-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251219193855.825889-4-mic@digikod.net>

On Fri, Dec 19, 2025 at 08:38:50PM +0100, Mickaël Salaün wrote:
> Cc: Günther Noack <gnoack3000@gmail.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
>  security/landlock/domain.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/landlock/domain.h b/security/landlock/domain.h
> index 7fb70b25f85a..621f054c9a2b 100644
> --- a/security/landlock/domain.h
> +++ b/security/landlock/domain.h
> @@ -97,7 +97,7 @@ struct landlock_hierarchy {
>  	 */
>  	atomic64_t num_denials;
>  	/**
> -	 * @id: Landlock domain ID, sets once at domain creation time.
> +	 * @id: Landlock domain ID, set once at domain creation time.
>  	 */
>  	u64 id;
>  	/**
> -- 
> 2.52.0
> 

Reviewed-by: Günther Noack <gnoack3000@gmail.com>
