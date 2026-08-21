Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13074C77B8
	for <linux-security-module@vger.kernel.org>; Fri, 21 Aug 2026 14:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787322726; cv=none; b=fFtUfLKAqe1n8o7oOBqgIkvHwv+gGkrapTfyUkxOuh4T1Xh0Kc1KDbqbMlOZklJZM38A4kIiHXtiTF7KVM85F6s1+cfUUKgmLmVGq5kfJOiYbDk8WSFQjii5Zscar2eLqQEm8QgiF/LnhIeh2dNAhUuz53h5QiRvILunS9TJk6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787322726; c=relaxed/simple;
	bh=DrZfMDLRTzk2UFTiQWUmac1FpzL/yMGaHEUgIZ1u0pE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OL41I2qJxydrRGSaqCySoGoc8Y/BBP0oRWa+COjVFTzi80kuU5zZ1rF8y4IfCBk7iIFQ/H5RitXtIvnfAZXsmoN1veSX1D4LssV7Fy0lUHuv86kF8US/CK7bfUnjXqOYtu8nPgBmePiOV+/J75aOC2uA6YRcwA4VwSAUv5ZzynQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=im+5H1/+; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="im+5H1/+"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-6688acd1a51so1745008d50.3
        for <linux-security-module@vger.kernel.org>; Fri, 21 Aug 2026 07:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787322712; x=1787927512; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KEQwtM0/L/H2ZNYGWj1jrSqhTDuXigyAxGdx+ch9XwU=;
        b=im+5H1/+xxm3KqD/mY/LTqlNBB4XW2Y+Yn3CtrTn/Hr+HJenHeLobUtDlacTH72Whb
         fbb01VwtvmVpHFkDQQZI0ycNZ6ujNQnNlnX4bud9N1WtGkjsMKLwela4HnisqczBCIGn
         sDyxciEEqzKBXgYwuvaVzooCxMzTcvM+N4d+BuO5gp1epKMkexpyAvt+7Y61NyPUX4Oi
         W/rIG/W2zDhCaq/AJN5jw+NKKUQnwW8mr3uy+TWWPlI+URYsCTZ4zQm2jz2+IIkuMAWS
         gBxf9ynTuLI6/eiAJgS//pEnmK9EV4hZZQDjB1pD1vDjJ74Vbeon27uqgXsZLgA35Dnl
         AAiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787322712; x=1787927512;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KEQwtM0/L/H2ZNYGWj1jrSqhTDuXigyAxGdx+ch9XwU=;
        b=lHvWDEZl8sXa8ZH+pnkro+LMR6F3tINumIWdHF6Ymu9THg401WeKC8Pdem2xyfuI+E
         f6hFGbn7JwtOIGW/1TttTM8kvEz9efepIQ/D9H8edB9v3az7uNPr7iCkDvdRNADtZ5XW
         2B65b/HhKvbgZgDljjiUbmcX7LeGNWXD0TiXST+JzHTjU2GYW2krtNf+53HpUgJk3VBS
         CCZ/OshnLaVhtHM+s+I8+UJk+ybFdc4+ydYUSWpzKgMQAhZ5zXQDV4hDP2LKlOukovIr
         u+1s6djZuvlrn2ys5yeBiwRxhRTdw44ZVGoiNBDQ29P0kt+1eS4oNaAJR3CTqbtOEPhE
         WYUA==
X-Forwarded-Encrypted: i=1; AHgh+RpwjO4wbTGZRdZ7jBaimwK01GA7oP5zI7XF05hIeLuuC5fNMUW+8o6qTV8VtDuiaMfolqhcpKxztFeFkTr9kYW58bxlioY=@vger.kernel.org
X-Gm-Message-State: AFuF++n9t+xQPMEjmwkGeoLb7DQtXatr7cWS+wLN/+eLr/GU2ocaVzI4
	z0MscJ1vUgSsHfvfarSN4uqXpAQBxnvGsKh6g4NEtujzQ3HcGsFc6y9s
