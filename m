From: wangboshi@huawei.com (Boshi Wang)
Date: Fri, 29 Sep 2017 20:37:57 +0800
Subject: A potential issue in security_inode_init_security function
Message-ID: <cedbcdd2-ef0c-afa9-627a-406ed0712af8@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

In security_inode_init_security function of security/security.c, lsm_xattr can be modified by multiple functions due to call_init_hook function. I think that it is a potential issue when inode_init_security list is associated with more security modules, although inode_init_security list is associated with only selinux and smack currrently and the two security modules usually are not used at the same time.


--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
