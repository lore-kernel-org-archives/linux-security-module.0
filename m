From: paul@paul-moore.com (Paul Moore)
Date: Fri, 3 Aug 2018 15:01:16 -0400
Subject: maybe resource leak in security/selinux/selinuxfs.c
In-Reply-To: <E490CD805F7529488761C40FD9D26EF12A72A2C9@dggemm507-mbx.china.huawei.com>
References: <E490CD805F7529488761C40FD9D26EF12A72A2C9@dggemm507-mbx.china.huawei.com>
Message-ID: <CAHC9VhS4nwcErVriwBzvvRQTFLZ=U_p8gA7xQnjs1wBKtmSgxQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Aug 1, 2018 at 5:39 AM Nixiaoming <nixiaoming@huawei.com> wrote:
>
> advisory:
> 1 After creating dentry in d_alloc_name, should I call dput to release resources before the exception exit?
> 2 After calling the new_inode to create an inode, should the inode resource be released before the exception exit?
>
> If the dentry and inode resources need to be actively released, there are multiple resource leaks in security/selinux/selinuxfs.c.

Hello.  Sorry for the delay in responding, comments inline ...

> Example:
> Linux master branch v4.18-rc5
> The function sel_make_avc_files in security/selinux/selinuxfs.c.
>
> 1566 static int sel_make_avc_files(struct dentry *dir)
> .......
> 1580     for (i = 0; i < ARRAY_SIZE(files); i++) {
> 1581         struct inode *inode;
> 1582         struct dentry *dentry;
> 1583
> 1584         dentry = d_alloc_name(dir, files[i].name);
> 1585         if (!dentry)
> /*Resource leak: when i!=0, the release action of dentry and inode resources is missing*/

I don't understand the leak in this case?  If d_alloc_name() fails on
a partially constructed /sys/fs/selinux/avc directory the previously
allocated dentry/inodes are not lost or leaked, d_alloc_name()
attached them to the parent dentry.

> 1586             return -ENOMEM;
> 1587
> 1588         inode = sel_make_inode(dir->d_sb, S_IFREG|files[i].mode);
> 1589         if (!inode)
> /*Resource leak: missing dput(dentry)*/
> /*Resource leak: when i!=0, the release action of dentry and inode resources is missing*/

Yes, in this case it does look like we are missing a call to dput().
Would you like to submit a patch to fix this as well as the others in
selinuxfs.c?

> 1590             return -ENOMEM;
> 1591
> 1592         inode->i_fop = files[i].ops;
> 1593         inode->i_ino = ++fsi->last_ino;
> 1594         d_add(dentry, inode);
> 1595     }
> 1596
> 1597     return 0;
> 1598 }
>
> There are similar resource leaking functions:
> Sel_make_bools
> Sel_make_avc_files
> Sel_make_initcon_files
> Sel_make_perm_files
> Sel_make_class_dir_entries
> Sel_make_policycap
> Sel_fill_super
> Sel_make_policy_nodes
> Sel_make_classes

-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
