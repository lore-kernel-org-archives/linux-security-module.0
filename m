Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40381339A4
	for <linux-security-module@vger.kernel.org>; Wed,  7 Jan 2026 01:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767751077; cv=none; b=MCBf/WmYTDXiDSjr3ZBGGf3kA2YAp3z+igLJgPQM0pndsnGNueL4uoBeAEtNhJ59PrNog9j3efA1SJidVxIKR5MWEkn8m0DX2L4siVbCs0fK5nbgFyPWLqU8dHbcNqsrNfyJu4oSZHNobiVQ/96YbR3myGy0gvs3ylJ8N4TrO2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767751077; c=relaxed/simple;
	bh=avHQJ1ZmX9roX0am14C09/wdnSph7eLjg6ZB5uFDu6g=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=JR3ltKr0GSxGhHMBr1A2Hek4RbhUq2iks2VQqlpI5zvRIhp1HuY3tVVxMLjmW5Fm2b+5DIVBDj7gb0NFGvuVS8+Z/wkbQh7KYleu7uoj3pNMxt7LUomEnsS+dURhD2MNvPAOKf6MK0VDta8rH0JlpIT8pFgOya41AxC1whqNBTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=USWah2Ct; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="USWah2Ct"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8bb6a27d390so105891785a.3
        for <linux-security-module@vger.kernel.org>; Tue, 06 Jan 2026 17:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1767751075; x=1768355875; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/n4OKQ1p2rLBJccVbmNE8YULKxul1X3u9fZ3VtZZHbA=;
        b=USWah2CtLDKw0k3hR4eOXFSvC6DC10Q3rovqZX/reRXHjmApVTLRi1QNvqQLteSmvA
         9KZvQv7BhEPOOIXLppI1+n3amec2xMRUCmAmLeuzBAJBZ5eaCYt/QvlNVO/c2hLdCLMH
         cFXvJliwZ6HALb7jiqgz5EJSqNItRenssIj3Z2X6bbMoNejA3egHZdSaW9RcLdPhlVBe
         t6muC3JmJuZhFUACjFZyzuttD96T2vSGKNivekApDa1ou9femOyJYiCuWr468dZNf4eh
         9mQoJzVvb7QQvB1DGw06LqmVBO/J2kWkwLCl0ogVpkEnqvugYwPI9ivsyP8Y1Jxqk4Oc
         M4xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767751075; x=1768355875;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/n4OKQ1p2rLBJccVbmNE8YULKxul1X3u9fZ3VtZZHbA=;
        b=QxhUBVrsWVPn/Wmv7g1w7ylhSLbM1qGPChq5QpYJjyaq6oDVEK81nWD2lHltGBRbLK
         eokMeKZTzT4P6Zlzw7AaFNE+Fy3b6WTbqcn0/0xn+5KKyr5HwNI6VcP7qgI6FIS2oi0D
         LZMBC7REoWLkI5SkWwtPNrHLkUSVqURoVCu7g2CPxMriNzt1SQt7YP5hg+I4jVw0xkXb
         t0+YInfYrANGK7onT+rMP/NA0bLkwpV2Xrj4xH4A+XPD6Yak4VadOfe9Qa6ZmeyOxaO1
         Z6GFZboPH5Xm/O1GOnELur8ynt2LsGvDNfJZBjPwgMCudfd+gBZkQ5YGrBZgo527Tc3A
         Kjhw==
X-Forwarded-Encrypted: i=1; AJvYcCUsN5EpPyi+YHyQsisnxKYPPJ8TLS837yCwCSuF+5IGQNPAXsB8Vmd3R526wCTp6xReO6+2elpxtDuWtMmuY0Qa5UOtzQg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe295M/yeHpWswf0SgPHPiQ2Q6D/q47SXDw9L8esaBWS7tNhJJ
	Y7cscyhR5pCLzcBFMCmhaUePhBNwDxTZVlr8VEd8ltZW8Bx8NiZ4lL8vb2I30oeptDL/AJaV8V1
	fwcI=
X-Gm-Gg: AY/fxX5QgMsvl2zyFvGExKVucAcxlUIIxuwvecqze1p2ph+c0iy143GlH65Y+Dj3dwr
	DzLecL51Y68YnEDde9Zkl0pvYm52uxZbjP0+TjFrvE3D9PAQLYwnkom+uyw4NEbytdtgwXNjqvR
	dmTLrcLTWk6AkvXWr3Tn1ijRblRtzeODha602EYZrjLs+SCmWe4M9TGm1ja5RCESQrjiHQMZJBH
	pdxa+8JSMlmKWacDI8Q+DRR3nAgYM3piC9rtX6U3e4RyZ8hb4f9xO23hU5uZX3/GDlW423Ufrw5
	ur8AufuIXaxxaSDSwH9sYesDSD7VpgF1iw3FAzYNLBO1UsnNZllINUD4K4mdUEbMKD8zyRR0Rkg
	XK5SHTB/wsmchBa+njOByiBwI8l1pf1Z1gfU6ijfET1J5GnKrA5HlUBYVgGB59PMhDyhZN6ByNq
	PVpvhUxlump2J4CFvRwHx63jptzPKtXA0RPasPATwrWucWZXI3+li5BQDK
X-Google-Smtp-Source: AGHT+IFnNxiixHbf2mkoJM5V89/G69AA9FcCYBOfPqB4X3HFyfkttxdgFGbnPhtVjSq01FoWHgaj7g==
X-Received: by 2002:a05:620a:2584:b0:8b2:db27:425b with SMTP id af79cd13be357-8c3893f5a82mr130279585a.74.1767751074679;
        Tue, 06 Jan 2026 17:57:54 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890770e8cfasm24888506d6.21.2026.01.06.17.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 17:57:53 -0800 (PST)
Date: Tue, 06 Jan 2026 20:57:53 -0500
Message-ID: <cbbd4457d76c90179a63a87645c688f0@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260106_1639/pstg-lib:20260106_1639/pstg-pwork:20260106_1639
From: Paul Moore <paul@paul-moore.com>
To: Ben Dooks <ben.dooks@codethink.co.uk>, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Cc: serge@hallyn.com, jmorris@namei.org, paul@paul-moore.co, Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: [PATCH] lsm: make keys for static branch static
References: <20260106171332.69558-1-ben.dooks@codethink.co.uk>
In-Reply-To: <20260106171332.69558-1-ben.dooks@codethink.co.uk>

On Jan  6, 2026 Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> 
> The key use for static-branches are not refrenced by name outside
> of the security/security.c file, so make them static. This stops
> the sparse warnings about "Should it be static?" such as:
> 
> security/security.c: note: in included file:
> ./include/linux/lsm_hook_defs.h:29:1: warning: symbol 'security_hook_active_binder_set_context_mgr_0' was not declared. Should it be static?
> ./include/linux/lsm_hook_defs.h:29:1: warning: symbol 'security_hook_active_binder_set_context_mgr_1' was not declared. Should it be static?
> ./include/linux/lsm_hook_defs.h:29:1: warning: symbol 'security_hook_active_binder_set_context_mgr_2' was not declared. Should it be static?
> ./include/linux/lsm_hook_defs.h:30:1: warning: symbol 'security_hook_active_binder_transaction_0' was not declared. Should it be static?
> ...
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  security/security.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged into lsm/dev, thanks.

--
paul-moore.com
