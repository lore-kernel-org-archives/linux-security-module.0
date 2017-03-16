From: dhowells@redhat.com (David Howells)
Date: Thu, 16 Mar 2017 10:17:25 +0000
Subject: [PATCH v12 06/10] KEYS: Consistent ordering for __key_link_begin
	and restrict check
In-Reply-To: <20170309202315.15361-7-mathew.j.martineau@linux.intel.com>
References: <20170309202315.15361-7-mathew.j.martineau@linux.intel.com>
	<20170309202315.15361-1-mathew.j.martineau@linux.intel.com>
Message-ID: <23615.1489659445@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Mat Martineau <mathew.j.martineau@linux.intel.com> wrote:

> The keyring restrict callback was sometimes called before
> __key_link_begin and sometimes after, which meant that the keyring
> semaphores were not always held during the restrict callback.
> 
> If the semaphores are consistently acquired before checking link
> restrictions, keyring contents cannot be changed after the restrict
> check is complete but before the evaluated key is linked to the keyring.

I'm still not entirely sure that this gains us anything.  At the point we did
the restriction check, the key was validated.  Yes, the keyring can be
modified between then and the actual link, thereby rendering the chain broken
- but this is true after the link also.  The whole point is that it was valid
at the time of asking.

Mainly I have an aversion to doing things under a lock when I can do it
outside of the lock.

Btw, do you check for cycles anywhere?  For example, if I create two keyrings,
A and B, and can I then set restrictions such that A is restricted by B and B
is restricted by A?

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
