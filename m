From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Mon, 12 Feb 2018 14:11:27 -0500
Subject: [GIT PULL] Integrity: IMA FUSE fixes
In-Reply-To: <CA+55aFxoLQ=FW7BkpyTHTQ6HJMW3a7fW-Ew0zrprRqwk-xwLTg@mail.gmail.com>
References: <alpine.LRH.2.21.1802101718330.4382@namei.org>
	<CA+55aFzX+=WRaVi51gaqCdnrxwXC3kqxk8LZyXQY=yn5XigE4Q@mail.gmail.com>
	<1518324116.5491.132.camel@linux.vnet.ibm.com>
	<CA+55aFxoLQ=FW7BkpyTHTQ6HJMW3a7fW-Ew0zrprRqwk-xwLTg@mail.gmail.com>
Message-ID: <1518462687.5491.310.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sat, 2018-02-10 at 20:50 -0800, Linus Torvalds wrote:
> On Sat, Feb 10, 2018 at 8:41 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> >>
> >> What am I missing?
> >
> > No, you're right.  The file could change at any time, making the
> > measurement(s) and by extension signature verification meaningless.
> > Custom policy rules could be defined to disable measurement,
> > appraisal, and audit for files on fuse.  However, I don't think we
> > want to automatically disable measurement, even meaningless
> > measurements.  Some indication needs to be included for remote
> > attestation, security analytics, or forensics.  For systems with
> > policies that require file signatures even on fuse, the safest thing
> > would seem to be to fail the signature verification.
> 
> Failing seems like a sane model, although I also suspect it would just
> break a lot of cases that currently work fine because *in*practice*
> fuse works fine as a normal filesystem (think fuse "exfat" module
> etc).
> 
> So yes, the failing behavior is sane, but I agree with you that it
> should be something that requires a specific policy ("fail on
> untrusted filesystems like fuse").

Could we differentiate between untrusted from unprivileged and
untrusted fuse? ?The existing fuse would continue to work, but on
systems with IMA-appraisal enabled the new, unprivileged fuse would
fail.

> But regardless, disabling caching just seems broken in all situations
> and never right, so I really don't want to pull that tree unless
> somebody can point out where it makes sense.

Agreed. ?Re-measuring/appraising the file would only detect well
behaved malicious fuse.

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
