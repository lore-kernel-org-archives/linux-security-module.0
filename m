Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7292380FE0
	for <linux-security-module@vger.kernel.org>; Thu,  2 Jul 2026 21:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783026566; cv=none; b=p0kINBGqzdJ9MnZh+JB9bTGqX0CAzqzm5gOtBSIceb489O/ybPkCmbWd+vN0d+LUZGQesPQLi8mNZ58C1xGzhUUdPtPP1DeD0PfhkcDVHkAYAFXPUcPf/hCVOg9CcPxxYwQwqecfBP3AVMO5DphdU8ii3aX3MBkw45oTJfYOoUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783026566; c=relaxed/simple;
	bh=kVMPhLG4B61syX8xYRQTF775Svpe3o2smNHOoAYP/TQ=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=DLv9qyTVwfwMCjtJt510r75zJXf5e/WmVh5MxKUDcL/4k21vnS5SnYED+9T/gRvleqqWmVebJ+GsQmvWnftr4EgFXxrx3fOQz9GU45dOrj+hj6bJ5qbtp7k1Gw/zDM3g/DlMvGIYMLCPdXaBn2mNbBC3imC5Wl9qtjQs2tC1/Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=b1zMWoPy; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="b1zMWoPy"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-920f33347f5so118979785a.3
        for <linux-security-module@vger.kernel.org>; Thu, 02 Jul 2026 14:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1783026561; x=1783631361; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1zDD65xSoNtkwN4qUjfkJpOGx1BZRFvF8Z2RPhtKTW0=;
        b=b1zMWoPyIyUPRzQnUtmbHDRANlrqWvVcXwZO0Op6XxYtWyuOn+9Id5AumXGEQ/W28t
         UKtlq3ygUeCxWYjd4myDsGxOmAYGlMG6SuMfCNT8DMyKRc2uL6i1RkDw0dmkDuvhYkxr
         iXzzylOM0zPGzFYEN5iuGZ3oqTBPAoi7APaXr34WidhKA3mSSofE5i5hhZrOe3DKQPOA
         gcAS2KC8Vr0UE7YttI614TsIiMbUlHo6BirQV7y4ZpYJHE96jZpYe2wDB/TQCWCms1/v
         2EINURQIE0vDTUsSbMII+mzCTOPHHCRMU0/4QC2NCzzmhcoxS5qTEynmeKYoJVSBScZD
         uBVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783026561; x=1783631361;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1zDD65xSoNtkwN4qUjfkJpOGx1BZRFvF8Z2RPhtKTW0=;
        b=bcRmFLody3XsQsqJ5vwsQFavj3H9nilr0UH+EnW9FrFUVTjQhEDPSmXHI2+nHcLTuv
         B6Mf9ffeVPMOEaQYv3zuTzZwr40W7uiRCvfVO1CD5hrTsksFeAlU4qvvqpLp0DRp554n
         AWya3QKOVqBrOM9PeWvhVIB//sa+pLiCpSigDYceOX67th0IBkNpdKC9b+BhYhbq18df
         xP40rQH62kKfML4hpHnXxemfTFhdt0BUrOztxbe3EjS06975iTqeooBlkztcQY+ayv1E
         e6mO0eeL2CDfPpVtK6eq3Sq93tic0EkTZDnN3M3f+yh/klpoaWr4tffeNbrA+NELKLrN
         +Fdg==
X-Gm-Message-State: AOJu0Yxy3uvS9CLdM5Ohn6a+bbDsiAWN/UGTXGr1BdLRgneTmZc+7at9
	HnKn17AMKnfNVuncxtefnsUsSZ2wAGAqMVr5nRViBKNKdEAwOotxOjVKgcUh0jkOiw==
