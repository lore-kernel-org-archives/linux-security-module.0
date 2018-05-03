From: jmorris@namei.org (James Morris)
Date: Fri, 4 May 2018 03:11:31 +1000 (AEST)
Subject: [PATCH v6 0/4] Certificate insertion support for x86 bzImages
In-Reply-To: <20180502230811.2751-1-mkayaalp@linux.vnet.ibm.com>
References: <20180502230811.2751-1-mkayaalp@linux.vnet.ibm.com>
Message-ID: <alpine.LRH.2.21.1805040311050.12843@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 2 May 2018, Mehmet Kayaalp wrote:

> These patches add support for modifying the reserved space for extra
> certificates in a compressed bzImage in x86. This allows separating the
> system keyring certificate from the kernel build process. After the kernel
> image is distributed, the insert-sys-cert script can be used to insert the
> certificate for x86.

Can you provide more explanation of how this is useful and who would use 
it?

-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
