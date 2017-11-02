From: dhowells@redhat.com (David Howells)
Date: Thu, 02 Nov 2017 21:30:11 +0000
Subject: [PATCH 03/27] Enforce module signatures if the kernel is locked
	down
In-Reply-To: <1509650031.3507.20.camel@linux.vnet.ibm.com>
References: <1509650031.3507.20.camel@linux.vnet.ibm.com>
	<1509130095.3716.13.camel@linux.vnet.ibm.com>
	<150842463163.7923.11081723749106843698.stgit@warthog.procyon.org.uk>
	<150842465546.7923.6762214527898273559.stgit@warthog.procyon.org.uk>
	<20240.1509643356@warthog.procyon.org.uk>
Message-ID: <12321.1509658211@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:

> By this point, IMA-appraisal has already verified the kernel module
> signature back in kernel_read_file_from_fd(), if it was required.
> ?Having a key with which to verify the appended signature or requiring
> an appended signature, should not be required as well.

I guess I don't need to put in any support for IMA here, then, and you've
taken care of it in your patchset such that it won't actually go into
module_sig_check() in that case (or will at least return immediately).

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
