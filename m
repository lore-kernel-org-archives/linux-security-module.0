Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch [185.125.25.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A81F322523
	for <linux-security-module@vger.kernel.org>; Fri, 19 Dec 2025 20:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766176032; cv=none; b=kJJ5NpaOKm2HarCufdmDsmQn04+QUFicojxHSJbGF3XQzYCMnVBVhF8Im/Xkt8h5NEyGqkCo9V37EVe2hA3dMBlIg5OtvAJmMRAxYsZ1LSAhIC88EIYyRqvm67OZp8efGWBcXAmjwkn8khVF1JuRzzn+LmXnLQSrZmD1j4bpsGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766176032; c=relaxed/simple;
	bh=r/2CqwzDCduVQKYbbp2hucTnAozFHMBGFkZU76tK0ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TSpvqOtPrbm18o80OANppkwqF+w/zTV6ZaK1TtggSNug4Ikr0/CzCsIkYN9omsklrdnpiX8zsCAtFcLAxMG0wgjq6ok9V5BBVcq2A2q4qAvVGltVwZJ+KTqoneQY+9WKcXlmzHIA/zzcvKtWeeTn9Pi0twETdPfMa97iA6BN6Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=b0zNNxrL; arc=none smtp.client-ip=185.125.25.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="b0zNNxrL"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dXzbX4fz6zH6;
	Fri, 19 Dec 2025 21:27:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1766176024;
	bh=GC40OdK3iQpnKtPqMmH3wSCIQAnDI8+Bm95IN+HDqvM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b0zNNxrLxoRxCYnaCwQw14lzxzc5lMX/Lq/0jNEF+bW3qIXZ/uOkV1fPEg1qKdE3W
	 HmoRhQAl+Ha2OYpsUNlzG9RcdaxBAZvn5zSQz8W0fFCSJWQnhswcaNV7dhLbJ4Dwxv
	 Bru4xB9yE4LIgY8O4+S6tL/PC6lMWGoA0he1UIx4=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4dXzbX1401zYc6;
	Fri, 19 Dec 2025 21:27:04 +0100 (CET)
Date: Fri, 19 Dec 2025 21:26:59 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: Matthieu Buffet <matthieu@buffet.re>, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH] selftests/landlock: NULL-terminate unix pathname
 addresses
Message-ID: <20251219.otohnaeCait3@digikod.net>
References: <c2780073-9e74-4303-9e07-6b825963148e@buffet.re>
 <20251202215141.689986-1-matthieu@buffet.re>
 <aTAHfes90YxsXWt0@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aTAHfes90YxsXWt0@google.com>
X-Infomaniak-Routing: alpha

Thanks for both patches! Applied to my -next branch.

On Wed, Dec 03, 2025 at 10:48:45AM +0100, Günther Noack wrote:
> On Tue, Dec 02, 2025 at 10:51:41PM +0100, Matthieu Buffet wrote:
> > The size of Unix pathname addresses is computed in selftests using
> > offsetof(struct sockaddr_un, sun_path) + strlen(xxx). It should have
> > been that +1, which makes addresses passed to the libc and kernel
> > non-NULL-terminated. unix_mkname_bsd() fixes that in Linux so there is
> > no harm, but just using sizeof(the address struct) should improve
> > readability.
> > 
> > Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
> > ---
> > [...]
> 
> Thank you very much, this looks good!
> 
> Reviewed-by: Günther Noack <gnoack@google.com>
> 
> —Günther
> 
