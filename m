From: hch@lst.de (Christoph Hellwig)
Date: Wed, 28 Jun 2017 16:41:12 +0200
Subject: [PATCH v2 10/10] ima: use existing read file operation method
	to calculate file hash
In-Reply-To: <1498069110-10009-11-git-send-email-zohar@linux.vnet.ibm.com>
References: <1498069110-10009-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1498069110-10009-11-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <20170628144111.GI2359@lst.de>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

NAK - we'll need an explicit method for the integrity code.

And just curious - what filesystem that you care about actually
implements ->read instead of ->read_iter?  We shouldn't be doing that
for real file systems anymore.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
