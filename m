From: dhowells@redhat.com (David Howells)
Date: Thu, 06 Apr 2017 13:54:23 +0100
Subject: [PATCH 1/5] efi: Move the x86 secure boot switch to generic code
In-Reply-To: <149148299794.3427.549144000807596903.stgit@warthog.procyon.org.uk>
References: <149148299794.3427.549144000807596903.stgit@warthog.procyon.org.uk>
Message-ID: <3598.1491483263@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Sorry, I forgot to include a cover note.

These five patches would replace 1-3 & 6 from my Kernel Lockdown series.  The
additional patch moves the secure boot switch from x86 to generic code.

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
