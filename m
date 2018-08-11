From: viro@ZenIV.linux.org.uk (Al Viro)
Date: Sat, 11 Aug 2018 03:17:04 +0100
Subject: BUG: Mount ignores mount options
In-Reply-To: <20180811015815.GD6515@ZenIV.linux.org.uk>
References: <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
	<87d0uqpba5.fsf@xmission.com>
	<20180810151606.GA6515@ZenIV.linux.org.uk>
	<87pnypiufr.fsf@xmission.com>
	<20180811015815.GD6515@ZenIV.linux.org.uk>
Message-ID: <20180811021704.GE6515@ZenIV.linux.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sat, Aug 11, 2018 at 02:58:15AM +0100, Al Viro wrote:
> On Fri, Aug 10, 2018 at 08:05:44PM -0500, Eric W. Biederman wrote:
> 
> > All I proposed was that we distinguish between a first mount and an
> > additional mount so that userspace knows the options will be ignored.
> 
> For pity sake, just what does it take to explain to you that your
> notions of "first mount" and "additional mount" ARE HEAVILY FS-DEPENDENT
> and may depend upon the pieces of state userland (especially in container)
> simply does not have?
> 
> One more time, slowly:
> 
> mount -t nfs4 wank.example.org:/foo/bar /mnt/a
> mount -t nfs4 wank.example.org:/baz/barf /mnt/b
> 
> yield the same superblock.  Is anyone who mounts something over NFS
> required to know if anybody else has mounted something from the same
> server, and if so how the hell are they supposed to find that out,
> so that they could decide whether they are creating the "first" or
> "additional" mount, whatever that might mean in this situation?
> 
> And how, kernel-side, is that supposed to be handled by generic code
> of any description?  
> 
> While we are at it,
> mount -t nfs4 wank.example.org:/foo/bar -o wsize=16384 /mnt/c
> is *NOT* the same superblock as the previous two.

s/as the previous two/as in the previous two cases/, that is - the first two
examples yield one superblock, this one - another.
