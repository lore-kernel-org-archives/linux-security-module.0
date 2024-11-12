Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED241885A4
	for <linux-security-module@vger.kernel.org>; Tue, 12 Nov 2024 14:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731420030; cv=none; b=GMJCJ5u/3lVxZAV6FtMZ0GTU0QumA08h3Amyck5Ryd8UJBNlPvuEKpMTVZYUBRSm64SwDRv0zv+an+vDE0HJJoS32TpKpmWjnYblWs2BTcbi9WThhDZFux/bp2DLKqrnnIhnT4qx/3Wxitf/qnhUx3wDdcy0lYK4RSEIVM/keFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731420030; c=relaxed/simple;
	bh=TRnR0puv3DVvdMkmJ8jXgDJd8hbXTb7LJCiudOLugI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MxmQjE0oy5WShnPrYPDuaFlvNJdnPFKujbH5Hkn04btjPHC/vocxVSchmbjTY/AaQ0O877Bvucd9OK+U7g31+St/cV9T7FcwdxS0wEL/V8tcVsALWormFrsld0EVOiGkDMLI+tzW3jGXd8WtNCnW0UjEIe6VrPdTGB+urC3Yt1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XQeLXCXk; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XQeLXCXk"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9e8522445dso1006629566b.1
        for <linux-security-module@vger.kernel.org>; Tue, 12 Nov 2024 06:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731420027; x=1732024827; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JotyiF7JA1aOKIxM8oyPGm4XUpGQdD7Isb1ZkZqsUuw=;
        b=XQeLXCXksUkzajjXbDYEGT2ycAsgDtiBV/8QLIMg1k/s4+UF9BCa9jWyH2ZDzx/i4u
         lTKAitmlazOOh7NBqKwLfkJ7CukU57dfQH0Q12x4opSBVdrTIulvcilW4dnb0Q1tNiMg
         m3b9XnQKDukpea+aJ0wqDpbjEC7/CuXGj/5IHdotwichMhAVdV/evirozu7XZAfcR+bN
         V6dtXck8hLJLbTxbL1tcNg5VsARFJ+j6/0NKmOlmBJD4TaiGg408kbwaBTlxcVX33u8p
         MZgJezxTUDutvAe7ZjdZoHdOtroa2wCJPTnbC3MFF+RuB6yDiPS6lQbXuZFMq1jUGPhj
         mGAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731420027; x=1732024827;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JotyiF7JA1aOKIxM8oyPGm4XUpGQdD7Isb1ZkZqsUuw=;
        b=YxaGj5dcrOIlGFgOecwb+7N2UOTrvwgd3Gg1SuujSFVtJPLSSgVP5MKDj+RYdZER0h
         BnR7f4b6S5uAB/gxxxOuZiC7YxVzmdeBRJE+RgyCEKBkxqIP7EoVEF8EWKIsFtVY/qEs
         Zj+2gEG9b5Rptg7Gw/VYSXDGUlEzFf86M5GskCyKtUAkQIyOxGk07G2EiGPjQQc17uVD
         3ZtS4IZ4zUDp3FSs600hgPKoinHOukAb+hSf81ibHrreNvWLrOhlcHmFOl1jijkf2+dq
         9WzK1Je3VzezXp4NYfJVby3kIbSHeDEdmD5hNrZEYjtaoZGZlzBc+eGqEQVZKhjqh5XL
         NIyg==
X-Forwarded-Encrypted: i=1; AJvYcCVHFNkB4+e0m7TDTGvWOnEEyHQ8vxNE0jBZi/XAXjKi4h55MhLrkQoeT/GFmLBs2Fu8BTO5bdPxI+FTWRqidxDI0IAu+LE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLEqVNuDVK8oj48f7ZS04lLBucGGeHFFQiZsTx5eWv5/eREwWZ
	4FV74QGoh4aE4l/p7//BAJ2zxlh5DgN5Svw4XC0a+mtZT9JN1rX/bqBFeVxDJ4c=
X-Google-Smtp-Source: AGHT+IEuCfFqsVepbJbSlEu8+mWrlXZd1MVpoMO+tLhQgthVKd5GpvRRJnE/ndDrxDsOu4+BUtcj0w==
X-Received: by 2002:a17:907:9344:b0:a9a:714:4393 with SMTP id a640c23a62f3a-a9eefeecafcmr1660632466b.23.1731420027014;
        Tue, 12 Nov 2024 06:00:27 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9f08c9ae30sm416505066b.55.2024.11.12.06.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 06:00:25 -0800 (PST)
Date: Tue, 12 Nov 2024 17:00:22 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Colin Ian King <colin.i.king@gmail.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	linux-security-module@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] security: remove redundant assignment to variable
 rc
Message-ID: <433bb625-480f-46f2-986a-604fda49c046@stanley.mountain>
References: <20241112124532.468198-1-colin.i.king@gmail.com>
 <20241112133224.GA340871@mail.hallyn.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112133224.GA340871@mail.hallyn.com>

On Tue, Nov 12, 2024 at 07:32:24AM -0600, Serge E. Hallyn wrote:
> On Tue, Nov 12, 2024 at 12:45:32PM +0000, Colin Ian King wrote:
> > In the case where rc is equal to EOPNOTSUPP it is being reassigned a
> > new value of zero that is never read. The following continue statement
> > loops back to the next iteration of the lsm_for_each_hook loop and
> > rc is being re-assigned a new value from the call to getselfattr.
> > The assignment is redundant and can be removed.
> > 
> > Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> 
> Reviewed-by: Serge Hallyn <serge@hallyn.com>
> 
> (long as it doesn't go to stable :)
> 

There is a tag for fixes which would break stable.

Cc: <stable+noautosel@kernel.org> # reason goes here, and must be present

But this isn't a fix and it wouldn't break stable so probably that's not
appropriate.

regards,
dan carpenter

