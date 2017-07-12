From: vgoyal@redhat.com (Vivek Goyal)
Date: Wed, 12 Jul 2017 13:53:57 -0400
Subject: [PATCH v2] xattr: Enable security.capability in user namespaces
In-Reply-To: <1499785511-17192-2-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1499785511-17192-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1499785511-17192-2-git-send-email-stefanb@linux.vnet.ibm.com>
Message-ID: <20170712175357.GA32609@redhat.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Jul 11, 2017 at 11:05:11AM -0400, Stefan Berger wrote:

[..]
> @@ -301,14 +721,39 @@ ssize_t
>  __vfs_getxattr(struct dentry *dentry, struct inode *inode, const char *name,
>  	       void *value, size_t size)
>  {
> -	const struct xattr_handler *handler;
> +	const struct xattr_handler *handler = NULL;
> +	char *newname =  NULL;
> +	int ret, userns_supt_xattr;
> +	struct user_namespace *userns = current_user_ns();
> +
> +	userns_supt_xattr = (xattr_is_userns_supported(name, false) >= 0);
> +

Hi Stephan,

> +	do {
> +		kfree(newname);
> +
> +		newname = xattr_userns_name(name, userns);
					    ^^^
Will name be pointing to a freed string in second iteration of loop. 

> +		if (IS_ERR(newname))
> +			return PTR_ERR(newname);
> +
> +		if (!handler) {
> +			name = newname;

Here we assign name and at the beginning of second iteration we free 
newname.

Also I am not sure why do we do this assignment only if handler is NULL.

BTW, I set cap_sys_admin on a file outside usernamespace and then launched
user namespace (mapping 1000 to 0). And then tried to do getcap on file
and I am not seeing security.capability set by host. Not sure what am I 
doing wrong. getxattr() seems to return -ENODATA. Still debugging it.

Also, have we resovled the question of stacked filesystem like overlayfs.
There we are switching creds to mounter's creds when doing operations on
underlying filesystem. I am concenrned does that mean, we will get and
return security.capability to caller in usernamespace instead of
security.capability at uid=1000. 

Vivek

> +			handler = xattr_resolve_name(inode, &name);
> +			if (IS_ERR(handler)) {
> +				ret = PTR_ERR(handler);
> +				goto out;
> +			}
> +			if (!handler->get) {
> +				ret = -EOPNOTSUPP;
> +				goto out;
> +			}
> +		}
> +		ret = handler->get(handler, dentry, inode, name, value, size);
> +		userns = userns->parent;
> +	} while ((ret == -ENODATA) && userns && userns_supt_xattr);
>  
> -	handler = xattr_resolve_name(inode, &name);
> -	if (IS_ERR(handler))
> -		return PTR_ERR(handler);
> -	if (!handler->get)
> -		return -EOPNOTSUPP;
> -	return handler->get(handler, dentry, inode, name, value, size);
> +out:
> +	kfree(newname);
> +	return ret;
>  }
>  EXPORT_SYMBOL(__vfs_getxattr);
>  

Thanks
Vivek
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
