Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483D122BAD7;
	Mon, 13 Jan 2025 15:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736780440; cv=none; b=Frr8gMUSOELPJy66JHOv+ulGYdyEjr1fDDWany89F8ZNNByupWPxBvMKYvePK99dps+eLt4AlW/DmRmUAJ46GDwQFC2h4tbPzxoscS4gOBSaBECxMMVYhgJDMx1ons28ZPcXJ6ohW7ANkf2igmAtNou1ecD78d3+L4o5M74yF6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736780440; c=relaxed/simple;
	bh=YYK4qRr5/0kN9rqtefDG849UfWQjZqOik06wRTCm40I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WCj9jwI2XmTLMsiqbnzmcwAcl+yyutBWrvMW0fmp/CeLCY5mdWUcbhGLi0W86Ru10Z+YjtpSoM3VmqtNwmfGjJB127v1YEQvpbfEUqDrUqF8gcdREJG5UTLyH3obpVms8DXItwF5vdrQ0s0czNLJDRTqnFmpiFU/H765NavYJCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9bwj8X1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9bwj8X1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FABBC4CEE2;
	Mon, 13 Jan 2025 15:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736780439;
	bh=YYK4qRr5/0kN9rqtefDG849UfWQjZqOik06wRTCm40I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k9bwj8X1fnCpBNKkmhCm3w+NmrdZF+yft0hY+WMyuuioG3oKPjhXvOyLHppVbQYyC
	 YfH9ySzEnF76h2L9dtcBG75SVTI0Vv/i5w84OSP879Ecl9U1QwRXm1eAvGN5QkwkMt
	 PPedhya7CwKJHnP/NRewq0k38gU+P508mT1zbFWJR+vu0o3e7CTVkJiPPZCEWrQmAM
	 CwMUrgtH14ING7YY5y+uPFyJByDt+4ngwCy8D8SzCLHSupzEBEUVhw0i6yfFdsE1jr
	 eBdFDlSC/kwja9qj1fHhO6cGo5ENo+JTF2dMwry6FgDLVeIrQ9HSSEaTxuQNOmbC1/
	 L2H7gJbelNsbA==
Date: Mon, 13 Jan 2025 16:00:31 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
	Al Viro <viro@zeniv.linux.org.uk>, Eric Paris <eparis@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Ben Scarlato <akhna@google.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Charles Zaffery <czaffery@roblox.com>, Daniel Burgener <dburgener@linux.microsoft.com>, 
	Francis Laniel <flaniel@linux.microsoft.com>, James Morris <jmorris@namei.org>, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@google.com>, Kees Cook <kees@kernel.org>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Phil Sutter <phil@nwl.cc>, 
	Praveen K Paladugu <prapal@linux.microsoft.com>, Robert Salvet <robert.salvet@roblox.com>, 
	Shervin Oloumi <enlightened@google.com>, Song Liu <song@kernel.org>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Tyler Hicks <code@tyhicks.com>, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v4 27/30] fs: Add iput() cleanup helper
Message-ID: <20250113-endlos-lerche-e1958bd9ce32@brauner>
References: <20250108154338.1129069-1-mic@digikod.net>
 <20250108154338.1129069-28-mic@digikod.net>
 <CAG48ez25VjcbUUkJiPru42LEX9AbUp0tfVrAcujo15ebozb0ew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez25VjcbUUkJiPru42LEX9AbUp0tfVrAcujo15ebozb0ew@mail.gmail.com>

On Mon, Jan 13, 2025 at 03:00:20PM +0100, Jann Horn wrote:
> On Wed, Jan 8, 2025 at 4:44 PM Mickaël Salaün <mic@digikod.net> wrote:
> > Add a simple scope-based helper to put an inode reference, similar to
> > the fput() helper.
> 
> Cleaning up inode references with scope-based cleanup seems dangerous
> to me because, unlike most resources, holding a reference to an inode
> beyond the lifetime of the associated superblock can actually cause
> memory corruption; and scope-based cleanup is designed based on the
> idea that the order and precise location of dropping a reference don't
> matter so much.

That's in general a good point and I know there's been opposition to
this in the past when we discussed this. So fine by me.
