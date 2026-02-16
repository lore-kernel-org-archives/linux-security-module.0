Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EFB2E3387
	for <linux-security-module@vger.kernel.org>; Mon, 16 Feb 2026 18:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771268000; cv=none; b=BRAfXE7BwDBPgeS/SSEtgJlcgc+i157DXZ4KoX6D3uutpSl4gyfOZcZnHy6uUYnnn5nbD7zpu27RgEZhNSB24j7/vnIo6/d+ZaIEFvibC4c2DAufSHR72O1pAO4rFOawdx/2cXDPbbOGZJ/t/PmkwenAb9wnVDJXQwDlQrn+OKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771268000; c=relaxed/simple;
	bh=z9lAxhqAOWJK3aphGz/9Vo1vFjVyDgEXn3dJEE5GF1Y=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=o7QFgl+T1lXgmxX4d6y0PrjhHHxfL6lIxQZaj0LQSR3KgUCq2RrBHCrIYc+jO7iGk3PbwXLrNQchi+MkNqBSOSooO7VKyd7ofz2oc6hoV+SjH6JNa1fljMVbK4oN16GkG4cNCkqBRFnEAklOBqw0tbZWwzr86T74w3RNhy33u1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VwXMj77Q; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VwXMj77Q"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-506c00df428so16933261cf.3
        for <linux-security-module@vger.kernel.org>; Mon, 16 Feb 2026 10:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1771267997; x=1771872797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=agZzr/J+RDM+D3SvvYA7saHpdOrKQ4jtNNKUE6kjFHU=;
        b=VwXMj77QZGbt2ce0+4DkN/ZxxPEJYeuEEgUhM9twT/NnFze3id/Kr/EzbyKXyc1fAw
         zoV2NVMboXHPJgKW9bm1KGcUlm4WM29Qb+neCzQSwS3yEy7BSnJOCyI1gXPIeTAK2poP
         +krUklWqSVnDtXgNYRnCxYqJhiYLPJ6KdIQYuthTKUSgj5TCiGjUl185xYYlQE6AhKqs
         XBU1d80NqY6lmjMNqglDyz037KdE2vj/38hJ0Yi6xpAirELeUqDsFuvnq0IBVdjnUa1Y
         sC6ifj7OZhFBZWWaiyaVdAJV1Dm4OmeoQnKKUSBuhlx0gO5w4UvTb/1j10NHCrB+QyVK
         +GxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771267997; x=1771872797;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=agZzr/J+RDM+D3SvvYA7saHpdOrKQ4jtNNKUE6kjFHU=;
        b=pe97dqdaWozCOUiHN57Elvv9OyEUE5335FYUSyudhaaJdRlX8KuNb0v/fk1bik1lIH
         aKYfwYDVU/cyn6t749VnpVF+fsX9+gtIeRnaKqtlY0E+i5akIO3zEkubIysIDu7Hei4I
         Eyn6HnndzKm7dblNqG7bXxgML38IpJI70dNaMfiA6Q9ej7BMiSbYLFBULlC29Zp7A2UR
         LP6nfocGbMAlKgKX3WSGJX7YAJH6b6ZOoHP6580anB6He9Pa2BJfUpNN4CUBaMhtn8sP
         txRbaDIxN3mW+rONX924/xOplF+EGXZpa1xGahDJaa6RkTq0Z0Ltd0lBzw5XB4GYo88a
         eYIg==
X-Forwarded-Encrypted: i=1; AJvYcCVtOLB47C7QyvdjBv10aO9sqCfHTeOtBwrGiYU7VE9eu1xMgJCWgvSUx2Wd4PZeyWi6c1hJALsMrQGGOS4uN4SnChgdSPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuRUCOkai4jrz7aSWCBIwnwwEgbo0oMvwyVlEyqyIzINFuq/FT
	ElT32SBsfHGGxtIuPrzzBL7HHI5QkYsU7UGv55SMaJbJ0QJ3/KICS3kpBrfLfGSyhQ==
