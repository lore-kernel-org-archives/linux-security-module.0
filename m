Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAD913633F;
	Tue, 25 Mar 2025 19:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742931430; cv=none; b=rVsJ0Nw4GZX4r8OKYSUdX2pMIOxCcNSUkyAUj1KnMXzTuadAoZaYBO57xqYpLCY3EKabznknpKi8TXsbtJOmDleBJFOBlAgvTVzwP5aViBqflF/dNa415MBps9hiA20YGlvGLERoBqEM3VJkYq6/e6YXgG/A+PIbShkj+W+aong=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742931430; c=relaxed/simple;
	bh=uthNjXBoXkAGwHsnyFmQnHx+HwMrTRlPfgpjVBvqb3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Co7AGaLdSnHTdX8hGpfKHt074OJUA3AaYzc61CgPuFQt4rYY/2N+eaPzhinPOMQbCSlPeClG0km0u+5u0U8hEJBto1t5rHWFmXto4eVBSGGZUWF8kt/QNYQVQ500gFxJuZPLMF0FeShec+3oGJQ0affHgpZ6Oa1EVztInqmRzzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZP8kv4tk; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZP8kv4tk"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cef035a3bso42590315e9.1;
        Tue, 25 Mar 2025 12:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742931427; x=1743536227; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rH4vDDOqAIrVKZRAgJWmuhvlSdSlkAEZ46YZCOWscpc=;
        b=ZP8kv4tkYh+WCHmAiFNO8CpRzBCCUrMguwlCo5QnknvzqhSBgUZdxmHZ92TsamZhrN
         GSteVHRjXDYoFDpEIwWufBsPnNlchMKQWK740CIM17kgE11jBS+hRy1A14c4XSjk68ic
         o6qV7Aw/axNIFs9Db/BnRI9TQu4N3wzn7NqVlYGZefLzqBgmSJvZ02CAjfQjy1x0+TB4
         Z61Or9SwyVSx0tpm6in6K3CPVLqhr1ekWqQpPtCpfEpyL7PIMjAIdktVT98O27IVZ7qs
         56+v1pTgKVnQROUU24/SgVT8kLUIe7Uq3g5Ysb0XFyu+oanlS/pIxnMGxiCVga/nVUsq
         UWVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742931427; x=1743536227;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rH4vDDOqAIrVKZRAgJWmuhvlSdSlkAEZ46YZCOWscpc=;
        b=VKkk20joQFoau/vffW9xoZBH0SXdSTccZO4GbAUFaun6e0EOXos8Mcxou+H3c6wtgC
         wUaCCbnwuusG8pZH7MUatnexSHQA19DAfF5oil6y9o5z7/j0IFeu2kZlxsOmGViEJMF1
         IK5Y1sd5BwmwgVmEmK8uCosUsef/MlyAMy58njCC9qeNOmGRNfxVf/VodvL1tvw92EoN
         DF7AklJdBhEIkYW+W/OLujRa3YLiOWvQbi5pVSnYo5tfp5xxokX2u6zJB/h0IKFcxn3r
         wLKQij9UgzeMOxMRGZ3Q2lr+e5gQUv/HB8HR8eb9ejFzSjH5yfV05fwETw2zFFtgOf7g
         r8sg==
X-Forwarded-Encrypted: i=1; AJvYcCWm17WXRbjKLz9K265hIswAirbzQllQwIuBUGIYAXld8dwJkS+ns0POh1+zx1Ck1Fow8+GTzw==@vger.kernel.org, AJvYcCX+yQTkt3Y/a1ji63kkQwXNsebsgrOsOH0eFvVWodQrqjwebEQzGPdljfJ8JjAT8jX0NbxXIdNBovLaofZ3@vger.kernel.org, AJvYcCXmeGmsSZ8Zc8qT/Jnajb7EDcKJ9nBjBOM83AFWffq4o4eW2CKFh3P0WP+EZf3TUFA8tulP9blkH4SNwxjMhtMKyfmSxNKF@vger.kernel.org
X-Gm-Message-State: AOJu0YyP5fU/LWH14IDSZ/BI0rERw4tlGEZaQ6BessvxuVQAmcg+MDYH
	Vn7VsP6K2QgvYiFb1P4nDg/C8fqe4KDseDImvah4z+erEHesCRha
X-Gm-Gg: ASbGncuP7FHBg9HBIAsZr/9SDPdxUHQcp6L2v/TcPYajsx/at6uxXTBQjFoKZyV3v3z
	uchHg48OgDfHK9Qkd7/vOwu1neZf9ZMHeRTCE16pkDgCvo+QNRRzIPVqheDfWwPU5GtxTTXNS1p
	CwmnMfsD0ZsEjjyjOA+fJMZp0VP2WVhAwT8uZj5fgc5VNkveEQqYqY4xPSTYO5H5TbBKAFW3/zw
	W8e5c1i/xuAUjL1YGdPFr5t9Skgx8J6UQdRqMuQbG19cEexX2KWNgqVEvM55ed6Hdrs2CR0ssrW
	LCbXbHT/fVE2Y3uUCrYsoTYqSv2B8+YxTU3bA3V8d6Mj21KPYEqxr893jFHwXBIJlQswZpQ=
X-Google-Smtp-Source: AGHT+IFw1NFR+crAxRcNWPmKUDM5DyrL5IeJVqh0zoYri/CvcsnKkABhXy2mkwDNvRPMfbvA77BJ1g==
X-Received: by 2002:a05:600c:4ec7:b0:43c:fb36:d296 with SMTP id 5b1f17b1804b1-43d50a3c159mr133322765e9.25.1742931427201;
        Tue, 25 Mar 2025 12:37:07 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d6eab9d0fsm19968985e9.1.2025.03.25.12.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 12:37:06 -0700 (PDT)
Date: Tue, 25 Mar 2025 20:37:05 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Eric Paris <eparis@redhat.com>, Paul Moore <paul@paul-moore.com>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Ben Scarlato <akhna@google.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Charles Zaffery <czaffery@roblox.com>,
	Daniel Burgener <dburgener@linux.microsoft.com>,
	Francis Laniel <flaniel@linux.microsoft.com>,
	James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Jorge Lucangeli Obes <jorgelo@google.com>,
	Kees Cook <kees@kernel.org>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Phil Sutter <phil@nwl.cc>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Robert Salvet <robert.salvet@roblox.com>,
	Shervin Oloumi <enlightened@google.com>, Song Liu <song@kernel.org>,
	Tahera Fahimi <fahimitahera@gmail.com>, Tingmao Wang <m@maowtm.org>,
	Tyler Hicks <code@tyhicks.com>, audit@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v7 03/28] landlock: Move domain hierarchy management
Message-ID: <20250325.706d2d207107@gnoack.org>
References: <20250320190717.2287696-1-mic@digikod.net>
 <20250320190717.2287696-4-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250320190717.2287696-4-mic@digikod.net>

On Thu, Mar 20, 2025 at 08:06:52PM +0100, Mickaël Salaün wrote:
> Create a new domain.h file containing the struct landlock_hierarchy
> definition and helpers.  This type will grow with audit support.  This
> also prepares for a new domain type.
> 
> Cc: Günther Noack <gnoack@google.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>

Reviewed-by: Günther Noack <gnoack3000@gmail.com>
