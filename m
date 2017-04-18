From: dhowells@redhat.com (David Howells)
Date: Tue, 18 Apr 2017 16:30:34 +0100
Subject: [PATCH 15/24] asus-wmi: Restrict debugfs interface when the
	kernel is locked down
In-Reply-To: <1492526075.2409.140.camel@decadent.org.uk>
References: <1492526075.2409.140.camel@decadent.org.uk>
	<149142326734.5101.4596394505987813763.stgit@warthog.procyon.org.uk>
	<149142340198.5101.8171352010918423590.stgit@warthog.procyon.org.uk>
	<CAHp75VfpsnCHVqnFnwwh3JHB0ccY66Gj88sMGhrA9W7rDxiY_Q@mail.gmail.com>
	<31421.1491569449@warthog.procyon.org.uk>
	<CAHp75VfvWmv7SxgwCgR-ZBYPbeQW=+qesDoBNC5JFPtvzsN5gg@mail.gmail.com>
	<13615.1491830208@warthog.procyon.org.uk>
	<CAHp75Vd+-_CmW2MPpK3b6bER8bFmECusnx0BZMwYAizWZys4YA@mail.gmail.com>
Message-ID: <16503.1492529434@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Ben Hutchings <ben@decadent.org.uk> wrote:

> So it's generally not going to be OK to turn off debugfs.  There will
> probably need to be a distinction between believed-safe and unsafe
> directories/files.

Any suggestion on how to mark this distinction?  I'd prefer not to modify
every read/write op associated with a debugfs file.  Modify
DEFINE_DEBUGFS_ATTRIBUTE() maybe?  And provide lockable variants of
debugfs_create_u8() and co.?

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
