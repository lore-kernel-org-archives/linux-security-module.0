Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com [209.85.222.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20451315D33
	for <linux-security-module@vger.kernel.org>; Wed, 27 May 2026 23:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779925357; cv=none; b=T4kkP6RWFrgVA6B9UoAbPmpxDwp4fFOwtCm/LZ7BmdrZJciMs3m2xrn2UI4cKo0fq65qcrwJS6Te1FmTwWsFgPaxb3Q28E3SaQHXPgfCQfeCZynbI4kXoig1QHu1oNQfhM5/ATutzWC65cDdZ1VXy1NySey2RamWCScoBoVRkd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779925357; c=relaxed/simple;
	bh=bFhoZtKMfAkJEwxLgJ6/oZuzCLxHsvUxFVvVuDQhd20=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=c99A8/QHal6AYLMzo3kgUNeowPxdRuywpV5e/INh/Nx8MBX2JY4ziG2uZnRftKMrpxlFGoMyrbTeNAko6UoCqjHCl5kF5aNSIn4vFS7IhKy42kNu+G7TX48HG/hrJ618lo3lIHUTgK6M1mmROJVy/HHUJuFc2/2QYIA61FiL2qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MDbxYhSU; arc=none smtp.client-ip=209.85.222.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MDbxYhSU"
Received: by mail-qk1-f194.google.com with SMTP id af79cd13be357-914ae4101b4so814133585a.2
        for <linux-security-module@vger.kernel.org>; Wed, 27 May 2026 16:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1779925355; x=1780530155; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vWtSF+ZdJPKnDl6l0dlAcmnN+0WDS6LYwhPmb91DFEM=;
        b=MDbxYhSU8a1NXFKJ4BLckTioTxA6dz/9OKssB30bXmIC2aX9PwG3sb6SyK5dQhT378
         eYEB4iLolxeC/kIUfeQxaujeoq4VG30rDG2P/wo8uAdSYLUIZSLoDM5y0TSoY5kJmNJx
         oHsdLuJ6DLJbjnq0DhSuvJgkgjhf5R0bYUXsmpq9Qd7K2Yy7LrjjTKeFpVW5AkstFf/F
         rbfkEzac9Ci0TFwoxMSQNKaXTrO/Fmekpng+MeiWgmgMzXqgTBYUxNEaocn8shyzyfWI
         3+lb0W2OqCyTfZK9gT7QNFaGHXB2ZpFOP9lGyGUcwoBV7VEpf4vto10jc1qN7MYeK9tU
         CLNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779925355; x=1780530155;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vWtSF+ZdJPKnDl6l0dlAcmnN+0WDS6LYwhPmb91DFEM=;
        b=jeC2erPyC0Zri3+cqyDblzNIK2b1AayGFltwDB7d08ZrytS30lsJuwjeAEb7AlyT3O
         egDET0At00uMip5DthJ4yVyOimbNRgha0AaN3fVZfr8m7ufFxtxtDtXM1wDlIStgEJ5V
         2FAxZpwZTnVbi4d6TTpspleuedJS3QL578+bJj3gt8Ae2sJkUCaYj56V9g6bFXkcIHPM
         /vcZprka+LC6xB1u5Opyte9Dqk4qMn6giwVmOUUWZWHUt85SyHx/OkyhYqgET/ZBpBYt
         KJ4+qth0vDAX9fnSUP5gdXuOBz1hOTz9GjfDdZ6zQcNoV2EIYjkKNULmorStDarishQ4
         zquQ==
X-Forwarded-Encrypted: i=1; AFNElJ8GU++9rJY3a0ULcl2oD21WZUpe/pptcN1p2ePcISXyorzw8T78udUsXJjuws0pqYlGv8LnmMpiYg1nLmwvfYiis1gtzHE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5amDicNAD0rof639c+fVmfqphAPkEMkmANvlO9ZTg7VsfT8eJ
	fXpGe2h4eW7bo9mWK74aKAjuzwParA9xJy3aTuiSQe6VszHd8yvVUsDmdBI2inJB+A==
X-Gm-Gg: Acq92OFOYIntVRl7KjdboaXkX0silm2A41Ri1B60y+CL0U8qymTmFYK72JA5Q4FTzmr
	bkzt2N05ajD595Ew4BQGh7lZ0xnSWlvuQLFfPflV2JpHifoKRcmOpBrM+OEISPqtIEIakpO6hBq
	xSGwP2UfWi3c8oILrDWb4yC1Zp1cp/yYJkK9ykfkTaQpq53xiLxyoPQNDJQifZWyWsUSFE/bA5x
	2uT4VD58ASFPk2CnoXCL4EJj64mN2QUF2NPlS6QjuqWOuRTAvjzR9EA8mibk8G/T60Z2RaMrv3k
	Uj1YZoVG3HuhJoAGLlH61W//HWhz0THyk3Ody6S6xbuN6zAcY9p2XnZoLWl4h9qUtijHuYW+bJI
	wAqI/PzGBcrin1C0paCJsPYPY2VyDYBPPIRMzLVwnFL9Hs2OPAAbVXG5ZH//tdE0vm0LLb6lU9y
	flk6lOtaPfu9PJ3UVWlv5HMQGr062qjvKvuY777usmwR8JSv/JY6s+HfOZg6SFjGOb1Oq+mDIz0
	IXcGB2qNHsJsETSzw==
X-Received: by 2002:a05:620a:290b:b0:910:87f4:9a26 with SMTP id af79cd13be357-914b49937b6mr3695400885a.41.1779925354972;
        Wed, 27 May 2026 16:42:34 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914f8706968sm615403785a.17.2026.05.27.16.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 16:42:34 -0700 (PDT)
Date: Wed, 27 May 2026 19:42:33 -0400
Message-ID: <c8fb6387f3c1efa126013090f45528c6@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260527_1931/pstg-lib:20260527_1608/pstg-pwork:20260527_1931
From: Paul Moore <paul@paul-moore.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>, James Morris <jmorris@namei.org>, John Johansen <john.johansen@canonical.com>, Ondrej Mosnacek <omosnace@redhat.com>, "Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Mike Rapoport <rppt@kernel.org>, apparmor@lists.ubuntu.com, selinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH 1/3] selinux: use k[mz]alloc() to allocate temporary  buffers
References: <20260520-security-v1-1-831bd8e21dd0@kernel.org>
In-Reply-To: <20260520-security-v1-1-831bd8e21dd0@kernel.org>

On May 20, 2026 "Mike Rapoport (Microsoft)" <rppt@kernel.org> wrote:
> 
> Several functions in selinuxfs.c allocate temporary buffers using
> __get_free_page() or get_zeroed_page().
> 
> These buffers are used either to store a string generated by snprintf() (in
> sel_make_bools()) or to copy data from user (sel_read_avc_hash_stats() and
> sel_read_sidtab_hash_stats()).
> 
> Such usage does not require struct page access and it is better to allocate
> these buffers with kzalloc()/kmalloc() that provide better scalability and
> more debugging possibilities.
> 
> Replace use of get_zeroed_page() with kzalloc() and usage of
> __get_free_page() with kmalloc().
> 
> Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  security/selinux/selinuxfs.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

I suspect if we look closer we can probably also trim some of those
allocations to less then a page, but that can be work for another day.

Merged into selinux/dev, thanks Mike.

--
paul-moore.com
