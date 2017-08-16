From: jmorris@namei.org (James Morris)
Date: Wed, 16 Aug 2017 12:43:58 +1000 (AEST)
Subject: [PATCH v6 0/6] define new fs integrity_read method 
In-Reply-To: <1502808237-2035-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1502808237-2035-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <alpine.LRH.2.20.1708161240220.30541@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 15 Aug 2017, Mimi Zohar wrote:

> To resolve this locking problem, this patch set introduces a new
> ->integrity_read file operation method.  Until all filesystems
> define the new ->integrity_read method, files that were previously
> measured might not be currently measured and files that were
> previously appraised might fail to be appraised properly.

Are there any such filesystems in mainline which are not getting an 
integrity_read method in this patchset?

-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
