Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3A234C81E
	for <linux-security-module@vger.kernel.org>; Mon, 26 Jan 2026 16:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769446099; cv=none; b=u50RszUdwehP2nb5PO2qyEuh7Nvdlzl83JFOCXDVEfxOhUFk2ejFYYFfsqQnxi0ePd9LgYMNzvze3o08TwAGep3yhUhzvnGAnsmzUuxsbhGhVF3wj9V/K8XacXc7AduunmdjBf7kBqcn+LK07FyBumzMU/a++6nBPi0ynEUkztg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769446099; c=relaxed/simple;
	bh=aVXgtoo+JZ9O12OCD2CmcAFG+xEmzvyr7zrwMToRZsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OvxXKLQxeFqWo/UoStxO5xm3BiQAyVE0458hapYkwL5rv6aprflIa2TQBle1MJ1uB7JPe94UptK/boWsG4G8+h+mwUvFZDdMwrKDqpcvTlX2QDVT9y2zQjFcKJ4p7/H7CNbbH/gomnqQe0cLZHs7ZMJuXfVk2d7MT5yKMwA2jFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fUDzrEz6; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fUDzrEz6"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4359a316d89so3513988f8f.0
        for <linux-security-module@vger.kernel.org>; Mon, 26 Jan 2026 08:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769446093; x=1770050893; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ic8LZXJHvKWGWwVSyOG+EIVzeJOXXXVGTMKwIbQ5qhs=;
        b=fUDzrEz6eEkqO8JjwtnyKnBF42IBysdgkBbdRY7kK4aS2lrT9APywEXY6W/Yi6gGgP
         dUZEdSDjI6nwjbVSGMALIjwmJ3QSSGksuzxnZsCQkZeJFqvXpNRSxrCl4TcQSinqYn5X
         XX3phEQigBJDXN4VIP9xCio//6WR7jo2EyLdv9WR+XO4c7dY/OxYg+EfFs6Yni3uQd1E
         slwFpbV+lFl+roNdUeY9I2hlVlXhruZZx1fgcxOB5gHRDafp1FjT4t6Qa18jsj6C8v6D
         wbhKXN69+xQGULp76UH2ItTosSWO1vptPlbGRYVBUxYUSTNEKluU9XfyDsyHvjyiv4pU
         anQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769446093; x=1770050893;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ic8LZXJHvKWGWwVSyOG+EIVzeJOXXXVGTMKwIbQ5qhs=;
        b=pG13oHP3rMWBcP54sYTJ2eXnQ/tIqdMKOIKx2LtK3gv1KU2u5MMMPWgg+fLyd2A3LT
         Q1kI90Cb3gypmn9hB6edGSHQAC9oKrzyFYXhApEm+WHLzfuvjNPb+BraNxHrijKIlax+
         5vOCc5MEJ0qLTMIK3CWLYqxPALSUfOxPidKrePptVWqhgYmZjbXkuyqI93sWgC7yl69q
         zEE1qzACxEezkMEoX32ZZduQLjhgKIE3DP/S5qgBEeVbUdWkSBXmjd8B2pvjlO+fIp+n
         vtHtqFBAsCe0QHIUSoU2daMwCNgZfhHJQsEKQTPld5mKSpBPVCNIvt+3Pu1m4oWDaGOp
         PRAg==
X-Forwarded-Encrypted: i=1; AJvYcCW9F1pGgzWxeQttooq+H9lrIo94gUPAB1O+OaKL/Ot/M/DmypeBDzybGPpbC0t7yeJvBk4gjjZi8t7kuM7ifJ/ULOdZU7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEhLamfB9rbhCjRKTPSMESJRMskuQ2vqu3d8BCpEB91aKMBxGi
	0Rh5DygEUvYfBl9CK0SNk2FQCqYydKW9tNM/J8+MR8kWhH0EB8rRgDiW
X-Gm-Gg: AZuq6aLX3Qtx97yKNLgIcCOOXWdVL+Gqvr39Bwsqhcfnp75n1pfQaAut4Tc3XRV37IR
	LBh9CuyhCn9jROJj2JnlsivBfozSQ6/9ZDUbFm7YDx1lfbv9UhDlZrMzdb4WB58LOen7/Mgu707
	RxjEQ4z+8aZ+v7dzuTo9AkMUU16tihXDI6/hx4qqcuWQaK4bSYUurYhWkCyzy/xmtRkTFQftN5z
	dEtiTNE8mf8kZRaJORabONKrYfD720OFl/5ywtP2JReF9fAllmgI2Zjd4VpYHo6syzLq+a6u9vv
	MNPUtM6mxFlgZ5E8ZSFDNfltmX36TDSXm6YmaG2FxEhJfgbnc7FZ1+KmiTw2X6uDEJ22mfm5IXI
	ICh4ry0B0hsEqg37Wf6x0OriEZWm/CYVgk/oU8RfZGzzjQyZ9JE/nMAOle0vmQxhlQOlpvsNiEt
	mk3snTgZd5y1gOJHtSeXD5+JqNY/qxS9rCrPg9
X-Received: by 2002:a05:6000:2086:b0:431:907:f324 with SMTP id ffacd0b85a97d-435ca156496mr7939966f8f.61.1769446092544;
        Mon, 26 Jan 2026 08:48:12 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1f7b41asm33183157f8f.39.2026.01.26.08.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 08:48:12 -0800 (PST)
Date: Mon, 26 Jan 2026 17:48:07 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>,
	Justin Suess <utilityemal77@gmail.com>,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com
Subject: Re: [PATCH v2 2/3] landlock: access_mask_subset() helper
Message-ID: <20260126.6a26ddb1e32b@gnoack.org>
References: <20260125195853.109967-1-gnoack3000@gmail.com>
 <20260125195853.109967-3-gnoack3000@gmail.com>
 <d9bc1018-82ee-43fd-8a02-097bb54190ee@infradead.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d9bc1018-82ee-43fd-8a02-097bb54190ee@infradead.org>

On Sun, Jan 25, 2026 at 01:48:52PM -0800, Randy Dunlap wrote:
> Hi,
> 
> On 1/25/26 11:58 AM, Günther Noack wrote:
> > diff --git a/security/landlock/access.h b/security/landlock/access.h
> > index 7961c6630a2d..5c0caef9eaf6 100644
> > --- a/security/landlock/access.h
> > +++ b/security/landlock/access.h
> > @@ -97,4 +97,10 @@ landlock_upgrade_handled_access_masks(struct access_masks access_masks)
> >  	return access_masks;
> >  }
> >  
> > +/** access_mask_subset - true iff a has a subset of the bits of b. */
> > +static inline bool access_mask_subset(access_mask_t a, access_mask_t b)
> > +{
> > +	return (a | b) == b;
> > +}
> 
> Don't use "/**" for comments that are not in kernel-doc format.
> This function doesn't need kernel-doc comments, so just use "/*"
> here, please.

Thanks for the correction, will be fixed for next revision. :)

–Günther
