Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC657347505
	for <linux-security-module@vger.kernel.org>; Tue,  7 Apr 2026 19:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775588490; cv=none; b=mdNGK8Zf4C5ny6GzDMCzGi1yAUhDtU1R3JgIjGzoKzQ9pTPV7LQLrRyvEG59oOyZsGimGNB6/FRmGMF6w1br2/GiDHhqney9HTXEqah90+tNjiHqQWukGwEJeHQyaJgdjyn2ofVvN2pvW8YvrEom2KE1TGOc8k68U9b7uCJ6NVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775588490; c=relaxed/simple;
	bh=f3RFse77VTR9oCyHNOxlB9ANhwaYZmNeSiWpj5Qt2t0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBPz0OIVv4ovnDWl+M9nZob62ndsyx6JVOQnYbSM03qMG4r0bEuROsopoA6EG/naFoMaO1GEQEoe36PbhzaGrghuOAFnpR3Fe/ofI6kk+r/KIp1SoQ43uh1zdVzNJFIjGE2IqxLIHtZo9ucPlWg2iR34AZ1iuMVl5+RFr1Td61E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d7AeZ+2K; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7AeZ+2K"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488c2690057so7414605e9.0
        for <linux-security-module@vger.kernel.org>; Tue, 07 Apr 2026 12:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775588465; x=1776193265; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EybpI27ykLBReoqVN3CBYIMg5L15qes55puRafaysjo=;
        b=d7AeZ+2KM7hXd1pCEyEEhgk2OkjoKGL95cKvi5UeJucG9Bi5Auqk47jPOSPLGoo4v7
         vaJsZ0Yaufd34eUjAu0SG5yW6vg1DaS4IceR38XwIH8ETvr6lXkfrrnj1rqJAfsj7yJK
         goJDqjVX3jMZVvz0mkQ5VYYT39I53FLaksWd1k/SKn1ZU7B+S6fazOMkzHOeMhPfkmNb
         dwAP7AzDeCj2B7C6T3xXOPB+/UAjDzEuo34iwUFbAYDwqKVsr8a4JhsUo56vXJxcLkmF
         jxrMKduqzkOt4HVfiy3KqChF9U9pGYW0NdUBU0pc4xXzn6MK0kcxdy/G3GvdkJsmoWX/
         CLxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775588465; x=1776193265;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EybpI27ykLBReoqVN3CBYIMg5L15qes55puRafaysjo=;
        b=cGrpFYO91zOzCL9YNcLXY7Cymmww7jjM5rMjk8CMgZGFiITZibrBEq20BsJfAQE210
         z96bqvt+UOg1yBRM1zrw4c7Et1wsZc4pxPj87o3LRQV2Dpmtp6wgk1O7p251JQ+Ymh0b
         N+8LcQunmdjKbJjg5ifaOAN5U/vJV77rLRJKUf5+fHSC46uVRuML3tTM5cqTBOh01yak
         zeH47iJfYCHEInJD6lo4RItdBfGmNV9sCMPuFf5qvHXxOXn/cRlf6Nl0IZ+RhM/3z0Sz
         6hs5n6Xs35yl58J+bswKF07/sGjMgFPQHSgFWkz5+lcAgx/fA8ipjkdbiFEng8tkKRfa
         b4Zg==
X-Forwarded-Encrypted: i=1; AJvYcCWgE5a2vVBhVgMi2R5IcIKdN31xx/kXSLS080bt+A1+892ecAkVmhv0uNfcAXmCkS37z5+Apv0bpdWGu0tNNdD+ooqpMp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSq9UaIzJFGLeLhbyeYXrKTBQf0Oglmca62pPalu6vHNen6aC3
	8mCYZ+a6eaIU+3W6KvWd9ncSHq0XGWUrE5rSYu56A7SRrSVGcCpE6rYg
