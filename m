Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch [45.157.188.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCED21B9C5
	for <linux-security-module@vger.kernel.org>; Sun, 28 Dec 2025 18:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766946315; cv=none; b=Shb1CpOlOZvFu4bUMHY6jZyX9OO6AkC22KMY/ksIQmZJZsCqlc1EmVuGLzyV3Lttlljnd4McmU2jc+st3aQxPDhEKTyZkp8NmDWvxIZztKCA81AoJYRCp+H4DVj0AUbwFBAQKNra0bAV/MhnRXK30ZjXCBeAVuEYzmMM53oHb78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766946315; c=relaxed/simple;
	bh=RI6SS7krBqAoNyrCYEfOJ3BYbW4B+ic2Lha4xdtRnFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQUmz/gCY3UWGOL/aVweGPaxIGNauzObMaNf7hb8WL6AjPnI0pViwN+FSshJSHtwxsSnonySpdpgm38zv+6m13+IgkCsUbOZz02qWX+oL0l/Kpn+g7E/O8cCJjv8k92G95x1qDCShonZv0sLHMuM8pIbYQrdUUXM7OmZgJqHcSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=nv8MOBdw; arc=none smtp.client-ip=45.157.188.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="nv8MOBdw"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dfSGW6t2kzb70;
	Sun, 28 Dec 2025 19:16:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1766945779;
	bh=jBJLxe9C3UP4URhOPIuYQOIDSJ+3ITUZlPPucpwqwMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nv8MOBdwmGDvd4p5HAuVG/fF02aWSd5+pikn8ighjxhetQubIvYRUMR1KbUKKQexG
	 KMVi0EukYlEfpU1+AF5Z4HcKxB6bPza7jPLMowtC/BbnYnjh3FrZdkMJDLJlFTw7Es
	 BcslKGbueG28P61AAvh+x6cglutixNuJ8+l8pAAE=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4dfSGW37svzcS0;
	Sun, 28 Dec 2025 19:16:19 +0100 (CET)
Date: Sun, 28 Dec 2025 19:16:15 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, linux-security-module@vger.kernel.org
Subject: Re: [PATCH 0/5] Landlock: Test, comment and doc improvements
Message-ID: <20251228.cohl6Dai0pho@digikod.net>
References: <cover.1766885035.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1766885035.git.m@maowtm.org>
X-Infomaniak-Routing: alpha

On Sun, Dec 28, 2025 at 01:27:30AM +0000, Tingmao Wang wrote:
> Hi,
> 
> This series contains various unrelated improvements I stashed while
> working on pathname Unix socket scopes (I will send the series for that
> tomorrow).  Only test/comment/doc changes.

Thanks!

> 
> I was planning to include this in the upcoming Unix socket scope series
> but I thought maybe it would be better to send them separately, as they
> would be unrelated to the main topic of that series.

Yes, that's better.

> 
> Tingmao Wang (5):
>   selftests/landlock: Fix typo in fs_test

Applied

>   selftests/landlock: Fix missing semicolon

Applied

>   Documentation/landlock: Fix missing case for ABI 6 in downgrade
>     example

Not applied, see review.

>   selftests/landlock: Use scoped_base_variants.h for ptrace_test

Applied

>   landlock: Improve the comment for domain_is_scoped

Applied with cosmetic changes.

> 
>  Documentation/userspace-api/landlock.rst      |   6 +
>  security/landlock/task.c                      |   9 +-
>  tools/testing/selftests/landlock/fs_test.c    |   4 +-
>  .../testing/selftests/landlock/ptrace_test.c  | 154 +-----------------
>  .../landlock/scoped_abstract_unix_test.c      |   2 +-
>  .../selftests/landlock/scoped_base_variants.h |   9 +-
>  6 files changed, 26 insertions(+), 158 deletions(-)
> 
> 
> base-commit: 161db1810f3625e97ab414908dbcf4b2ab73c309
> -- 
> 2.52.0
> 
> 
