Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BB7360EE2
	for <linux-security-module@vger.kernel.org>; Fri, 28 Aug 2026 15:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787931656; cv=none; b=tEKG8t79TRLq+lL5Z88zfpPpNpO4LxqpRdA3mmv3keYohpt1f3gIOHrTr7OPkHkoWnDfBmydcXq5pnKqS/S2xu5R5PdFA3j1kK2eam3Vc9I+EvrwEgTE3fhAL1m0gkrszBvsiWiIbn3i12LAFYlY69TWiBKQZB6wfOietbBv0uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787931656; c=relaxed/simple;
	bh=3HjPR/NAweusIT/iyDUl7mmqaY74VFpMV2oma3CqhE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IZ8IvAWaquqFWCUZ+fbIkr9KrqoQbaKAfLebEg1vfDMREj3K5qfUUR8CsDoH81V9lor+XiXqiqKarDrZ1IYsq15epm6mYFcvNsMuTo9MWk0BnyftxAkyAnQsynkN6FKTShNOdhVBbhtrJYXd9FijaayQ6AAs2LAtQIRTRE778Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fcIBLnJs; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fcIBLnJs"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-499ae1c6471so8499605e9.3
        for <linux-security-module@vger.kernel.org>; Fri, 28 Aug 2026 08:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787931653; x=1788536453; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=or9it1bSqSerwJlL8gapxH1sr/v4GRq+wa+KaIeYZsI=;
        b=fcIBLnJso427HAahcQQgY2LNtmygrdSuYnJDLxSErF/EAIKpGQvl0A2GRrkKH5YwZj
         kI+k3ThEx3p1PWc9PC3N0RFz2WutJUr6A+QFil4LplnV6b/Sxu2iJI6hbqrMBmW2kLc5
         RFq2SZGncHYM+eQNzlq2iGtQMxaqtBpJRvDAf/BaiTea+4uCgRHiEUC8zeG3Ti4OPM8J
         Uvdvkhlu9ytJsS1qEVr4meOi/2nq6SGWxvJ66pjrpuf/++hTCiAk34fOcTL4PRo3/nHe
         brFljgOredUDXGY/V5EQ4a0hQPQ9GjlzSSu80iFYvDPGY8HJykjFyN+CJsv4RpRkMTDY
         JOaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787931653; x=1788536453;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=or9it1bSqSerwJlL8gapxH1sr/v4GRq+wa+KaIeYZsI=;
        b=dM/BR+Lhjp0LUeDSxW//8+VdKoYasC7AHdWI8m6TmnxdTy1Hld/HnyT4/98y5SlBvb
         E1kT+6IiIuE9ctkSFscif1MQ/jYeB3LUmj48a3eAfH1vjBTMcr71sclO3BwONAScvvBN
         bQMktgSELMuzOQDjxFdxsGqdRPXGV5InCe87fv95bUjthgVw/hw7Xx6g84QnqHZ89h2S
         e3fjLd8/GBVsxfdhG2pQFswQ/Dz9DL4vZhBjeARbgWlrisqb8DwgwktDj46Rmbx8v7Ay
         ll5tray9QRNHF7VMRR7SIk1ORHGqD/f/lu9qwJFjoOAPiW9pGHFZ5zpifl/3FSFcQ+Py
         qT4g==
X-Forwarded-Encrypted: i=1; AHgh+Rrd6vlkh+nGj9T9+2kf5M7mPZ0lrfNlZxmlj+QqMQnFQww8tBp3tEt62DAKrL1Y9wyb2Ws3T7b8OUQiayhFG58nblN5smI=@vger.kernel.org
X-Gm-Message-State: AFuF++krirHIVw1xLStJAPqz7cby2YoGV7zrA5z5aElT5hLHQ8zaKRgc
	l1hHXnT2JUcZg4RPgoFKiVyRa0eoTuyqLXlDYbD8cZKpz1lotUWEnplcHoHw4bh4
X-Gm-Gg: AR+sD10dChLh1UhaC5+D2LKlAAkWHokHKej61xRqvQ1d7vX+GmMEOvzXCx5gEerFQOw
	zAhC6zKIsMEDJXBmAgR/2HBZcT6F3geImi7v2fpRUCYO5TiT9i/zk14Lup1YjpNFtIFtQoSkXs8
	cjP9LD+woYs5z+Uvu/abclwB9v2lcZRklPIadxofygAeHjCdZsw0YS0eBa3/mo9Ua0zpHeCuzMX
	lMpsB6i4Q8c1adj3+X/nnLpIEc9UkjrsTp4777zwlazYymEr3b6jYWyG9BFRWjKdumE7hj+J0kW
	gVNnDRU5dkpExEb4iJhC+1DtwK6+SLU2EP8pxeCReY1G8Pnh9Y8MrFEYULNVBqwMztTx/DLZxP7
	/btnKHAvpiEJGUJnrDjd8vfxakrJ71t4N/U+7abSaUgFwQe3EzBm/cO13PrYnkuW0UMHtm9Zj6z
	q0yvadRqDoRMLY5szgKuokL0MvshvtIn1zge+fmSufeRFX0hvNAl+dvFUC7b9Ro3ehNEnbWhpiy
	eMBIr/exL8oV0j+De/L2ukY
X-Received: by 2002:a05:600c:524e:b0:49b:9438:7785 with SMTP id 5b1f17b1804b1-49b94387aaemr77157775e9.4.1787931652997;
        Fri, 28 Aug 2026 08:40:52 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b4c321184sm178561375e9.11.2026.08.28.08.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 08:40:52 -0700 (PDT)
Date: Fri, 28 Aug 2026 17:40:51 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Justin Suess <utilityemal77@gmail.com>
Cc: mic@digikod.net, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v4 4/5] landlock: Document
 LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS
Message-ID: <20260828.b569cf9602bc@gnoack.org>
References: <20260809154544.1253100-1-utilityemal77@gmail.com>
 <20260809154544.1253100-5-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260809154544.1253100-5-utilityemal77@gmail.com>

Hello Justin!

On Sun, Aug 09, 2026 at 11:45:22AM -0400, Justin Suess wrote:
> Document setting no_new_privs with ruleset enforcement, following the
> same compatibility section style as previous ABI additions.
> 
> Include a section explaining the tradeoffs of setting no_new_privs
> through any means for privileged users of Landlock.
> 
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> ---
> 
> Notes:
>     v3->v4:
>         - Reword the tutorial paragraph on CAP_SYS_ADMIN and no_new_privs to
>           remove the ambiguous "it"s, per Mickaël's feedback.
>         - Use the suggested "call (or ``CAP_SYS_ADMIN`` use)" wording in the
>           compatibility section.
> 
>  Documentation/userspace-api/landlock.rst | 47 +++++++++++++++++++++---
>  1 file changed, 41 insertions(+), 6 deletions(-)

Friendly reminder -- could you please also transcribe the newly added
documentation into the Landlock man pages?  I added a tracking issue
at https://github.com/landlock-lsm/linux/issues/66 where I outlined
the rough process, which is mostly mechanical.  I am happy to do a
review.

I think in this case, it probably only needs an entry in the VERSIONS
table in landlock(7) and an update to landlock_create_ruleset(2) to
document what the flag does.

Thanks,
Günther
