From: greg@kroah.com (Greg KH)
Date: Wed, 11 Apr 2018 22:33:08 +0200
Subject: [PATCH 24/24] debugfs: Restrict debugfs when the kernel is
	locked down
In-Reply-To: <12769.1523477356@warthog.procyon.org.uk>
References: <20180411195436.GA7126@kroah.com>
	<152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk>
	<152346403637.4030.15247096217928429102.stgit@warthog.procyon.org.uk>
	<12769.1523477356@warthog.procyon.org.uk>
Message-ID: <20180411203308.GA10167@kroah.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Apr 11, 2018 at 09:09:16PM +0100, David Howells wrote:
> Greg KH <greg@kroah.com> wrote:
> 
> > Why not just disable debugfs entirely?  This half-hearted way to sorta
> > lock it down is odd, it is meant to not be there at all, nothing in your
> > normal system should ever depend on it.
> > 
> > So again just don't allow it to be mounted at all, much simpler and more
> > obvious as to what is going on.
> 
> Yeah, I agree - and then I got complaints because it seems that it's been
> abused to allow drivers and userspace components to communicate.

With in-kernel code?  Please let me know and I'll go fix it up to not
allow that, as that is not ok.

I do know of some bad examples of out-of-tree code abusing debugfs to do
crazy things (battery level monitoring?), but that's their own fault...

debugfs is for DEBUGGING!  For anything you all feel should be "secure",
then just disable it entirely.

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
