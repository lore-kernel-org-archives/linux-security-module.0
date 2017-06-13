From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Tue, 13 Jun 2017 11:07:29 -0400
Subject: [PATCH 3/4] ima: use existing read file operation method to
	calculate file hash
In-Reply-To: <20170613142208.GA23872@lst.de>
References: <1497031364-19949-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1497031364-19949-4-git-send-email-zohar@linux.vnet.ibm.com>
	<20170613064658.GB31372@lst.de>
	<1497363465.21594.395.camel@linux.vnet.ibm.com>
	<20170613142208.GA23872@lst.de>
Message-ID: <1497366449.21594.422.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 2017-06-13 at 16:22 +0200, Christoph Hellwig wrote:
> On Tue, Jun 13, 2017 at 10:17:45AM -0400, Mimi Zohar wrote:
> > Calling ->read directly is intentional. ?Commit C0430e49b6e7c "ima:
> > introduce ima_kernel_read()" replaced the call to kernel_read with
> > ima_kernel_read(), the non-security checking version of kernel_read().
> > ?Subsequently, commit e3c4abbfa97e "integrity: define a new function
> > integrity_read_file()" renamed ima_read_file() to
> > integrity_read_file().
> 
> Again, the point is you should not call ->read for in-kernel reads.

Ok, there was a reason for restoring this behavior. ?Perhaps,
something that was previously being measured wasn't being measured
without it. ?Looking ...

> > Both NFS and OCFS define their own specific read_iter(),
> > nfs_file_read() and ocfs2_file_read_iter() respectively. ?As these
> > file systems have not yet been converted to use ->read_integrity, the
> > xfstests fail.
> 
> So they will need to be converted.  The xfstests will not just fail,
> it will deadlock the calling process with this code.

Right, process_measurement() is fail safe, meaning that any file,
which matches a rule in the IMA policy, that isn't appraised properly
fails.

from ima_main: process_measurement(
out:
        inode_unlock(inode);
        if ((rc && must_appraise) && (ima_appraise & IMA_APPRAISE_ENFORCE))
                return -EACCES;
        return 0;

With your patch, we now need to take into consideration that the file
system doesn't support IMA-appraisal. ?We can't just change the
existing behavior, so we will probably need the ability to override
the fail safe behavior for file systems that do not support IMA.

The bigger problem is that files that were previously measured, might
now not be measured, without any indication in the audit logs or the
IMA measurement list.

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