X-Gm-Gg: AZuq6aJe3ECxRedhTENb5TkQ6FhCDoPAjRQjb1iZ8oTETGYGVXiSlSTpugzR4wrnQxP
	StyTQjfYIkUemMpjrZ9Uwb3JwcAO6qZBHAd2xW0h3l5CRJDDnwWpKrbFiaHiJf9/uhxaGWS83V/
	yl2R7HcQ1QvyI9e+rm2oADBgw0urAf6BMby+d7bKlwe6pj/7q5gLD4Q9TLVSggGpIbM0sD2Ij3J
	/sk7w+eA6/8Kvycx9ST86dK1Vj+l0FJ+CqOp/L/hfi+yQ0L9Ju2/FpbKyAZKPTVBMUUeO21l4yM
	L/+xncvK/z2OMWtE1YuaU3s07wFBM/t+82zB5SSHuKjOThxDgh7n5orsNbJY/M0NiTQFBYmxRrl
	4bUD5SgJS0uYby3H2a9EBBz2np68s7DFaybYDfi6OIkIWMH3q8nXMINoiDFdAtSM+kklPCmCuhX
	B9z1ga+vKLwJpzxhj6W9nbxT+I
X-Received: by 2002:a05:622a:1787:b0:501:3df2:fd60 with SMTP id d75a77b69052e-506a8271d63mr139358561cf.12.1771267997128;
        Mon, 16 Feb 2026 10:53:17 -0800 (PST)
Received: from [10.116.167.119] ([166.196.57.81])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50684b6b576sm149233871cf.21.2026.02.16.10.53.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Feb 2026 10:53:16 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: Christian Brauner <brauner@kernel.org>
CC: James Morris <jmorris@namei.org>, <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Date: Mon, 16 Feb 2026 19:53:11 +0100
Message-ID: <19c67cca5d8.2843.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <20260216-work-security-namespace-v1-1-075c28758e1f@kernel.org>
References: <20260216-work-security-namespace-v1-1-075c28758e1f@kernel.org>
User-Agent: AquaMail/1.57.1 (build: 105701604)
Subject: Re: [PATCH RFC] security: add LSM blob and hooks for namespaces
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On February 16, 2026 2:52:34 PM Christian Brauner <brauner@kernel.org> wrote:
> All namespace types now share the same ns_common infrastructure. Extend
> this to include a security blob so LSMs can start managing namespaces
> uniformly without having to add one-off hooks or security fields to
> every individual namespace type.
>
> Add a ns_security pointer to ns_common and the corresponding lbs_ns
> blob size to lsm_blob_sizes. Allocation and freeing hooks are called
> from the common __ns_common_init() and __ns_common_free() paths so
> every namespace type gets covered in one go. All information about the
> namespace type and the appropriate casting helpers to get at the
> containing namespace are available via ns_common making it
> straightforward for LSMs to differentiate when they need to.
>
> A namespace_install hook is called from validate_ns() during setns(2)
> giving LSMs a chance to enforce policy on namespace transitions.
>
> Individual namespace types can still have their own specialized security
> hooks when needed. This is just the common baseline that makes it easy
> to track and manage namespaces from the security side without requiring
> every namespace type to reinvent the wheel.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
> include/linux/lsm_hook_defs.h      |  3 ++
> include/linux/lsm_hooks.h          |  1 +
> include/linux/ns/ns_common_types.h |  3 ++
> include/linux/security.h           | 20 ++++++++++
> kernel/nscommon.c                  | 12 ++++++
> kernel/nsproxy.c                   |  8 +++-
> security/lsm_init.c                |  2 +
> security/security.c                | 76 ++++++++++++++++++++++++++++++++++++++
> 8 files changed, 124 insertions(+), 1 deletion(-)

I still have limited network access for a few more days, but a couple of 
quick comments in no particular order ...

Generally speaking we don't add things to the LSM interface without a user, 
and I can't think of a good reason why we would want to do things 
differently here.  This means that when you propose something like this you 
should also propose an addition to one of the in-tree LSMs to make use of 
it. While the guidance doc linked below (also linked in the LSM MAINTAINERS 
entry) doesn't have any guidance for the LSM blobs as they are generally a 
byproduct of the hooks, if you are looking for some general info I think 
the bits on adding a new LSM hook would be very close to what we would 
expect for blob additions.

https://github.com/LinuxSecurityModule/kernel/blob/main/README.md

Getting to the specifics of namespace related APIs, we've had a lot of 
discussions about namespacing and my current opinion is that we need to 
sort out if we want a userspace API at the LSM framework layer, or if we 
want to do that at the individual LSM layer; there is a lot of nuance there 
and while one option may seem like an obvious choice, we need some more 
discussion and I need a chance to get caught up on the threads. Once we 
have an API decision then we can start sorting out the implementation 
details like the LSM blobs.

--
paul-moore.com
>



