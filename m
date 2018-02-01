From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Thu, 01 Feb 2018 13:36:53 -0500
Subject: [RFC PATCH v4 0/2] ima,fuse: introduce new fs flag FS_IMA_NO_CACHE
In-Reply-To: <cover.1517314847.git.dongsu@kinvolk.io>
References: <cover.1517314847.git.dongsu@kinvolk.io>
Message-ID: <1517510213.6675.12.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 2018-01-30 at 19:06 +0100, Dongsu Park wrote:
> This patchset v4 introduces a new fs flag FS_IMA_NO_CACHE and uses it in
> FUSE. This forces files to be re-measured, re-appraised and re-audited
> on file systems with the feature flag FS_IMA_NO_CACHE. In that way,
> cached integrity results won't be used.

Thanks!

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
