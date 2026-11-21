Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795224212;
	b=hiWj2Qbm+EztU1XklnWGxjdo9fmsmAbYkCGbBDbINHJyIH7gaTk+FR9n29LvoNJ/6NJP
	 hkusP1F4Lw0eBIIowWOcyPfiYm7R0Xe/3IyCw16dn0mVVLomBmXiZQzpR8CEPk0+vj7lb
	 xfybSbEeczxg35I81rk4P2YftSdXrl/RCWeBP7ayBfxB8j/NyK5ds4uUtXhlUjGOKVHgr
	 U1+eg5DcV9E1WakjlFRTB8Vze7arYUueeHJidjXJsN5MGLDAd2U1NyxHHWmobone0z6Q0
	 ZllaK/AAkc28TxvMa4fSjI7aQNr8UQ5pynSjAfnpP8HFo0pNlHpgdxwPvPBvffODR2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795224212;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:From:To:Cc:Subject:References:In-Reply-To;
	bh=C/s9wcJ+8gC3Nb5xrepSAAC9C96LJN04eXTPT7Jkc7c=;
	b=QIHx1mTN8QmhogmmF3LjuxTGkPpGrwvFyWEhDApDzxvL22imsPv/a1+qgF4vedn4mpYr
	 TdYSVrrQeu2x7B9H26wnlhlTX962YfwWqxJg+6DSAjJ+OhV1nFE7wRWnyqZaZTIogWvbs
	 Xy5c7M8soOLkpPWmfMuOvnrozSorX5z1tCd+ZUXSM6nNAqyoJOBKdOnQTXMwUTFqTs0hN
	 HpWlqujgSPDS5JyxlxqPm9s/yErPtKGoH916GZgvKeKbV2PEPzd7RvQdrjTv1fxSr2Nh6
	 u3sRgR9yvr3T0RSCWJ9/O91VSA7pasRAt3GnUuVnNyiXFNwr9beeNqieeo8yJHNDsnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=TjfjEOc0;
	arc=none smtp.remote-ip=209.85.219.50
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D43E606A6A4
	for <linux-security-module@vger.kernel.org>; Sat, 21 Nov 2026 01:23:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D43E606A6A4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=TjfjEOc0
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-921276742e3so14144906d6.2
        for <linux-security-module@vger.kernel.org>; Fri, 20 Nov 2026 17:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1795224209; x=1795829009; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C/s9wcJ+8gC3Nb5xrepSAAC9C96LJN04eXTPT7Jkc7c=;
        b=TjfjEOc0aofEpvFrY7KXYL11LNUhWl2DuCcRBIpqPGojBhPT7K/iBi8R6H+e+xS5+U
         57JpMW+1HxZDQx9vcDxyE0znqBVsyOswu+Nra4t6TUITj3wR6bWHE/jeo2co37BZxlIP
         1BXoCxCjAMAHG25xHYIYt6r0mV97y3xmE+8jHSGQZtj2vGWciLZvIh/5WYMSV6DlC8XO
         fom8Ib+tTQ6nUOrPGhtqzAebhHP0ViJt/NmIUhcveERdwSJJ8JDC3m4qDyCsJLHJs0lD
         N6kNDNnWFpe/3P5/pieXrSxcxTjb/5fVQg+xguXEo8mdMDKIymt3Fz9bW7rmvNR2Zh8X
         7x5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795224209; x=1795829009;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C/s9wcJ+8gC3Nb5xrepSAAC9C96LJN04eXTPT7Jkc7c=;
        b=FbReHUz7g7VELGTYOBsgn92wAyNBnfYfasDR1a1ANBCHe+0OHw1H/rIqLjRKcGxWf0
         Nr5ySziafILsDiT5F9T4ax/+ptz1zNCitjzqZsOWMtjX/KLr7r3q4sQ0aaZ84EqomYdr
         ZL/vKlFejTTad/ABt3e7Mkcn8/Xvr86K1c70Bs1cZG46dXP2HHB1+myAuSKcPQEX/TDL
         wj+0KO4ibxWziALXcaFuyAC3B2NEyh8oeaDajUEKOo9pmeyR96SoupbM1/LvJ2/kH7QI
         DfpO9DoVqQUTsIaUVuT3unLDPfktlN8eLQLvNOvRY8Hr7OBBvSjM9KMVLbyi8QvMRMQg
         nK2w==
X-Forwarded-Encrypted: i=1; AL+hErEVoqq6+JFTUhG4O+PbYaTZD03yUkJ/Q7pMtbzFrsEoGMVgykYcvPLpymOj+yvAfJrJALPW8bVriwxDDlIhs8VD16cmybg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8AVkcaI2K5jB20Rqr01F3kvppNZy1wZ2cOfgoj2p/NpWotzXey
	6aLn4tIQT2JraeCn11FGAkptaAPqDVdkVemfjNLt68q9kYfqb4yCXzAR9B1pedWbaA==
