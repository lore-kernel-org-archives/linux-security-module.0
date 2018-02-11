From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Sat, 10 Feb 2018 23:41:56 -0500
Subject: [GIT PULL] Integrity: IMA FUSE fixes
In-Reply-To: <CA+55aFzX+=WRaVi51gaqCdnrxwXC3kqxk8LZyXQY=yn5XigE4Q@mail.gmail.com>
References: <alpine.LRH.2.21.1802101718330.4382@namei.org>
	<CA+55aFzX+=WRaVi51gaqCdnrxwXC3kqxk8LZyXQY=yn5XigE4Q@mail.gmail.com>
Message-ID: <1518324116.5491.132.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sat, 2018-02-10 at 12:44 -0800, Linus Torvalds wrote:
> On Fri, Feb 9, 2018 at 10:26 PM, James Morris <jmorris@namei.org> wrote:
> > These patches ensure that IMA works correctly on FUSE filesystems, so that
> > cached integrity data is not used.  FUSE filesystems can change this data
> > at any time without notifying the kernel and we now verify it for each
> > use.
> >
> > This work is late in the kernel cycle, but they have had good review,
> > testing, and acks.  They only impact FUSE and IMA.
> 
> This seems entirely insane.
> 
> You simply cannot use IMA on a fuse filesystem, because the data can
> change dynamically any time.
> 
> But that doesn't mean that you can't cache the measurements - it means
> that the measurements are pointless. Those are two completely
> different things.
> 
> This patch seems to disable caching, but still _use_ the measurement.
> 
> Which seems *worse* than what we do now, in that it wastes time and
> effort on re-creating those pointless measurements because it disables
> the caching of them.
> 
> So honestly, the only sane thing seems to be to disable IMA on fuse,
> not to force it to do even _more_ pointless work.
> 
> What am I missing?

No, you're right. ?The file could change at any time, making the
measurement(s) and by extension signature verification meaningless.?
Custom policy rules could be defined to disable measurement,
appraisal, and audit for files on fuse. ?However, I don't think we
want to automatically disable measurement, even meaningless
measurements. ?Some indication needs to be included for remote
attestation, security analytics, or forensics. ?For systems with
policies that require file signatures even on fuse, the safest thing
would seem to be to fail the signature verification.

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
