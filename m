Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60C13385B6
	for <linux-security-module@vger.kernel.org>; Wed, 19 Aug 2026 14:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787150407; cv=none; b=E9GzrJD0zXeSqjEhpc7UKubv2SqkGnl94aChWySyAEz5Dxcs1AHl6NW1HCv5FyoGmKGo/GShWPpNeMQxjiCY3/9T+kl99ODZfcc/96e9YRApuWuHx4mqQzmLLgZ0gWi5yKo7iGOkdR1ygOb80E4fk7vygST3xp6TTKTAbWz4pkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787150407; c=relaxed/simple;
	bh=59VIFuHIEPnIpLqOvW7ZZ27FmwMymtX6CNna+u/WLZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oFJwYs7kZ9zaCQlRV0mZu1YoQa8v3nb/q6ogQF6t3Yge759auGfDBaRY9thot9XWPHSNn3KPvxHicob7ac9bL2EJLQd8j4jqJ1e7aIBYxyg/jno4axa9PV1Pm8OEYwHD13SpAlXRmOEZgdSPWgRKyfDzxcmrpv7zF5f0jstlthk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=eVU0ztwX; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="eVU0ztwX"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6b127c88220so768575eaf.1
        for <linux-security-module@vger.kernel.org>; Wed, 19 Aug 2026 07:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1787150404; x=1787755204; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XXzcZsy7hW4pGsTmoBSQRX5B4jq8GHlbDv+EwOBktmw=;
        b=eVU0ztwXhUqyge3uxoO5QtfxpeFXxDU/8r7ErRNofCrlVCRD85wF9TfZJ5MpqDG9fs
         6nZRgVK9IWdGmKtd29+F8dAmyXmv5QwCDfzNPIbw6/6TMv65X7VbHY6UfunZwVhVC0kg
         cPFZEMmLyfXzs/xJZRx7j3NPS4mk+rEgoVTAZhl3sR5gxaW2CZZij7e5eT1jc5gzMWSa
         MN+oCvD0qecN4+ZbujH+yuDCtPfqFQ5aMRA+pXZhlr2kixejlZO8jo67/cCwQwtiA5Nq
         m43aYnRRx67IxC1qwSexinu2zr2aG+suIOxBJUjcXIckMZA/17xa5JEpM4sIIAeSTEyB
         tzqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787150404; x=1787755204;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XXzcZsy7hW4pGsTmoBSQRX5B4jq8GHlbDv+EwOBktmw=;
        b=khb1j3cBKM20YQe+iEpmUeKAY0rScw032kJ/G6qb9twIRlmF8icE8jVDvFtmpej46c
         22JCSMGI10bF9W6EkClgW3BWzXoalC2mTVzRL6Kem/F7gNwjrv2ryW2mZMyhmSHWsRQS
         woD6+WTAQfXg9fLPhCkfT/k75dkkEOSwGr56whMBbuITS/MFDTkfMIvK3JrH22ZdRktC
         /GGElQp44JQCuBkmPss1BnpCD+DppCNJGLE3K3RSWH+cHv6uPu+B+SrTfGD+rJ487KSi
         pF0qwZ9zMWaN+/0mI+uqHUepTBNyNHH7J+j/YYQp3WJGN8trTWr8lV3gPm/LThVC/mMx
         Z9fA==
X-Forwarded-Encrypted: i=1; AHgh+RoDrsuf9c3LRquO9hHFeHjxwjOzYQEP3m7LZC7CU6bsQ7bzzOM08J6D2ciotOVomRi68Npzow5XKpXXe12MTD9y06uVTXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWRtdFDUXUdEpP2CPvo1sPS6otcMzbi1BmcHhDhDDdycM6cKSd
	BgN+2AONcP3HnwTVwygZxzGWbD8iZP5XF1hfJ1X+pwmfLjJVWKsgooKMH/stxGZtStU=
X-Gm-Gg: AR+sD10DHfLnIkleKhJ5tTqSvTh4cAb6uDTnA6U6M/FLZ3POE9xSFkOdm5vRn/I4sp4
	zJoA1O2v9l0jWPZIr+JfbansmmQmmr6LolqmAhersw+CSOd1/TAs/Yi2NmLXgPmJXQztNbBOvAS
	hvXmze5uNqsgC3adnTm9QXxVm5aFZYQeZpcc6VvvXUYfjon+s2A3PQ7wV1Y3lS5XDZeaZ2jqZUO
	Wg7MknSpbQmMYsaTm9Do4ZDNj16CfYAWw0H6DZq1h9u99stDz6dag2BghTGqkFS/x4avQFBLPpQ
	rqjCX38UY9Ib0L6P8c3do6vdd+y2Ds8UAuKctqtrdy68jVyttg2XzjaRkcU3Hln3xHezIkQ0kMl
	69tA79mTWCQe7RCHo0YdIgmZK0uo+pvAOeHW4GAC9zY5VPX5hinPmx8lzvHLn9FFok0D4P9vv2k
	VjfX2LL2dPsCZ9OB+VzZQTYuqTx2kjQlmN8VR7h9jhJ9JG
X-Received: by 2002:a05:6820:1988:b0:6a1:80a7:2c8d with SMTP id 006d021491bc7-6b13c611146mr5172325eaf.32.1787150404578;
        Wed, 19 Aug 2026 07:40:04 -0700 (PDT)
Received: from CMGLRV3 ([2a09:bac6:947f:3af::5e:84])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b13c90d160sm2123919eaf.0.2026.08.19.07.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 07:40:02 -0700 (PDT)
Date: Wed, 19 Aug 2026 09:39:59 -0500
From: Frederick Lawler <fred@cloudflare.com>
To: Breno Leitao <leitao@debian.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH 1/2] configfs: move CONFIGFS_MAGIC definition to magic.h
Message-ID: <lr2ysbkhe6nk4bf4roguv3x4lau76clypwc4gkpebfx5wgm3qb@qpxxabipfzmg>
References: <20260818-configfs-v1-0-a2329043cf86@cloudflare.com>
 <20260818-configfs-v1-1-a2329043cf86@cloudflare.com>
 <aoV1hRKX1yb5vKrW@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoV1hRKX1yb5vKrW@gmail.com>

On Wed, Aug 19, 2026 at 02:21:58AM -0700, Breno Leitao wrote:
> On Tue, Aug 18, 2026 at 02:35:15PM -0500, Frederick Lawler wrote:
> > IMA shouldn't measure or appraise configfs, but currently does because
> > it's missing from the default exclusion policies. Move CONFIGFS_MAGIC to
> > magic.h to expose the file system's magic to IMA, as well as other userland
> > applications.
> > 
> > Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> > Signed-off-by: Frederick Lawler <fred@cloudflare.com>
> 
> Reviewed-by: Breno Leitao <leitao@debian.org>
> 
> > +#define CONFIGFS_MAGIC		0x62656570	/* some random number */
> 
> 0x62656570 is ASCII "beep", I didn't know that :-)

I can't tell if it's a better joke to leave "some random number" as the
comment, or to change the comment to the more interesting fun fact about
the number.

Best,
Fred
