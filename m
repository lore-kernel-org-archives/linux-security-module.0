From: dhowells@redhat.com (David Howells)
Date: Fri, 11 May 2018 13:20:40 +0100
Subject: [PATCH 05/24] apparmor: Implement security hooks for the new
	mount API [ver #7]
In-Reply-To: <4eaa0e19-684c-bef8-5aea-ddb5ef30828e@canonical.com>
References: <4eaa0e19-684c-bef8-5aea-ddb5ef30828e@canonical.com>
	<152414466005.23902.12967974041384198114.stgit@warthog.procyon.org.uk>
	<152414469709.23902.10439448759049886690.stgit@warthog.procyon.org.uk>
Message-ID: <21733.1526041240@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

John Johansen <john.johansen@canonical.com> wrote:

> this looks good, and has pasted the testing that I have done so far. I
> have started on the work that will allow us to reorder the match but
> its not ready yet and shouldn't hold this up.

Excellent, thanks!

One thing to consider: Kent Overstreet mentioned the possibility of adding
support for multiple sources - something that his bcachefs would require.

>From the userspace PoV this could look something like:

	fd = fsopen("bcachefs");
	write(fd, "d /dev/sda1");
	write(fd, "d /dev/sda2");
	...

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