X-Gm-Gg: AeBDievOTOhPGL0k/SJZ66Y1cCILLO36GePMaPJLqDmVXh7kqEBqSkONF+4UpoBZT6+
	TkWQIFoR2Gf8PVIh/ekp8x8Lr08AzJOilWhCDGrVdlsNQtOFGLMXdBj7LdWGUs+umcMKwwe1VQR
	bsFzJqpnEf/K1XGlga8lQfu5Izq4N8FDXS0cDABr5vMY2+9QbJmcbaZ4dvK/KDwYkoyd5NeiJ93
	jyFaodVBSPbS3cCOGXDjNiUow1sFrDtUKFJf4XkFgv/C8tTod/EwGbQdPZlJ+eyu5+INPhl7SiY
	7FBwsw12qtLZVMtf4yLYCq1gLJAnplyKVvK7wBbeBGLNkbC2lcVUAPcdcKbJ87TBOkgftYfEYRX
	GOut+xB/ywjags3i02KsiWMkWbrO63gP7XVLg0h7cOMtf3IFK3eRIXCzug5TJ8r0Xw5PM7m3NvI
	TnuWUx+oG9A6H+5dOj5D9FjRBQmKhlz7W14iZX9aX8nNgW9M7k
X-Received: by 2002:a05:600c:64cd:b0:487:1fbf:e0bb with SMTP id 5b1f17b1804b1-488996a1c9dmr266783785e9.6.1775588464881;
        Tue, 07 Apr 2026 12:01:04 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488c5dac41fsm256275e9.21.2026.04.07.12.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 12:01:04 -0700 (PDT)
Date: Tue, 7 Apr 2026 21:00:55 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Jann Horn <jannh@google.com>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	linux-security-module@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v1 1/2] landlock: Fix log_subdomains_off inheritance
 across fork()
Message-ID: <20260407.895b3256373d@gnoack.org>
References: <20260404085001.1604405-1-mic@digikod.net>
 <20260407.844e42deb531@gnoack.org>
 <20260407.wuaqueid3Pai@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260407.wuaqueid3Pai@digikod.net>

On Tue, Apr 07, 2026 at 06:03:58PM +0200, Mickaël Salaün wrote:
> On Tue, Apr 07, 2026 at 09:30:40AM +0200, Günther Noack wrote:
> > On Sat, Apr 04, 2026 at 10:49:57AM +0200, Mickaël Salaün wrote:
> > > --- a/security/landlock/cred.c
> > > +++ b/security/landlock/cred.c
> > > @@ -22,10 +22,8 @@ static void hook_cred_transfer(struct cred *const new,
> > >  	const struct landlock_cred_security *const old_llcred =
> > >  		landlock_cred(old);
> > >  
> > > -	if (old_llcred->domain) {
> > > -		landlock_get_ruleset(old_llcred->domain);
> > > -		*landlock_cred(new) = *old_llcred;
> > > -	}
> > > +	landlock_get_ruleset(old_llcred->domain);
> > > +	*landlock_cred(new) = *old_llcred;
> > 
> > This fix looks correct for the hook_cred_prepare() case (and of
> > course, hook_cred_prepare() calls hook_cred_transfer() in Landlock).
> > 
> > 
> > But I'm afraid I might have spotted another issue here:
> > 
> > If I look at the code in security/keys/process_keys.c, where
> > security_tranfer_creds() is called, the "old" object is actually
> > already initialized, and if we are not checking for that, I think we
> > are leaking memory.
> 
> old is only a partially initialized credential, and the Landlock
> part is not set yet, which is the goal of hook_transfer_creds(), so
> there is no leak.

Ah, you are right.  I think we might have mixed up the names "old" and
"new" in the discussion briefly, but it's still correct - the target
credential is only partially populated and its Landlock domain is not
set, so we don't need to call landlock_put_ruleset() on it.


> > I would suggest to use the helper landlock_cred_copy() from cred.h for
> 
> This is not required but if we would like to do it anyway, that would
> not be backportable and would introduce a (minimal) performance penalty.

Fair enough, the backportability is a reasonable argument.


> > Test looks fine.
> > 
> > While I do still think we should investigate the memory leak, this
> > commit is, as it is, already a strict improvement over what we had
> > before, so:
> > 
> > Reviewed-by: Günther Noack <gnoack3000@gmail.com>
> 
> I'll keep your tag if this patch is ok with you as-is.

Yes, absolutely.

–Günther
