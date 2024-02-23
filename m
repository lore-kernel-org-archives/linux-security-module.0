Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874B014265C
	for <linux-security-module@vger.kernel.org>; Fri, 23 Feb 2024 17:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708710539; cv=none; b=VK+hb435xdZsL4uORNta5NzXTqyRNgCS37D36pmIBx3TjWs0xcYWTLGnlCcDnJLhXFFgS3O8CxH793Japn+e5Hfrm/g6xVPiONKXAHHaZMZF+G96gxNvOPP3pAXBuM/FKbaVcRNOXiX3CI2B0GlTG+9G9EPIUsJiCo2n9NUOaTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708710539; c=relaxed/simple;
	bh=J9CJg+f2XESx0EE8EOWgy7TWOEQmNvNe7CTVEAvMpdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rPCddVq3GEh5DYPeAQOmZ8I2sKaIiSElqQhlpPLIOhm4FQhKHTtERojsBm/PURR8R0Nr8Hr3QN5jtcYjprBGbSWSpIs4zhmjIfRgHJBkL9L1MT3yWJBnhxMATdTm3+5NEp7F3SKUOqV3/gWLZf+geD9Hsa2hAM1Xeg9e8l13nqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PaqJkDVN; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PaqJkDVN"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-299372abcfeso875833a91.1
        for <linux-security-module@vger.kernel.org>; Fri, 23 Feb 2024 09:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708710537; x=1709315337; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0xniysJokrJSL4kA+7xMXMFdpfM5voHW8xKXFN/4z3Q=;
        b=PaqJkDVNUvhAcZHYjyaXXhlR47txCPW5nwh7UvN501VLusznbTi0vhhkvcVwVUe96y
         hF9onaV6DcaczNiwnv7KhPHQPymZZRCFIjHroVVHqbkLd0KJRfiRo+86fPpFhLQrtQZE
         gLAV3WtKX9IYx4fP7TZjdHyZMZ5ZsVGOH12c8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708710537; x=1709315337;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xniysJokrJSL4kA+7xMXMFdpfM5voHW8xKXFN/4z3Q=;
        b=ku2WRij01T+PS268jiwogjNDCKWvrmwQ74dYKC3NcCehdr8FUbOON4pEmrbRc07hKn
         tDOp/UIZqam9fFA8twCHzTx1ROLj2x8w0X1kx8TAguaSL6wBgIeQQfbb5HOiqzvv6ig4
         Es4Nxx8qkE6mlxqf2OH8kr0jO3ob2oN71Af9Z4j/2tSGm2/rNc73Cg7OyKsqTHjYbmC7
         1EYoBN7hnnqb6PrcrYC6MgBF3VLA+75HPvc4jGBhTDj/KD5XuihN5hFqYzRe4LG/8mdv
         XUsxAR3p7HzUt5ZiPbjwWFOik9gMVYPNhOs8K9Y7/70BUBAClPBzkVzPizZS10P7LYn2
         onzg==
X-Forwarded-Encrypted: i=1; AJvYcCXqlzTUjPtiqhY/2zEza4VxvD1H+XNGpC6kNOnD5b2aUEnlp3A1W42/++DO5C0W3v6FqzzRHqBM2EI7R4JIE2i9l1buZ7jb/cSBGG5FtdJX9gMo3nmH
X-Gm-Message-State: AOJu0YzTO6e/pYM8OfC/NhtDZRt+AfN3VxgtsYErGTocx2AupaExjQMz
	cNqh7NznHlhf1Ruj5KqzzxExXMgEgSKOPYYcR2OR6DJkznSl8DpSV5U7/AIiYA==
X-Google-Smtp-Source: AGHT+IHPn7Lo2ZZEfv0egVA1U0588A9KlqO0T0qP4pZBiF5v6f+M7qkLa0yUFIE4yhmkeXZ+FjLDCg==
X-Received: by 2002:a17:90a:ad97:b0:299:41dd:95c0 with SMTP id s23-20020a17090aad9700b0029941dd95c0mr619373pjq.16.1708710536866;
        Fri, 23 Feb 2024 09:48:56 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l14-20020a17090a72ce00b002961a383303sm1742861pjk.14.2024.02.23.09.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 09:48:56 -0800 (PST)
Date: Fri, 23 Feb 2024 09:48:55 -0800
From: Kees Cook <keescook@chromium.org>
To: shuah@kernel.org, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, edumazet@google.com,
	linux-kselftest@vger.kernel.org, mic@digikod.net,
	linux-security-module@vger.kernel.org, jakub@cloudflare.com,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Subject: Re: [PATCH net-next v3 00/11] selftests: kselftest_harness: support
 using xfail
Message-ID: <202402230947.614061ABBB@keescook>
References: <20240220192235.2953484-1-kuba@kernel.org>
 <e0ce5ab05a0fc956ccde61686d7c6c90026e3909.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0ce5ab05a0fc956ccde61686d7c6c90026e3909.camel@redhat.com>

On Wed, Feb 21, 2024 at 01:03:26PM +0100, Paolo Abeni wrote:
> On Tue, 2024-02-20 at 11:22 -0800, Jakub Kicinski wrote:
> > When running selftests for our subsystem in our CI we'd like all
> > tests to pass. Currently some tests use SKIP for cases they
> > expect to fail, because the kselftest_harness limits the return
> > codes to pass/fail/skip.
> > 
> > Clean up and support the use of the full range of ksft exit codes
> > under kselftest_harness.
> > 
> > Merge plan is to put it on top of -rc4 and merge into net-next.
> > That way others should be able to pull the patches without
> > any networking changes.
> > 
> > v2: https://lore.kernel.org/all/20240216002619.1999225-1-kuba@kernel.org/
> >  - fix alignment
> > follow up RFC: https://lore.kernel.org/all/20240216004122.2004689-1-kuba@kernel.org/
> > v1: https://lore.kernel.org/all/20240213154416.422739-1-kuba@kernel.org/
> 
> @Shuah: it's not clear to me if you prefer to take this series via the
> kselftests tree or we can take it via the net-next tree. Could you
> please advise?
> 
> thanks!
> 
> Paolo
> 
> p.s. if this was already clarified in the past, I'm sorry: I lost track
> of it.

Given the urgency for net-dev and the lack of conflicts with other
kselftest changes (AFAICT), I would assume it would be fine to carry
this in net-dev (especially since the merge window fast approaches).

Shuah, any objection?

-Kees

-- 
Kees Cook
