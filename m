From: dhowells@redhat.com (David Howells)
Date: Thu, 06 Apr 2017 09:41:00 +0100
Subject: [PATCH 11/24] uswsusp: Disable when the kernel is locked down
In-Reply-To: <1491460792.1645.1.camel@suse.com>
References: <1491460792.1645.1.camel@suse.com>
	<149142326734.5101.4596394505987813763.stgit@warthog.procyon.org.uk>
	<149142336965.5101.2946578135980499557.stgit@warthog.procyon.org.uk>
	<CAJZ5v0hp=GJtQ+YnNdaMw6rtbBzNyueY+iqjPkHLKp57t822ZQ@mail.gmail.com>
Message-ID: <14980.1491468060@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Oliver Neukum <oneukum@suse.com> wrote:

> Your swap partition may be located on an NVDIMM or be encrypted.

An NVDIMM should be considered the same as any other persistent storage.

It may be encrypted, but where's the key stored, how easy is it to retrieve
and does the swapout code know this?

> Isn't this a bit overly drastic?

Perhaps, but if it's on disk and it's not encrypted, then maybe not.

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
