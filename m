From: ben@decadent.org.uk (Ben Hutchings)
Date: Tue, 18 Apr 2017 18:39:18 +0100
Subject: [PATCH 15/24] asus-wmi: Restrict debugfs interface when the
	kernel is locked down
In-Reply-To: <16503.1492529434@warthog.procyon.org.uk>
References: <1492526075.2409.140.camel@decadent.org.uk>
	<149142326734.5101.4596394505987813763.stgit@warthog.procyon.org.uk>
	<149142340198.5101.8171352010918423590.stgit@warthog.procyon.org.uk>
	<CAHp75VfpsnCHVqnFnwwh3JHB0ccY66Gj88sMGhrA9W7rDxiY_Q@mail.gmail.com>
	<31421.1491569449@warthog.procyon.org.uk>
	<CAHp75VfvWmv7SxgwCgR-ZBYPbeQW=+qesDoBNC5JFPtvzsN5gg@mail.gmail.com>
	<13615.1491830208@warthog.procyon.org.uk>
	<CAHp75Vd+-_CmW2MPpK3b6bER8bFmECusnx0BZMwYAizWZys4YA@mail.gmail.com>
	<16503.1492529434@warthog.procyon.org.uk>
Message-ID: <1492537158.2409.147.camel@decadent.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 2017-04-18 at 16:30 +0100, David Howells wrote:
> Ben Hutchings <ben@decadent.org.uk> wrote:
> 
> > So it's generally not going to be OK to turn off debugfs.??There will
> > probably need to be a distinction between believed-safe and unsafe
> > directories/files.
> 
> Any suggestion on how to mark this distinction?

I don't know.

> I'd prefer not to modify every read/write op associated with a
> debugfs file.

I think debugfs should be assumed unsafe by default.  So only the
believed-safe parts would need to be changed.

> Modify
> DEFINE_DEBUGFS_ATTRIBUTE() maybe???And provide lockable variants of
> debugfs_create_u8() and co.?

That could help.

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
URL: <http://kernsec.org/pipermail/linux-security-module-archive/attachments/20170418/ba79ccb8/attachment.sig>
