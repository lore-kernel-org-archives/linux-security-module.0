Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5757C22EE4;
	Fri, 29 Nov 2024 04:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732855731; cv=none; b=WqvMRMMQ1CqpEYoTJBtaSWGdjkUIUPZhPTSo9hHYhSwZ5XN7pvtngV9XEQPY1mGddKBLTScINELWwIbgwrJSakUArerbFxVB2Iqi5jl8ay18umarB5AMLFRWJi9FgbQuZFWTvBTU5yK/aZVSualblRWi46Ug/ksXgwoofJLh4Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732855731; c=relaxed/simple;
	bh=66+aNCl0vct1/rCpBqDrthFuXWIE52MKD/so5rxe0Wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JBghqZqpd9tl+V+7yAqIux5iBwosRyM80kMh0vZrCd5iXyvmyrXvJzm1g0Rl1IwrB7gdj18TUIg+YiK1yQrH0cjUq2XwQZnuIatY0c48Ag9aBkJdoRfAonPpZjNQ8cJqBFdyL5MH/OEETtCMeov9z+4JK37S7yyyZ4mgx1CFy0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=mWXjSXXp; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="mWXjSXXp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mylCL1TK9tClMQOnzunfRHBvBXDgIRC5CqipophzBv0=; b=mWXjSXXpZvWBI6sIvU8Q3KQUTN
	dfqqied2OARsvh/qjnTcdtEM8uLtK4ewmJidJ4xwPgIf62KVXHzUlX7zloBGxbWcCgGx8V24LhCpE
	xiMC8h05A2grqtUPpD8iLj5B8RrZVx5iU+EspOoe+rpPsfUvcTC8SqhYUD5l6qbHsy43wgUEwT+3o
	z3a8fzhn/sfKKI9IGvpauezeNY20fnT3hhIN0FFE8WBkyIen50lt0bCSZmX11kxxh3z+RREXS1/uV
	fzBqe5jQqS1oDCnLe6RZMfXrJP8RywtNmP5b2eX1RscuEAJF+CrYzq/BNf+m2X46wiNRALlFmCZC1
	VF/gQ19A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tGsvt-00000002zGk-2iq0;
	Fri, 29 Nov 2024 04:48:45 +0000
Date: Fri, 29 Nov 2024 04:48:45 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Nir Lichtman <nir@lichtman.org>,
	Tycho Andersen <tandersen@netflix.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	linux-security-module@vger.kernel.org
Subject: Re: [GIT PULL] execve updates for v6.13-rc1 (take 2)
Message-ID: <20241129044845.GJ3387508@ZenIV>
References: <05F133C4-DB2D-4186-9243-E9E18FCBF745@kernel.org>
 <CAHk-=wgEjs8bwSMSpoyFRiUT=_NEFzF8BXFEvYzVQCu8RD=WmA@mail.gmail.com>
 <202411271645.04C3508@keescook>
 <CAHk-=wi+_a9Y8DtEp2P9RnDCjn=gd4ym_5ddSTEAadAyzy1rkw@mail.gmail.com>
 <20241128020558.GF3387508@ZenIV>
 <CAHk-=whb+V5UC0kuJkBByeEkeRGyLhTupBvpF-z57Hvmn7kszA@mail.gmail.com>
 <13223528-74FF-4B68-B0CF-25DCC995D0A0@kernel.org>
 <CAHk-=wgKgi5eqo6oW0bBS2-Cr+d4jraoKfVq6wbmdiWWsZbMLw@mail.gmail.com>
 <20241129033419.GI3387508@ZenIV>
 <87h67qoeh5.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h67qoeh5.fsf@email.froward.int.ebiederm.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Nov 28, 2024 at 10:23:18PM -0600, Eric W. Biederman wrote:

> > I agree that for fexecve() the only sane approach is to go by whatever
> > that opened file refers to; I'm not sold on the _usefulness_ of
> > fexecve() to start with, but if we want that thing, that's the way
> > to go.
> 
> The craziness is that apparently systemd wants to implement execve in
> terms of fexecve, not execveat.

... presumably because the pathname might have changed its meaning
just as we called execve().  Which is why we want it to show up in
comm, got it.

</sarcasm>
