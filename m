Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B6E268691;
	Tue, 20 May 2025 16:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747757650; cv=none; b=MhK/oOGULUyS1h4q2EB0z3jUU5EOAOZbABAeXDNhbV/eWpOXazSoFXcHLjBrbdAuMAUX5B09twhY0WRxJSaJLoG6SGU7UrNKEj6urLkcniqr2kIv/eIjoqdx4nwY6YOBLlGDf/otyNaIU1hIWw2pwYTEES5xdm3oLYciRgOL/e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747757650; c=relaxed/simple;
	bh=+H3xBuHGe0NFinX9jkoWQvlO5VXuQWV97EPa8IuIT6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hFUtbAWQN94k5ocZTKx7A2sXtf5+GkYbC/5PvGa15HAZbaNAhywyOXSp8WeXaZXPZzRWYxFKmTZ/fE34WgyCXoFAiaveW6yVJP8KFYGJHQQg14NO6eUTYwHtJYykSgwe9MdP/ExmC4jzQQuhCM64Eily2G0KYm7Gn1CWDvHBLdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NsvLE17Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NsvLE17Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DACCC4CEE9;
	Tue, 20 May 2025 16:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747757650;
	bh=+H3xBuHGe0NFinX9jkoWQvlO5VXuQWV97EPa8IuIT6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NsvLE17ZvdJbEkbwNWg2kTh6hXJbKZC6LP0NeMEcWGq6U7uh26CBdbbPooeBaqowt
	 jC8/I5S5/EN2LAoxnGefK9K5R4PQTnJOjzBlxlrlK1p7f7NQ0NWzRLP54ckExKjexb
	 YrxK4yoFhrZOvaxRFSd4Yd81GsreAWMZRmq1N4tng7R4hAxe8WqZSI2q+q12HH4PNd
	 f2evJyAv3hwh8nhVKZqZavc+8zePH9gjKKxOOJ8bp6gVvVbWuLkbmKzXzy0t87+5E8
	 3AYcXniqOPFFnVkGUGFx7cIWbAzguYSrMpmFTVMbj9T92PP+0KKr+h9O40DO71L+Yu
	 hoW4sowIGetTw==
Date: Tue, 20 May 2025 09:14:06 -0700
From: Kees Cook <kees@kernel.org>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Arnd Bergmann <arnd@arndb.de>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Mark Brown <broonie@kernel.org>, WangYuli <wangyuli@uniontech.com>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Bill Wendling <morbo@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Justin Stitt <justinstitt@google.com>,
	Petr Mladek <pmladek@suse.com>, David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>, Tamir Duberstein <tamird@gmail.com>,
	Diego Vieira <diego.daniel.professional@gmail.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH 0/3] randstruct: gcc-plugin: Remove bogus void member
Message-ID: <202505200912.DC143B5A13@keescook>
References: <20250427013604.work.926-kees@kernel.org>
 <20250520.Riene6ceesha@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250520.Riene6ceesha@digikod.net>

On Tue, May 20, 2025 at 05:18:56PM +0200, Mickaël Salaün wrote:
> On Sat, Apr 26, 2025 at 06:38:32PM -0700, Kees Cook wrote:
> > Hi,
> > 
> > Okay, I've tracked down the problem with the randstruct GCC plugin,
> > and written a KUnit test to validate behaviors. This lets us add
> > it back the COMPILE_TEST builds.
> > 
> > No need for https://lore.kernel.org/all/20250421000854.work.572-kees@kernel.org/
> 
> Hi,
> 
> What is the status of this patch series?  Do you plan to send it for
> v6.15?

Since it is pretty late for v6.15 and exposes missed designated
initializers, I was planning to send it (and the designated initializer
fixes) for the v6.16 merge window and have them all go into -stable
for v6.15.

-- 
Kees Cook