X-Gm-Gg: AR+sD10fHtp3u5LkSWFewZuy/80+Ya9vRzBr4bt1BFZkhSO6xIDDV/1tyZKnx0fPSVN
	Jp81b8x7olcyykSJ6iRx1SlLCAzoqwF367KaVsRIOLrHM0aiUGzhhk05mPxgebGDQT/Nvj6XzSK
	V29ENZkd9a5lhI/TODttK8AEAcNHtxqTgHSc3Z8WvhN0ZcaR3hqqg76A+mNKN2Md4tCoTIIzohR
	/2d0eG9Z+7dKrRCuhZwCDGUVWl6GpavM7K+ytGQVdk5Sx30JJ3/rOuz99miofkdMOS0L33fzyy1
	zqewyyHa6bQiTpPBbjHEbYmbl15qiNiXpbb4zeMLun4AkkVhduMYvLnXqYgpRsJfqT8h166glhH
	iAjPa2K9/WkSE6+fty3dlyIk2kLpcirYJj75oMWBJFY+i4VttMXWtXry5PcpVgwa/H+Lf6F625p
	KjG2mxm1qFFDqc8jQC0+r9GJuXFDqF2PD2q5Q57sUEb0Xl560IMmzeuew/OOczcnheWIWmkf5Bv
	qFO/JFM3GBvbF38eOwq6w==
X-Received: by 2002:a53:c087:0:b0:66c:c7ec:27f5 with SMTP id 956f58d0204a3-66ce4b8b4e3mr1930264d50.54.1787322712556;
        Fri, 21 Aug 2026 07:31:52 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:350e:631:3b2c:9519])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66ccafcfe3esm4404567d50.2.2026.08.21.07.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 07:31:52 -0700 (PDT)
Date: Fri, 21 Aug 2026 10:31:51 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: mic@digikod.net, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 3/6] landlock: Bump ABI for
 LANDLOCK_SCOPE_SYSV_MSG_QUEUE
Message-ID: <aohfGjG15BUfOY7X@zenbox>
References: <20260727230833.138165-1-utilityemal77@gmail.com>
 <20260727230833.138165-4-utilityemal77@gmail.com>
 <20260821.ad614a879e61@gnoack.org>
 <aohKoD4GqIFR4ni4@zenbox>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aohKoD4GqIFR4ni4@zenbox>

On Fri, Aug 21, 2026 at 09:15:31AM -0400, Justin Suess wrote:
> On Fri, Aug 21, 2026 at 02:38:15PM +0200, Günther Noack wrote:
> > On Mon, Jul 27, 2026 at 07:08:30PM -0400, Justin Suess wrote:
> > > Bump the ABI version for Landlock SysV message queue scoping.
> > > 
> > > Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> > 
> > The ABI bump is normally put into the same commit as the
> > implementation for easier backporting. Otherwise, looks good.
> I'll squash them.
> 
> >
> Thanks,
> 
> I did wonder about if we need to use the landlock_object here?
> 
> I'm pretty sure SysV message queues stay open after process exit,
> which could cause the domain to be pinned by landlock_cred_security,
> if programs are lazy and don't close them.
> 
> So it probably needs to be a weak reference. 
> 
> But it's unclear what should be the behavior there when the domain
> is dropped:
> 
> 1. Should it become inaccessible and belong to *nobody's* domain?
> 
> (i.e when owning domain is dropped, the queue belongs to no domain and is inaccessible to
> all LANDLOCK_SCOPE_SYSV_MSG_QUEUE scoped domains)
> 
> 2. Should it be moved to the parent's domain?
> 
> (i.e when owning domain is dropped, the parent domain is the new scope,
> and then it's parent, so on and so forth, more complicated, but more correct)
> 
> 3. Or be kept as is.
> 
> (i.e Allow an open sysv message queue to pin a domain
> for it's lifetime)
>
Scratch all of this, I think it's best if the kern_ipc_blob takes a reference to
the landlock_hierarchy plus a depth u16.

I think this will require introducing a new
landlock_put_hierarchy_deferred method because of the runtime context of
the ipc hooks, but should be pretty easy.

Also refactor domain_is_scoped() to take the server side as (hierarchy, depth).

Justin
> Either way this almost certainly needs to be rebased since it's been
> a little bit and there were significant refactorings of the domain and
> ruleset structures since the tracepoints series.
> 
> Justin
> 
> > –Günther
