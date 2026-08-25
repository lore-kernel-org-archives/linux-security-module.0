Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1681A38DC77
	for <linux-security-module@vger.kernel.org>; Tue, 25 Aug 2026 16:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787676430; cv=none; b=L4gifdG6QQD4er0aeK7s4HrOOjzOIj4NZ5EM8kPaxzNQdKA/6t73iaNRJsyV+DXJI3cGoFt2EAoeNMHf9IfchkXXaZogv5RvfnP8PmjQryFOyqAKaoVhyMLXHMcQJ1+5e8n1qFS1F8vPdrU1bjTouvpSoGG+yhIUK3HHgT/ObOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787676430; c=relaxed/simple;
	bh=Q5RlCcycfNc2TZ/PvLCKqaWXfCM1b94KP4InGT6cXWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=obG0rU8l+180Y/+YFt9E0HZuhZfIX8Yz1yPdK5152ChwuHhIGxTeia/zI5kDmd01TX31Mg/ON5tPEEgzz0PPs4046q47rOBD2tAwNk/m3FyUf+W6RlJrypEeZIpnPds9GK3R8flL7I+iJtYDXorm218lXbZpEIYLbYe1Qu7/pXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=CTsPnkvf; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="CTsPnkvf"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-6682259cae6so6330180d50.3
        for <linux-security-module@vger.kernel.org>; Tue, 25 Aug 2026 09:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1787676428; x=1788281228; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=A7t5uDlAobliWG5HjrlwdWCEo0ZIR1xcFmgey215k/k=;
        b=CTsPnkvf0m3sqQspkwWMq4D5A/GGYn8KzLNyWRisJVRFRVoZh6Yh3INW9orlTdvr2E
         vW8HisecWBMfGuV27vMC/k/Y5ZW/EqAe5cYVKiADRDKKHev275E8+FT737YEy8d6ij+u
         TvNcoEW40FrgjLQbIQM6jJUlAB2cdnBAMFzLCeOnLIHRlW1UoJA6obrsi8KHy6C9Svnm
         oI4/1qu/paodGaTq7/3Wfr9wgA56kmFvNBuDwYiVp8E+8HGnx+0pz4MRh+UMwaJkz0mh
         okLoVfynBFUlGwmxjpI6uhDFGBZA2cykAZH/J1SDAQv3ggRGdLB5AGzF3Uhkk5gf3KvC
         l96g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787676428; x=1788281228;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A7t5uDlAobliWG5HjrlwdWCEo0ZIR1xcFmgey215k/k=;
        b=fVRQaXZrYBSAH0UMHJ4Msi/Kqva+Jy7emI7Q1f66u0gpsA2MGqYeA6Ib8paDu2FP30
         qUobbh2eHP6EVYKSTu9iADwGaICfBMI+xIC0Ai4/hccmQlieUtssomf+2m/AQ7i+mOTV
         YmRWm3bYT/r9KnoMrMrorjL7+zX8BxUmYiu1jNvAJ4+kPjkRKQG9TMgjq5d7Zm4WS/TS
         JKNZVb8/bnOh8w/Tw3+nEEwO8pt2ucJaJ1Tzlo9qW/NJ2czN6wxuMoAw5+s4jIv2WahF
         6ipECCsYDepwWQeDgfI/cIbgFKNjd0oJrpAJjhpig1zsU74O82/Z2my5A1H4jxCjkr55
         Gvqw==
X-Forwarded-Encrypted: i=1; AHgh+RocmVSn2P+uGlXAhXFZPwG4Y8+QgTcv2l40EE0Man8tVCkgMGA5ebMVUWa+LlvwEneqsNxPVFR7DVTwqPu9uYjqLsN3bJM=@vger.kernel.org
X-Gm-Message-State: AFuF++nRczgs370HkWwvY7RAvWA0sKAXh2wY71Dz5chr04RM7kNKixJ3
	p/njRjMK489EJD91HZ6GUmMssPgFdnVmRXco34xGs3RoMYi9JOAZiIU0BJuDORKiV2s=
X-Gm-Gg: AR+sD13+2PAJYZmT2Uolcy8vkyFF4sanPCaOLOb82TQ81zASkr51nei0uFz8AdYjW1N
	B9Jdrb0HQirINuHhvUpFHP2svQOHHUAIIIC7bF39wZRsdzZJIRfniHxWukOdTULYjHaCkxKmSuU
	JTPoYcCXLVXL9U8hxIi+h7Qnfgjm0vuyou9AUKf5ocO9KcEanjXBesBZ0vnvPnqW4XLqAlLUse/
	J6dqORfIsjY6M59eh5OG8ZOVwYROAQEqz64a5AGhWULX3X3ReVp0jJ7l7wEku5SsnC9qIoqcTis
	ba0tg+tNYYQGGbc1kl4fWhuunU5uYyZO55fNOKEgfqpu311scVMY0GFPn/jZV3raM8c9ZEsDsDD
	k6vtglaoONnZCMQw9y1pPHfSZ4uDgw/lc38BvH69GplpiEMN9LQGs0KbmkohDyF5P/pNEhNCokn
	Nedp+364PK3JPUnnk16LsQW9a0zykgNhBFW4IsLWk=
X-Received: by 2002:a05:690e:e26:b0:667:f9cd:6ba4 with SMTP id 956f58d0204a3-66d256656a7mr11937d50.2.1787676427852;
        Tue, 25 Aug 2026 09:47:07 -0700 (PDT)
Received: from CMGLRV3 ([2a09:bac6:947f:3af::5e:70])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66d2454d92asm262019d50.3.2026.08.25.09.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 09:47:07 -0700 (PDT)
Date: Tue, 25 Aug 2026 11:47:04 -0500
From: Frederick Lawler <fred@cloudflare.com>
To: Breno Leitao <leitao@debian.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH v2 1/2] configfs: move CONFIGFS_MAGIC definition to
 magic.h
Message-ID: <6k67quhqhibslnmavtbvgnlzbohpgmyfm4yxekl4k5lzqdvr5o@xg3wbmdl5wbt>
References: <20260819-configfs-v2-0-cb6e65d11589@cloudflare.com>
 <20260819-configfs-v2-1-cb6e65d11589@cloudflare.com>
 <ao2iHWDZAJf0FRqh@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ao2iHWDZAJf0FRqh@gmail.com>

Hi Breno,

On Tue, Aug 25, 2026 at 07:10:02AM -0700, Breno Leitao wrote:
> On Wed, Aug 19, 2026 at 06:45:22PM -0500, Frederick Lawler wrote:
> > IMA shouldn't measure or appraise configfs, but currently does because
> > it's missing from the default exclusion policies. Move CONFIGFS_MAGIC to
> > magic.h to expose the file system's magic to IMA, as well as other userland
> > applications.
> > 
> > Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> > Signed-off-by: Frederick Lawler <fred@cloudflare.com>
> 
> Do you want this change to go thorugh the configfs tree, or the tree
> specific for IMA?
> ?

Unless you have a user asking for it, I personally think it makes sense
for linux-integrity to take it since the two patches are related.

I don't mind spinning a v3 for integrity if you choose to take it now.

Best,
Fred

PS. Sorry for not keeping the Reviewed-by tag from v1. I usually
forget _something_ with re-spins until after the fact.
