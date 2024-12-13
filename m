Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E781318DF89
	for <linux-security-module@vger.kernel.org>; Fri, 13 Dec 2024 08:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734077153; cv=none; b=eYuNe/Ln7e2HjK5B9OPPDTSdiK9OPdyUnGHUWLu2wmWVvyE+EjjlRnehRwOTGgItgC7vWTer+AMSzHWeNHb/Gs3kFW/2n4sBoNPqIepj+XliDMCsfHwAOVNne/P4zQESqoYEBfEn1ymr6g8ZRnG2HesgN+87I+OdZiVkispGWk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734077153; c=relaxed/simple;
	bh=Gm1aSfPWn+6Iv90/f+5lwr4JIOMPpgZfZJbELp9SPys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VOqxGFuwpkvAJU+eAunTmZ9l/hqxN7Dn96mXjPAYyJcUCXyz5ap3LcxeSrCwSkxfmBKUy5SyQb6b9DtSS63XftN92O6oDKTgv1/mryK16jbZ3B/i3pEjwIUCtHK+zxO3mL4fpyi2cllKx3UEm+2uYquIK3syEPHJlbEgZMXSbYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JLi1Ub40; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JLi1Ub40"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d0d32cd31aso1745472a12.0
        for <linux-security-module@vger.kernel.org>; Fri, 13 Dec 2024 00:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734077150; x=1734681950; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lgwYE8AkKohlShjZLrwteb4c+nimfkWQZUupQYO5W68=;
        b=JLi1Ub40QBv66ZjD7LttDdNXIL9STIwTkkza6loCqucui2uM3j9xdISG+PuR+Ks4Dw
         VFQm2ZqQDTqOMUf26R5D4jr4ELtV//qcPMOupX3H2QD38yq3LwEL9JRUY7kMvdi+chwg
         rpmhxVyEShwyfM3PHOB4uYy5OfJv/z9SljmG8PLFEd8Wd3OFrq+11rPlhaf0jphRYp5/
         KOE0Hj0vqdVtvPWVcyy8IVbXrKSUUV82lvIM/0O+038nVI/fPRGrHuitVOgj5Aq24nS1
         vuOheIixL6exmB/lKTzdTtIB/c0Ru20ZK2SveaNytzw3QMb5lGXpaP4PCI8XKb2vb7VL
         n1QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734077150; x=1734681950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lgwYE8AkKohlShjZLrwteb4c+nimfkWQZUupQYO5W68=;
        b=GbBk3GPe1lV8Qzpnmi2TWWIDjSLOQ+Mia+OZOzCGOdeaIla2HKINAatDjjWA/MAAFq
         iyARdzeHC+0ERm8IlMfjHPEp5k4qNi9GbeJr64C6WdIuxhvPkHxEpZFJLuKG59bvWKvG
         6Nj+aJGg0SfJFctPpX2hyIwe2nuR9meYRcWlDaeGs5JWKki1sv6RMhUVCLuRwfF1R76w
         c4DoyO4FZ4DhpdhxE9LquXVCf4qFNBdub2Elc73Mr8ek6rLK0jdgYJpSLzIRgP2kQxqi
         pyq29jh6RsTAbeCptVlIjPVExfvBX1mXlNAWc71DqPfRogvSu/HHm7Tv+6IUnbfeoI+u
         QZjw==
X-Forwarded-Encrypted: i=1; AJvYcCU4y6wvFzrOBxrKSE2aA/hUFIJSID7Cgmx0P5XXB+pyRKZ/W+5Fs83ovuDYj+T+B6qT9ZDiMn3RsEo5vNgHffAABvTZp5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuSnzBXkzpR2w7J3QNiuXhSrErp1uAQF+UotlKBoQAGLcyTIvu
	fHRTBGZWIF8mnTz0v0dkdMTx/0MVFldSQS2JTied5UOsmR2FYO2T3P2AB/+w6EM=
X-Gm-Gg: ASbGncthhyAxqjxG+EWHDY94OOdvQP+27fkcHqZYyb2oieSjiWLiLvheqiH9Jb8U+tD
	eugkhjnTb8OFC4oNIlCWtvXwysDKqSdqZq7kNpxXil6bwC6330rs2zgkzKPyJ8H9Jcy10GFMAA4
	SfSpnJ8AlYe3k6VGkj1gn1W6Xo5ory0edm6wo1obUS9XFEXXtBh3OKcxzguhp0bnB5gHobnj209
	DfuaQPoMivVuB5ohk6SXi3vkwPxFwZKZmBtHM8ifly5+XsQLurpO1ra4g==
X-Google-Smtp-Source: AGHT+IEBU3KaEVduDDJFmDiYKp43p4o//mXEFM4u7vCzKG7h47JoeDZ5E1DdrcH3VOsdWE+nfKrYuQ==
X-Received: by 2002:a05:6402:4584:b0:5d0:ea4f:972f with SMTP id 4fb4d7f45d1cf-5d63c318beemr3590523a12.8.1734077150211;
        Fri, 13 Dec 2024 00:05:50 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3ef026a41sm7507030a12.15.2024.12.13.00.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 00:05:49 -0800 (PST)
Date: Fri, 13 Dec 2024 09:05:47 +0100
From: Petr Mladek <pmladek@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	x86@kernel.org, linux-snps-arc@lists.infradead.org,
	linux-wireless@vger.kernel.org, intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, ocfs2-devel@lists.linux.dev,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH 1/7] vsprintf: Add %pTN to print task name
Message-ID: <Z1vq2-V7vB5KhBR9@pathway.suse.cz>
References: <20241213054610.55843-1-laoar.shao@gmail.com>
 <20241213054610.55843-2-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213054610.55843-2-laoar.shao@gmail.com>

On Fri 2024-12-13 13:46:04, Yafang Shao wrote:
> Since the task->comm is guaranteed to be NUL-ternimated, we can print it
> directly. Add a new vsnprintf format specifier "%pTN" to print task comm,
> where 'p' represents the task Pointer, 'T' stands for Task, and 'N' denots
> Name. With this abstraction, the user no longer needs to care about
> retrieving task name.

What is the advantage, please?

Honestly, I believe that the meaning of

	printk("%s\n", task->comm);

is much more clear than using a cryptic %pXYZ modifier:

	printk("%pTN\n", task);


The %pXYZ modifiers makes sense only when the formatting of the printed
information needs some processing. But this is a plain string.
IMHO, it is not worth it. In fact, I believe that it is a
counter productive.

Best Regards,
Petr
