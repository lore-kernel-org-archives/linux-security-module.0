From: viro@ZenIV.linux.org.uk (Al Viro)
Date: Thu, 15 Jun 2017 11:14:42 +0100
Subject: [PATCH 16/27] proc: Add fs_context support to procfs [ver #5]
In-Reply-To: <149745346349.10897.1390410969617844911.stgit@warthog.procyon.org.uk>
References: <149745330648.10897.9605870130502083184.stgit@warthog.procyon.org.uk>
	<149745346349.10897.1390410969617844911.stgit@warthog.procyon.org.uk>
Message-ID: <20170615101441.GI31671@ZenIV.linux.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Jun 14, 2017 at 04:17:43PM +0100, David Howells wrote:

>  int pid_ns_prepare_proc(struct pid_namespace *ns)
>  {
> +	struct proc_fs_context *ctx;
> +	struct fs_context *fc;
>  	struct vfsmount *mnt;
> +	int ret;
> +
> +	fc = vfs_new_fs_context(&proc_fs_type, NULL, 0, FS_CONTEXT_FOR_NEW);
> +	if (IS_ERR(fc))
> +		return PTR_ERR(fc);
> +
> +	ctx = container_of(fc, struct proc_fs_context, fc);
> +	if (ctx->pid_ns != ns) {
> +		put_pid_ns(ctx->pid_ns);
> +		get_pid_ns(ns);
> +		ctx->pid_ns = ns;
> +	}
> +
> +	ret = vfs_get_tree(fc);
> +	if (ret < 0) {
> +		put_fs_context(fc);
> +		return ret;
> +	}
>  
> -	mnt = kern_mount_data(&proc_fs_type, ns);
> +	mnt = kern_mount_data_fc(fc);
> +	put_fs_context(fc);

Same as with ipc; do you need to go through dynamic allocation,
container_of, patching it up, etc.?
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
