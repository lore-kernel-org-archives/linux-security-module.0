From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Wed, 05 Jul 2017 10:50:09 -0400
Subject: [PATCH v2 10/10] ima: use existing read file operation method
	to calculate file hash
In-Reply-To: <20170628144111.GI2359@lst.de>
References: <1498069110-10009-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1498069110-10009-11-git-send-email-zohar@linux.vnet.ibm.com>
	<20170628144111.GI2359@lst.de>
Message-ID: <1499266209.3059.91.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

[Cc'ing linux-ima-users]

On Wed, 2017-06-28 at 16:41 +0200, Christoph Hellwig wrote:
> NAK - we'll need an explicit method for the integrity code.
> 
> And just curious - what filesystem that you care about actually
> implements ->read instead of ->read_iter?  We shouldn't be doing that
> for real file systems anymore.

Right, pseudo filesystems are using ->read. The existing builtin
measurement policies exclude a number of pseudo filesystems, but not
efivarfs. ?Unfortunately, we do not know what type of custom policies
are currently being used.

The contents of the IMA measurement list are verified against a
reference manifest, provided at registration, or against a white list.
Not measuring files that were previously measured could break
userspace applications.

Let's wait to hear back from the larger IMA community as to whether
there is a need to measure files on pseudo filesystems, before
implementing an explicit method.

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
