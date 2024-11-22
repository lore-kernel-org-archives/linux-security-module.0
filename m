Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4781DF759;
	Fri, 22 Nov 2024 17:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732297330; cv=none; b=h7QW14MwHjoA4fmBtmHv1VmshnVjVGnKxaIgp7bMWZiapJu+bz/riDjraYpL0Z0bB64poAqKfn0LhnGkBknZPvdktxN61/jCbAnsAZ1MbdQWJEbAtPJvxBs147ft1GsA6hUxlXlwP4KU2jBbMUZhuyhAwWfeMCF9wXhlydz15+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732297330; c=relaxed/simple;
	bh=a4st4C5XXyoPcxv2sZbE67XBW/hIZc7o/BdosAHwM4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=spdx9T3fI8Je+LTNOZn0jOhAyK9PPofrh5iBseGag2Fgk7t9Ww6OYB8F9si3cAJgLNIpBI++PGOGYi2doJi+gY3/NDuR4nWKeMb4m0cXj6oGN5S/q0A8uXr5YEVEurLUiIT1zDaIXDmz+MCsHdTYJr4kEdxkqUW5BQSSLXzeNUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 796D620D; Fri, 22 Nov 2024 11:34:18 -0600 (CST)
Date: Fri, 22 Nov 2024 11:34:18 -0600
From: "Serge E. Hallyn" <serge@hallyn.com>
To: sergeh@kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Paul Moore <paul@paul-moore.com>,
	Jordan Rome <linux@jordanrome.com>,
	linux-security-module@vger.kernel.org,
	lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] capabilities
Message-ID: <20241122173418.GA518018@mail.hallyn.com>
References: <Zztcp-fm9Ln57c-t@lei>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zztcp-fm9Ln57c-t@lei>

On Mon, Nov 18, 2024 at 03:26:31PM +0000, sergeh@kernel.org wrote:
> Hi Linus,

Hi,

before the merge window closes, I just wanted to make sure this didn't get
lost.

thanks,
-serge

> The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:
> 
>   Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/sergeh/linux.git tags/caps-6.12-rc1
> 
> for you to fetch changes up to 54eb2cec2ed7aaf25524dd5ebeaa4f87ed5c6bd6:
> 
>   security: add trace event for cap_capable (2024-10-30 14:40:02 -0500)
> 
> This branch contains two patches:
> 
> 1. Remove the cap_mmap_file() hook (Paul Moore), as it wasn't actually doing anything.
>    de2433c608c2c2633b8a452dd4925d876f3d5add
> 
> 2. Add a trace event for cap_capable (Jordan Rome).
>    54eb2cec2ed7aaf25524dd5ebeaa4f87ed5c6bd6
> 
> Both patches have been sitting in linux-next for quite some time with no apparent
> issues.
> 
> thanks,
> -serge
> 
> ----------------------------------------------------------------
> Jordan Rome (1):
>       security: add trace event for cap_capable
> 
> Paul Moore (1):
>       capabilities: remove cap_mmap_file()
> 
>  MAINTAINERS                       |  1 +
>  include/trace/events/capability.h | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  security/commoncap.c              | 37 ++++++++++++++++++++++---------------
>  3 files changed, 83 insertions(+), 15 deletions(-)
>  create mode 100644 include/trace/events/capability.h
