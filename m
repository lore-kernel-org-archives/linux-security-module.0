Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF27A27E1D5;
	Tue, 18 Nov 2025 23:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763510371; cv=none; b=MMQhpl3plbaA9z2V3+LgnEiSwV3z6Z+LN/8H6R/IjRHiy6ldVFHFSZF60InrRObOXoXuo6eDDHL4A/B5lni5fAGr4D/9Xm4dFBpAKTUdAPbam7yl6x18s/3IHci4eVjPWfN9QPumtsndpMTcKpU5go+jWEOC2aK47QYbr1gvpoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763510371; c=relaxed/simple;
	bh=wmj6s2ji5hLtrtTuz6IwOWyg8oVo0ZGuktIuy7NTs/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aHi2ZXgitBbkaGLFwnNzTwznMCgFWYGmjdRCOYXxB0bEnvWXxwgsB//b/lVvt85c37lAAXJZLKP/bAgS+x0NhBaQiQmnUSOmUmSKWMSfPJMyI8mtGgdbe5hmgs9QVSRpiXdiORRHvS8kj1avgiFFErhUPGqQQ0WSZt82AjPt3PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id BD73B43C; Tue, 18 Nov 2025 17:59:25 -0600 (CST)
Date: Tue, 18 Nov 2025 17:59:25 -0600
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Paul Moore <paul@paul-moore.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>,
	lkml <linux-kernel@vger.kernel.org>,
	linux-security-module@vger.kernel.org,
	Ryan Foster <foster.ryan.r@gmail.com>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH] Clarify the rootid_owns_currentns
Message-ID: <aR0IXXF45jzoq1ZZ@mail.hallyn.com>
References: <aRegH8P4cPlzzlX9@mail.hallyn.com>
 <aRx/1MvvBqu5MhKv@mail.hallyn.com>
 <CAHC9VhQu7gSVO-QZFE_iaCB0qBqB3surdHQo4Vg71zc890uEhA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhQu7gSVO-QZFE_iaCB0qBqB3surdHQo4Vg71zc890uEhA@mail.gmail.com>

On Tue, Nov 18, 2025 at 10:47:06AM -0500, Paul Moore wrote:
> On Tue, Nov 18, 2025 at 9:16 AM Serge E. Hallyn <serge@hallyn.com> wrote:
> > On Fri, Nov 14, 2025 at 03:33:19PM -0600, Serge E. Hallyn wrote:
> > > Split most of the rootid_owns_currentns() functionality
> > > into a more generic rootid_owns_ns() function which
> > > will be easier to write tests for.
> > >
> > > Rename the functions and variables to make clear that
> > > the ids being tested could be any uid.
> > >
> > > Signed-off-by: Serge Hallyn <serge@hallyn.com>
> > > CC: Ryan Foster <foster.ryan.r@gmail.com>
> > > CC: Christian Brauner <brauner@kernel.org>
> >
> > Paul, Christian, let me know if you have any objections, else I will
> > queue this up in caps-next.
> 
> Seems reasonable to me, but it would be good to fix the parameter doc
> bug that the kernel test robot identified.  I suspect it is just the
> extra vertical comment space between the top one line summary and the
> parameter list.

ooh, is that it.  I couldn't for the life of me figure out what it
was complaining about.  Will try that, thanks.
