Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B2D1974EA
	for <linux-security-module@vger.kernel.org>; Mon, 23 Sep 2024 11:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727092372; cv=none; b=amOndVys43aCLLMXpHmcdsQMSBije1uJqQqrJs4QbB9yKzrWl1+xUXfFL0+vTfLNs+s6g0gJEWdCeFCswgC/Nwf16/5c7T5mo4zt22P/OY04yUyeTG67L3Avz1gvij8m7SPT4or2asS/tkRSEeKnW1wL3qHxVp04CM9/LVkJjKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727092372; c=relaxed/simple;
	bh=HZTG+GQe52jS6g5Tcq06PZcX/VJwn6XsB9avf7KWn8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D9Xs/rOtQ/eoiFO22HsFpezjlfcYqrTZyA6Qi/AL8CSqaw4pDQqsfyXvenn8nA4e3uPP0idlvZoOzXydld57e98PVy980L09fLKfDFzS6D/u/a10B5cSOQvdeCMMoJeHcZezBeZW7Id8W8ific6ctbK5+hVRYPJbEu6jdITlvpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YateBYjH; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YateBYjH"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e201f6eda9fso3663211276.2
        for <linux-security-module@vger.kernel.org>; Mon, 23 Sep 2024 04:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1727092370; x=1727697170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QcXFy+gXVZbSoblIlaneu9leYvh2hodNZXQ13I8Q1lY=;
        b=YateBYjHOHSWxRV1t2MxnJmlOFpCzBtukb9MpkAGPlTCRIZQvfoGWiS3m6FohcDJWF
         dGRm/mIlTTBk+M8bFRrObWfaEHIDkgnyqSUizo0FPvAWKEXXcyhqaCMX2kQakPK3i+kQ
         O/AzsbRZRrmSMcYBSMnx/MewVH5EvR9m6Y1Q+wuEGCk9fJDzyyU1WLlP1bd7dr2oMzqU
         l9lrbLJPWLV0SdbU+3K5ACxNwp1rFCaDkkVZriWE+r2zh9lcPZnmRjj5DdTsj/LB8ySt
         bsv9zH9UoztlApSnJP5uaJCldD/gXoAYrMUkrck1ZHHa6+z1zob/L/aCtbSbWmBh1ABr
         Zd1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727092370; x=1727697170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QcXFy+gXVZbSoblIlaneu9leYvh2hodNZXQ13I8Q1lY=;
        b=gyR6O6tlPsPwuiMTkO+9RmwCGi91EIh14hghDskbIEnfma9clPt9szrGAloyVZbL+u
         h6GMPSCiXWpKLp0eOI0iWxHAi1J64G35Nds7daBGsovS1yCF1y4B2P5cj54eI5vp5y9N
         IaheVJaxshus1hsL4FWe/vX7YiM0e/35vDbRX7sw6fZpN/iUgIFmMoSWmojWbHEYRkEI
         K0mhd5JuuTbxVvFIB4Wbzzj1mhAM3FGNUghvenT9X7CT96dYmE8R17N9iM+Lhni7Nbld
         oVYtw1GCJ6ImY3WLrZrU2AZiB+yWb/yAuV0t5NxecNpXxAyynqFI9rHBHJIatUMolQWx
         Nanw==
X-Forwarded-Encrypted: i=1; AJvYcCX6IQN4s4l8WoUaBYPvBoD/OYOnXM/AEmddTOqPf9oNBmpVRoyLxfOdHS8C3Fj78eNy9KEQLmQYi9133K1UkNr9uGRgGg0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtivLMidpjFTSY3jPCo6lBfWQMPC7rtkCdynd4F4agi+NlnYCL
	u9msUst9W9fK+NYmWuO15GDOM2XJ1yl7GtTWt5WVHwHxtok0Zec/EcHkNx6cK2ELdmm9cjCpK5V
	3PwadNjIWn6E8NFsthnblXaKoDcQZqa1luKoE
X-Google-Smtp-Source: AGHT+IH67k8daKEYTW3HHmz6negW5CiPM7iyxdQ5CKiRgxjRoq1/X/Upes8Q9bMpCpOlddu//dq56AyXXaFan3/oJXs=
X-Received: by 2002:a05:6902:248c:b0:e1d:2300:29a1 with SMTP id
 3f1490d57ef6-e2250c5483bmr7783067276.29.1727092369977; Mon, 23 Sep 2024
 04:52:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923080733.2914087-1-dongtai.guo@linux.dev>
In-Reply-To: <20240923080733.2914087-1-dongtai.guo@linux.dev>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 23 Sep 2024 07:52:39 -0400
Message-ID: <CAHC9VhQM7ingdydXFZ7Mt9FHLc4E1q7Mg_FR7FbFajw068TBig@mail.gmail.com>
Subject: Re: [PATCH 1/1] netlabel: Add missing comment to struct field
To: George Guo <dongtai.guo@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	George Guo <guodongtai@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 4:08=E2=80=AFAM George Guo <dongtai.guo@linux.dev> =
wrote:
>
> From: George Guo <guodongtai@kylinos.cn>
>
> add a comment to doi_remove in struct netlbl_calipso_ops.
>
> Flagged by ./scripts/kernel-doc -none.
>
> Signed-off-by: George Guo <guodongtai@kylinos.cn>
> ---
>  include/net/netlabel.h | 1 +
>  1 file changed, 1 insertion(+)

Looks good to me.

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/include/net/netlabel.h b/include/net/netlabel.h
> index 529160f76cac..4afd934b1238 100644
> --- a/include/net/netlabel.h
> +++ b/include/net/netlabel.h
> @@ -208,6 +208,7 @@ struct netlbl_lsm_secattr {
>   * struct netlbl_calipso_ops - NetLabel CALIPSO operations
>   * @doi_add: add a CALIPSO DOI
>   * @doi_free: free a CALIPSO DOI
> + * @doi_remove: remove a CALIPSO DOI
>   * @doi_getdef: returns a reference to a DOI
>   * @doi_putdef: releases a reference of a DOI
>   * @doi_walk: enumerate the DOI list
> --
> 2.34.1

--=20
paul-moore.com
