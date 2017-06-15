From: viro@ZenIV.linux.org.uk (Al Viro)
Date: Thu, 15 Jun 2017 11:07:14 +0100
Subject: [PATCH 25/27] ipc: Convert mqueue fs to fs_context [ver #5]
In-Reply-To: <149745354300.10897.4615400686590211820.stgit@warthog.procyon.org.uk>
References: <149745330648.10897.9605870130502083184.stgit@warthog.procyon.org.uk>
	<149745354300.10897.4615400686590211820.stgit@warthog.procyon.org.uk>
Message-ID: <20170615100713.GH31671@ZenIV.linux.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Jun 14, 2017 at 04:19:03PM +0100, David Howells wrote:
> Convert the mqueue filesystem to use the filesystem context stuff.
> 
> Notes:
> 
>  (1) The relevant ipc namespace is selected in when the context is
>      initialised (and it defaults to the current task's ipc namespace).
>      The caller can override this before calling vfs_get_tree().
> 
>  (2) Rather than simply calling kern_mount_data(), mq_init_ns() creates a
>      context, adjusts it and then does the rest of the mount procedure.

> +	fc = vfs_new_fs_context(&mqueue_fs_type, NULL, 0, FS_CONTEXT_FOR_NEW);
> +	if (IS_ERR(fc))
> +		return PTR_ERR(fc);
> +
> +	ctx = container_of(fc, struct mqueue_fs_context, fc);

Ugh...

> +	if (ctx->ipc_ns != ns) {

How could they possibly be equal?  You are setting that ns up here, right?  How
could it be in any process' nsproxy?

> +		put_ipc_ns(ctx->ipc_ns);
> +		ctx->ipc_ns = get_ipc_ns(ns);

> +	mnt = kern_mount_data_fc(fc);
> +	if (IS_ERR(mnt)) {
> +		ret = PTR_ERR(mnt);
> +		goto out_fc;
> +	}
> +
> +	ns->mq_mnt = mnt;
> +	ret = 0;
> +out_fc:
> +	put_fs_context(fc);

Am I right assuming that it's an attempt to cope with "one process starts
setting the things up, passes descriptor to another and buggers off; the
recepient mounts the damn thing and needs something to hold your reference"?

Ugh, again...  Is there any reason for dynamic allocation of that thing in
this particular case?  AFAICS, these contortions are all due to going through
vfs_new_fs_context()/put_fs_context().  And it's not as if they had been
refcounted...
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
