From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Thu, 03 May 2018 17:42:00 -0400
Subject: [PATCH v6 0/4] Certificate insertion support for x86 bzImages
In-Reply-To: <alpine.LRH.2.21.1805040311050.12843@namei.org>
References: <20180502230811.2751-1-mkayaalp@linux.vnet.ibm.com>
	<alpine.LRH.2.21.1805040311050.12843@namei.org>
Message-ID: <1525383720.3539.76.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, 2018-05-04 at 03:11 +1000, James Morris wrote:
> On Wed, 2 May 2018, Mehmet Kayaalp wrote:
> 
> > These patches add support for modifying the reserved space for extra
> > certificates in a compressed bzImage in x86. This allows separating the
> > system keyring certificate from the kernel build process. After the kernel
> > image is distributed, the insert-sys-cert script can be used to insert the
> > certificate for x86.
> 
> Can you provide more explanation of how this is useful and who would use 
> it?

I'm involved in a number projects that rely on a kernel build group to
actually build kernels for their systems. ?Reserving memory for
additional public keys, allows product groups to insert public keys
post build. ?Initially the product groups might insert development
keys, but eventually they would insert the product's public key.

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
