From: sds@tycho.nsa.gov (Stephen Smalley)
Date: Wed, 26 Sep 2018 09:23:03 -0400
Subject: Leaking Path in XFS's ioctl interface(missing LSM check)
In-Reply-To: <20180926013329.GD31060@dastard>
References: <5EF0D46A-C098-4B51-AD13-225FFCA35D4C@vt.edu>
	<20180926013329.GD31060@dastard>
Message-ID: <dc3bf978-1b98-bebd-6f35-9b2795693ea7@tycho.nsa.gov>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 09/25/2018 09:33 PM, Dave Chinner wrote:
> On Tue, Sep 25, 2018 at 08:51:50PM -0400, TongZhang wrote:
>> Hi,
>>
>> I'm bringing up this issue again to let of LSM developers know the situation, and would like to know your thoughts.
>> Several weeks ago I sent an email to the security list to discuss the issue where
>> XFS's ioctl interface can do things like vfs_readlink without asking LSM's
>> permission, which we think is kind of weird and this kind of operation should be
>> audited by LSM.
> 
> These aren't user interfaces. They are filesystem maintenance and
> extension interfaces.  They are intended for low level filesystem
> utilities that require complete, unrestricted access to the
> underlying filesystem via holding CAP_SYSADMIN in the initns.
> 
> i.e.  they are used to perform filesystem maintenance and extension
> operations that need to be completely invisible to users from
> userspace. e.g.  online file defragmentation (xfs_fsr), data
> migration (e.g. HSM products), efficient backup of data (xfsdump),
> metadata and data scrubbing, online repair, etc.
> 
> IOWs, I really don't think these interfaces are something the LSMs
> should be trying to intercept or audit, because they are essentially
> internal filesystem interfaces used by trusted code and not general
> user application facing APIs.

If they are interfaces exposed to userspace, then they should be 
mediated via LSM.  We only omit the LSM hook when the usage is purely 
kernel-internal.  Security modules are often used to limit even 
"trusted" applications to least privilege and protect them from 
untrustworthy inputs, moving from binary trust notions to only trusting 
them for what they must be trusted to do.  CAP_SYS_ADMIN doesn't 
necessarily indicate that they are trusted to override any given MAC 
policy restrictions.

Wondering why we don't perform the security_inode_readlink() call inside 
of vfs_readlink() currently.  The general pattern is that we do perform 
security_inode_*() calls inside the other vfs_*() helpers, so 
vfs_readlink() is an exception currently.
