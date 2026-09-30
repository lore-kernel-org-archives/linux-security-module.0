Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993B4EEC3
	for <linux-security-module@vger.kernel.org>; Wed, 30 Sep 2026 01:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790732842; cv=none; b=lujQGAT5L5kqxtaHK7RIoK8Ole7f8psUWjKD3ALQNl2Z7CmeoSmrkkLQyIVfBqUpOQE4oxg03gS682Dq6IEqvEwNfe+Xb1qiXIdxWqMhFWwvTSIKvEGkGcE8B1NYsFtyFj/0Gxri0T5n0xdgAiXkvML4YskGiLspZ57IHB5TjHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790732842; c=relaxed/simple;
	bh=j1y8JII0KbtcnzztOwJmIIpaTkjRZQ9gyapQ+M0qlbI=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=RatsCdtK3LOAEl1fYZdXlEDgjp8FQoBIHWDdDDHI4WLjp9seY9zgxk24vAA28FImDlbvZn1r8ryiv5dNaqOL74QIpyyllKL/eP36VkK2g+IkGd7a/c2mu9fOmoGHXzz380ct2ZaYsk6o3ZZpJg+J8YRRIAvuwGPsKBCXa6CVrNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=P1heOGdg; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="P1heOGdg"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-52fb769ca17so40677711cf.2
        for <linux-security-module@vger.kernel.org>; Tue, 29 Sep 2026 18:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1790732840; x=1791337640; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lWYz+s+5nxbUDdD0enMJq534GP2tZO4g9IGtCMKK1Kg=;
        b=P1heOGdg/bhrcDV7vdA+xIyBmbUMWWZ/nvBAx8V2Tys1olQWnAcn1ifhRQ61XhpNf7
         MsSM2zhL4o8Q9Nl99gb3bDmhW5yrK0ENHA2yfbwWntY7YAIvfSjl4bBeeZk+5cc48vgn
         sI2hWzlZ8h72eX4QVxJfwqh2JaNtyx52Qb0S8SPjM4cJhfEa6fn6z1nMTRopD24jKE4a
         ho6VLLJfauWQtg8QX11Le5g4DPth0A2RnPd8arFOHw1eqCRT+eVBL0OnKAfguJJgcXPR
         YXxmMxVwe9RN2jJQviJsWg8SUbGSJgIjfNV3q3JibfLi7lnx3HTJ0+CjpUfgCmMNKyW4
         WCRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790732840; x=1791337640;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lWYz+s+5nxbUDdD0enMJq534GP2tZO4g9IGtCMKK1Kg=;
        b=GWZo5HX0dMD3tQt9ckyOm+1icHDRM48bvkdw85rif6pxg+tPsfFfaPK8vbIJLfoAa2
         zGebLEwpcISE52iwi9MOtcq4glaYjRclQKGL3yNlGvI7FJJuWtcYnlRJFjJvgphpQ5sm
         /Nj164O6sOs81r9/rL9kmJpTR1x5s/KE2FCAfincvH1c+UUwXL9mG/9fH/pIv47+g3Mk
         q6FhTu3K+ejT9dMIds3IvD613lPEuZfbXURZSUimHdwrWLPZf3rW2XMOBNpawrKqjVGO
         1w0Mg7OJ8QHKU3vLJlIp32ZabV2WoVXP+AQzhJCBXCa8LzRi+Mc+8AP8SZOG6sDmraKJ
         2R9A==
X-Gm-Message-State: AFuF++lp9zKulWlQRwzrt6tbX/oaNwg4189Kqg/bDDBEXKF5oQ9syxRY
	LqdvccGDjB0tvu79gfUijKL/+OznbDj0V1UqB8spPlBsc2+l07nbFsA35MevACSUnw==
X-Gm-Gg: AYBFou03WtCLOeetmXUPXtYBLR1UIRiZpCsWzathDRMcklwt/EQB1qn5LdfYEWXpbkU
	3IULpCgqzup77tXk8fLCNSEWiEURyCzQsJDsHROXT3BMY5kGmyVeSpfIK7Iyzm0kotIHmgqsDPR
	LFI3goLWNb9N8LrS/daZZiVGrlYrI+PcLRANELa/SXZ4fGGtE2bUvWR0QR1aGqGu5MRL6aSPv5D
	5S8AEIiTUd60VXSC5rldc74UXk4Ipq1IMPhovX5rbWv5NF9WOKou3CclPb651UHiKd1LQwZKCjg
	+aKoi6W5duoKqfaZQlc9axZNOOTDVp5IJIkW5GIXRhO+4yGJ/LciFSQ8JOvHUC92iMxD6iYZmys
	exEiCwu3LRCc/yqRru0knGoQ1R2zu+sCLREDBlgmQFwUURTGcmEXFr8fkw8nsMSIV8SJNSB7/kx
	4DStgGuQQS+5me0/Sucae3/rFkhZ4t68fLN4gk18UqyY4BqVN6l9ZFmfR0LSdYQUqHS0Eks78lg
	aA8RRq22iWtAzoVe7ooPfnY2cjNGloYfAI7KYa19cVjE7S8GCRWbz+Uq8QsasnTZaN/xbGmGQ4=
X-Received: by 2002:a05:622a:2589:b0:532:e568:7ee1 with SMTP id d75a77b69052e-5337431644dmr958921cf.40.1790732840261;
        Tue, 29 Sep 2026 18:47:20 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53373d7876csm619341cf.15.2026.09.29.18.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 18:47:18 -0700 (PDT)
Date: Tue, 29 Sep 2026 21:47:17 -0400
Message-ID: <62213a3e502201cc97730a108fd51aed@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260929_2146/pstg-lib:20260929_1010/pstg-pwork:20260929_2146
From: Paul Moore <paul@paul-moore.com>
To: Sang-Heon Jeon <ekffu200098@gmail.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org
Subject: Re: [PATCH] lsm: remove redundant NULL check in security_init()
References: <20260928170639.413560-1-ekffu200098@gmail.com>
In-Reply-To: <20260928170639.413560-1-ekffu200098@gmail.com>

On Sep 28, 2026 Sang-Heon Jeon <ekffu200098@gmail.com> wrote:
> 
> Since commit 5137e583ba26 ("lsm: cleanup the debug and console output
> in lsm_init.c"), the NULL check for lsm_order_legacy in security_init()
> has no effect.
> 
> So remove the check.
> 
> No functional change.
> 
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> ---
>  security/lsm_init.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Merged into lsm/dev, thanks.

--
paul-moore.com
