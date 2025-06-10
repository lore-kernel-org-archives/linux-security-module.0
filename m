Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC8574C14
	for <linux-security-module@vger.kernel.org>; Tue, 10 Jun 2025 23:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749599981; cv=none; b=RRHR5vsvEa6TBVb5C64RSx/nQJNuI5UUskdlx7/BdycRqj1gAHddlMeBfee3rHCXeJI1tk3dywf4ViQyZiPjNeHVzba3HB+Bl+mm3BTmSkR0bvNSTcTwzijpsxKkMomarGMjVYVLut/RRdOBzrJd4fZEmYzcPgB8z34lNsAxmno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749599981; c=relaxed/simple;
	bh=Je4CJQwLEMxzyvSqXnXflA8q5uNGWa/x2XoZS+jIlro=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=uUs6OGBIHTMaGJRSUQYhwed7ckTyQBV2EZLYCgr2bL+9LxfcIlWINb0tFwTRriaz83A1e1Bwb0trFx2NKAPaqdSEcLhJBJ4OaQGdiPo+2xVqs6ZRsgKzfgJuNsJ9AcwkvM0HjjW/t5kbOtp3HPdKQ6nSCorSfAtcbRudSQ0I6+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RXKuHeLq; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RXKuHeLq"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7d20f79a00dso779618185a.0
        for <linux-security-module@vger.kernel.org>; Tue, 10 Jun 2025 16:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1749599977; x=1750204777; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v7XbTnvXmwSEu1E53OM74kRhz4BEvh+0MMYgo4LW+rk=;
        b=RXKuHeLqAXrHmeY4ugstcuiL3UzkGw/IjNjadYmyq0hw/l3KV6dOxAFEWsT+ysC2Jl
         e/aeJqg827Z21yZWFO/ciVffcfXLIzgCUw/08VeslPM+T2zBccLMcAVSP8XhHH/z69xg
         swnvn5Z0V6bPGmp8MYyeg+zUUUIYxvE7E+hLbgW9wPYXXLMRqx3nQd3n0tKFdropv79A
         6sBJtgyrFeuPm6TbvrzH74MsjMvzUO2tEUr6LyGyV/JD44oXMxPxzGum9drrHgms0GXf
         tIDb6ANWb38f8LC5szm+Gm7mCzTxsNfEIFZu2a7t5ekhX2Hf0CxgJLyINpjtKwXl+UAB
         giDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749599977; x=1750204777;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v7XbTnvXmwSEu1E53OM74kRhz4BEvh+0MMYgo4LW+rk=;
        b=WuOhVtr5gv4u/gB0vJB/CXlJXK/JorXPmPSOGDddrS4l1tVYCKC8oNdeX6QDLKYEIl
         CfYHdI4Pbmxp4o61ZlyeNgcPgV1SlbkZuzORQTSknwgL4vAgra6v8l0/oeZHYk32GDl2
         em3+JFBCU7vDnDZaVis6rjRSTX9N1xHLEX7WAIPdysaXO/hlY8R2Nm/h9kGFX2VKqQqU
         f/KZu7/+Gn6aSAwGjEO8P+HiIkgEN/SAq6uB2aLfqpwvTCoV6BOVxYIh7T8IAlAyWkoI
         7Ybckf100I1i9IEHZ3Owrl+46/CZUTfgX8v5KxtP3UBZx1xKa/pj6ipZvbmL45zopf9f
         6Q0w==
X-Forwarded-Encrypted: i=1; AJvYcCUe+PYhBlbOEyrZi7HWmPfBjCQIW6KRhU1PLIf6xMZ6jHb0m+4+TT16kOwlq0vyfQMDIcDMPI73IpnzovhU5m5WfdBEcsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBdVQWIGVmJrHQ74S0R2/i0JhqZoVx6FEJPgQWi2z38crWg43S
	bc/IePU0kjNK4V4ImNXwqxT/3eZGmBMCl+fBSwzcqohK9DTRphoQcORAVqzQPvoylkfgkFJce5W
	kcrA=
X-Gm-Gg: ASbGnct/upcfjK94dOzqlv+33gLj677lyBW8q006VVjHpwX7gNUsoZCa+OLqBUC8vtp
	GWFG3FwEuVR7WV2Wg4CeVZPJUyOTF3YWK3tCt4Sh4wFoZULZPbv43G3Mzvzdx/g3bwLK+V+vLxs
	mNGSGxiwbXPHzPQNav1WSRFIWBKpoPwKUUVYkoZ5Ec86Cs3DmxgWBKu7eGiHVHUXuIi3ERrYjDI
	qM4X/CaTUBlM+vqU9RSmPgVlTAb7q3lRPVfi8b89Q8aziUe1Yekx2jFnBf3B27pkA8rNIvDvJds
	UErxCcFuUUy1uqaOIN4OhNBckSt2raVM3Zu4RdaNLN/YV6F0kjOra+dg+EOYTtIpuV7TylGx+r4
	a4vnvlVkHtfhFYOWIIWKSv0sAh1UZ5Do=
X-Google-Smtp-Source: AGHT+IEYvYq1zREnITQiTHWiFYu+Q7dqnjN3FAbmTP65Qo4UtNmfwZPUsk9OIL+y0WOtEfcnduwFPg==
X-Received: by 2002:a05:620a:458b:b0:7d0:a25b:d04c with SMTP id af79cd13be357-7d3a9566e5dmr171097285a.9.1749599977500;
        Tue, 10 Jun 2025 16:59:37 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6fb09b2a021sm73954656d6.83.2025.06.10.16.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 16:59:37 -0700 (PDT)
Date: Tue, 10 Jun 2025 19:59:36 -0400
Message-ID: <9d934c88d329a2e6076c344c90cf620a@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250610_1956/pstg-lib:20250610_1817/pstg-pwork:20250610_1956
From: Paul Moore <paul@paul-moore.com>
To: Kalevi Kolttonen <kalevi@kolttonen.fi>, linux-security-module@vger.kernel.org
Cc: Kalevi Kolttonen <kalevi@kolttonen.fi>
Subject: Re: [PATCH] Trivial fix comment
References: <20250515202340.4271-1-kalevi@kolttonen.fi>
In-Reply-To: <20250515202340.4271-1-kalevi@kolttonen.fi>

On May 15, 2025 Kalevi Kolttonen <kalevi@kolttonen.fi> wrote:
> 
> Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>
> ---
>  security/security.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged into lsm/dev but I fixed the subject line and added a simple
commit description.  Please take a look and apply these lessons to
any future submissions.

> diff --git a/security/security.c b/security/security.c
> index 596d41818577..fc8405928cc7 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2181,7 +2181,7 @@ int security_inode_symlink(struct inode *dir, struct dentry *dentry,
>  }
>  
>  /**
> - * security_inode_mkdir() - Check if creation a new director is allowed
> + * security_inode_mkdir() - Check if creating a new directory is allowed
>   * @dir: parent directory
>   * @dentry: new directory
>   * @mode: new directory mode
> -- 
> 2.49.0

--
paul-moore.com
