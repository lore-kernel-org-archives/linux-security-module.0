From: dhowells@redhat.com (David Howells)
Date: Sat, 22 Sep 2018 01:03:40 +0100
Subject: [PATCH resend] uapi/linux/keyctl.h: don't use C++ reserved
	keyword as a struct member name
In-Reply-To: <20180910150903.249031442dd7fe43e01812cf@linux-foundation.org>
References: <20180910150903.249031442dd7fe43e01812cf@linux-foundation.org>
	<0db6c314-1ef4-9bfa-1baa-7214dd2ee061@infradead.org>
	<20180909220018.GH13219@asgard.redhat.com>
Message-ID: <19867.1537574620@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Andrew Morton <akpm@linux-foundation.org> wrote:

> Are there such programs?  Do they reference the `private' field?

They would use the keyutils.h header from keyutils package probably.  There
the field was named "priv" not "private".  The kernel's UAPI header should be
amended again to match that.

David
