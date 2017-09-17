From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Sun, 17 Sep 2017 12:15:35 -0400
Subject: [PATCH 3/3] ima: use fs method to read integrity data (updated
	patch description)
In-Reply-To: <CA+55aFyrZ=YsfNc1vp=vArNgotLXGPr4F6uZiz22Uj2XHGUvaw@mail.gmail.com>
References: <1505451494-30228-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1505451494-30228-4-git-send-email-zohar@linux.vnet.ibm.com>
	<1505507142.4200.103.camel@linux.vnet.ibm.com>
	<CA+55aFxmeff53zeioTiQY6m=F18ekgX1-HWZyQUor=NJYrxM9A@mail.gmail.com>
	<20170917151757.GA14262@infradead.org>
	<CA+55aFyrZ=YsfNc1vp=vArNgotLXGPr4F6uZiz22Uj2XHGUvaw@mail.gmail.com>
Message-ID: <1505664935.4200.191.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, 2017-09-17 at 08:28 -0700, Linus Torvalds wrote:
> On Sun, Sep 17, 2017 at 8:17 AM, Christoph Hellwig <hch@infradead.org> wrote:
> >
> > Only for direct I/O, and IMA and direct I/O don't work together.
> > From ima_collect_measurement:
> >
> >                 if (file->f_flags & O_DIRECT) {
> >                         audit_cause = "failed(directio)";
> >                         result = -EACCES;
> >                         goto out;
> >                 }
> 
> That's not the issue.
> 
> The issue is that somebody else can come in - using direct IO - at the
> same time as the first person is collecting measurements, and thus
> race with the collector.
> 
> So now the measurements are not trustworthy any more.

Unless I'm missing something, that would only be possible with an IMA
policy rule that permits direct IO (eg. permit_directio). ?Otherwise
the direct IO is denied.

> > Well, that's exactly the point of the new ->integrity_read routine
> > I proposed and prototype.  The important thing is that it is called
> > with i_rwsem held because code mugh higher in the chain already
> > acquired it, but except for that it's entirely up to the file system.
> 
> .. and *my* point is that it's the wrong lock for actually checking
> integrity (it doesn't actually guarantee exclusion, even though in
> practice it's almost always the case), and so we're adding a nasty
> callback that in 99% of all cases is the same as the normal read, and
> we *could* have just added it with a RWF flag instead.
> 
> Is there some reason why integrity has to use that particular lock
> that is so inconvenient for the filesystems it wants to check?

Originally IMA had its own lock (iint->mutex), prior to IMA-appraisal
being upstreamed. ?With a separate lock, the iint->mutex and i_rwsem
would be taken in reverse order in process_measurements() and in the
setxattr, chown, chmod syscalls.

I'm at the airport on my way back home.

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
