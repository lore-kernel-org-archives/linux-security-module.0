Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch [84.16.66.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833592798F4
	for <linux-security-module@vger.kernel.org>; Tue, 27 May 2025 14:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748357608; cv=none; b=Eza8UCtQgChuo73p3a9krClV0dHhVuNUUoItzkPT8xYl26PRp64TLJi71WzLrqPZu5jgJJ1mxw4WubRsWpdbNNNUeDvT/DF5iaubpUAyg+XizdRp40IRYhX9QXYH2uLjAl1kTCg7W4CjfReUaFC65dufb4yX59KQDAec9+8yqtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748357608; c=relaxed/simple;
	bh=56FmbnUmeKfYr4o85CdfJbUTpAxf06qEhqsBjPm541g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UOhhCsmxJAJnOazEBXcopRj64TujhsplHHMckj+j3NrPQDR/KYY0+BG9A8T34mGu6ajib9UOq1d5/cVr9rf36q5Eg3UzmLGRk4ntLTSavfLzoHryN6Xl3KezDq9ltqG0GuMA72CdKc+tznbp6tG9ERWnRCuO2XxvN65BlBYbpu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=wLSsp06y; arc=none smtp.client-ip=84.16.66.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="wLSsp06y"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4b6Fxb2zqdz3vg;
	Tue, 27 May 2025 16:53:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1748357603;
	bh=mg1VvsY1Z1KsXWpmOIQaxc0t5/MOBWB3tUq7d1mur6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wLSsp06yqw+tkpc99UFBY5GuHUFExEePkifC9sbuw+RXwvunThtlSjbyJGdNENOZf
	 FznAotlDwajqLnj+ed5qIbo7CZkJ3l/tPJMKrsiKH5P8enIKHNrdLHlNhcOFl0saSC
	 5niij9ZvVOa1DB9srcC5Pw6wR/nbqlITqfAkGRN0=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4b6FxZ5c4jz8Q2;
	Tue, 27 May 2025 16:53:22 +0200 (CEST)
Date: Tue, 27 May 2025 16:53:22 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Daniel Burgener <dburgener@linux.microsoft.com>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, 
	Kees Cook <kees@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Matthieu Buffet <matthieu@buffet.re>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Ryan Sullivan <rysulliv@redhat.com>, 
	Shervin Oloumi <enlightened@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 2/5] landlock: Merge landlock_find_rule() into
 landlock_unmask_layers()
Message-ID: <20250527.un9ae3Ohlaih@digikod.net>
References: <20250523165741.693976-1-mic@digikod.net>
 <20250523165741.693976-3-mic@digikod.net>
 <ec7198c7-bed9-4a04-9ff0-da90ce729897@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ec7198c7-bed9-4a04-9ff0-da90ce729897@maowtm.org>
X-Infomaniak-Routing: alpha

On Mon, May 26, 2025 at 07:38:07PM +0100, Tingmao Wang wrote:
> On 5/23/25 17:57, Mickaël Salaün wrote:
> > To be able to have useful traces, let's consolidate rule finding into
> > unmask checking.  landlock_unmask_layers() now gets a landlock_rule_ref
> > instead of a rule pointer.
> > 
> > This enables us to not deal with Landlock rule pointers outside of
> > ruleset.c, to avoid two calls, and to get all required information
> > available to landlock_unmask_layers().
> > 
> > We could make struct landlock_rule private because it is now only used
> > in the ruleset.c file.
> > 
> > Cc: Günther Noack <gnoack@google.com>
> > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > ---
> >   security/landlock/fs.c      | 144 ++++++++++++++++++++++--------------
> >   security/landlock/net.c     |   6 +-
> >   security/landlock/ruleset.c |  12 ++-
> >   security/landlock/ruleset.h |   9 +--
> >   4 files changed, 100 insertions(+), 71 deletions(-)
> > 
> > diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> > index f5087688190a..73a20a501c3c 100644
> > --- a/security/landlock/fs.c
> > +++ b/security/landlock/fs.c
> > @@ -356,30 +356,27 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
> >   /* Access-control management */
> >   /*
> > - * The lifetime of the returned rule is tied to @domain.
> > - *
> > - * Returns NULL if no rule is found or if @dentry is negative.
> > + * Returns true if an object is tied to @dentry, and updates @ref accordingly.
> >    */
> > -static const struct landlock_rule *
> > -find_rule(const struct landlock_ruleset *const domain,
> > -	  const struct dentry *const dentry)
> > +static bool find_rule_ref(const struct dentry *const dentry,
> > +			  struct landlock_rule_ref *ref)
> 
> I think a better name would be something like "get_rule_ref"? Since it's not
> really _finding_ anything (like doing a search in a rbtree).

Correct.

> 
> (If you take the rename suggestion, then it would be "get_rule_target")

What about get_inode_ref()?
