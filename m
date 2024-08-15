Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D941B29A9
	for <linux-security-module@vger.kernel.org>; Thu, 15 Aug 2024 16:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723738304; cv=none; b=skUCI4iViCWVytv3VC1Fbc6zB1009I58NWKDr3FNk0VHF/VahwBcgY/5NUoMLZvwOljHmUjwbQiER8LHV3waiu5AnlSMiJ3ASWJ7JV7wgNaCmuXFHiUdnyEWAc2UoOAIAktea681bX0bOmpGKEmcdjo/qzx9zoEaZOch20zI96g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723738304; c=relaxed/simple;
	bh=stmfQPjThOY5JY5xeIkuajVC8TaX1REhTG6g4I0TuS4=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=sS+qQ1d+ptRVufKOu5FLxbMaUUXu4FOYNKDn6U+vPS9eICjwcOxaTEjxJinWd3H2iuMxJxWU9cbIAu0UuWceWslpn8MILQpJBxdu8ZaZiJldHnPpe96///qT9EiiJ8r8zRYZq8npb4sf+6O30RfpEj3mle9gSQK3M8q+OwpPzJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=I3YFT+mM; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="I3YFT+mM"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6b7b349a98aso6563586d6.3
        for <linux-security-module@vger.kernel.org>; Thu, 15 Aug 2024 09:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1723738302; x=1724343102; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UJMlTsl69w1myQg1uCFGfwb6Hmq9ET+WkI++9CZ+3Gk=;
        b=I3YFT+mM/WAviM/75hFTw3+CbMcp/jt5bOuBP0X0ETsyTU48gossRdfpvQ0w1DH5zC
         HGxKw3Pyycm1z82bnrs7q+TGy9PaB9Aa1lLJWFiQO3mzjO39DnXwFRqU90CDh+EhOKvw
         9yNT+E1xloCTEDNv41KqisvyoQkk/nbxl42Xgiz7sP2uLPh4wDq0y1d2bWhRUqqqoHl5
         NgiJHsY+aaeybwetIAIPqaV1Hv920J9MPb1G19BlZqa2On6pLQX+WzVx/L1hMc7WSfWE
         ha2O7g42KZWUaed6gOV0cYGBC6je5eCmAaDHT4kppFmoWG0vKxgEPv+bQTaJxK1Rkun0
         ga4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723738302; x=1724343102;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UJMlTsl69w1myQg1uCFGfwb6Hmq9ET+WkI++9CZ+3Gk=;
        b=ooZI1okXpw8Pz14xdQ57wG3fUaN+j0YjHf47O/L37dQcOTyPK4027o/OggwjqGHZyE
         hT9WUBln+19pEUFIDoXdgokTsDQFkcoPj1FF8qMSQhnmVQd6eWeciDavP9TEZ2GwmPcM
         iBjAk19/6aNpyVT7eBqRyzZR/GJdvMT1xM6wG+IQXXBRc3/4TT6iBdXR+XCX2Yp+YUo1
         iHjDdoACu6C8RWyoneHgCt7+It5xo/UpbjmYg5YhXvo0b9VSf+saVwO6XGkCzebnBYNh
         LScQWraJZErkiRxznqDBpR+TJobzeF3o96jn0co+mIWbXxrCwE96bVM9XjYfS4gUU2fe
         0tzA==
X-Gm-Message-State: AOJu0YyRrUhtBkYnOoM7Irgo+mGgqnK4sgz02qk6MD/bc9weFfIonwva
	2dpHXazzXwm/ZV+jLaBlPY73pw3uKBv9jD8Ocsm7q898vDSM9k4M29df7bz+tw==
X-Google-Smtp-Source: AGHT+IHQ1oOJcKiCksF01aDFCB2y7+5wp5A5LBl+qgAXT7t5DQc/XTTEcSo/ahqIW74tm7SnPGG2NA==
X-Received: by 2002:a05:6214:5989:b0:6bd:7f27:3565 with SMTP id 6a1803df08f44-6bf5d1c5053mr81869636d6.6.1723738301725;
        Thu, 15 Aug 2024 09:11:41 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fdd9c7esm7568686d6.4.2024.08.15.09.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 09:11:41 -0700 (PDT)
Date: Thu, 15 Aug 2024 12:11:40 -0400
Message-ID: <bfc25c139caf8eacc02973b94ac05030@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Yue Haibing <yuehaibing@huawei.com>, <jmorris@namei.org>, <serge@hallyn.com>, <kees@kernel.org>, <casey@schaufler-ca.com>
Cc: <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <yuehaibing@huawei.com>
Subject: Re: [PATCH] lockdown: Make lockdown_lsmid static
References: <20240814033004.2216000-1-yuehaibing@huawei.com>
In-Reply-To: <20240814033004.2216000-1-yuehaibing@huawei.com>

On Aug 13, 2024 Yue Haibing <yuehaibing@huawei.com> wrote:
> 
> Fix sparse warning:
> 
> security/lockdown/lockdown.c:79:21: warning:
>  symbol 'lockdown_lsmid' was not declared. Should it be static?
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> Reviewed-by: Kees Cook <kees@kernel.org>
> ---
>  security/lockdown/lockdown.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged into lsm/dev, thanks!

--
paul-moore.com
