Received: from pf-012.whm.fr-par.scw.cloud (pf-012.whm.fr-par.scw.cloud [51.159.173.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562CE288C37;
	Tue, 29 Jul 2025 12:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.173.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753791426; cv=none; b=ZVR85KBWi6b6AafON9y4q9UtOO38Z8yQK0haay6wQZ77EZnC6wJDuQFJ0fQkaaSQoMjNyQGVZXB8lXlo7+j+yxm5PgDptM4JUaUmpWG0VsGl73cohrAG9LaUwj7Ht9ad1/5WMn7P/pkQqjNb+ujIAmNHLQtc8HtcOaIG+A/Vubs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753791426; c=relaxed/simple;
	bh=no0lrymv4RgXYfc8OR5+GOYkwyzqdwdbzCQ6jmn/YEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F7yXBk5xfYRbGt9voiny8hcsgkjpeioHcE3Gp6O2M1GWeEIuWXjFCf3vSym3dc7MD0adgF+sJBV5BachVH8NGS+fxVD7SUTwYJm5kEM4pv30mNcQUAC/kidKQ1gtBFazRznLgYEJKVqksCv5/xxl3uGKH+O55rVYCLSxTHxG96s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=aQ2BFgsO; arc=none smtp.client-ip=51.159.173.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="aQ2BFgsO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Ja/rpFmme61qsVwtiG2iEWQLNzHPxWHDhttFM3TSdWA=; b=aQ2BFgsObO4y12z6Aut9Z4C18B
	DHypJn3ZepinYaIkmKBMUi9zF8GUkiKrU98Zr46DwfipLovZNCqNe59fXJG+eliTElIZN8c4H2ood
	xnHMvI4XFBg5jam0PgWlmmFDB6WjxUhbROSXG7vYcI/GxAUSwSCQTg+x7S5RjyO6e0g9awi4znZ2b
	jtHgsILUVVjra77jDW8aloo2+gl67mvvP5aAy1utDXOhnjSHV009jKD+e2Xv+YmPoWCVmX8nXXBpG
	sl3ou0Enj+9TPkghx80JKopjIcyD3eBUqjMzWa4Y+SUSEAdY9bKqCwn4bfxIMHu4rSTBMr9AeoWG2
	Pj1smPUw==;
Received: from laubervilliers-658-1-215-187.w90-63.abo.wanadoo.fr ([90.63.246.187]:64728 helo=archlinux)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <nicolas.bouchinet@oss.cyber.gouv.fr>)
	id 1ugjGK-0000000Drss-2vYm;
	Tue, 29 Jul 2025 14:16:56 +0200
Date: Tue, 29 Jul 2025 14:16:53 +0200
From: Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	paul@paul-moore.com, serge@hallyn.com, jmorris@namei.org, dan.j.williams@intel.com
Subject: Re: [PATCH v2 0/3] Allow individual features to be locked down
Message-ID: <kl4rvgnupxnz4zrwlofrawdfy23tj2ylp5s3wovnsjxkr6tbrt@x5s3avqo2e7t>
References: <20250728111517.134116-1-nik.borisov@suse.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728111517.134116-1-nik.borisov@suse.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: nicolas.bouchinet@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: nicolas.bouchinet@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hi Nikolay,

Thanks for you patch.

Quoting Kees [1], Lockdown is "about creating a bright line between
uid-0 and ring-0".

Having a bitmap enabled Lockdown would mean that Lockdown reasons could
be activated independently. I fear this would lead to a false sense of
security, locking one reason alone often permits Lockdown restrictions
bypass. i.e enforcing kernel module signature verification but not
blocking accesses to `/dev/{k,}mem` or authorizing gkdb which can be
used to disable the module signature enforcement.

If one wants to restrict accesses to `/dev/mem`,
`security_locked_down(LOCKDOWN_DEV_MEM)` should be sufficient.

My understanding of your problem is that this locks too much for your
usecase and you want to restrict reasons of Lockdown independently in
case it has not been enabled in "integrity" mode by default ?

Can you elaborate more on the usecases for COCO ?

[1]: https://lore.kernel.org/all/CAGXu5j+UWQWDacMvvRCke3xUOb7uTkxn=WaHzG4kJTKWh-6tAA@mail.gmail.com/

Best regards,

Nicolas

---

On Mon, Jul 28, 2025 at 02:15:14PM +0300, Nikolay Borisov wrote:
> This simple change allows usecases where someone might want to  lock only specific
> feature at a finer granularity than integrity/confidentiality levels allows.
> The first likely user of this is the CoCo subsystem where certain features will be
> disabled.
> 
> Changes since v1:
>  * Added Patch 3 to incoroporate Serge's hardening suggestion
> 
> Nikolay Borisov (3):
>   lockdown: Switch implementation to using bitmap
>   lockdown/kunit: Introduce kunit tests
>   lockdown: Use snprintf in lockdown_read
> 
>  security/lockdown/Kconfig         |  5 +++
>  security/lockdown/Makefile        |  1 +
>  security/lockdown/lockdown.c      | 36 +++++++++++++++------
>  security/lockdown/lockdown_test.c | 54 +++++++++++++++++++++++++++++++
>  4 files changed, 86 insertions(+), 10 deletions(-)
>  create mode 100644 security/lockdown/lockdown_test.c
> 
> --
> 2.34.1
> 
