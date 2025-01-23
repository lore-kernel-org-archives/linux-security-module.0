Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3791487ED;
	Thu, 23 Jan 2025 23:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737674489; cv=none; b=QO80WBWj2O0rTc8UvW0iJONdY28f8oYeoepcCYjeaCFxU1hnon5M2LMARcbteeOfQYTVnzbQjCS2jOQdHe+U5cr9B9sDmhhTtZBY5cZ/CqFECbDdrJL8ODEhyIFA7Zo6PsGISpkzGq19YCxVT9C+D9UOgN+byNuXQpObp3UvWxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737674489; c=relaxed/simple;
	bh=kilyVXms8HI3Guhk/Z1x2kI9BGbT7GdBpsOUh4412ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=an6kl9Q/kYmZQk1UogazCWZQlBG0DLS35/bDRh2GP3teZ+g6gcchFnZP6UTmeLvXQT4gkKKQ/Pk85WOJiJFPHaQoS61YuRD6Toh4cw90QpyxhOMflOXh82bd7WhCWchX2PAuelHmISEfAcEAccgJScSv92bw5FqgTe5pQY9voB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nSnJSm7D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSnJSm7D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E31B9C4CED3;
	Thu, 23 Jan 2025 23:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737674488;
	bh=kilyVXms8HI3Guhk/Z1x2kI9BGbT7GdBpsOUh4412ko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nSnJSm7Dedh79cRX4HFWFuewJ7mWSdlrt/s9Rn9M7wMHVlZ04VWdEn2EjzdU46eHo
	 zvFRIiBU0xaHJZmAqow6DVXBV0qMxuZpqIKPUq45j4XANkJ2XKbxObm0yMLvcTRnYQ
	 q84XetzS7SLUmJkqsR5IyInuKGE+wH7DCr9wP+WcNyDg+go6wQWyp6puywLNlSziJk
	 WGEEtsT4L7GwaPff5+H9PGpfSMhnH56faOja6nFxlUblyhwEc0O/9bd1Z9WB2FCwkV
	 fUpEQ8xQ0MA2Vbhg3odYWfpR6mY20agAq4SXmQgT4BC6s6U9iPYPyu/lmfVImXrHwq
	 SuGVig1BStSDQ==
Date: Thu, 23 Jan 2025 15:21:26 -0800
From: Kees Cook <kees@kernel.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Ricardo B. Marliere" <rbm@suse.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Subject: Re: [PATCH 0/2] security: Constify sysctl tables
Message-ID: <202501231521.A114C18BE@keescook>
References: <20250123-sysctl-kees-v1-0-533359e74d66@suse.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123-sysctl-kees-v1-0-533359e74d66@suse.com>

On Thu, Jan 23, 2025 at 04:33:33PM -0300, Ricardo B. Marliere wrote:
> Please consider pulling these small cleanup patches. They simply add
> "const" to a couple of ctl_table structs within your subsystem.

Paul, do you want to take these, or should I put them in my tree?

-Kees

-- 
Kees Cook
