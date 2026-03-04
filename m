Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF1837F8D3
	for <linux-security-module@vger.kernel.org>; Wed,  4 Mar 2026 07:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772610305; cv=none; b=n7az6i3qNOTrJPyPX0aeQh8mreude/XPjzLppJQrVdsesO9nI2uE3f4xEMVyqnOPRiOGNhl4aBJBE4mItm7BKU0yxtILp+BXFnEJz3O1iuUh9GGKclJAsPDNOmP+e1GIQwqdFPz0Da0B26yFbNUF+2G9xWJBnbNtcbOn683MM/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772610305; c=relaxed/simple;
	bh=Bl7YSDtmmKcJFmJ3E29bRrcaVds7w3c5c0tPYWcUazU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N1xY7EA+8VYtzB9U6W73ALhn78UqX1qqTFfirQ3paRwi4zltXcoETR/C9u1TvCwX07jw7CzD5yJq5ExLBUrFdsNx4LjVgUGHxNHh3ZQOkfPx6ZAlXVKl88oQaBqfVHMWyGHTdF1ySSQEFv/vOb2BVCfHhf236s8GXyRIyT3F5RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hwfDiiTs; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hwfDiiTs"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-439b790af67so1756298f8f.0
        for <linux-security-module@vger.kernel.org>; Tue, 03 Mar 2026 23:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772610302; x=1773215102; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y6R4KpRzY0pdh8BZXIGvyv7ewrhWYqro8EcQRduV4G0=;
        b=hwfDiiTsQLm5HzfXfnC5F0WpM7NDxTzhA6fNLc1iWFOFuqAUwZ42GKmoNJuDNBuVXw
         ZyxyOUTSXAUznnGZiogm71ACNvD+UznnIpRoyO9TTmIDLlED3wsyfoVL92dxRCxtgPpo
         Wo0BEIuAoqfpFS+wgcrQc3OPX/bimciTb+TpRxUOGFF6GzdO51pMUpMOsw0eQg10wDje
         LwPGDhKEsRrQ6kQ73Z/e4nQx06VB6c/Xqqj1tFuIHtes2kce9EgMtVFWitYqWFkPUsnB
         KJ+Ge3ZUoKWSunuI/eTkfo+Q/Z4BvAOvrGVc+d5qEyDnUEHupeu4ZGHVd+FUwKNLUsm9
         0BUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772610302; x=1773215102;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y6R4KpRzY0pdh8BZXIGvyv7ewrhWYqro8EcQRduV4G0=;
        b=rB6zwFM7q9hDRD25h57lYmGS7gKAHuCP1+X1oVfeaobi+TBBY6Yi2a9nYxt7PO9tAx
         5KgmR8FI74G3t6ipeg4HDRauxVO92QLzyo3Br/O8OugvRfIdaWCWXz1FcO4OLhJ8Wrgu
         sQsgT3o2mme6gcrfgIv4cAeOI3laIas4CGBAqj0AnYuBBo2WJ3NNZrIxBrWZTO9xM5vf
         u9gXvsO6LJVDqsdRflIByJ5wz1mqS9io4JFrBILhZK7Nz43kJg4wDsIh2V3Gyds+WgD6
         snS/Hnfg+h5SaK0CShajqOYD5BeS00NP0txcdp5Ns+fq6sFalSVUXitpboPUxfWbhx1B
         mq2g==
X-Forwarded-Encrypted: i=1; AJvYcCWzzlRx0cv6hSdwvaq0RFfZ8NyKpkFW31HjGl4wHGPfcKzcpS4MKwWf4tioCOgOIe/c0cVIc7AL26CCrt68UHQnZ5sGQ/s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx80rx5HpgF259tih7+rYUsZInDiy37NTPqZYFamB6R4AA6OPfJ
	ikcl6km2xb6GLxTMqWavzpU96tE3jV9yY1rGOe3aW65Yq2SaCdLa4JVh
