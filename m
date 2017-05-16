From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 16 May 2017 09:01:56 +0200
Subject: [PATCH 0/5] Convert more books to ReST
In-Reply-To: <20170515111519.7bbb449b@lwn.net>
References: <cover.1494672881.git.mchehab@s-opensource.com>
	<20170515140912.100c9cac@bbrezillon>
	<20170515111519.7bbb449b@lwn.net>
Message-ID: <20170516090156.47d55338@bbrezillon>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Jonathan,

On Mon, 15 May 2017 11:15:19 -0600
Jonathan Corbet <corbet@lwn.net> wrote:

> On Mon, 15 May 2017 14:09:12 +0200
> Boris Brezillon <boris.brezillon@free-electrons.com> wrote:
> 
> > >   mtd: adjust kernel-docs to avoid Sphinx/kerneldoc warnings    
> > 
> > Not sure how you plan to merge these changes, but if it goes through
> > a single tree I'll probably need an immutable topic branch, because I
> > plan to change a few things in nand_base.c nand.h for the next release.  
> 
> docs-next doesn't rebase, so there shouldn't be trouble there.  But we
> could also just separate this patch into two pieces.  I suspect we could
> live with a couple of warnings for a period during the 4.13 merge window
> without too much pain...

I like this idea. This way I can take the nand_base.c/nand.h changes
through my tree and let you pick the Doc migration bits.

Thanks,

Boris
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
