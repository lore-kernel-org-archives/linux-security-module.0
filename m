Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A966610A1B
	for <linux-security-module@vger.kernel.org>; Tue,  5 Mar 2024 09:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709631797; cv=none; b=Nb+/kFa00k9vycN26IiPof8X1GTt0Cg4cHbNaoSR8RKJMxv1EIkMA9dUcwPsqVXwBLFylqZih/60bPtNDwYJbyvbeJW6Ty3r1kPpNi6D+cbhUeIy/aVtl4bowFoMOzfDUHD75A7jSEp3Pio3lq9efQnsW31GMylmHeHeS4jUr1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709631797; c=relaxed/simple;
	bh=m15fKz5tn5qjvDx1rmcQ6eNp9BysJTSlwqR2O7YG770=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QhOOy5z/qDAKabPyy0j8Qj7zNDkVQ3fCxJyntHFlzuDpBIRgFFAgERprX7KuLa9jXcb/aTDu4ME1kP1IiZhP8WB2cXTMjb+QK4Q5Jcbk5rPX7dFCFEk4H+QZM9F0g1addNkerSe2X+rvCnafVihtLG5JRbgGLopxyd0j9dIl+6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DtHQdQaQ; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DtHQdQaQ"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e64261e712so154073b3a.3
        for <linux-security-module@vger.kernel.org>; Tue, 05 Mar 2024 01:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709631795; x=1710236595; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qlO9KJY2+Wev5gu1Gmg14kKqRey8tMMcaneA5J7f8gY=;
        b=DtHQdQaQ5+evETyYfqOPmpmY/FFdEAbc1u2gNSpz7Jolc6Otib+rUIxoNttSO1tqhD
         Ow/0pxL6Qmh+f1wZizgbUMAXnDo5sqsMZQY2SNszmMHF+gsD2YHoEc7bEpc4SGXiOX4f
         Dkf0DM9wjAqeK9vhGjihe1kNkgu98OrxquBJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709631795; x=1710236595;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qlO9KJY2+Wev5gu1Gmg14kKqRey8tMMcaneA5J7f8gY=;
        b=ACXUIYpaN3avSwK/G3ZztwU7QfbOMK3x60UV6/ypWbmjD1E+S5y6pg+C7yH4e20FUo
         nbg4+ZQX1HORUF83PAIS60q6hCTbg1Pn+p5ucemkN0pBLFeqXqWSEQgRiuJ6DLWtm3PX
         KIZ2pbCvO2ItBMpWmw/LNUrc7S6UV0O9KWGxSDncojglzJ76bDF8jXL8a4QiE+iuAfF/
         a54enpPTnxkDc804+SpKXrLgxZ75fimdsKSyGFUYktoyTKsmOuGMSOprO/MMT3lQqnVr
         ylV9K004Bk5NM9HJREZxRM8dW+aq7ONA/aMcybExT6J7yiMVt1fdMSy8Hw1Bb3Wg+mXa
         BrAg==
X-Forwarded-Encrypted: i=1; AJvYcCV0m7VRuhQs4oOBFKQL6WzxxKxq90/EoFVP2Qe10dWvg87ecWIIJtq5rjshbZhlOZ3LgeIIbs0XhpP3haNNEI/+kPEpTRN97jhXD9Vjec7vi80BW0Cm
X-Gm-Message-State: AOJu0Yz+GNL+aq3oMXu0IAkYrWK6SsBcKo4bHbdq1fn9PmdESCov812P
	ahe6ZlJuhyXE2Nz44fYj/G6rjoy1a+jT9bs8ogEmPufjtNKHXioYjeMJG533rQ==
X-Google-Smtp-Source: AGHT+IEHX7VS98PVmPfQMP1A4xGFPH1JI0XcQyxGUfAbT5ZVpEx99l+bOBaCZ6HcNRkSZQoSe7xP0g==
X-Received: by 2002:a05:6a20:3941:b0:1a1:50d2:58d6 with SMTP id r1-20020a056a20394100b001a150d258d6mr1266291pzg.23.1709631795159;
        Tue, 05 Mar 2024 01:43:15 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d10-20020a170902ceca00b001db94dfc2b5sm10089983plg.107.2024.03.05.01.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 01:43:14 -0800 (PST)
Date: Tue, 5 Mar 2024 01:43:14 -0800
From: Kees Cook <keescook@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	shuah@kernel.org, linux-kselftest@vger.kernel.org, mic@digikod.net,
	linux-security-module@vger.kernel.org, jakub@cloudflare.com
Subject: Re: [PATCH v4 00/12] selftests: kselftest_harness: support using
 xfail
Message-ID: <202403050141.C8B1317C9@keescook>
References: <20240229005920.2407409-1-kuba@kernel.org>
 <05f7bf89-04a5-4b65-bf59-c19456aeb1f0@sirena.org.uk>
 <20240304150411.6a9bd50b@kernel.org>
 <202403041512.402C08D@keescook>
 <20240304153902.30cd2edd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240304153902.30cd2edd@kernel.org>

On Mon, Mar 04, 2024 at 03:39:02PM -0800, Jakub Kicinski wrote:
> On Mon, 4 Mar 2024 15:14:04 -0800 Kees Cook wrote:
> > > Ugh, I'm guessing vfork() "eats" the signal, IOW grandchild signals,
> > > child exits? vfork() and signals.. I'd rather leave to Kees || Mickael.  
> > 
> > Oh no, that does seem bad. Since Mickaël is also seeing weird issues,
> > can we drop the vfork changes for now?
> 
> Seems doable, but won't be a simple revert. "drop" means we'd need 
> to bring ->step back. More or less go back to v3.

I think we have to -- other CIs are now showing the most of seccomp
failing now. (And I can confirm this now -- I had only tested seccomp
on earlier versions of the series.)

-- 
Kees Cook
