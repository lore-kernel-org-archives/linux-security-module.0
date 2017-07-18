From: vgoyal@redhat.com (Vivek Goyal)
Date: Tue, 18 Jul 2017 07:48:49 -0400
Subject: [PATCH v2] xattr: Enable security.capability in user namespaces
In-Reply-To: <7a39e8a6-a33b-f6a8-3fd5-6211c075ab91@linux.vnet.ibm.com>
References: <1499785511-17192-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1499785511-17192-2-git-send-email-stefanb@linux.vnet.ibm.com>
	<20170717185811.GC15794@redhat.com>
	<7a39e8a6-a33b-f6a8-3fd5-6211c075ab91@linux.vnet.ibm.com>
Message-ID: <20170718114849.GA8233@redhat.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Jul 17, 2017 at 04:50:22PM -0400, Stefan Berger wrote:
> On 07/17/2017 02:58 PM, Vivek Goyal wrote:
> > On Tue, Jul 11, 2017 at 11:05:11AM -0400, Stefan Berger wrote:
> > 
> > [..]
> > > +/*
> > > + * xattr_list_userns_rewrite - Rewrite list of xattr names for user namespaces
> > > + *                             or determine needed size for attribute list
> > > + *                             in case size == 0
> > > + *
> > > + * In a user namespace we do not present all extended attributes to the
> > > + * user. We filter out those that are in the list of userns supported xattr.
> > > + * Besides that we filter out those with @uid=<uid> when there is no mapping
> > > + * for that uid in the current user namespace.
> > > + *
> > > + * @list:        list of 0-byte separated xattr names
> > > + * @size:        the size of the list; may be 0 to determine needed list size
> > > + * @list_maxlen: allocated buffer size of list
> > > + */
> > > +static ssize_t
> > > +xattr_list_userns_rewrite(char *list, ssize_t size, size_t list_maxlen)
> > > +{
> > > +	char *nlist = NULL;
> > > +	size_t s_off, len, nlen;
> > > +	ssize_t d_off;
> > > +	char *name, *newname;
> > > +
> > > +	if (!list || size < 0 || current_user_ns() == &init_user_ns)
> > size will never be less than 0 here. Only caller calls this function only
> > if size is >0. So can we remove this?
> 
> Correct.
> 
> > 
> > What about case of "!list". So if user space called listxattr(foo, NULL,
> > 0), we want to return the size of buffer as if all the xattrs will be
> > returned to user space. But in practice we probably will filter out some
> > xattrs so actually returned string will be smaller than size reported
> > previously.
> 
> This case of size=0 is a problem in userns. Depending on the mapping of the
> userid's the list can expand. A security.foo at uid=100 can become
> security.foo at uid=100000, if the mapping is set up so that uid 100 on the
> host becomes uid 100000 inside the container. So for now we only have
> security.capability and the way I solved this is by allocating a 65k buffer
> when calling from a userns. In this buffer where we gather the xattr names
> and then walk them to determine the size that's needed for the buffer by
> simulating the rewriting. It's not nice but I don't know of any other
> solution.

Hi Stefan,

For the case of size==0, why don't we iterate through all the xattr,
filter them, remap them and then return the size to process in user
namespace. That should fix this? I thought that's what
xattr_list_userns_rewrite() was doing. But looks like this logic will not
kick in for the case of size==0 due to "!list" condition.

Also we could probably replace "!list" with "!size" wheverever required.
Its little easy to read and understand.

For the other case where some xattrs can get filtered out and we report
a buffer size bigger than actually needed, I am hoping that its acceptable
and none of the existing users are broken.

Thanks
Vivek
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
