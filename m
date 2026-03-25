Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2405B17555;
	Wed, 25 Mar 2026 12:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774442018; cv=none; b=MgW1npvjHxbaq/XRYYF0QbRomwokX/hZYu/7E0sVF/iYCsxC4MA9m/Mueg3LP1cPYerfQyLpi9A2v02kjmeJacDsmbfuc2aG8QdYmTX7psEq5Q68anPVVFbZfdOZZ1iYrXo3ndipsc6kXQ+oppLG3vPWHKZg01P3TcaI7hZy/nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774442018; c=relaxed/simple;
	bh=FcYxRB6BuSzOktssYl6PvMTsCq80cp6NboexOwaGgyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C7QOetDJFIwSKtqM2BpXcdNAXTmBWAr9gPqog6kUDfQUHZFLcYChQPwCdPp3O1Lr60fet359Lsp65XTmwCd3IUVY0+xgCdmNJ7uSzETVVqf1xhok4QRc4fCvbGXtVQrGC83lBeA5L4nVREmAiGT9qbkBu9dzCfIBKoUnBzk5OkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZN7fQfu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZN7fQfu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 631FDC2BC9E;
	Wed, 25 Mar 2026 12:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774442017;
	bh=FcYxRB6BuSzOktssYl6PvMTsCq80cp6NboexOwaGgyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AZN7fQfu2mB3JPlQT7cozZ/RpoCwhzCAi+h6RaraKIlH6enuXHL2kP6Xiv21oT+4k
	 zqNoyHhbeLhnaLeTluvXivCQU7l+EamC47Tnztyo7d3WNxrVKmEOYi9y7owS7dVehh
	 dMXF1WainTSussVtL514bK2MEV8u7w1qjg9oHr21vkeqTbIbtqov/JJxtm2O9Bj7Ck
	 dK2wOYFRt5KY86X6PWYoD5PlA4cDARFPVf348CKTgHXIdToWIi84YuP4I7W40zfCrv
	 QaN+feOL/eguq/1Zc64c60OxsOgKeO0DHqYj7vFp39TBoHZZnV2w/FQhvJ6A84Gc2r
	 Bu4afPF7uiCbg==
Date: Wed, 25 Mar 2026 13:33:31 +0100
From: Christian Brauner <brauner@kernel.org>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Paul Moore <paul@paul-moore.com>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Justin Suess <utilityemal77@gmail.com>, Lennart Poettering <lennart@poettering.net>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, 
	Shervin Oloumi <enlightened@google.com>, Tingmao Wang <m@maowtm.org>, kernel-team@cloudflare.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v1 03/11] nsproxy: Add FOR_EACH_NS_TYPE() X-macro and
 CLONE_NS_ALL
Message-ID: <20260325-utensil-endung-6e28806ae92c@brauner>
References: <20260312100444.2609563-1-mic@digikod.net>
 <20260312100444.2609563-4-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260312100444.2609563-4-mic@digikod.net>

On Thu, Mar 12, 2026 at 11:04:36AM +0100, Mickaël Salaün wrote:
> Introduce the FOR_EACH_NS_TYPE(X) macro as the single source of truth
> for the set of (struct type, CLONE_NEW* flag) pairs that define Linux
> namespace types.
> 
> Currently, the list of CLONE_NEW* flags is duplicated inline in
> multiple call sites and would need another copy in each new consumer.
> This makes it easy to miss one when a new namespace type is added.
> 
> Derive two things from the X-macro:
> 
> - CLONE_NS_ALL: Bitmask of all known CLONE_NEW* flags, usable as a
>   validity mask or iteration bound.
> 
> - ns_common_type(): Rewritten to use the X-macro via a leading-comma
>   _Generic pattern, so the struct-to-flag mapping stays in sync with the
>   flag set automatically.
> 
> Replace the inline flag enumerations in copy_namespaces(),
> unshare_nsproxy_namespaces(), check_setns_flags(), and
> ksys_unshare() with CLONE_NS_ALL.
> 
> When a new namespace type is added, only FOR_EACH_NS_TYPE needs to
> be updated; CLONE_NS_ALL, ns_common_type(), and all the call sites
> pick up the change automatically.
> 
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Günther Noack <gnoack@google.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---

Yeah, I love that. I can take that as a separate patch right now even.

Reviewed-by: Christian Brauner <brauner@kernel.org>
