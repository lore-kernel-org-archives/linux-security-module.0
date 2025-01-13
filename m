Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch [83.166.143.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C6C20AF74
	for <linux-security-module@vger.kernel.org>; Mon, 13 Jan 2025 16:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736787333; cv=none; b=i1ka8GltOBCjbb34wplBDhN5o5e82K9DXsISeET90DhAc2yZ4srig9EBxVkbBP0mrsIF2Hmq/7ozkWFFoPu9GY5e4tcwlGnwiqM7oHUbiLIOH7QOeFmh83ilYIT+Su3bwdxlomzKPuzx3mofHrADSu3dWwQ66jjouUiDl5Nec9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736787333; c=relaxed/simple;
	bh=GY3lBzf2jQZTyUqw/KtfO5SPHbgH1lCC/gWVyYIm+aQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HvtHlWJcmsdny4YCvhR6tlhqNwc3cmHQWaAsgPlkzo75eWrwT1p+zPjpBU+gFs1Awh3Qf9tGOjY5Ty3AjBGGEkqrAoX5zHSjLPjnv2Fg0fnqgEqx5iMk28szBvsDycZZpa6iVTsSfhgeCxkrYEvJvRUD6t6CtSBuxBTmnr7dwBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=jHsaj4k+; arc=none smtp.client-ip=83.166.143.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="jHsaj4k+"
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:1])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YWz0B1Ys8zy2B;
	Mon, 13 Jan 2025 17:55:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1736787322;
	bh=y0iyHTodjaLkrMlBHireseWKxknvKBh6g5IkCy7KlqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jHsaj4k+AfA88WWv+T9RZuahZQsdyxPcLzI3yjWE6x/5GiQPYbXrNoP+vHEWl5HMT
	 C9rlYGCViIiyCPK9XlhaXDjD9NveqAsMnXtR3fsVgvZWtxCpiUilTxy3p+8i/gev1X
	 WBhaX2VCOFCLLbJDe0m7TeG2JHLqWvwo1+5xW9B4=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4YWz091wGWzVgn;
	Mon, 13 Jan 2025 17:55:21 +0100 (CET)
Date: Mon, 13 Jan 2025 17:55:20 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>
Cc: Jann Horn <jannh@google.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Eric Paris <eparis@redhat.com>, Paul Moore <paul@paul-moore.com>, 
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
Message-ID: <20250113.shaonge7xieT@digikod.net>
References: <20250108154338.1129069-1-mic@digikod.net>
 <20250108154338.1129069-28-mic@digikod.net>
 <CAG48ez25VjcbUUkJiPru42LEX9AbUp0tfVrAcujo15ebozb0ew@mail.gmail.com>
 <20250113-endlos-lerche-e1958bd9ce32@brauner>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250113-endlos-lerche-e1958bd9ce32@brauner>
X-Infomaniak-Routing: alpha

On Mon, Jan 13, 2025 at 04:00:31PM +0100, Christian Brauner wrote:
> On Mon, Jan 13, 2025 at 03:00:20PM +0100, Jann Horn wrote:
> > On Wed, Jan 8, 2025 at 4:44 PM Mickaël Salaün <mic@digikod.net> wrote:
> > > Add a simple scope-based helper to put an inode reference, similar to
> > > the fput() helper.
> > 
> > Cleaning up inode references with scope-based cleanup seems dangerous
> > to me because, unlike most resources, holding a reference to an inode
> > beyond the lifetime of the associated superblock can actually cause
> > memory corruption; and scope-based cleanup is designed based on the
> > idea that the order and precise location of dropping a reference don't
> > matter so much.
> 
> That's in general a good point and I know there's been opposition to
> this in the past when we discussed this. So fine by me.

Right, I'll use __free(path_put) instead.
