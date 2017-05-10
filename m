From: hch@lst.de (Christoph Hellwig)
Date: Wed, 10 May 2017 08:45:06 +0200
Subject: fix IMA deadlock
Message-ID: <20170510064507.1764-1-hch@lst.de>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

IMA currently tries to read the file to calculate a hash from inside
i_rwsem.  On file system like XFS that also take i_rwsem for reads this
deadlocks.

This patch instead adds a new ->integrity_read method for IMA that can
be used to read data with i_rwsem held.  For XFS it has an implementation
that skips the locking, other file systems can just set it to the default
implementation.

As a side effect this also gets rid of playing with the address limit.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
