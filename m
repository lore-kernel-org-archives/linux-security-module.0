Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB76147FB0C
	for <linux-security-module@vger.kernel.org>; Thu, 27 Aug 2026 16:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787848263; cv=none; b=aW8zKFJ4y4LN2DRhIJwHqYZ+heAqrjPfC9iNSA5JDRSYB8xmsEHAwB+TMTXHgIh8jDGyiQEpQG/m80eJCecA1AkY1kV/DHE0/GSfaX6/sHnr5936Ybu/MTnV5BNGirhPICZfizEKOgCvLrZep5QnBOb82XSbPtnxHLP9SyHy428=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787848263; c=relaxed/simple;
	bh=Q7OU5Jz6IQBMs1spEvrVx8dsBO8QJhIHsIwAADhDZF0=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=kzt9tsYBdlZaEu6P9gS8QVaao40rmPGZ1j7LUKqLjZ57Ue/HRGlflyY2bprGsS5gZlfaJDtyR3PGrMhfvXKeRYqzif3I7pmfxyFFpKg5THb78OUa3UqvvlLmMHPnnF2MraqErfuOIU84E6j4G/X+r0G15N7g33OxZsfc+DtbTO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Ch7NMVUO; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Ch7NMVUO"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-90ce08834feso1286756d6.0
        for <linux-security-module@vger.kernel.org>; Thu, 27 Aug 2026 09:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1787848260; x=1788453060; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dq25/aBtrpBpx0nZ2dCJgr2eO7iV5tGb9Q2RS6EzPiM=;
        b=Ch7NMVUO+B69x8WhWm17WiQd0VbYvH7C1fK281mttc/ITu40Ju86ZLst2Qy8dHBz+f
         xv9GakndqLpr+dT//OIVMViHUCVTfUqOPZ+DmNAotFDn+szK5trbtFTfe0jd4J0nJMqs
         iAShvLDzU+EQhxNlqD8X7vO7MLhWCMyJ2jDi6WcUt3GgVF1ltIoneYXosLC5Ap5sgCjS
         JTHUqlj0x170DjRdUhzR8GSZ8mbHTP1XiJ80QHOHrSI2aJYXMRU0jIPi7+j8j9lm6oz3
         aMfvyF9BsPe8MEQMzPvAdr3LYjGJjpNkkq7D52vCe7t3P5z5XS7P5Gu9g1o2/9clfpbC
         Ct9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787848260; x=1788453060;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dq25/aBtrpBpx0nZ2dCJgr2eO7iV5tGb9Q2RS6EzPiM=;
        b=KiJQamykrdCeDKlGH6H7SxIy+zTN50kLCG3rYIbsimKYORcqDr8JLuSybG2j/x9mfU
         hympYLV6t5Uo58k+XLt31z1t+x/JVYHdAb8nudMScALq37j2LGpCD3qdDKdfu5BxrHVs
         dUaPXJrLVfleCyiCp0T98dWlSzJrz+G9VkYbrxNkf7qxkB7INQX67mBqtfAXiDRkLZtE
         QBvJn3d+tvLIh7yXDOa+OGL8TlyHedsOlZ44CWKWkUCQ189s9XECLYepKVCxyZTOFM8N
         28/YEYpr8DNw+exhSMyYDsfLvfRiQoOLqQyz02h4UTSQriOM+cqm7xrlZH6BX0gvCJLv
         E40A==
X-Gm-Message-State: AFuF++n8H6FBCnyv54YOqsZi8cTdIHrv6Sw6nNew5Jn/RufAQ2H5rwed
	vRwMLvdUVbf2rY4t39IhAeMUvi1KrlUb4VtQzFKaiEKclGYo+KNa6Qha+x/H8ph00w==
X-Gm-Gg: AR+sD12NXjU78M1CvPKSDaWWV3BdD9GuTJ5xZEOtcmvdgXFC0hVlXel/60fh3GRtJ0P
	qSrc8bFZa9NjDfegfvuC2CZDaS006fXR6OtEqUdBvenPt19epqaDhFzy6Q2HHDd4gPri0QtJ6ua
	C2l9tPyQmckIYASAYifxpdrhUk5txsa8iNk/G5y0EiwxnbodqF/+auFXqLxLoofFpf65VM0LMbu
	44BX86pdHxZdfCiAWGG0bQhBQZmwm3m2MWJ/TRjRcR3w9ZCNbH/r76GQm8gN86WfgxhnrU2DuVa
	SEZSjWC8q6lqz4i1DbBjHyz9o/80O+IhHOfHl/Br1z8tIhZU0uB6Y/BtDX7UiKW2Lmg759BUF9w
	DQz0iWQ9+t3mtXHOqbHTD+R8AdLArIZ24D2leMoqLu2cD9SDSNnwUtL5vdkAJ0PM4pthSPKkdad
	WfEv1nnE8WEfDItKPp/fvCKn/u9u6vPFT79YZ6exF9U0SAyM0L4rCF6twAQ8l3dHisDdh8Bn/0q
	uwXoPNFE/vu9EX3J36zBTpBx6lr0xtVig==
X-Received: by 2002:a05:6214:2aa8:b0:8ee:fd0c:5d96 with SMTP id 6a1803df08f44-90ce0c375b0mr6387676d6.7.1787848259896;
        Thu, 27 Aug 2026 09:30:59 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90cd741629esm20326666d6.49.2026.08.27.09.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 09:30:59 -0700 (PDT)
Date: Thu, 27 Aug 2026 12:30:58 -0400
Message-ID: <e7bf759345415ea1935fc845506d84d9@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260827_1122/pstg-lib:20260826_1402/pstg-pwork:20260827_1122
From: Paul Moore <paul@paul-moore.com>
To: Cai Xinchen <caixinchen1@huawei.com>, <jmorris@namei.org>, <serge@hallyn.com>, <amir73il@gmail.com>, <brauner@kernel.org>, <caixinchen1@huawei.com>
Cc: <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <lujialin4@huawei.com>
Subject: Re: [PATCH v2 2/2] security: Fix call security_backing_file_free  second time
References: <20260707080615.1235830-3-caixinchen1@huawei.com>
In-Reply-To: <20260707080615.1235830-3-caixinchen1@huawei.com>

On Jul  7, 2026 Cai Xinchen <caixinchen1@huawei.com> wrote:
> 
> I found the following path:
> 
> alloc_empty_backing-file
>     init_file(&ff->file, xxx)
>         -> file_ref_init(&f->f_ref, 1); // only 1
>     error = init_backing_file
>         -> security_backing_file_alloc
>         -> rc = call_int_hook(backing_file_alloc, ...)
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
> Currently, only SELinux has the lsm backing_file_alloc hook, and it always
> return 0. When security_backing_file_free is called for the first time,
> the blobs pointer is set to NULL. Therefore, double free will not occur in
> the code.
> 
> Fixes: 6af36aeb147a ("lsm: add backing_file LSM hooks")
> Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>
> ---
>  security/security.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Merged into lsm/dev-staging, will be moved to lsm/dev after the merge
window.

--
paul-moore.com
