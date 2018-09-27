From: jmorris@namei.org (James Morris)
Date: Fri, 28 Sep 2018 07:23:42 +1000 (AEST)
Subject: Leaking Path in XFS's ioctl interface(missing LSM check)
In-Reply-To: <20180927013812.GF31060@dastard>
References: <5EF0D46A-C098-4B51-AD13-225FFCA35D4C@vt.edu>
	<20180926013329.GD31060@dastard>
	<20180926192426.472360ea@alans-desktop>
	<20180927013812.GF31060@dastard>
Message-ID: <alpine.LRH.2.21.1809280720330.8410@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 27 Sep 2018, Dave Chinner wrote:

> Sure, but there are so many CAP_SYS_ADMIN-only ioctls in the kernel
> that have no LSM coverage that this is not an isolated problem that
> people setting up such systems have to deal with. 

I could be missing something here, but all ioctls are mediated by LSM at a 
high level (security_file_ioctl). Some problematic ones are singled out at 
that point by LSMs for special handling.


-- 
James Morris
<jmorris@namei.org>
