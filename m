From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Wed, 16 Aug 2017 16:59:13 -0400
Subject: [RFC PATCH 2/4] ima: define new ima_sb_post_new_mount hook
In-Reply-To: <63522b3b-5e61-f760-5f74-f9fbe44741f5@schaufler-ca.com>
References: <1502904620-20075-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1502904620-20075-3-git-send-email-zohar@linux.vnet.ibm.com>
	<63522b3b-5e61-f760-5f74-f9fbe44741f5@schaufler-ca.com>
Message-ID: <1502917153.21278.48.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 2017-08-16 at 12:24 -0700, Casey Schaufler wrote:
> On 8/16/2017 10:30 AM, Mimi Zohar wrote:

> > diff --git a/security/security.c b/security/security.c
> > index 592153e8d2b6..79111141b383 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -402,6 +402,7 @@ void security_sb_post_new_mount(const struct vfsmount *newmnt,
> >  				const struct path *path)
> >  {
> >  	call_void_hook(sb_post_new_mount, newmnt, path);
> > +	ima_sb_post_new_mount(newmnt, path);
> 
> Have you thought about converting the IMA code into
> a security module that gets loaded after all the others?
> That would make this (and several other similar instances)
> bit of special case code go away.

Yes, each time I need to add another IMA call, where there isn't an
existing LSM hook, a decision needs to be made as to whether it needs
to be a generic LSM hook or not.

Assuming we made IMA an LSM module, what would we do with these other
calls? ?Would they need to be converted to LSM hooks? ?(Are all LSMs
visited, even if an earlier LSM fails? ?Or does the first LSM failure,
stop the LSM traversal?)

Unlike LSMs which are sharing the i_sec, IMA doesn't have an entry in
the inode, but does an rbtree lookup to access the associated data.
?Having an i_sec would simplify a lot of the code, but making this
sort of change would be a major undertaking.

In this context, I'm not sure what you mean by "loaded".? IMA needs to
be enabled from the very beginning to capture all measurements and
verify the integrity of files, without any gaps. ?At some point this
would include other LSM policies. ?IMA certainly cannot be loaded late
like kernel modules.

Similarly, we would need to think about EVM.

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
