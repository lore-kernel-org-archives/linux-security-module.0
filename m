From: viro@ZenIV.linux.org.uk (Al Viro)
Date: Sat, 3 Jun 2017 07:33:55 +0100
Subject: [PATCH v1 1/1] Add Trusted Path Execution as a stackable LSM
In-Reply-To: <20170603055351.16080-1-matt@nmatt.com>
References: <20170603055351.16080-1-matt@nmatt.com>
Message-ID: <20170603063354.GJ6365@ZenIV.linux.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sat, Jun 03, 2017 at 01:53:51AM -0400, Matt Brown wrote:

> +static int tpe_bprm_set_creds(struct linux_binprm *bprm)
> +{
> +	struct file *file = bprm->file;
> +	struct inode *inode = d_backing_inode(file->f_path.dentry->d_parent);
> +	struct inode *file_inode = d_backing_inode(file->f_path.dentry);

Bloody wonderful.  Do tell, what *does* prevent a race with rename(2) here,
somehow making sure that your 'inode' won't get freed right under you?
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
