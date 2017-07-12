From: serge@hallyn.com (Serge E. Hallyn)
Date: Tue, 11 Jul 2017 22:45:03 -0500
Subject: [PATCH v2] xattr: Enable security.capability in user namespaces
In-Reply-To: <1499785511-17192-2-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1499785511-17192-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1499785511-17192-2-git-send-email-stefanb@linux.vnet.ibm.com>
Message-ID: <20170712034503.GA8270@mail.hallyn.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Quoting Stefan Berger (Stefan Bergerstefanb at linux.vnet.ibm.com):
> +/*
> + * xattr_list_userns_rewrite - Rewrite list of xattr names for user namespaces
> + *                             or determine needed size for attribute list
> + *                             in case size == 0
> + *
> + * In a user namespace we do not present all extended attributes to the
> + * user. We filter out those that are in the list of userns supported xattr.
> + * Besides that we filter out those with @uid=<uid> when there is no mapping
> + * for that uid in the current user namespace.
> + *
> + * @list:        list of 0-byte separated xattr names
> + * @size:        the size of the list; may be 0 to determine needed list size
> + * @list_maxlen: allocated buffer size of list
> + */
> +static ssize_t
> +xattr_list_userns_rewrite(char *list, ssize_t size, size_t list_maxlen)
> +{
> +	char *nlist = NULL;
> +	size_t s_off, len, nlen;
> +	ssize_t d_off;
> +	char *name, *newname;
> +
> +	if (!list || size < 0 || current_user_ns() == &init_user_ns)
> +		return size;
> +
> +	if (size) {
> +		nlist = kmalloc(list_maxlen, GFP_KERNEL);
> +		if (!nlist)
> +			return -ENOMEM;
> +	}
> +
> +	s_off = d_off = 0;
> +	while (s_off < size || size == 0) {
> +		name = &list[s_off];
> +
> +		len = strlen(name);
> +		if (!len)
> +			break;
> +
> +		if (xattr_is_userns_supported(name, false) >= 0)
> +			newname = name;
> +		else {
> +			newname = xattr_rewrite_userns_xattr(name);

Why are you doing this here?  If we get here it means that
xattr_is_userns_supported() returned < 0, meaning name is
not userns-supported.  So xattr_rewrite_userns_xattr() will
just return name.  Am I missing something?

> +			if (IS_ERR(newname)) {
> +				d_off = PTR_ERR(newname);
> +				goto out_free;
> +			}
> +		}
> +		if (newname && !xattr_list_contains(nlist, d_off, newname)) {

Now here, if name was recalculated to @newname, and @newname is
found in the nlist, that should raise an error right?  Something
fishy is going on?

> +			nlen = strlen(newname);
> +
> +			if (nlist) {
> +				if (nlen + 1 > list_maxlen)

d_off needs to be set to -ERANGE here.

> +					break;
> +				strcpy(&nlist[d_off], newname);
> +			}
> +
> +			d_off += nlen + 1;
> +			if (newname != name)
> +				kfree(newname);
> +		}
> +		s_off += len + 1;
> +	}
> +	if (nlist)
> +		memcpy(list, nlist, d_off);
> +out_free:
> +	kfree(nlist);
> +
> +	return d_off;
> +}
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
