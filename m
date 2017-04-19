From: dhowells@redhat.com (David Howells)
Date: Wed, 19 Apr 2017 16:29:48 +0100
Subject: [PATCH 06/38] Annotate hardware config module parameters in
	drivers/clocksource/
In-Reply-To: <9f97544c-cb49-c2a3-ecec-7840386d9281@ADLINKtech.com>
References: <9f97544c-cb49-c2a3-ecec-7840386d9281@ADLINKtech.com>
	<149141141298.29162.5612793122429261720.stgit@warthog.procyon.org.uk>
	<149141145858.29162.13072730133817038218.stgit@warthog.procyon.org.uk>
	<alpine.DEB.2.20.1704142021320.2327@nanos>
Message-ID: <25530.1492615788@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Jens Rottmann <Jens.Rottmann@ADLINKtech.com> wrote:

> > When the kernel is running in secure boot mode [...] prevent
> > access by means of configuring driver modules
> 
> I may easily be wrong, but doesn't secure boot require EFI?

For the patches I have, yes.  It could feasibly be done by some other
mechanism, though I don't know that such an alternative exists.

> Do secure boot capable systems with old CS5535/36 even exist?

No idea.

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
