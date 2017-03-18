From: dhowells@redhat.com (David Howells)
Date: Sat, 18 Mar 2017 08:10:05 +0000
Subject: [PATCH v12 06/10] KEYS: Consistent ordering for __key_link_begin
	and restrict check
In-Reply-To: <alpine.OSX.2.20.1703171149440.51649@mjmartin-mac01.sea.intel.com>
References: <alpine.OSX.2.20.1703171149440.51649@mjmartin-mac01.sea.intel.com>
	<alpine.OSX.2.20.1703161654010.36452@suhwanki-mobl.amr.corp.intel.com>
	<20170309202315.15361-7-mathew.j.martineau@linux.intel.com>
	<20170309202315.15361-1-mathew.j.martineau@linux.intel.com>
	<23615.1489659445@warthog.procyon.org.uk>
	<19834.1489736603@warthog.procyon.org.uk>
Message-ID: <28519.1489824605@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Mat Martineau <mathew.j.martineau@linux.intel.com> wrote:

> Do we go back to the simpler restriction record (just a key pointer, no void*,
> no free_data) so we can detect cycles without the stack overhead of a
> depth-first search, like this?

Sure.  We can always add data in future.

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
