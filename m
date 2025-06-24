Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [45.157.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF7226CE02
	for <linux-security-module@vger.kernel.org>; Tue, 24 Jun 2025 19:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750793118; cv=none; b=hSU6ONnGWnP3Szo2Di+9F1GFpqH5d0w2MnXv/SjHX3atiM7xAdzDgcKeBufx5kr77CKIJRbjTb0ME61Eu2ikr+izZcSdBTyD5tet9Bc+eb1ZP0DWLPDAitF0ay2eST5OT9waoC+NSwBIcuGw9VVl3IarJCuMt7zpBOybmUExqX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750793118; c=relaxed/simple;
	bh=n3gPP5ter8z/G2UK+N8u5iPsNH1l9p6GeoNFT2fHCLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fMOAANQBXdifcRTkqWgLuybsVAgjphLR5e9tD8BjvX3bh+qo4faKPZV4NVPs3bzGYBwEEgpe2CG9Rjp6nqSnds4PQuMay2XO1Qy2JPo7kZyxonV1ht/qGI3uApPvdpfRzMRsqWGoVhsrplsJWaEzvxEqaUQWYlL5TB2FlU1DZow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=UQQwoqXE; arc=none smtp.client-ip=45.157.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="UQQwoqXE"
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bRYn45ytMzV6v;
	Tue, 24 Jun 2025 20:46:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1750790760;
	bh=u1rRYMTWI2GRDd2TE9wM30VWfP4sJX0NGJS6BmSAJtM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UQQwoqXEpxtEJCOHOk2/X9CWB1KzMUyxiRIvB/4YzrwwoneL5tl9zyvuzpwFXI361
	 sLM702qxP1UsO/Y9b+ljbx52e28Loed5fXRuzmGrjQnGZnOVhlTlHfKrzjGq1IA9cu
	 ML8DLRd9DdBy5QQhRjKWspMBAf7cHbjjAxG3NIr4=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4bRYn358gbzMBy;
	Tue, 24 Jun 2025 20:45:59 +0200 (CEST)
Date: Tue, 24 Jun 2025 20:45:58 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, brauner@kernel.org, 
	kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, viro@zeniv.linux.org.uk, jack@suse.cz, 
	kpsingh@kernel.org, mattbobrowski@google.com, m@maowtm.org, neil@brown.name, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Subject: Re: [PATCH v5 bpf-next 0/5] bpf path iterator
Message-ID: <20250624.xahShi0iCh7t@digikod.net>
References: <20250617061116.3681325-1-song@kernel.org>
 <CAPhsuW5uu8cOYJWJ3Gne+ixpiWVAby1hZOnUgsXcFASEhV4Xhg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW5uu8cOYJWJ3Gne+ixpiWVAby1hZOnUgsXcFASEhV4Xhg@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Fri, Jun 20, 2025 at 02:59:17PM -0700, Song Liu wrote:
> Hi Christian, Mickaël, and folks,
> 
> Could you please share your comments on this version? Does this
> look sane?

This looks good to me but we need to know what is the acceptable next
step to support RCU.  If we can go with another _rcu helper, I'm good
with the current approach, otherwise we need to figure out a way to
leverage the current helper to make it compatible with callers being in
a RCU read-side critical section while leveraging safe path walk (i.e.
several calls to path_walk_parent).

> 
> Thanks,
> Song
> 
> On Mon, Jun 16, 2025 at 11:11 PM Song Liu <song@kernel.org> wrote:
> >
> > In security use cases, it is common to apply rules to VFS subtrees.
> > However, filtering files in a subtree is not straightforward [1].
> >
> > One solution to this problem is to start from a path and walk up the VFS
> > tree (towards the root). Among in-tree LSMs, Landlock uses this solution.
> >
> 
> [...]
> 
