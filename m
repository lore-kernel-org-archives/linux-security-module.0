Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4E7522699
	for <linux-security-module@vger.kernel.org>; Fri, 18 Sep 2026 19:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789761591; cv=none; b=jKWIYlCQoolG6FWdZoFRX91rO9FgUEEdYTUNVrh7eknLJGs6QM/z4pmGUXI9mHu6aEhR+rUg9Ogj01bcJsf5Z/7QVQRZNWS4jwRjNTSvAndBme5GHR+yqDS4P3IefFyOpchf2C8fUK4XcejGl96cZ1+uVOV7pkQLvyIi59mmI7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789761591; c=relaxed/simple;
	bh=Jv9PmI2tuRQ6a0mGkf94vkgPMQlOdZGeXzjl16O8i00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uLEfyGeFdnm7JySBzuTXvRE63tQV9hoKtkseaWzXJQfb6Mn4hDQAKZ56ad46qlfnV1caQ4LqLr4j4cPBsMFO1PYjntWJk/s6/rbeHsS8+N7fVXi27CDobaWxjByOP0JwCgrJ6ZA8cE7ipE+eHwrbGIwqyU9TZdzZT36jdUrSc/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com; spf=pass smtp.mailfrom=amutable.com; dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b=ch2e604T; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b="ch2e604T"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66fabb1a601so1098318d50.3
        for <linux-security-module@vger.kernel.org>; Fri, 18 Sep 2026 12:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20251104.gappssmtp.com; s=20251104; t=1789761587; x=1790366387; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jFiXSu2V4pZ+QeomBn1c5HcWy5gtnzTo7Z55CduAixo=;
        b=ch2e604TIxvi8hLh6mLXV0Kd6bTBiZI6iola+whhEHBQ/gRtNMLO9+O8h75SUTlcSD
         ct4Fq4vTT/VWzsVFSc3o1K507n3fGuVDlzN1p1N7Lkdt1Oewd4iWhDCX9oexGV0yw1Uf
         x2xfQyWszMMyEtpwNcapqacbwvHOBZrrOHwghHYVKP+FpxGbDBAq6+cwPnqMOmdXT/Wp
         RmREmPUaX2sGnpVAZP5EJ1ONwPxNa2rNIQ/a9maVbyLwwsluXGxl9TM9z9D6C+ZEnGU5
         8BEMTctHx5RvzLgo9Lu01MauixY+qjScYIhLTGc4EVl9uKr4tRuCeerFP6EutvGdfkxX
         Sdmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789761587; x=1790366387;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jFiXSu2V4pZ+QeomBn1c5HcWy5gtnzTo7Z55CduAixo=;
        b=d5QwiY20IRUki7LVgV+2UL284Eo/3r5RYb0KfLs7+5DQGjXLlduGfKw++bDPZXGglF
         8ZNa9nidYOKkpIohr4p5VPR7MvbalqYqKNvXrXPBFytr4TywAuhOuxm1sYophBgmCRzC
         eE4WCdocl0zHLblZpKRhEgAC64ecOnLWiBus1QNcenUVmT74Kah0ThUyDFWGPuEpYEcy
         bLIOWJ1IWR3N9FiSQR3hLhHA+I+rarQ/2ynEBAs9wQYF7Q/oA6uMiavfzKrJC4rkROtd
         yjlacq+WO8T6ahVYL6ERT+rgzn6P13uLYxL4gHywM3O24YisDTjXMaVf1fP0Pf1/oSFq
         cpmg==
X-Forwarded-Encrypted: i=1; AKwUvBxeggXwtg+YKOgltFPYeb+Fh0/vbWXUr25s6rdJv11+svrhqQ5hmUGjAQaRrdWMsvaAhpzLACeUw3JVqubMOYHJEVlnWow=@vger.kernel.org
X-Gm-Message-State: AFuF++mfn5UOHpYy5JxFIwSGe6/1Yj+EGEKSUOM3N19xJNXr7e6depiT
	smQIy5pfxr7uBu5OrE2kj0lSIHGAUMlOrmVnmTMhXexrd/cuM8pxZkPtslo32wcUj9un