X-Gm-Gg: ATEYQzwWJqqJDkFdnAwG3JaJlBM0VEMNBFSz109Tdm705hs6SstCcHZ5vymZPaHY3p8
	kDkK1hUffzNvD2tYRKtDqg9OsE9BBPEFq3ilipbSJocfsfFQjjYYADGVNk7QW3rGSoJ93IDs2Uy
	tDb2Y8PlRBWY9ogXAW2il2a3gGfEbtG1NZKUjJcEU6nfn0tG62TD66tr60LlX8kNejyVRuqAWMx
	RUT5D5vfHlS4+4JXFwxGSx8MueUSMWN080ZB5CeHog4FaSMFgJiTEdMkMJPWGNhzju9yuIlRjRE
	I6VG4Gjvbvlz0RtrV8gCp9qR1Csb2gatchTZwA98e/Ibw3u5j5FzVuV0bAEsfBQQeRhTneBDuWL
	hlPxIAVJZC6CyiCAj8FyRU9kbAhknoA6fLyv4nIK1Y9L+hOGtayJioudaqIk0CS9alB/PLRezj9
	sfPewktOtyfVwihxx5g+uVKS6antiuyznqTq57o07ygIVCZTS0
X-Received: by 2002:a05:6000:200d:b0:439:8c72:1d8f with SMTP id ffacd0b85a97d-439c8a3d018mr1602542f8f.2.1772610302355;
        Tue, 03 Mar 2026 23:45:02 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439c2f8c0e7sm8157690f8f.29.2026.03.03.23.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 23:45:01 -0800 (PST)
Date: Wed, 4 Mar 2026 08:44:57 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Ding Yihan <dingyihan@uniontech.com>
Cc: Tingmao Wang <m@maowtm.org>, Justin Suess <utilityemal77@gmail.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Paul Moore <paul@paul-moore.com>, Jann Horn <jannh@google.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+7ea2f5e9dfd468201817@syzkaller.appspotmail.com
Subject: Re: [PATCH v3 1/2] landlock: Serialize TSYNC thread restriction
Message-ID: <20260304.c0c2ccadbde6@gnoack.org>
References: <20260226015903.3158620-1-dingyihan@uniontech.com>
 <20260226015903.3158620-2-dingyihan@uniontech.com>
 <aacKOr1wywSSOAVv@suesslenovo>
 <20260303.2e4c89f9fdfe@gnoack.org>
 <c482a8bb-d8c5-4008-9c8d-704d6a880022@maowtm.org>
 <20260303.94e335a9bdaa@gnoack.org>
 <D31C8311F753F56D+d07bcc15-ede7-4a04-829d-d80f69abda83@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D31C8311F753F56D+d07bcc15-ede7-4a04-829d-d80f69abda83@uniontech.com>

On Wed, Mar 04, 2026 at 10:46:39AM +0800, Ding Yihan wrote:
> Hi all,
> ﻿
> Thank you Justin for catching the test failure and the thorough
> investigation! And thanks Günther and Tingmao for diving into the
> syscall restart mechanics.
> ﻿
> I've evaluated both the `while` loop approach with `task_work_run()`
> and the `restart_syscall()` approach. I strongly lean towards using
> `restart_syscall()` as suggested by Tingmao. 
> ﻿
> As Günther pointed out earlier, executing `task_work_run()` directly
> deep inside the syscall context can be risky. Task works often assume
> they are running at the kernel-user boundary with a specific state.
> Using `restart_syscall()` safely bounces us to that boundary, processes
> the works cleanly, and restarts the syscall via standard mechanisms.

Agreed.  I also like the restart_syscall() solution for its simplicity
and use of a standard mechanism.

(This code path is very unlikely (and probably unintended by the
userspace programmer), so we need to protect against deadlock, but
it's not a performance critical path by far.  By using the more
standard restart_syscall(), we have to worry about fewer corner cases
(e.g. what assumptions are made by task_works about the context they
get executed in).  I think this robustness trumps performance tuning
in this case.)


> After some selftests,I will prepare the v4 patch series using `restart_syscall()`.
> I will also ensure all comments are properly wrapped to 80 columns as requested
> by Mickaël, and make sure to include the proper Reported-by and
> Suggested-by tags for everyone's excellent input here.
> ﻿
> Expect the v4 series shortly. Thanks again for the great collaboration!

Thanks, I'm looking forward to the revised patch. I agree with this plan. :)

–Günther
