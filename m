Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E2625DB12
	for <linux-security-module@vger.kernel.org>; Mon,  2 Mar 2026 22:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772489287; cv=none; b=LkEzNXrVfPAwsD5xTGvMKpoIJ068LYgvAFqONsvmHsnKvn9piE7xt3r5fEGHAv8OZ/taRlW2jh0yCDuyk16VErAUUDEAT/hzdHA0kZTzxLmISjQnqjh68FWPezXEbqwSYJuCyEz7wYUn0bLmdiBsed0NZrIcVxj5nE49mpJgKRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772489287; c=relaxed/simple;
	bh=z/rzJMtLGYiIALrhUHUuSMwe3YYACkYuyancAx+6GE8=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=g2BDpovqjGpF8hnCoiRKnfMK4yyXrLOB0K4Gtb4taRWePBPehqd0lwtMlW2vvSBgn5tOVbapkOOT3SZRbMG3BSzZAyJpedU/w5DaPl+eVFJJgyhjaoKegTTwKROZOvCA2qqM3RrYD26O0b8GEyp9CGiOyP0HJSkaM/FvauyNWgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=X1TfWAE7; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="X1TfWAE7"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8cbad8e6610so548211185a.0
        for <linux-security-module@vger.kernel.org>; Mon, 02 Mar 2026 14:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1772489285; x=1773094085; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bgeJCkYZ7uwILUeA+oiWIAr+ytL103rllkD82SG1eeA=;
        b=X1TfWAE7mhvtEdVV+0UnUFak7ukpMufYJzvW5Ex0sOJtoRxzso5+KsJyolwMM73hPm
         Ihk5pAReaff6q1A2QoYegYfIpjOkmzbKhblAaezOGpHLg+858cG5rMLuE6doueYNX5dt
         RDl3d/cJ8To9rkxiS2GhHBdZQu87DoCpVfy7Yqpte7/AccR1Dn/1FBMu0iLL/cm7YvHv
         T1vL/Nlk4xbY9xSJKZIU54rLiHjPi9Y79s9TQhVT5XIvE/abAzBeaeAGlRocIf8N8ysK
         6tA4mhSw/ndrMM7YTIHNAFlleG/bxFisNKBY2YCpx1QhcIHcgFVhrqA2ng3eXsZ8yNnW
         TWZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772489285; x=1773094085;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bgeJCkYZ7uwILUeA+oiWIAr+ytL103rllkD82SG1eeA=;
        b=rK7YkTbANbn+sZOPWPSt9o3pok/DPGiZ7YHvNCIaBY4qe9YLjalfrZGFKUvQxSDq95
         4wmEKrq57Kre7eqY7yRY0RuKyl4ausCshnF14R7iu6T6o+XtMUFDRBK9yFUccSbDfRN7
         NyzxwME4pvE3O+rAoc8o1GlIfzSQBTeNYHXrTx/Oc7DvNhnnQ/NRbY0WWlGsAAoWmH85
         VxmaoBoXGSMErAhmp05XApzdfmPxyzk5wakoAwHAB5ftldDQGPrfM3H5mUWTI1klYfX8
         Il+qvqv69o8UAaAb4tgLaE+2VzOqqVofGHf7GQJLukdeHc1dE3YgPqXrLNZNA1LI6K3t
         sUuQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1pvsb2wQBgKlYmCgrfRkWsUUEmyszXcWuPIEmlDT6CEZZ4hG91Fzocz/6PnSoeQ1K4tGgCbqOnxZPCqKP6LsIOHxnJWo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/KWSxOBK182WM/fXpHGqwAkV4Hq9ocQzfuW2EURKK2SmOWdo9
	jYO0CCoBWcYdahhigbDo8lKIbgqqtzjspJf8c6ulXZHk3SyYquJz+xf+igJvpYcJ3w==
X-Gm-Gg: ATEYQzxfLln0jUWfgDA7TSkiGbFW36ZR8RUtD9HwdUGjKmE2IVnvNhLEDvktiE/YGTD
	vL5VRqZOq/NqPYyWXt5FJMEJD+CtRRSH8OcEJRbl4QdUbLcBbKGfQBVzmviJxo00gyonZlLrkhR
	RsoqZPjm34Q57+vdpaeOyRZxZI4L7jANXtMoRFFj9+Ldz4uNpUaJc+7CalTqU03llDy3U9H+yZQ
	WnCSk9YDf0mINMwCFF4qXemxgkv3VqxnaAG9fNaUBlzKGAvDNdMBf8MjQlD4nFDMUliwfF/I7zk
	KD7fpPCkoegV7pixLQmVldMi6XI6AynnGXnOZ4fMKINhLGvHxYQUKpSY7+/wCa2T9caqML7TzHA
	E32a3AMpRpIiZtecjjTONZh9Z9Njj/e76AgykDU5miYROdAQ2t8XYbN4lfsJWX+u1ljQd+KnjS2
	jIRGFWj92tffS9uPwXZT4i2Ul20fdj841nNqN+4oZ6Jmb2uV/0Wn5GDUZofFhdud/l6nSJ
X-Received: by 2002:a05:620a:170b:b0:89e:b0bd:ced9 with SMTP id af79cd13be357-8cbc8ef7a8fmr1888817485a.43.1772489285291;
        Mon, 02 Mar 2026 14:08:05 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899f850b8b3sm36608516d6.23.2026.03.02.14.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 14:08:03 -0800 (PST)
Date: Mon, 02 Mar 2026 17:08:02 -0500
Message-ID: <0b3c6d530122d72a1047db17d016cf05@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260302_1612/pstg-lib:20260302_1053/pstg-pwork:20260302_1612
From: Paul Moore <paul@paul-moore.com>
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Serge Hallyn <sergeh@kernel.org>, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] cred: cred.h: fix kernel-doc warnings
References: <20260302005154.3468238-1-rdunlap@infradead.org>
In-Reply-To: <20260302005154.3468238-1-rdunlap@infradead.org>

On Mar  1, 2026 Randy Dunlap <rdunlap@infradead.org> wrote:
> 
> Use the correct function parameter names, function names, or kernel-doc
> format, and add function return comment sections to avoid kernel-doc
> warnings:
> 
> Warning: include/linux/cred.h:43 function parameter 'gi' not described
>  in 'get_group_info'
> Warning: include/linux/cred.h:43 No description found for return value
>  of 'get_group_info'
> Warning: include/linux/cred.h:213 No description found for return value
>  of 'get_cred_many'
> Warning: include/linux/cred.h:260 function parameter '_cred' not described
>  in 'put_cred_many'
> Warning: include/linux/cred.h:260 expecting prototype for put_cred().
>  Prototype was for put_cred_many() instead
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Serge Hallyn <sergeh@kernel.org>
> Cc: linux-security-module@vger.kernel.org
> 
>  include/linux/cred.h |   10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

Merged into lsm/dev, thanks.

--
paul-moore.com
