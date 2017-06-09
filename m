From: penguin-kernel@I-love.SAKURA.ne.jp (Tetsuo Handa)
Date: Fri, 9 Jun 2017 23:02:59 +0900
Subject: [PATCH v1] shebang: restrict python interactive prompt/interpreter
In-Reply-To: <1497014528.21594.190.camel@linux.vnet.ibm.com>
References: <1497014528.21594.190.camel@linux.vnet.ibm.com>
Message-ID: <201706092302.HCE57804.OSFJFVtMLOQHFO@I-love.SAKURA.ne.jp>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Mimi Zohar wrote:
> This patch defines a new, minor LSM named "shebang", that restricts
> python such that scripts are allowed to execute, while the interactive
> prompt/interpreter is not available.  When used in conjunction with an
> IMA appraise execute policy requiring files signatures, only signed
> python scripts would be allowed to execute.  (A separate method for
> identifying "imported" code would need to be defined in order to verify
> their file signatures.)

Below case is blocked by IMA?

   $ cp -p /usr/bin/python2 /tmp
   $ /tmp/python2

Below case is also blocked by IMA?

   $ echo '#!/usr/bin/python2 -' > /tmp/run-python
   $ chmod +x /tmp/run-python
   $ /tmp/run-python

What about execution via ld-linux ?

   $ /lib64/ld-linux-x86-64.so.2 /usr/bin/python2

> +#define MAX_INODES 6 
> +static char *pathnames;
> +static int pathnames_len;
> +static unsigned long inode_list[MAX_INODES];
> +static int total;
> +
> +/*
> + * Get the inodes associated with the list of pathnames, as specified
> + * on CONFIG_SECURITY_SHEBANG_PATHNAME.
> + */
> +static void init_inode_list(void)
> +{
> +	char *tmp_pathnames = pathnames;
> +	char *p;
> +	struct path path;
> +	int i;
> +	int ret;
> +
> +	total = 0;
> +	while ((p = strsep(&tmp_pathnames, " ,")) != NULL) {
> +		if ((*p == '\0') || (*p == ' ') || (*p == ','))
> +			continue;
> +
> +		if (total > MAX_INODES - 1) {
> +			pr_info("too many interpreters\n");
> +			break;
> +		}
> +
> +		ret = kern_path(p, LOOKUP_FOLLOW, &path);
> +		if (!ret) {
> +			struct inode *inode = d_backing_inode(path.dentry);
> +
> +			inode_list[total] = inode->i_ino;
> +			pr_info("pathname:%s i_ino: %lu\n",
> +				p, inode_list[total]);

Leaking reference to "struct path".

> +			initialized = 1;
> +			total++;
> +		}
> +	}
> +
> +	/* cleanup in case we need to lookup the inodes again. */
> +	tmp_pathnames = pathnames;
> +	for (i = 0; i < pathnames_len; i++)
> +		if (tmp_pathnames[i] == '\0')
> +			tmp_pathnames[i] = ' ';

Why need to restore?

> +}
> +
> +/**
> + * shebang_bprm_check - prevent python interactive prompt/interpreter
> + * @bprm: contains the linux_binprm structure
> + *
> + * Restrict python such that scripts are allowed to execute, while the
> + * interactive prompt/interpreter is not available.
> + */
> +static int shebang_bprm_check(struct linux_binprm *bprm)
> +{
> +	struct inode *inode = file_inode(bprm->file);
> +	int i = 0;
> +
> +	if (bprm->interp != bprm->filename)	/* allow scripts */
> +		return 0;
> +
> +	if (!initialized)
> +		init_inode_list();

init_inode_list() can be called concurrently.

> +
> +	while (i < total) {
> +		if (inode_list[i++] != inode->i_ino)
> +			continue;
> +
> +		pr_info("prevent executing %s (ino=%lu)\n",
> +			bprm->interp, inode->i_ino);
> +		return -EPERM;
> +	}
> +	return 0;
> +}
> +
> +static struct security_hook_list shebang_hooks[] = {
> +	LSM_HOOK_INIT(bprm_check_security, shebang_bprm_check)
> +};
> +
> +static int __init init_shebang(void)
> +{
> +	pathnames = kstrdup(CONFIG_SECURITY_SHEBANG_PATHNAME, GFP_KERNEL);
> +	if (!pathnames)
> +		return -ENOMEM;
> +	pathnames_len = strlen(pathnames);

Why need to kstrdup()? 

  static char pathnames[] = CONFIG_SECURITY_SHEBANG_PATHNAME;
  static int pathnames_len = sizeof(pathnames) - 1;

will be fine.

> +
> +	security_add_hooks(shebang_hooks, ARRAY_SIZE(shebang_hooks), "shebang");
> +	pr_info("initialized\n");
> +	return 0;
> +}
> +
> +late_initcall(init_shebang);
> +MODULE_LICENSE("GPL");

Nice example for loading as a LKM-based LSM. ;-)
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
