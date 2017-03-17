From: mathew.j.martineau@linux.intel.com (Mat Martineau)
Date: Thu, 16 Mar 2017 17:47:02 -0700 (PDT)
Subject: [PATCH v12 06/10] KEYS: Consistent ordering for __key_link_begin
	and restrict check
In-Reply-To: <23615.1489659445@warthog.procyon.org.uk>
References: <20170309202315.15361-7-mathew.j.martineau@linux.intel.com>
	<20170309202315.15361-1-mathew.j.martineau@linux.intel.com>
	<23615.1489659445@warthog.procyon.org.uk>
Message-ID: <alpine.OSX.2.20.1703161654010.36452@suhwanki-mobl.amr.corp.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 16 Mar 2017, David Howells wrote:

> Mat Martineau <mathew.j.martineau@linux.intel.com> wrote:
>
>> The keyring restrict callback was sometimes called before
>> __key_link_begin and sometimes after, which meant that the keyring
>> semaphores were not always held during the restrict callback.
>>
>> If the semaphores are consistently acquired before checking link
>> restrictions, keyring contents cannot be changed after the restrict
>> check is complete but before the evaluated key is linked to the keyring.
>
> I'm still not entirely sure that this gains us anything.  At the point we did
> the restriction check, the key was validated.  Yes, the keyring can be
> modified between then and the actual link, thereby rendering the chain broken
> - but this is true after the link also.  The whole point is that it was valid
> at the time of asking.
>
> Mainly I have an aversion to doing things under a lock when I can do it
> outside of the lock.

Restriction methods can consider the contents of the keyring being linked 
to, and they can't really be thought of as enforcing invariants on the 
contents of the keyring without this patch.

This locking change had more concrete consequences before 
KEYCTL_RESTRICT_KEYRING, when you could add the first cert to an empty 
keyring without a signature check and all later additions would verify 
signatures based on certificates already in the keyring. It would have 
been possible to add multiple certs (that hadn't signed each other) to an 
empty keyring if the keys were both checked before they were linked.

In the current iteration of the patch set, it comes down to enforcing 
invariants (as I mentioned above) and consistency in lock/check ordering 
across different code paths. Restriction functions (present or future) 
can't offer a consistency or security guarantee about the state of the 
keyring if the contents of the keyring can change between the check and 
the link. I share your locking aversion, but think this is a case where 
a lock is needed.

> Btw, do you check for cycles anywhere?  For example, if I create two keyrings,
> A and B, and can I then set restrictions such that A is restricted by B and B
> is restricted by A?

I don't check for cycles yet, but the references held by the restrictions 
could be a problem. I'm not sure how to address it yet, I could clear the 
restriction info when a keyring is revoked/dead/etc or I could check when 
restrictions are created.

--
Mat Martineau
Intel OTC
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
