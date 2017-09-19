From: jmorris@namei.org (James Morris)
Date: Wed, 20 Sep 2017 02:02:47 +1000 (AEST)
Subject: [GIT PULL] Security susbsystem updates for v4.14 (v2)
In-Reply-To: <alpine.LRH.2.21.1709101406320.22614@namei.org>
References: <alpine.LRH.2.21.1709101406320.22614@namei.org>
Message-ID: <alpine.LRH.2.21.1709200201040.310@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, 10 Sep 2017, James Morris wrote:

> Here's an updated pull request with the IMA integrity_read() patch 
> reverted.  Note that this restores the orginal buggy behavior with XFS/IMA 
> deadlock the builtin ima_tcb policy wand XFS rootfs.

Linus, can you pull this v2 version?  The buggy IMA change is reverted in 
this which means that we simply have the existing behavior.  Otherwise, a 
bunch of other unrelated stuff will be missed for this kernel release.


-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
