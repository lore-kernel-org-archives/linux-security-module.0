Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C046C386C0D;
	Wed, 16 Sep 2026 08:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789548592; cv=none; b=evIrk2OW+1sexvgfe5399gtBvEPGj9xsVrx108BHHKtIYYUW+vDCCryFwa2IgBpU+E+nMZbQotM3WMgVuCp8VLRUAq3i7ery2N3trs8SunVscbMbGQAGMuh5LADjLfDeBXlBLEMo85X280zaNVQnU3d29UBRQ/FjLBqHs6a3/M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789548592; c=relaxed/simple;
	bh=ihmXYVeMmg2Jerw/GEnfftPEHTm2oEQbk9qxIjSjbkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NreOWzwC9q6ox2+JWmP1nIF8U0eBxaCLwb7YrPZzlkFhAtfJqbhNhmRC3MyK1nrc2EDorkfWvAEsvEvBVG1qF4hH/EOH+nce/XpOO9Azd8k0R9aZNsG0BAGQ3Kt8Wjk/iXxdlWNqsUv8rY3VTzeAXP9GZvwqcy7YS9UOKtRKPGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MZeYyIHC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=whngwqGp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MZeYyIHC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="whngwqGp"
Date: Wed, 16 Sep 2026 10:49:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1789548588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zibvGOtXD/dN1/gknHfMQUENOl4oEIycRhECJ1GE8rU=;
	b=MZeYyIHCflNxaXsYfcB/H1Td2iAaWolcrYOkwS3cnByW71B8LarBibC18XAJ//wqrm6MyI
	FlDgMk+fysdEMGjCn+vK9YVS3WaxhAXnDx6du6UebpYGPKqdeOtKzXvyhV1/mFDx2LAuwx
	SI7ebK0Aq/NR7DwB5RGLSmiJ8ytMbCfsUfEr37WSJWMf03ZNGaGLw4xmvIlYBfuhQGOu84
	tJijEO2W8ZyhQtvZrWI/uTRyPt7oQxgA7jjr0my/ntiWN/21kgWs//4pjFiKAAt2q2Mju3
	3+j4Fchv0AIJ/NZwHSlRYk/FEFx7WqHnJlKp7Bk8dyi4EqdHxpB7hBdp8YgrEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1789548588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zibvGOtXD/dN1/gknHfMQUENOl4oEIycRhECJ1GE8rU=;
	b=whngwqGpe5G1qvHE0bFeAAFlToc+413f38OQwOeyNQw7J5E/vglnonP2MAf7Di7I54Bhaa
	Eabw71pw4yfxbaDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Arnd Bergmann <arnd@kernel.org>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, Tingmao Wang <m@maowtm.org>,
	Justin Suess <utilityemal77@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] landlock: work around gcc-16 -Wuninitialized warning
Message-ID: <20260916084947.6QDy8KZQ@linutronix.de>
References: <20260915201036.3527935-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260915201036.3527935-1-arnd@kernel.org>

On 2026-09-15 22:10:30 [+0200], Arnd Bergmann wrote:
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=110743
> Link: https://lore.kernel.org/all/20260619082133.3504146-1-arnd@kernel.org/
> Fixes: a260c0055665 ("landlock: Add a place for flags to layer rules")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: rebased to linux-next-20260914
> 
> I originally sent this in June, but got no reply and this still
> happens with gcc-16.2, which is the latest stable release.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

This looks reasonable. I don't see this with gcc-16.2 and the referenced
gcc bug has it as fixed.

Sebastian
