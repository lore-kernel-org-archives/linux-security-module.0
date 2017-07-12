From: serge@hallyn.com (Serge E. Hallyn)
Date: Wed, 12 Jul 2017 12:32:37 -0500
Subject: [PATCH v2] xattr: Enable security.capability in user namespaces
In-Reply-To: <8c3e8c6f-52c5-5b04-8cad-1aeae25f0ec6@linux.vnet.ibm.com>
References: <1499785511-17192-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1499785511-17192-2-git-send-email-stefanb@linux.vnet.ibm.com>
	<20170712034503.GA8270@mail.hallyn.com>
	<8c3e8c6f-52c5-5b04-8cad-1aeae25f0ec6@linux.vnet.ibm.com>
Message-ID: <20170712173237.GA18391@mail.hallyn.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Quoting Stefan Berger (stefanb at linux.vnet.ibm.com):
> On 07/11/2017 11:45 PM, Serge E. Hallyn wrote:
> >Quoting Stefan Berger (Stefan Bergerstefanb at linux.vnet.ibm.com):
> >>+/*
> >>+ * xattr_list_userns_rewrite - Rewrite list of xattr names for user namespaces
> >>+ *                             or determine needed size for attribute list
> >>+ *                             in case size == 0
> >>+ *
> >>+ * In a user namespace we do not present all extended attributes to the
> >>+ * user. We filter out those that are in the list of userns supported xattr.
> >>+ * Besides that we filter out those with @uid=<uid> when there is no mapping
> >>+ * for that uid in the current user namespace.
> >>+ *
> >>+ * @list:        list of 0-byte separated xattr names
> >>+ * @size:        the size of the list; may be 0 to determine needed list size
> >>+ * @list_maxlen: allocated buffer size of list
> >>+ */
> >>+static ssize_t
> >>+xattr_list_userns_rewrite(char *list, ssize_t size, size_t list_maxlen)
> >>+{
> >>+	char *nlist = NULL;
> >>+	size_t s_off, len, nlen;
> >>+	ssize_t d_off;
> >>+	char *name, *newname;
> >>+
> >>+	if (!list || size < 0 || current_user_ns() == &init_user_ns)
> >>+		return size;
> >>+
> >>+	if (size) {
> >>+		nlist = kmalloc(list_maxlen, GFP_KERNEL);
> >>+		if (!nlist)
> >>+			return -ENOMEM;
> >>+	}
> >>+
> >>+	s_off = d_off = 0;
> >>+	while (s_off < size || size == 0) {
> >>+		name = &list[s_off];
> >>+
> >>+		len = strlen(name);
> >>+		if (!len)
> >>+			break;
> >>+
> >>+		if (xattr_is_userns_supported(name, false) >= 0)
> >>+			newname = name;
> >>+		else {
> >>+			newname = xattr_rewrite_userns_xattr(name);
> >Why are you doing this here?  If we get here it means that
> >xattr_is_userns_supported() returned < 0, meaning name is
> >not userns-supported.  So xattr_rewrite_userns_xattr() will
> >just return name.  Am I missing something?
> 
> xattr_is_userns_support(name, false) does a _full string match_
> rather than a prefix match and will only return >= 0 for
> security.capability. This case handles the hosts's
> security.capability which  'shines through' for read and needs to be
> listed. Only in this case we set newname=name.

Ah, right.

I think it would be worth #defining XATTR_PREFIX_SEARCH and
XATTR_FULLNAME_SEARCH or something.  Or maybe not, maybe I was
just being dense.

> In the else branch we handle security.capability at uid=1000 and
> rewrite that to security.capability for root mapping to uid=1000.
> 
> >
> >>+			if (IS_ERR(newname)) {
> >>+				d_off = PTR_ERR(newname);
> >>+				goto out_free;
> >>+			}
> >>+		}
> >>+		if (newname && !xattr_list_contains(nlist, d_off, newname)) {
> >Now here, if name was recalculated to @newname, and @newname is
> >found in the nlist, that should raise an error right?  Something
> >fishy is going on?
> 
> If security.capability is set on a file but the container doesn't
> have security.capability at uid=1000, we still need to list the former
> here. However, we end up with duplicates if security.capability is
> there and security.capability at uid=1000 is also there and root is
> mapped to uid=1000. Both would be shown as security.capability
> inside the container. In this case we need to filter.

Gotcha, thanks.

> I think the code is correct. More problematic is a memory leak in
> the error case. Will fix that.

Great.

> >
> >>+			nlen = strlen(newname);
> >>+
> >>+			if (nlist) {
> >>+				if (nlen + 1 > list_maxlen)
> >d_off needs to be set to -ERANGE here.
> 
> Fixed.

Great, thanks.

-serge
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
