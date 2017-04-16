From: matt@codeblueprint.co.uk (Matt Fleming)
Date: Sun, 16 Apr 2017 21:46:21 +0100
Subject: [PATCH 06/24] Add a sysrq option to exit secure boot mode
In-Reply-To: <alpine.DEB.2.20.1704142003570.2327@nanos>
References: <149142326734.5101.4596394505987813763.stgit@warthog.procyon.org.uk>
	<149142332458.5101.14654616837280513947.stgit@warthog.procyon.org.uk>
	<alpine.DEB.2.20.1704142003570.2327@nanos>
Message-ID: <20170416204621.GA24360@codeblueprint.co.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, 14 Apr, at 08:05:07PM, Thomas Gleixner wrote:
> On Wed, 5 Apr 2017, David Howells wrote:
> 
> > From: Kyle McMartin <kyle@redhat.com>
> > 
> > Make sysrq+x exit secure boot mode on x86_64, thereby allowing the running
> > kernel image to be modified.  This lifts the lockdown.
> > 
> > Signed-off-by: Kyle McMartin <kyle@redhat.com>
> > Signed-off-by: David Howells <dhowells@redhat.com>
> > cc: x86 at kernel.org
> 
> Matt, Ard?
> 
> Any opinions on this?

Looks OK to me.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
