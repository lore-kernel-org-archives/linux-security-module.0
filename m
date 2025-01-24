Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759CE1BFE10;
	Fri, 24 Jan 2025 21:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737752525; cv=none; b=TDXc7tuz5wqJYon8xS5giNuxpk17jZw6K/0HgwSEFCYnYCXS0UFp7+vwx5bVn1PvyAl0EfSLTiOyvg+KHrVf85bF+lrZp49yMyvlbwaY7ZiSOiB2CaO7fikIvf01hmSsfgt6R3SS23MC+m58SpJsX+4+VPc5ZZFx0C48pqhuqkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737752525; c=relaxed/simple;
	bh=tZNRU8KJwodrpmDlffh9iH/IX2dkBicg8hHlupZ2MGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UppRojRbnpjM0Y9feOCKymW1tmTHQHYPiALAVXhWzxwbqnGEBklVhU3zlcKD6xc2NBpARMCiN5abZRO48WlyARnCq/d/PFT0qnl9SbYO0BHv4yauQCqyPntEXmQUwIAwwDqUWDEbsY2CnXReNw13rQZZsWV0F/wT82OAxgpgLUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U5j5Z5WE; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5j5Z5WE"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ef8c012913so3610856a91.3;
        Fri, 24 Jan 2025 13:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737752523; x=1738357323; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vl/7RHmlJOr2tZEOpWiSD3B3yqWlSgOvTUSx/EiYt0Y=;
        b=U5j5Z5WEbKQ5luqdvIZ4Xdf/L0MQ/i8deMBRHRyUxHJrkN9lDBLxa2WfyZwZjstaRV
         /OuX+93rvDrCw3R1tGRXNTTw0rMdeQEnR00MW24xwWxSyDQ8U8dtP4iYOqeNgGg7fOGC
         sEkp21UoqlORvyW5ggZKscWAXMaTtQtAF6jytbdgFaZXPA2GgPSOXrl49T88TOxJWRKo
         imsuwL1JwOzDCmqVKLQCX2snnwUC13iRL22OhmvpbAQfa1DCABcOYSaFFHRuJ11snS7i
         RYyfGzeCKHSPV2qwlBApADXXVw4ndP97ZIv/OIrD7oBi3GgmWYTWhN250jsJc1/D/lxY
         xRug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737752523; x=1738357323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vl/7RHmlJOr2tZEOpWiSD3B3yqWlSgOvTUSx/EiYt0Y=;
        b=QS14UmikgbBgQAJFEwAEkqVxsutAyCCd177JLMeFYJDNJuiRlrSVZX3dv+fH8BbFuh
         2KBdhu8AIPx1+tNZj18buDllAsv9YIsFXU0TTkvl9rfq6rwgewoYcpepoZ1nX7Dbwg6n
         ZWK99xYf/xq8XFVm4hFMIX5w8oOV+eSJ+6b/9ntRxJDqT5Il5d34G1UvuPw6wAQdWoQo
         d5wkoLvxQMnqpgSoqMBNFYYVUfZqIEctOwsIEGn9PXddSZAffCWcrmOw2IEG5LsYDUpK
         U2OFE/XfDwDnPiWE2W3m8Liea5kly6C10yXa6tMYBkgiqWTKB9Ty1ugLXZvwE2Yp1TPl
         dokg==
X-Forwarded-Encrypted: i=1; AJvYcCVCde+ZTbFSlYtybnxN/b8vSrZ8HSQSLlIqtjnPIYGapZmq+BDoovlcGUwp20qUcI4hQzQgZc9qF6rHWsYvdkwd1+sTovMr@vger.kernel.org, AJvYcCWuId+MwINR83iIUHA0c/B3KmOz/YseI6sy5WQGqD6o2v3Ze/OIfT9ETltDk7v1tSkK/lESi69bkS26UfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyztJi7PDYxecKkWtYJOafWCo7w0ExHxQQxxMioUlkKq8W1ojBC
	4vc3Ah1Wyurk4Go80WSHN/PfZ9hjNL8zqgsspcz0gnLeFTr5SIDa
X-Gm-Gg: ASbGncuuLOZgXuTG2jJH1j43XwsYsTFyyIGiJUOCgUP+69UMhCnL79EuqNLO+ZPFJyP
	6mgESyRO3Sobk3PK5B2DmL/Qn4ZsVUdt9FRhXETRhn98AySkDrZ6cYo5loqov0UO6EHXthq+N1p
	Zr2pxvTXDnyt2MYMMM9TzMKuEySpKRtShwWrkEawjC5XZy0wAPKt2jgdhOD9uuyXRzKrtLCVu7r
	4BkO5PRvUMQ0CIbmM29ifQzmazXMmPfUet6lAtRRgJdv8nKCva+B5A6bqPB9ar6qA1UYlnvnV/D
	hRda+kJ3UNqsOkddZQ==
X-Google-Smtp-Source: AGHT+IES2AXoEp2vaNvzmtAT97SEWpz/MOxHMw92kqsJdiBJpjKlD2lmih0tYPSEmaztwWaO2TYlIQ==
X-Received: by 2002:a17:90b:51c1:b0:2ee:b2fe:eeeb with SMTP id 98e67ed59e1d1-2f782d2ea80mr37753282a91.22.1737752522606;
        Fri, 24 Jan 2025 13:02:02 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffaf8f03sm2180067a91.39.2025.01.24.13.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 13:02:01 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 24 Jan 2025 13:02:00 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: sergeh@kernel.org
Cc: Arnd Bergmann <arnd@kernel.org>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, Arnd Bergmann <arnd@arndb.de>,
	Colin Ian King <colin.i.king@gmail.com>, apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] apparmor: remove unused variable
Message-ID: <dff63c58-6f13-420d-9a67-1d6d3a273458@roeck-us.net>
References: <20250122065543.1515519-1-arnd@kernel.org>
 <Z5FPFhc9w0aemqL_@lei>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5FPFhc9w0aemqL_@lei>

On Wed, Jan 22, 2025 at 08:03:34PM +0000, sergeh@kernel.org wrote:
> On Wed, Jan 22, 2025 at 07:55:35AM +0100, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > The local 'sock' variable has become unused after a change to the
> > aa_sock_file_perm() calling conventions:
> > 
> > security/apparmor/file.c: In function '__file_sock_perm':
> > security/apparmor/file.c:544:24: error: unused variable 'sock' [-Werror=unused-variable]
> >   544 |         struct socket *sock = (struct socket *) file->private_data;
> > 
> > Remove it here.
> 
> That's interesting.  The aa_sock_file_perm() further in will
> still trip the AA_BUG(!sock) if there's some shenanigans going
> on so no big loss in dropping the AA_BUG.
> 

AA_BUG(X, args) extends to
	AA_BUG_FMT((X), "" args);
which is
	#define AA_BUG_FMT(X, fmt, args...) no_printk(fmt, ##args)

if CONFIG_SECURITY_APPARMOR_DEBUG_ASSERTS=n. That means the first
parameter is dropped and sock is indeed unused in that case.

Guenter
