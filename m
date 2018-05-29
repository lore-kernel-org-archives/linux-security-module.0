From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Tue, 29 May 2018 12:05:04 +0300
Subject: [PATCH] EVM: Fix null dereference on xattr when xattr fails to
	allocate
In-Reply-To: <20180527225510.25612-1-colin.king@canonical.com>
References: <20180527225510.25612-1-colin.king@canonical.com>
Message-ID: <20180529090504.6dpdadjyjxo45nu2@mwanda>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Not really related to this patch except I was looking at the function:

security/integrity/evm/evm_secfs.c
   191          ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_INTEGRITY_EVM_XATTR);
   192          if (IS_ERR(ab))
   193                  return PTR_ERR(ab);
   194  
   195          xattr = kmalloc(sizeof(struct xattr_list), GFP_KERNEL);
   196          if (!xattr) {
   197                  err = -ENOMEM;
   198                  goto out;
   199          }
   200  
   201          xattr->name = memdup_user_nul(buf, count);
   202          if (IS_ERR(xattr->name)) {
   203                  err = PTR_ERR(xattr->name);
   204                  xattr->name = NULL;
   205                  goto out;
   206          }
   207  
   208          /* Remove any trailing newline */
   209          len = strlen(xattr->name);
   210          if (xattr->name[len-1] == '\n')

strlen() could be zero, leading to a read underflow here.

   211                  xattr->name[len-1] = '\0';
   212  
   213          if (strcmp(xattr->name, ".") == 0) {
   214                  evm_xattrs_locked = 1;
   215                  newattrs.ia_mode = S_IFREG | 0440;
   216                  newattrs.ia_valid = ATTR_MODE;
   217                  inode = evm_xattrs->d_inode;
   218                  inode_lock(inode);
   219                  err = simple_setattr(evm_xattrs, &newattrs);
   220                  inode_unlock(inode);
   221                  audit_log_format(ab, "locked");
   222                  if (!err)
   223                          err = count;
   224                  goto out;
   225          }

regards,
dan carpenter

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
