From: casey@schaufler-ca.com (Casey Schaufler)
Date: Fri, 22 Jun 2018 07:37:00 -0700
Subject: 4.18-rc1 regression in /proc/self xattr handling
Message-ID: <020be8a4-961b-b92f-7ee9-3c439d629338@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

There is a regression in behavior regarding xattrs in /proc after:

commit 1bbc55131e59bd099fdc568d3aa0b42634dbd188
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Wed May 2 21:26:16 2018 -0400

    procfs: get rid of ancient BS in pid_revalidate() uses
    

Prior to this change lgetxattr() would provide the correct attributes
for entries in /proc. With this change I see that while the behavior
remains correct if the procid is specified, it is not when "self" is
used. On a system with Smack enabled, where the shell has the Smack label
"Crackle" I see: 

[root at localhost linux]# attr -S -g SMACK64 /proc/self/attr/current
Attribute "SMACK64" had a 1 byte value for /proc/self/attr/current:
_
[root at localhost linux]# attr -S -g SMACK64 /proc/$BASHPID/attr/current
Attribute "SMACK64" had a 7 byte value for /proc/1716/attr/current:
Crackle

These should be the same, and in the past have been. I don't know
what SELinux expects as far as attributes in /proc, so I can't say
if the problem is manifest with SELinux.


--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
