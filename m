Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807C03451BD
	for <linux-security-module@vger.kernel.org>; Fri,  6 Feb 2026 07:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770364183; cv=none; b=K2NqrqqbPbldTmd8AEOu0bpWj8kYJdiZ24BBK7QZXvFUuNvOjyjk+6YK3KWEgF2yuXIwA+Uxzxn9ZSI/pqRI0Ve3O67eyMff2AZ1eqxPc7RsD5tqR7qj7ulFVi6l8VzeBo/SzZ0YtLbeJSX7wRdI8/fSmRSgkr+tbWRmDDMzMzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770364183; c=relaxed/simple;
	bh=ichyTyguPgigBiw1zt6Jd1uaxfKj28WdJ/QrgAACPeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mFdv5d3jIGnXc6atSW6cwuvRPOANTc1SVYi5fyBh5c6w6tpelGn9NV92SLKDvovUYX8+CjrHt3z3+VtUp2W0czWqa4JMD9x9G9U8+dz5rWaKnwd1OopdQkGCALZvQe02GDfaUxdEcJsN5ejwQx7CfCdBe6FdqggOzHLyhLe3VpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UxHRsF6I; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UxHRsF6I"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4806b43beb6so3790625e9.3
        for <linux-security-module@vger.kernel.org>; Thu, 05 Feb 2026 23:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770364182; x=1770968982; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I7F/ZeL0mxRV2y1m2mFdPul2p2bxP7mRx3qr6IIzHbE=;
        b=UxHRsF6IrNLBIBr/KTHE3jIMmIMyjUp/LHv5Ncinh6wUqYnl3Em1gaTfafHm95zHWn
         EjmIpGvPS8RWhBmELoTmdPlBXC2+LeJD9YmQ62W9AA40XJcnOcII8JqVZM8K9HWbg0DP
         bnk2tWmHbQ4VF37OlowUYsWGswr8xk2fiBzT4WmVwAsA1zEM9BljXc8Ua9pSYjb8LtrW
         eGTwosjAN4Etn68zS+LLEnix+D+pdVIv6TmSvkATO7iI3k02Hgqai10e52n24XGjrcTt
         rrAzJwWT7K9YUxKiL8ZI0cx3u9oUT7SXE8XrHnnDeaBNo06KG3HoCoP5mcaYstvcvICK
         dJSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770364182; x=1770968982;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I7F/ZeL0mxRV2y1m2mFdPul2p2bxP7mRx3qr6IIzHbE=;
        b=qv6LpGRzPkMW+lsK4ncbhXtUM7gHAY9prZwCsQ24IKY3YoSy/q1SQPTd1uoDearhb9
         0ZQXprOB6QOhecE9dJ1sos3TepWMRAIcv9OfG//xxD79gyuvQE491qd1j7znS5qO0bF2
         Zil0Bck2ehw+G8X9BuBNdPv3f7w8BZcr4UOxR2VCZHg4p6RQZ7dR09bCNgQkYpYZ5yj4
         A999n+mFz4b7ziOfVNv/VLYHP3tk6OGiH1LYJnNJE29RBLWR7O+2sG7m3hSVxG/pOR5F
         kQdeZOBfQT+dDZZGTaeIW1hy3gYp/YYuDmgnqVqLkE45lqkI1JBwstA36b+t/Qs1EDEQ
         83RA==
X-Gm-Message-State: AOJu0YxA2Rgv5ehFRbS/obdmC52uhL788/KI+nOCk9vm80jRyI3OAk2q
	5TVhoqCQUgfvDKUYw4KduBRKTUvnJNkNC+KC7asaFSzfjtmDPBZV14M4
X-Gm-Gg: AZuq6aK9t4KAds0eou+CdqVn2rpt1BOiDNnjMr8P7fohm8tEzFiCsjEL/fVhmATeWY+
	4FrIfiGaGhbE4SdSZ5LhqUrJ9bmrxN8nNIH475/GB+l+hCt6ejIJb4PZbnZSYfMzpCmsH3t0Rfe
	BWKUYhtKO1KeCaR+rx7qt/z5qGX0c9yF8BhJchF6gJe6nE1lQfBOSePrsW7geb01NvlC3fE5gdv
	Ge6ZBmr8+opSgPuCdIH0dWm/4SjkMoEaCInRHUMVmjEPAn9A7jW0cMHsPF+haY/Az9J7Ox/cXVe
	l1bvgLYOAs0n3hQComU6iipbaEm84rG0RNVpknBoCVFRahJnnK1Q0JZAczTvyvxjNtxfy+OQ+Ig
	NFh3fsJAOskcdCICGHuSTGrWGRjQzaSYMZ6eHHQoK5tBPlyI8e7cWDuYxemamvlYu7HFuSKdVD7
	sT4bcDr8+h7YL6ZE1BosF/KBgdFUwWSPo041+f
X-Received: by 2002:a05:600c:8b26:b0:46e:59bd:f7d3 with SMTP id 5b1f17b1804b1-48320216165mr22318155e9.20.1770364181655;
        Thu, 05 Feb 2026 23:49:41 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483209cfd77sm12041745e9.14.2026.02.05.23.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 23:49:41 -0800 (PST)
Date: Fri, 6 Feb 2026 08:49:39 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>,
	Justin Suess <utilityemal77@gmail.com>,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 0/3] landlock: Refactor layer masks
Message-ID: <20260206.a8bf33606ef0@gnoack.org>
References: <20260125195853.109967-1-gnoack3000@gmail.com>
 <20260128.jiethoh2Zeem@digikod.net>
 <20260206.9509420815f5@gnoack.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260206.9509420815f5@gnoack.org>

On Fri, Feb 06, 2026 at 08:32:06AM +0100, Günther Noack wrote:
> On Wed, Jan 28, 2026 at 10:31:07PM +0100, Mickaël Salaün wrote:
> > On Sun, Jan 25, 2026 at 08:58:50PM +0100, Günther Noack wrote:
> > > P.S.: I am open to suggestions on what the "layer masks" variables
> > > should be called, because the name "layer masks" might be less
> > > appropriate after this change.  I have not fixed up the name
> > > everywhere because fixing up the code took priority for now.
> > 
> > Could you please clarify your thoughts and explain why this name might
> > not be appropriate anymore?  Any list of name proposals?
> > 
> > If we rename the variables, this should be done in the same refactoring
> > patch.
> 
> When this was an array of layer_mask_t, the name layer_masks was a
> description of that underlying data type.  Now that we have removed
> the layer_mask_t datatype, it is not as obviously true any more.
> 
> When trying to name these variables after the "role" that they have in
> their declaration context, I think of them as "unfulfilled per-layer
> access requests", but that strikes me as a bit long.
> 
> For the upcoming patch set, I'm leaning towards naming these variables
> just "masks", to keep it short.

OK, staring at the code a bit longer, I realize that since the type is
now named "struct layer_access_masks", "layer_masks" is actually still
a reasonable shorthand.  I have abbreviated that to "masks" in some
places where it is anyway clear from the context that those are the
layer access masks, but left it as "layer_masks" in places where we
also use other access masks, for disambiguation.

–Günther
