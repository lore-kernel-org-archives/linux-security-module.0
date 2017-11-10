From: adobriyan@gmail.com (Alexey Dobriyan)
Date: Fri, 10 Nov 2017 12:26:30 +0200
Subject: [PATCH RFC v3 1/7] proc: add proc_fs_info struct to store proc
	information
In-Reply-To: <1510244046-3256-2-git-send-email-tixxdz@gmail.com>
References: <1510244046-3256-1-git-send-email-tixxdz@gmail.com>
	<1510244046-3256-2-git-send-email-tixxdz@gmail.com>
Message-ID: <CACVxJT88zLoekiwFxq1rdDEnFxPnpZeDYHOWEVQEwHZvFdOy4A@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 11/9/17, Djalal Harouni <tixxdz@gmail.com> wrote:

> +struct proc_fs_info {
> +	struct pid_namespace *pid_ns;
> +};

> +static inline struct proc_fs_info *proc_sb(struct super_block *sb)
> +{
> +	return sb->s_fs_info;
> +}

Can you rename this to "struct proc_super_block *" then?
That "info" suffix all over filesystems doesn't add much info itself
just more typing.
Ditto for "fs_info" identifiers.

> +extern inline struct proc_fs_info *proc_sb(struct super_block *sb)
> { return NULL;}

extern inline?
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
