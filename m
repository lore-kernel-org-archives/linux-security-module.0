From: dhowells@redhat.com (David Howells)
Date: Fri, 17 Mar 2017 07:43:23 +0000
Subject: [PATCH v12 06/10] KEYS: Consistent ordering for __key_link_begin
	and restrict check
In-Reply-To: <alpine.OSX.2.20.1703161654010.36452@suhwanki-mobl.amr.corp.intel.com>
References: <alpine.OSX.2.20.1703161654010.36452@suhwanki-mobl.amr.corp.intel.com>
	<20170309202315.15361-7-mathew.j.martineau@linux.intel.com>
	<20170309202315.15361-1-mathew.j.martineau@linux.intel.com>
	<23615.1489659445@warthog.procyon.org.uk>
Message-ID: <19834.1489736603@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Mat Martineau <mathew.j.martineau@linux.intel.com> wrote:

> > Btw, do you check for cycles anywhere?  For example, if I create two keyrings,
> > A and B, and can I then set restrictions such that A is restricted by B and B
> > is restricted by A?
> 
> I don't check for cycles yet, but the references held by the restrictions
> could be a problem. I'm not sure how to address it yet, I could clear the
> restriction info when a keyring is revoked/dead/etc or I could check when
> restrictions are created.

Yep.

The way to do it is to store the pointer to the restriction keyring in the
restriction record and then when you set a restriction on keyring A that
refers to keyring B as a source of authority, you go to B's restriction record
and if it points to A, say no, if it points to C, go to C's record and if it
points to A, say no, if it points to D, go to D's record and so on and so on -
all whilst under a master lock.

As the above algorithm only has one pointer to follow each time, it can be
done iteratively, so no particular stack overhead.  And as a lock is held
whilst you do the check and the add, you can't get one process adding an A->B
dependency whilst another adds B->A.

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
