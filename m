Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39A73DA7C2
	for <linux-security-module@vger.kernel.org>; Fri, 24 Apr 2026 14:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777040366; cv=none; b=hA18RBiTr+rw1ePQmQJjDJXeg4ymsER91y6/F2wjDfYIZ+7n5E7n5TOdjzHhg7Di/h9zHXmqazKWg9tWxyhgMwD8+niCzl8ifhQ2myDh7F4qeknJMRtAo0W/2f0YeJEkyBNhIS41BodUaY6cfaB25cpGsr3Rvwqy9WpGjG1+M8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777040366; c=relaxed/simple;
	bh=sR29cvVWWj1zEvLPCnOluGKLlUo6GPJZv7ipVNXVONw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gopqhzNz1mtsFMJrBZ38wvtrihPJvVwy7I3L4p0CDsL0mEy/Dv3ULsnzHZOiHyQ9PNpHQMbx2Pre49jiTu1QK9DeO2IFA1jedhPNPftVhEQAfu92GzcCiWuuYcnmhctRyVdaRIcLJ3PzsmIK86rZxLfDNIzc30NwsyPPG6Zpb4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=igpKv7ta; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="igpKv7ta"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-94ac7f22d23so1951692241.3
        for <linux-security-module@vger.kernel.org>; Fri, 24 Apr 2026 07:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1777040364; x=1777645164; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zV0Gq4Db+XurRwmLehRl8plU7HsCQBBchm2UxZdn8eA=;
        b=igpKv7tavJsOoMZy48+l67X+sKqw4fGrLFlfTwBT8xEv50hjj/UwxHNUnf6A7XM62x
         6SO9kz0XzK1vDDn1Fw1/WKyMSl4z+tC1/eqSsCRIpe2RiqDq2/uHMMKjUOH7fnKEYoV6
         m4GWv5P5pMeL4gPkHQV4216zlJVaxS4kVcC3kwsVW/FfqTCKIaVt8hiEaaf9iO4v0gdB
         YeTTXCdYGuPMDVBEYlVxdNnSGim+WPSH2z22x/JCLWF1KqQHsC2FqQnEEao6vrYN1GCO
         +UtOJC3nva1hzI0OMrjCuvSu0Q9pxqVbXYH4JVx7vv1Ysw6H7gkDMjw7KhsYQ+vfetw1
         spWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777040364; x=1777645164;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zV0Gq4Db+XurRwmLehRl8plU7HsCQBBchm2UxZdn8eA=;
        b=GOvYE/RGvXSP08EskJli0y6Gl1/ckqHk7MC0WRkVX9LY2zIcJ/2UIhw35/IRWjEewh
         v3mU1hHy5SPV8dI6LejfavlJ/eHpiCjJedX0acqcT8Wlculak6N7M85xJFC92DXjTdSZ
         B/+6lbE0pOuFz24W6vNR5M7uSEsPbbQ5nKnVVYADDjBBpIRM7FZcFjKeJ9jkwOMHk2Xj
         9y9Wvwn4ftlU18HNUsTD2amrj5KwOg4ipwv3ue3G66pCEe/QO6GaTav754oR7hHygGRE
         I4NuKzBZ73EkQR5PAwt9IWxg1dW2D5xv++exTN4jZTJ0RagUunqIie2Wvwul4/sPmCO7
         527Q==
X-Forwarded-Encrypted: i=1; AFNElJ8x2EjmtMZPwwaqZZ6inmK75vEzIh+PhgN2SIKaLwFbp+GzCiksVGgPTzB325KqkZ0a8qUnOV5TeRKX1UHVaGMQlnxvCOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC3pcq2G85gbVgtI9KX561SQNuxCQVkTRWbGP6si1v0EgshePW
	gb9yw8O1ROnqxQXNbrl6h8pGRF5C7Rjm9AKITxkRcUAjOBjUHrwrWUGLUNTcYL1WrVE=
X-Gm-Gg: AeBDieu9drlc1x2WlHlkMFWY18hOm+IQqU5d0eJlkyCFIjutXH7A+AQ5XPQFWUK1PcO
	X8G6q3kwW2tUUB03pD6BSA4W86+qsh8Uu1ytReW/BcUwPQsip6DOJRmEd0ZyQhZ4W2JkrvviEY3
	B5gZw+dP9ia957Nm6/UpjwJSJWGnAtExSN9eHf7FaGaCpXigpYJC67rwVBTgPi35BIdWH6heVVZ
	PHhRFlbvju4svMeXt3E311g3jmttNMKX/rBaWC6eGTM/5TB0VXKdoNpn0oxx9nP6tOmNounhomo
	pGUhBjI9x+1H0esXoY1Eijob79O5v2NXxtGTH5wWYMCcCuy57Qhs61q24jFSfbIsA0brgRyR4jp
	UFlKAhqjYtnx9FH9cTQiv6ymU+Jn4QRW9t/vBnC/WrRCeij4rssVem+o0PiPMFqIoOwkGLATM8v
	viUjDAgbd/IAQ0wvImJhhafq+wl/3CTmhGrvSsMS4S4ruoIk07Sd6zrsHFcNHdi/lhYkS7X40Zv
	gBmQyeD64Ij5LQI
X-Received: by 2002:a05:6102:6cd:b0:602:6784:3eef with SMTP id ada2fe7eead31-616f90e6f07mr16856701137.28.1777040363554;
        Fri, 24 Apr 2026 07:19:23 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ac81a9dsm186723106d6.21.2026.04.24.07.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 07:19:22 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wGHNK-00000002j9p-04Ph;
	Fri, 24 Apr 2026 11:19:22 -0300
Date: Fri, 24 Apr 2026 11:19:21 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>,
	Roberto Sassu <roberto.sassu@huaweicloud.com>,
	KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Itay Avraham <itayavr@nvidia.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org, Chiara Meiohas <cmeiohas@nvidia.com>,
	Maher Sanalla <msanalla@nvidia.com>,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Firmware LSM hook
Message-ID: <20260424141921.GA3611611@ziepe.ca>
References: <20260412090006.GA21470@unreal>
 <CAHC9VhRnYXjg+vE9a8PeykbXk91is12zYLaO7EFdfZPKMxDfPA@mail.gmail.com>
 <20260413164220.GP3694781@ziepe.ca>
 <CAHC9VhR1Uke9P==CELKavBcogHoNCtMZFfNWUbgm5HYUfomhtw@mail.gmail.com>
 <20260413231920.GS3694781@ziepe.ca>
 <CAHC9VhTLamfe4C81ZNRVT=H32x+KLxSqH3o0eBfrHsWAgAqxCA@mail.gmail.com>
 <20260415134705.GG2577880@ziepe.ca>
 <CAHC9VhSECYihup=tURo_Qk__xUdYYPkHgnz5CWA0BrRAkvwbog@mail.gmail.com>
 <20260417191749.GK2577880@ziepe.ca>
 <20260423140950.GE172828@unreal>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423140950.GE172828@unreal>

On Thu, Apr 23, 2026 at 05:09:50PM +0300, Leon Romanovsky wrote:

> > > Leon mentioned that different firmware revisions would have different
> > > parameters for a given opcode, and that one would need to inspect
> > > those parameters to properly filter the command.  Is that not true, or
> > > am I misreading or misunderstanding Leon's comments?
> > 
> > They are ABI stable, so there will be rules about future changes that
> > old software can follow to ignore or reject future things it doesn't
> > understand.
> 
> It is wishful thinking and applicable only to mlx5 devices. No one
> promises that other devices follow same ABI rules.

Well, I will definately kick them out of fwctl if they don't.

Jason
