From: ben@decadent.org.uk (Ben Hutchings)
Date: Tue, 18 Apr 2017 15:34:35 +0100
Subject: [PATCH 15/24] asus-wmi: Restrict debugfs interface when the
	kernel is locked down
In-Reply-To: <CAHp75Vd+-_CmW2MPpK3b6bER8bFmECusnx0BZMwYAizWZys4YA@mail.gmail.com>
References: <149142326734.5101.4596394505987813763.stgit@warthog.procyon.org.uk>
	<149142340198.5101.8171352010918423590.stgit@warthog.procyon.org.uk>
	<CAHp75VfpsnCHVqnFnwwh3JHB0ccY66Gj88sMGhrA9W7rDxiY_Q@mail.gmail.com>
	<31421.1491569449@warthog.procyon.org.uk>
	<CAHp75VfvWmv7SxgwCgR-ZBYPbeQW=+qesDoBNC5JFPtvzsN5gg@mail.gmail.com>
	<13615.1491830208@warthog.procyon.org.uk>
	<CAHp75Vd+-_CmW2MPpK3b6bER8bFmECusnx0BZMwYAizWZys4YA@mail.gmail.com>
Message-ID: <1492526075.2409.140.camel@decadent.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 2017-04-18 at 09:06 +0300, Andy Shevchenko wrote:
> > On Mon, Apr 10, 2017 at 4:16 PM, David Howells <dhowells@redhat.com> wrote:
> > > > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > 
> > > > > It looks a bit fragile when responsility of whatever reasons kernel
> > > > > can't serve become a driver burden.
> > > > > Can we fix this in debugfs framework instead?
> > > > 
> > > > Fix it with debugfs how???We can't offload the decision to userspace.
> > > 
> > > I mean to do at least similar like you have done for module
> > > parameters. So, instead of putting above code to each attribute in
> > > question make a special (marked) attribute instead and debugfs
> > > framework will know how to deal with that.
> > 
> > Hmmm...??It's tricky in that debugfs doesn't have any of its own structures,
> > but is entirely built on standard VFS ones, so finding somewhere to store the
> > information is going to be awkward.
> 
> I see.
> 
> > ?One obvious solution is to entirely lock
> > down debugfs in secure boot more, but that might be a bit drastic.
> 
> But this sounds sane! debugFS for debugging, not for production. If
> someone is using secure kernel it means pure production use (otherwise
> one may do temporary hacks in kernel).
[...]

Production systems need instrumentation to understand performance
issues and any bugs that?for whatever reason didn't show up in earlier
testing.  A number of interfaces for that have been added under
debugfs:

- tracing (now tracefs, but it's expected to appear under debugfs)
- dynamic_debug
- various ad-hoc statistics

So it's generally not going to be OK to turn off debugfs.  There will
probably need to be a distinction between believed-safe and unsafe
directories/files.

Ben.

-- 
Ben Hutchings
The world is coming to an end.	Please log off.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://kernsec.org/pipermail/linux-security-module-archive/attachments/20170418/a2cd5310/attachment.sig>
