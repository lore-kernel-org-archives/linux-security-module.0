Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5682D8DCA
	for <linux-security-module@vger.kernel.org>; Fri, 23 Jan 2026 22:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769207345; cv=none; b=bnd7NROBwMnoUmN94Xx7MsEj9/nH4wDJEJI74xZcfLzIsKNDfcY/G+bdW7CNOpDsy3Nxj1D5CzSoUEqm5pUQnNARaGGrJEelKRN1cmCycJxZuK3oEKS4mfd48MGsR/FHlZTWC3Hmf7tD5CKD9giWCZjLGZ3LyW/vDaLCQw3Awnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769207345; c=relaxed/simple;
	bh=cDSiJZRzaVJA7MZmaJ6nzQSRVUGHB5aneJydXOsi/ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n9DIN6OSDRBGPknJVFwFkcwfwobNk+/krVTTprqPR8hyDaNBsK5goQYeESrLrXywb/PFe7aWggHmhKVj6fzGB5RZs7SvTxn9w1Cqgbed+q08zpiTf9o+TSwdzeJu5H1BWTfI7HZ2sGZQkNA6pfBDw4GwJuwQwsXUOjHBKFBDfzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0o/Lv/Z; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0o/Lv/Z"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47edd6111b4so31355275e9.1
        for <linux-security-module@vger.kernel.org>; Fri, 23 Jan 2026 14:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769207342; x=1769812142; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jRM+V48M4huC/vC4vqp5EdO2tv3b6ildC0GB7Yynz9M=;
        b=l0o/Lv/Zz/uw4uQPrSDnEEqw+LcK6qWfoYPagE6/MAsPunHk1xDQuKXsLuHTb34ILO
         XJIoOVvZ3NPJSE48Se6dKI4ByGdYEArdb0eCgFOzz2zIHdvAGSKqo44uwgsyin3Ervoh
         pY6GJDhXRLL1rSEwRU4wjCqM3AonRmWPfgY63vPoCEuzp+FelJpyZNVZQBzv507/WChL
         37GuyJ8SlqwCHRerTwA3g59Wd0W1uBS8eGPHdEVWqGBiBj/t8Pk9RPvuqUf2rqiAnnVg
         EVJtwjtPZ5mW7/S+D6EGxdIiHfplWgFCA5G0Hlx5iHB7wYeFZDIkrGoNnM4f/qx8cuSl
         oMwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769207342; x=1769812142;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jRM+V48M4huC/vC4vqp5EdO2tv3b6ildC0GB7Yynz9M=;
        b=ECY8+gguTb+Tq19xfouSHcWEwhHOgFu/EaFlDHEJvmxh7pZz3zOg5SkqxwdTiRcvN3
         dzJTbMFQhWOS7odpFWQsHJJ76kLQ0XgABc9D5PuFsw4oFaX02squi5mVD4y+stb9sK9w
         hIka99yNiuKcD+RUTEDQNt0skmdhSjBmRH+gkCx39ARdUjr27O2UatXb1Y16nLELPYO8
         yklvYZjsXvFCbQdC1gBAgb/F1saGkwX6hbSslFQcgATBPy0cNPGzW1h/kW3B+1+MHJ5c
         1Hp9YQChnbkpjLhD/rTNqjvPR1OV1RMXEG8jtpmaLqPFXLzuargJoRJgrz2K0XpByI0o
         46UQ==
X-Forwarded-Encrypted: i=1; AJvYcCWe4dzU806eLL7MD169BrzkiXmVO+FuMUaV9ocIrD8krZ5iCcXbtmd9Dtr8ellKj4ksUEcWw77Eu6lIvTyTz550r7uOEDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDaqTsgNgmrg6yLLWVzattHYwdzZpWANJ92xfZALsRN7jgPp0B
	vPM5mYRc5P6tC2/zvzyBFPJWH0MJWp94eSXX6HefcWE+MYD+jHyFHQ3a
X-Gm-Gg: AZuq6aJUUdyN79VokF7e7yyYIAFwdTpfo+v9uRnmFBPxlUfu9DylA7j0hBtDde33NxK
	TtFzX6PtuuDdSfOGGfyYkjdguLYkLAjupZ/xrfm6d0EDx9EBeSM9N4O2r0WGdIyXNcXM0TVWbto
	/uIQjE3pQi3FYpH5tdqPtozf+csoHYTPdhj6Rq5gwNuh1Mszf4D+eIWGL/V7KRlJFdgf1cy1YAQ
	7zRja8I/IqGpEmTd8SCLsaF3u5Flib2fhPBLT52mognEorYUM3HOtzr4mb5kI5bddzMmEVkoXdO
	G8TZba5AvfwLaTMtuu4a4pYivHMwZ0h7JMF7ihv+RvA5vwXzoLXGnu2Sc7LNYG2l+J6UP+d4dcf
	8Ge4wRBp0a2zs1Ym/JNfGkl+tbIejSEZxZR8j39VMYJDhViVPveeezszrAaAf4Wx/y5kJ/tKo4n
	xlDfs2lo+XEXj0JouAcoHY9Qgn32beNyRx1sYV
X-Received: by 2002:a05:600c:474a:b0:480:4c45:aff5 with SMTP id 5b1f17b1804b1-4804c9db7bbmr69621005e9.34.1769207341661;
        Fri, 23 Jan 2026 14:29:01 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804703b59esm173211345e9.4.2026.01.23.14.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 14:29:01 -0800 (PST)
Date: Fri, 23 Jan 2026 23:29:00 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH] landlock: fix struct layer_access_masks kernel-doc
Message-ID: <20260123.0fc66f6d76a2@gnoack.org>
References: <20260123025121.3713403-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260123025121.3713403-1-rdunlap@infradead.org>

On Thu, Jan 22, 2026 at 06:51:19PM -0800, Randy Dunlap wrote:
> Use the correct struct name and describe the struct member in
> kernel-doc notation to prevent kernel-doc warnings.
> 
> WARNING: ../security/landlock/ruleset.h:313 expecting prototype for
>   struct layer_accesses. Prototype was for struct layer_access_masks instead
> 
> Fixes: 1ebf8e8d3245 ("landlock: Transpose the layer masks data structure")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Something like this is needed. Feel free to massage/correct it some.

The code that ended up in linux-next is an ongoing patch set and was
not the final version yet, so I'll take the liberty to include a
rewritten and fixed documentation in that place in the next patch set
version (I'll CC you).
https://lore.kernel.org/all/20251230103917.10549-3-gnoack3000@gmail.com/

Thank you for spotting this so quickly! We had actually overlooked it
in the code review so far.

–Günther
