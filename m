Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114301C5D72
	for <linux-security-module@vger.kernel.org>; Wed,  6 Aug 2025 22:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754517976; cv=none; b=n7btjaRAUq4U7TGMNZVLvR+3FUX+0M8XVl9xBwG3OmQPgryTncQlg3vBmXj7WEWIkzTnVw3zNge6V77r+gQtNHQd+1f7WHih4O8waQHDClawRGv4lFScdVruDEOTvVuXeA1m6FKhS0lYHh1r6GGTqe4WSAU3k+2DUMWa6HBpVWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754517976; c=relaxed/simple;
	bh=AZb3s71JJh33LT/OJ6WTaBPpWMRvxVzhiysQxR+t4Yo=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=VvFa1McGUdl/TsaGuz1DAE4hHFR8ok5UlZ4HRJgxUNLwNzYu6wP60jULDVvNecdhmh3RIcYz9Bf6X/tJoepKRY8obwKjetynFMjDWHppoo8oe+xKfMIRATPvMNEjy4r1XSK0XsD0IjNOcEK14+PnjBaMH/OVl3ndFwxy+kx45as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=KqKCtHbP; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KqKCtHbP"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b06d162789so4377901cf.2
        for <linux-security-module@vger.kernel.org>; Wed, 06 Aug 2025 15:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1754517973; x=1755122773; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1o80sNmGFwzKlK4FxAE/E67Erwh6Se4s2RUs98B2vc0=;
        b=KqKCtHbPnuDXRIY+fhAZjVUj+3FIOk6+LdpoQun47mvWq3iDGxfZQx8mvZ+dM6OLli
         aEgKnWZL2Csvrc0hfMITHWLc0Rjmg/V+OyTpyWgiwe1hsreV3UUqV5s76tKJzfJZV3KC
         /5bVqqdquQlc+27y9Sta6Nw38+EBtZK0jiN7OEYd97+QcALMsrFucfDGHrxGcDoMvRUN
         X1b/APBElAfNVYTpDOpBUOH3aBrOcf39M2Or84eZwUKW9xs2Skuk3tgvkDKuKihOj1t3
         ZVP/us2flk87x2oHs8NTH0OCI+oCTChB1ld1gu78VBS1IKRFMzMZhJjLG2PFoyMAN6xr
         o/cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754517973; x=1755122773;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1o80sNmGFwzKlK4FxAE/E67Erwh6Se4s2RUs98B2vc0=;
        b=C8R3gfbsEWVtN1nkhZW/88NTOCFszrGpnwhDsFpRyM2b7U6TD/2OyPu8oja11eRVR/
         v4CgHxmVpGGEkA5SodrUxZJxhJTaq08gBUwz355FTNhDixfqExiWkLxeqCfaotGsnVY+
         0/i9Q208xWY5nnjVU+TccDZkLXbBM9SyCuW+wzUoNdbWxqOrJMLNxBxvNfLZJ2RJUhGy
         XznYTJs9CEK6VOe+PgQY7OjMQBtlMB6g2cHzyCBT5QlDRJaLkBysVThHylQi/Rddh6DN
         gv69PAAHTvLaBjStmXq3jsOTMup3Yglc0ocKgSWArzAerbnaeAwXRZgp5cQ9yvyTPqqN
         Mjhw==
X-Forwarded-Encrypted: i=1; AJvYcCXbfUtC/MSrI5XeHUFJSbdyw2Bius6aVAjwHOByOYoNhiIClV9J+tkNaTL036zTzd2RpCNW0quE3/t9ilWQeDX3fT67eLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRVv3DvCx9Zwt2MOTp1rYVmUQJzGVMpLngf2HbDEFkRFNgH/y0
	HAxODOjpCkoSPudLKvIHNHwxLhQfPUAGaETp5OY9YxbPbZxMk9mCeJkE0LBZ4kom6A==
X-Gm-Gg: ASbGncv/+Ik1oRuvCxVzeL6xaxnbsQnBOMkzbeJ1HchkXO29TfDMTEO9+QqR/WudH75
	YpOCaDx+pMjDTxuzlwfu9B44KR0HZcQ7gsa64q8lrZVbAqLHUwtFIvkrf+Y/nOT8pWKxtGrfAPn
	Xwmczxd5+zs76YRVv3rdXWglrvP9a80+rqrTeRHBJi1GsJdQZ81k5IQguTDznYjVKuPvLQlO3SI
	ufVYIKPXm8xZXz9PEBFSv00RNzj59z9AcUUiSPHKxMSePlNG0PLQvS3a8BbDmtzOV3wBhoWpz7p
	+HR4BpJ8nEKITZindKrwBBbvvyLuLHaDJjXZv7h4uNp6W9xSgyAjjY1wxJZuBs3WjYvBxcYk5TX
	3eySxickXJcy8RLxoQ1j6TT+biDMpN6Ky+5UvtMGgIb4OS3Cqn9ACvN9Jte1dSW7fUGY=
X-Google-Smtp-Source: AGHT+IG4WOTe52hbcaGbNLSDM3J6PCnYw/yKUN/TtQ1ElGqLlp3dNbbODonDRI+YTHlBq/QwlhefrA==
X-Received: by 2002:a05:622a:4012:b0:4ab:a762:4c8d with SMTP id d75a77b69052e-4b0924b5879mr63239841cf.4.1754517972960;
        Wed, 06 Aug 2025 15:06:12 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4b06f790834sm40991931cf.60.2025.08.06.15.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 15:06:12 -0700 (PDT)
Date: Wed, 06 Aug 2025 18:06:11 -0400
Message-ID: <3e45e20228c80f9f6a126d09208ff995@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250806_1659/pstg-lib:20250806_1657/pstg-pwork:20250806_1659
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, eparis@redhat.com, linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH 1/3] LSM: Add mount opts blob size tracking
References: <20250617210105.17479-2-casey@schaufler-ca.com>
In-Reply-To: <20250617210105.17479-2-casey@schaufler-ca.com>

On Jun 17, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Add mount option data to the blob size accounting in anticipation
> of using a shared mnt_opts blob.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/lsm_hooks.h  | 1 +
>  security/lsm_init.c        | 2 ++
>  security/selinux/hooks.c   | 1 +
>  security/smack/smack_lsm.c | 1 +
>  4 files changed, 5 insertions(+)

Since you're respinning this patchset for other reasons, just base it
on the existing LSM initialization code.  If this patchset collides with
the init rework mid-flight I'll handle the merge fixup.

I appreciate the consideration, but in this case I think it's easier to
not have the dependency.

--
paul-moore.com
