From: dhowells@redhat.com (David Howells)
Date: Fri, 28 Apr 2017 16:47:37 +0100
Subject: [PATCH v4 3/4] KEYS: Support for inserting a certificate into x86
	bzImage
In-Reply-To: <73122870-E138-4DA5-90C9-91CB664E7DF1@linux.vnet.ibm.com>
References: <73122870-E138-4DA5-90C9-91CB664E7DF1@linux.vnet.ibm.com>
	<1492727320-26194-4-git-send-email-mkayaalp@linux.vnet.ibm.com>
	<1492727320-26194-1-git-send-email-mkayaalp@linux.vnet.ibm.com>
	<13470.1493301291@warthog.procyon.org.uk>
Message-ID: <486.1493394457@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com> wrote:

> >> +	/* TODO: update CRC */
> > 
> > Is this bit missing?
> 
> I didn't add it, since I wasn't sure it was still used with secure boot.

I'm not sure why secure boot would skip it if normal boot does it.  You'll
have to trawl the boot wrapper and kernel arch setup code to answer that one.

> The CRC code is implemented in multiple places, but not exposed to the
> tools/scripts.  Should I make the crc32() in tools/pcmcia/crc32hash.c
> non-static, maybe?

Making it non-static won't help since it's a standalone program.  You could
just shift it to scripts or something.

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
