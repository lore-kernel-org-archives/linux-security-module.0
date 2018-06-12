From: peter.enderborg@sony.com (Peter Enderborg)
Date: Tue, 12 Jun 2018 10:08:59 +0200
Subject: [PATCH 00/13 selinux-next] selinux: Cleanup printk logging
Message-ID: <20180612080912.7827-1-peter.enderborg@sony.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This patch replaces printk with pr_* for the selinux files.
I get a lot of checkpatch warnings when doing my other work,
lets get rid of the warnings.

For the policydb.c there also a removal of KERN_CONT with
two longer prints.

I have NOT cleaned up splitting lines with long prints. I think
the current conclusion is that it is better to have long lines
that it to have splitting print lines.

There is one patch per file for this files:
conditional.c
ebitmap.c	 
policydb.c
avtab.c
hooks.c	  
avtab.c	  
services.c	  
selinuxfs.c	  
netlink.c	  
sidtab.c	  
netport.c	  
netif.c	  
avc.c	 
netnode.c   

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
