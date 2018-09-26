From: ztong@vt.edu (TongZhang)
Date: Tue, 25 Sep 2018 20:51:50 -0400
Subject: Leaking Path in XFS's ioctl interface(missing LSM check)
Message-ID: <5EF0D46A-C098-4B51-AD13-225FFCA35D4C@vt.edu>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi,

I'm bringing up this issue again to let of LSM developers know the situation, and would like to know your thoughts.
Several weeks ago I sent an email to the security list to discuss the issue where
XFS's ioctl interface can do things like vfs_readlink without asking LSM's
permission, which we think is kind of weird and this kind of operation should be
audited by LSM.

see the original post below:

>We noticed a use of vfs_readlink() in xfs_file_ioctl(), which should have been checked by 
>security_inode_readlink().
>The callgraph is:
>	xfs_file_ioctl()->xfs_readlink_by_handle()->vfs_readlink()
>
>This path allows user to do things similar to SyS_readlinkat(), and the parameters
>are user controllable.

security_inode_readlink() is not used inside vfs_readlink()

- Tong
