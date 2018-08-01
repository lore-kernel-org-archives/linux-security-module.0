From: jmorris@namei.org (James Morris)
Date: Thu, 2 Aug 2018 05:34:38 +1000 (AEST)
Subject: [PATCH v2] security: Add LSM fixup hooks to set*gid syscalls.
In-Reply-To: <CAJ-EccOMdg370kMfU2=gMbSEyOE3sRVLpca86BHgr+i0_C=J9Q@mail.gmail.com>
References: <CAJ-EccNNCNrA7to85WrYFjRUP7Z1XC+sJ2JXkargiEvXd11AVg@mail.gmail.com>
	<alpine.LRH.2.21.1808010608080.8072@namei.org>
	<CAJ-EccOMdg370kMfU2=gMbSEyOE3sRVLpca86BHgr+i0_C=J9Q@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1808020534330.7346@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 31 Jul 2018, Micah Morton wrote:

> The ChromiumOS LSM used by ChromeOS will provide a hook for this, in
> order to enforce ChromeOS-specific policies regarding which UIDs/GIDs a
> process with CAP_SET{UID/GID} can transition to

Will you be submitting this LSM to mainline?  It's a policy generally of 
the kernel that we only add features to support in-tree code.


-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