X-Gm-Gg: AfdE7cl8VwlsQraYMqxRDXjfIVpnXGYnp6nw8soG7j5DzSN4Uzy8vB942h6jP9zUwNO
	asiNyebx0llEfQ4+R4OAjY2h5aEx7GD11ReAWDvsUPhDF0YWB0U2naPRusJdfbnsSBq6K38puiL
	LvqMf9YZ2ugm7l9TsG0gXPcsqGUo9RjJT1kQ4vPLZlogfq+ooXcdI08ZDsj68lNTPYdAH1hzz49
	eLSvJ92CQhs8nMXqZNPcZoVVihfSdK/4OOdNyWILItjm29eHyT95sE2uVtlGJ+SnVb+nb23lSlE
	CBwj51YaEHH3TUGiwKXk0HPHnBzLpE0kUG5goFWa+KxtJUDNmM1n+o2m45PVnUJ96SXiZNkrrTj
	lLgL19nfhIO6mKJEQ6Ds19lbMLavsxfN7APSC74H3Gw85EuX3VmZO+uJbmoU8kNb/8LlN3ASkmk
	IjkJ5ztDi4LzVEZaHc6GfinY58IG8dpky3N/p6yebGHt76eFI103FbJJL7dg==
X-Received: by 2002:a05:620a:2915:b0:92e:4927:1fff with SMTP id af79cd13be357-92e782c94ddmr1075758985a.36.1783026560920;
        Thu, 02 Jul 2026 14:09:20 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e80162029sm312593485a.26.2026.07.02.14.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 14:09:19 -0700 (PDT)
Date: Thu, 02 Jul 2026 17:09:18 -0400
Message-ID: <aa30283e5827cdff22a62421c8d8e088@paul-moore.com>
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
Subject: Re: [PATCH 2/2] security: Fix call security_backing_file_free second  time
References: <20260626011720.1144213-3-caixinchen1@huawei.com>
In-Reply-To: <20260626011720.1144213-3-caixinchen1@huawei.com>

On Jun 25, 2026 Cai Xinchen <caixinchen1@huawei.com> wrote:
> 
> I found the following path:
> 
> alloc_empty_backing-file
>     init_file(&ff->file, xxx)
>         -> file_ref_init(&f->f_ref, 1); // only 1
>     error = init_backing_file
>         -> security_backing_file_alloc
>         -> rc = call_int_hook(backing_file_alloc, ...)

The good news is that as you mentioned, only SELinux defines a
backing_file_alloc hook and it always returns success/0.

>            if (unlikely(rc))
>            	security_backing_file_free(backing_file); // first call
>     if (unlikely(error)) {
>         fput(&ff->file);
>          -> if (unlikely(file_ref_put(&file->f_ref))) // zero
>                 __fput_deferred(file);
>                  -> ____fput -> __fput -> file_free(file);
>                  -> backing_file_free(backing_file(f));
>                  -> security_backing_file_free(&ff->file); // second call
> 
> Currently, only SELinux has the lsm backing_file_alloc hook, and the
> backing_file_free hook is not set. When security_backing_file_free is
> called for the first time, the blobs pointer is set to NULL. Therefore,
> double free will not occur in the code.
> 
> Fixes: 6af36aeb147a ("lsm: add backing_file LSM hooks")
> Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>
> ---
>  security/security.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/security/security.c b/security/security.c
> index 71aea8fdf014..595d3c73253e 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2468,11 +2468,8 @@ int security_backing_file_alloc(struct file *backing_file,
>  	rc = lsm_backing_file_alloc(backing_file);
>  	if (rc)
>  		return rc;
> -	rc = call_int_hook(backing_file_alloc, backing_file, user_file);
> -	if (unlikely(rc))
> -		security_backing_file_free(backing_file);
>  
> -	return rc;
> +	return call_int_hook(backing_file_alloc, backing_file, user_file);
>  }

I think the better option would be to move the
call_void_hook(backing_file_free, ...) call in security_backing_file_free()
into the if-statment true block before we set the backing file's LSM blob
pointer to NULL and free the LSM blob.

--
paul-moore.com
