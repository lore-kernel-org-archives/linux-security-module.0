Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC39359A66
	for <linux-security-module@vger.kernel.org>; Thu,  2 Jul 2026 21:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783026562; cv=none; b=ZWsLtowcEnTlsUKVT0wk+QUbdlTOdz8A9P83k0KuTwMrIiH7zZK1w+0gFuaZJJcMS4zuPbdYi0lzGzZvMg3V3tPKx6JYvE+CV8a3+O7MA+/9/CwC10dOj7EO93YkO7a5zAT22kgbN1Gb0rZhEVzV6VhRTjW8V2X7Mg4+S0EcDX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783026562; c=relaxed/simple;
	bh=ouR8TrKTdaUgj5VUYgwEuvViJWqxd5FXy5BOp8C8MMw=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=PERQRqV2i/2F1Dyta1w+f4yExPqmNMYGXTsrDxuMzoaHDKVzgBALBCkx2xHQqhPYcGMGPi8DxSnEdDUt9gNzS+VlQvKPrSjj9WHremHQrDUHLTMCoqDUbTkYf3RHe+nsDWQuEM5ZsCXo4jZQP8dNFNqs+6IYaLcHhFvpF6FVVRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Dc8O+x3D; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Dc8O+x3D"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-92e54f8c051so115813085a.3
        for <linux-security-module@vger.kernel.org>; Thu, 02 Jul 2026 14:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1783026559; x=1783631359; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IJB+SnKXg/Iaj9dh+1/QXu3RKn8G8jVD2oOZ/Lpv5FQ=;
        b=Dc8O+x3DIkzMHgcQesFvCraBnNy7hZBLEewz7iHWwQNU2YmOfW6Zvh4R0VWZIE052S
         rkNqVU0vMts3wTOCSSQIOPXfmFERG18FszSRkRkEMNzfqxdIkmtOm4bQv4+ZL1j2GwYI
         prioKCniYJq+5HdTx3rlrCminF20yYfznQwG9174HDzIPQePqYexd94zrNusqoHSUaS8
         Woti7MXxXAfcys3QUprcTSl2NjBcq84U9CIBRtKybgN9emcUmhJVIUVORNzQRVZdcCLz
         fHvFsE0EvcumwVO9ZX1d7WW1vFyB7fD1nBBnz5aRmRDr/bSVr+dlpAAdjAWLotn8sO35
         cNaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783026559; x=1783631359;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IJB+SnKXg/Iaj9dh+1/QXu3RKn8G8jVD2oOZ/Lpv5FQ=;
        b=NSkKKBK1KqVbC4KHujzCCi6T5P/xa9/gqzaiXZTH7U3ixiJn2S1q4BKB/oEms08kCI
         66qVQNPKpjT0kr75Y1N0tBs08Dr+MnFZpYS0i0Y5ZVY8Dr/kLI185tQjbqfMPXJZMXiQ
         zehC5zjJIpBe3QU5eOrfIxRwHjX0/JUWyQov6GMk/pCXZce+Y9BVhHN9CqlGKce2UtkK
         wkFZTdLlYeKpkUzE3aVVzZjFZRSS8GELkbyTtuIqAlP1DooV1DmnTtepTsLEkEoWWlne
         DpbXxPJgltuZHVC3TNi8WoOzXWHs+EGLV8tyKkFPuuyJW3vlebABjfIQogK8jphTfC/q
         eDFA==
X-Gm-Message-State: AOJu0YxsHQFJ3lkh3xTHAZDDp1J1fLpjxgmotZYMHYAWsaXuFmM+cKq5
	1w9GKSBX3Krm6r/xPJv48YEbaFRYWvD3qddVm7+EXDs6HsMJBP2CIIYavpiZ3a3ymw==
X-Gm-Gg: AfdE7ckHsNUedb9Lq+a1TwwbdFQS8hO9CTXOIVWZNMdnSotZDr8UeDsrfgyKpe+SkU6
	DovxIykmp4T8u4C7zKi5267Ds1YXsQpFQbcNUJSLmdKO5Ee8D8HTYfMhQEJ7xQ2k/lKeXlEP9lZ
	7RHn9SxMke+kR1v6q4FDeWU9UkrDrfXti7IrOeaxsP8kIdpD93tB7jSe4MsPVq1mpFks0m4uAjT
	/BE3kPKPFC66f5CGiB4R7iuTylYQQbxzweyeI36OI27jYEKy7QYv0I5NQun1bRZmEnjgqW5Cdu9
	HlERF2VBURWY3Wd61xC/wuKNfS0ATQlgwc/HJt4Xz01qPfFANKbUVrIA4wc3uwjFjShFeQPceEC
	P9LAfr0BhVnIScYuQk1lnRKhK/2vMH1a1cTaOR0bR9/jjkSnxELD7dSJiguNwSHWvuOQI8jOYEr
	qoLa77syu9ny2aYDrZvom1kxVIXNNMCYQgbeWx1NYr2juT4WPxYJRD9Saupg==
X-Received: by 2002:a05:620a:170c:b0:92e:61f1:6b72 with SMTP id af79cd13be357-92e781d6ab1mr1061745885a.13.1783026558741;
        Thu, 02 Jul 2026 14:09:18 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e80162034sm315351285a.27.2026.07.02.14.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 14:09:17 -0700 (PDT)
Date: Thu, 02 Jul 2026 17:09:16 -0400
Message-ID: <d6f8f888e50c38903c19123673056924@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260702_1708/pstg-lib:20260702_1621/pstg-pwork:20260702_1708
From: Paul Moore <paul@paul-moore.com>
To: Cai Xinchen <caixinchen1@huawei.com>, <jmorris@namei.org>, <serge@hallyn.com>, <stephen.smalley.work@gmail.com>, <omosnace@redhat.com>, <amir73il@gmail.com>, <brauner@kernel.org>
Cc: <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <selinux@vger.kernel.org>, <caixinchen1@huawei.com>, <lujialin4@huawei.com>
Subject: Re: [PATCH 1/2] security: Some cleanup code
References: <20260626011720.1144213-2-caixinchen1@huawei.com>
In-Reply-To: <20260626011720.1144213-2-caixinchen1@huawei.com>

On Jun 25, 2026 Cai Xinchen <caixinchen1@huawei.com> wrote:
> 
> Delete an unnecessary blank line and a blobs variable with
> duplicate assignment.
> 
> Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>
> ---
>  security/lsm_init.c      | 1 -
>  security/selinux/hooks.c | 1 -
>  2 files changed, 2 deletions(-)

Please split this into two patches: one for the LSM (lsm_init.c) and
one for SELinux (hooks.c).  They are two different subsystems, mailing
lists, etc.

> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index 7c0fd17f1601..d7384866e3a5 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -290,7 +290,6 @@ static void __init lsm_prepare(struct lsm_info *lsm)
>  		return;
>  
>  	/* Register the LSM blob sizes. */
> -	blobs = lsm->blobs;
>  	lsm_blob_size_update(&blobs->lbs_cred, &blob_sizes.lbs_cred);
>  	lsm_blob_size_update(&blobs->lbs_file, &blob_sizes.lbs_file);
>  	lsm_blob_size_update(&blobs->lbs_backing_file,
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 1a713d96206f..e5930ebc9e37 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1748,7 +1748,6 @@ static int bpf_fd_pass(const struct file *file, u32 sid);
>  
>  static int __file_has_perm(const struct cred *cred, const struct file *file,
>  			   u32 av, bool bf_user_file)
> -
>  {
>  	struct common_audit_data ad;
>  	struct inode *inode;
> -- 
> 2.34.1

--
paul-moore.com
