From: casey@schaufler-ca.com (Casey Schaufler)
Date: Fri, 18 Aug 2017 17:14:22 -0700
Subject: evm_inode_init_security and module stacking
Message-ID: <356f4787-4f07-2957-eb00-05f77b5e0989@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

I'm looking at the code in evm_inode_init_security
and it looks like there's no way it could be taught
to deal with there being more than one security
attribute being controlled. This is because the
EVM data is stored in XATTR_EVM_SUFFIX, for which
there is only one per file. On a system with both
SELinux and Smack, there isn't a place to put the
EVM attribute for whichever module comes second.

Or, as has often been the case, am I missing something?

Thank you.

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
