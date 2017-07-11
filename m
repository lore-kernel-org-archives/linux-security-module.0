From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Tue, 11 Jul 2017 15:31:16 -0400
Subject: [kernel-hardening] [PATCH 00/11] S.A.R.A. a new stacked LSM
In-Reply-To: <69ff2195-d0e1-8a0f-b80e-5d8d55947907@nmatt.com>
References: <1497286620-15027-1-git-send-email-s.mesoraca16@gmail.com>
	<53a2d710-b0f0-cdf9-e7ad-cd8d03fc835a@digikod.net>
	<CAJHCu1+=uYQ-N7CH4KfmTHrN2hJjwzN0tgg4sWHU0LjVr+uGGA@mail.gmail.com>
	<c19917fa-f62c-b7e0-8cbd-f10a96f686ba@digikod.net>
	<CAJHCu1K1Hg5M2HhJxN_aj2P_S8Pez9+8KL=wHKBgAN0jN1+mLg@mail.gmail.com>
	<69ff2195-d0e1-8a0f-b80e-5d8d55947907@nmatt.com>
Message-ID: <1499801476.6034.265.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 2017-07-11 at 13:49 -0400, Matt Brown wrote:

> I have merged my TPE LSM with Mimi Zohar's shebang LSM and will be
> releasing a version 3 soon. I have also added securityfs support to
> shebang that will allow users to update the interpreter list at run
> time. This allows for user's to configure TPE/Shebang without any
> xattrs. For a preview of my version 3 you can check out my dev tree
> here:
> https://github.com/nmatt0/linux-security/tree/tpe/security/tpe
> 
> Note: that git tree is WIP and may not have all of the attribution and
> documentation needed.

You'll want to detect when an interpreter is deleted or renamed. ?I
would define?security_inode_rename, security_path_rename,
security_inode_unlink and security_path_unlink hooks.

"rename" could be an indication that the existing interpreter is being
updated. "unlink" indicates that the interpreter has been deleted. ?At
either of these points, you'll want to start checking for the creation
of a new file with the expected pathname.

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