X-Gm-Gg: AYBFou00+I2SQawgDWR1nWhahRQOoUDH2uNuaPQEGz9H5mSobdDbB+N89g9bYxDFX4C
	DsO6oG+Dyk3UNGrmpfsLTtxAEl7Nuzg0MrBe3b3m7yPkSYbzB+24HsFBbKXeCouX5H4T85IPhDs
	MUHcVzahokJMnX7VA5k36tpv9V80kc7by3uRx88iaBnZNfxEHQe0QTUsSJwunhNDAeWJUSJGfwH
	5wOrJ9u1v/c07t1UbPrfHLLcQJtzrjmcUiv9VsnL/0ZSCISrglUWuRT9D3IN8VQp7bGy9DeuMQB
	KKl9CNyRJnEGd/EQOfdvhXDu1d23J5Y9y7by1SQWo3gRC2Xp/d/r1PlXytX8kxyPPJZKvTqsXFT
	gVoTst2iWZMlKwTuPgO8VXG2BYVWbU03AsSc+/MQdu+PMMG1Dj5Z6LSZ2shs4QelhP9ND0fVqmU
	a3isz+hqxnI/AOTo7nwq+jRQBHo9v5iBGq+VABLyl2s6f78HOIPL1HNtSaEunK4b32MCC9t+ikR
	dWscTsXFh9E1lWfso+yF9HsNyJC9IkI29ptoV5O44WkPSsfq1O0sg==
X-Received: by 2002:a05:690e:e89:b0:671:4d46:8d5a with SMTP id 956f58d0204a3-6717fcee54emr1347891d50.41.1789761587246;
        Fri, 18 Sep 2026 12:59:47 -0700 (PDT)
Received: from toolbx (104-53-165-62.lightspeed.stlsmo.sbcglobal.net. [104.53.165.62])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-672990ab5desm406523d50.8.2026.09.18.12.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 12:59:46 -0700 (PDT)
Date: Fri, 18 Sep 2026 14:59:49 -0500
From: Andrew Halaney <andrew@amutable.com>
To: David Howells <dhowells@redhat.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, Alasdair Kergon <agk@redhat.com>, 
	Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>, 
	Benjamin Marzinski <bmarzins@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Eric Biggers <ebiggers@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	fsverity@lists.linux.dev, linux-doc@vger.kernel.org, 
	"Christian Brauner (Amutable)" <brauner@kernel.org>
Subject: Re: [PATCH 1/3] keys: add KEY_SPEC_DM_VERITY_KEYRING
Message-ID: <aq2VxlttdlTNlHo6@toolbx>
References: <aqyiCavj3xeNqyAo@kernel.org>
 <20260914-ajhalaney-dmverity-key-identifier-v1-0-01922dc1366a@amutable.com>
 <20260914-ajhalaney-dmverity-key-identifier-v1-1-01922dc1366a@amutable.com>
 <715249.1789718726@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <715249.1789718726@warthog.procyon.org.uk>

On Fri, Sep 18, 2026 at 09:05:26AM +0100, David Howells wrote:
> Jarkko Sakkinen <jarkko@kernel.org> wrote:
> 
> > This is great for discussion but what we want for the commit message
> > is just motivation and resolution.
> 
> Actually, I think it's useful that Andrew wrote up the issues in the commit
> message - and I think it shows part of the motivation.  The 'writing a fake
> /proc/keys line in the description' is something I hadn't considered.

I'll defer to what you all want in the message here, I found it valuable
but I trend on the side of overly verbose admittedly!

> 
> > I don't think we need all this just to say that /proc/keys in a racy
> > query mechanism for production, which is an issue for dm-verity, given
> > that nothing else is available.
> 
> I think at some point, we will need a system call to search all for all
> accessible keys matching certain criteria by actually walking the key
> database.  The problem there is that there may be multiple hits, so we may
> need something like:
> 
> 	int count = find_key(key_serial_t start_id,
> 			     const char *type, const char *desc_prefix,
> 			     key_serial_t *results, size_t results_size,
> 			     unsigned int flags);
> 
> Allowing you to do:
> 
> 	key_serial_t dm_key;
> 	int n = find_key(0, "keyring", ".dm_verity", &dm_key, 1,
> 			 FIND_KEY_EXACT_DESC);
> 
> This wouldn't be as fast as a direct lookup since it would have to walk the
> key tree, doing name comparisons and perm checks on each key of the type.
> 
> > And secondly special keys are meant for implicit keyrings so isn't
> > that all there's to it?
> 
> I have no particular objection to setting aside a block of negative key IDs
> for special keyrings that need to be accessed a lot - though I would make
> common reg/unreg functions that take the ID to be registered and, say, set the
> block at -257..-512.  Moving the BFP keyring to -257 and DM to -258.

To be clear are you suggesting I do that for v2 here? Happy to make the
change and add some reuse to the registration functions, etc. I'm
guessing its fine to change the bpf id since its still only in -next?

The only awkward bit with making that more generic is that dm-verity
isn't __ro_after_init since its coming from a module possibly, and
because of the module usage I also protected it with a spinlock in case
someone's accessing it while you unload the module. Could just use one
spinlock for the whole generic array, and drop the __ro_after_init I
suppose.

Let me know if I'm not following properly!

Thanks,
Andrew
