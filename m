From: tj@kernel.org (Tejun Heo)
Date: Thu, 31 May 2018 09:11:07 -0700
Subject: [PATCH 1/1] Fix memory leak in kernfs_security_xattr_set and
	kernfs_security_xattr_set
In-Reply-To: <4f00f9ae-3302-83b9-c083-d21ade380eb2@schaufler-ca.com>
References: <CGME20180531092848epcas1p24b638ccd6da00f1e039bdb64de7e1a5b@epcas1p2.samsung.com>
	<1527758911-18610-1-git-send-email-chandan.vn@samsung.com>
	<20180531153943.GR1351649@devbig577.frc2.facebook.com>
	<4f00f9ae-3302-83b9-c083-d21ade380eb2@schaufler-ca.com>
Message-ID: <20180531161107.GV1351649@devbig577.frc2.facebook.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, May 31, 2018 at 09:04:25AM -0700, Casey Schaufler wrote:
> On 5/31/2018 8:39 AM, Tejun Heo wrote:
> > (cc'ing more security folks and copying whole body)
> >
> > So, I'm sure the patch fixes the memory leak but API wise it looks
> > super confusing.  Can security folks chime in here?  Is this the right
> > fix?
> 
> security_inode_getsecctx() provides a security context. Technically,
> this is a data blob, although both provider provide a null terminated
> string. security_inode_getsecurity(), on the other hand, provides a
> string to match an attribute name. The former releases the security
> context with security_release_secctx(), where the later releases the
> string with kfree().
> 
> When the Smack hook smack_inode_getsecctx() was added in 2009
> for use by labeled NFS the alloc value passed to
> smack_inode_getsecurity() was set incorrectly. This wasn't a
> major issue, since labeled NFS is a fringe case. When kernfs
> started using the hook, it became the issue you discovered.
> 
> The reason that we have all this confusion is that SELinux
> generates security contexts as needed, while Smack keeps them
> around all the time. Releasing an SELinux context frees memory,
> while releasing a Smack context is a null operation.

Any chance this detail can be hidden behind security api?  This looks
pretty error-prone, no?

Thanks.

-- 
tejun
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
