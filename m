From: viro@ZenIV.linux.org.uk (Al Viro)
Date: Fri, 22 Jun 2018 15:52:59 +0100
Subject: 4.18-rc1 regression in /proc/self xattr handling
In-Reply-To: <020be8a4-961b-b92f-7ee9-3c439d629338@schaufler-ca.com>
References: <020be8a4-961b-b92f-7ee9-3c439d629338@schaufler-ca.com>
Message-ID: <20180622145259.GZ30522@ZenIV.linux.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Jun 22, 2018 at 07:37:00AM -0700, Casey Schaufler wrote:
> There is a regression in behavior regarding xattrs in /proc after:
> 
> commit 1bbc55131e59bd099fdc568d3aa0b42634dbd188
> Author: Al Viro <viro@zeniv.linux.org.uk>
> Date:   Wed May 2 21:26:16 2018 -0400
> 
>     procfs: get rid of ancient BS in pid_revalidate() uses
>     
> 
> Prior to this change lgetxattr() would provide the correct attributes
> for entries in /proc. With this change I see that while the behavior
> remains correct if the procid is specified, it is not when "self" is
> used. On a system with Smack enabled, where the shell has the Smack label
> "Crackle" I see: 
> 
> [root at localhost linux]# attr -S -g SMACK64 /proc/self/attr/current
> Attribute "SMACK64" had a 1 byte value for /proc/self/attr/current:
> _
> [root at localhost linux]# attr -S -g SMACK64 /proc/$BASHPID/attr/current
> Attribute "SMACK64" had a 7 byte value for /proc/1716/attr/current:
> Crackle

Wait a sec - the former will be that of attr, the latter - of bash;
it's not the same file at all.

> These should be the same, and in the past have been. I don't know
> what SELinux expects as far as attributes in /proc, so I can't say
> if the problem is manifest with SELinux.

Very interesting...  About the only thing changed here seems to be
the relative order of smack_d_instantiate() and smack_task_to_inode()...

Would setting SMK_INODE_INSTANT in isp->smk_flags in smack_task_to_inode()
be the right thing to do, anyway?
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