X-Gm-Gg: AZFdTZfd96TZLbP2NVHXCnr9+YNTd/hObCwj25Owf50+/VVu8Md9cDI84sS2eb7zepu
	HA074ND9KGt/Z1u5bG6cVpYgwfwG5XMecGBjTe60vZE29N36fF856iBTHjBQfqpxCBzwZLbpRF0
	Iq8SdrSQ8L5RXfUfwTKX2SBax/4GTrCeDqrneY852+3aVxvMKetn77Vo5uLLbLJiDYtnrGh5lkS
	ugh1uFuJg/oi/j/Vd/YNeT6kLWyAINJKDn6f+fYQbNtiTlg45HdEg1f0UwaPoZnFENvaBbsBmp6
	okMHer8uX5/nGfouno64RFQHsCvw93Swt0l3f+7A7WAFgzjuat6hSS3tTjzHay1s8w2a0zTV6xf
	Tz+YLR91H0hgcpGgHhOdix3raqXM2L1NfR+92MuNdECvTLZB0qwg5mnK20qBsF77Wen8KV83iiO
	ZfZMkZOabJtTP0jB60xljBbgzJuNQwbLH7OoMTKiUXNPKD7STsLGM7CioBaPrtm8hg2xjG9vFFk
	5mc25rWKk2uNlT2FJWJucMCin37Zt8p25pd1yJMPcWrBi2RrSjLJLnQ6vzutqRaGSwCEjG7YSjZ
	NVoEYgNefIRK4WO3BH52oE7AsjjqpgMLf5fWvlHQmx6IomstQdE22A66yTKQy4QbK3hXIO7QSOs
	x/t9JeUnT9pkDf1o9VwSDrL3ESPCFHQ==
X-Received: by 2002:a05:6214:29e8:b0:91b:8b2b:5a0 with SMTP id 6a1803df08f44-92134a59f89mr82088546d6.23.1795224209503;
        Fri, 20 Nov 2026 17:23:29 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921347a0b6bsm40207456d6.1.2026.11.20.17.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 17:23:28 -0800 (PST)
Date: Fri, 20 Nov 2026 20:23:28 -0500
Message-ID: <7695c09e696343176f9d1e1c3a3f4105@paul-moore.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20261120_1711/pstg-lib:20261120_1707/pstg-pwork:20261120_1711
From: Paul Moore <paul@paul-moore.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, Miklos Szeredi <miklos@szeredi.hu>, linux-security-module@vger.kernel.org, linux-unionfs@vger.kernel.org, Stephen Smalley <stephen.smalley.work@gmail.com>, Vivek Goyal <vgoyal@redhat.com>, Christian Brauner <brauner@kernel.org>, Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] lsm: put the copy up creds when an LSM hook fails
References: <20261120073717.1588080-1-amir73il@gmail.com>
In-Reply-To: <20261120073717.1588080-1-amir73il@gmail.com>

On Nov 20, 2026 sashiko-bot@kernel.org wrote:
> 
> security_inode_copy_up() leaks a struct cred when one LSM allocates new
> creds for an overlayfs copy up and a later LSM then denies the copy up.
> One such pair is SELinux and a BPF LSM program that denies
> inode_copy_up. Enabling both LSMs and loading the program requires
> root. After that, each denied copy up leaks one struct cred, no matter
> which user triggers it.
> 
> The hook calls each enabled LSM in turn. SELinux or Smack allocates the
> creds and returns them through a pointer argument of the hook. A later
> LSM can still return an error, and the hook then returns that error with
> the creds still allocated. Its kernel-doc does not say that the caller
> owns them on error, and the only caller, overlayfs, does not put them.
> 
> Reproduced with SELinux and such a BPF LSM program: 36000 failed opens
> and chmods by an unprivileged user on an overlayfs mount left 36000
> struct cred objects allocated, which kmemleak reported.
> 
> Fix this by putting the creds in security_inode_copy_up() when the hook
> fails, so the caller gets either creds that it owns or none.
> 
> Fixes: d8ad8b496184 ("security, overlayfs: provide copy up security hook for unioned files")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Mason <mason@kernel.org>
> [amir: put the creds in security_inode_copy_up() instead of in overlayfs]
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
> Hi Paul,
> 
> Apologies for missed the LSM list and maintainers in first posting [1].
> Resending with proper Cc list.
> 
> I think this LSM hook was introduced with confusing contact for chained
> LSMs and this change makes the hook contract more sane in this case.
> 
> Thanks,
> Amir.
> 
> [1] https://lore.kernel.org/r/20261104082128.3573690-1-amir73il@gmail.com/
> 
>  security/security.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)

Thanks Amir, Chris - this looks good to me, I'm going to merge this into
lsm/stable-7.4 and I'll send it up to Linus after it has had a few days
in linux-next.

--
paul-moore.com
