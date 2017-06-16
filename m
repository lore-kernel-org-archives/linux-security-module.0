From: hch@lst.de (Christoph Hellwig)
Date: Fri, 16 Jun 2017 08:18:43 +0200
Subject: [PATCH 1/4] ima: use fs method to read integrity data
In-Reply-To: <201706160704.Yq17eRie%fengguang.wu@intel.com>
References: <1497031364-19949-2-git-send-email-zohar@linux.vnet.ibm.com>
	<201706160704.Yq17eRie%fengguang.wu@intel.com>
Message-ID: <20170616061843.GA6592@lst.de>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Yeah, the iovec there should be a kvec..
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
