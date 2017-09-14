From: jmorris@namei.org (James Morris)
Date: Fri, 15 Sep 2017 09:21:53 +1000 (AEST)
Subject: [PATCH 2/2] integrity: replace call to integrity_read_file with
	kernel version
In-Reply-To: <20170914204954.GA27029@infradead.org>
References: <1505270734-4280-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1505270734-4280-2-git-send-email-zohar@linux.vnet.ibm.com>
	<alpine.LRH.2.21.1709150617350.4414@namei.org>
	<20170914204954.GA27029@infradead.org>
Message-ID: <alpine.LRH.2.21.1709150920390.21698@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 14 Sep 2017, Christoph Hellwig wrote:

> On Fri, Sep 15, 2017 at 06:21:28AM +1000, James Morris wrote:
> > So, to be clear, this patch solves the XFS deadlock using a different 
> > approach (to the now reverted integrity_read approach), which Christoph 
> > also says is more correct generally.  Correct?
> 
> No.  It is in addition to the previous patches - the patches were
> correct for the IMA interaction with the I/O path.  It just turns
> out that the function was also reused for reading certificates
> at initialization time, for which that change was incorrect.
> 
> If this series is applied first the integrity_read code is not
> used for that path any more.

Ok.  Sorry I hadn't looked at the code in detail at this stage during the 
conference and wanting to just revert back to something that Linus can 
safely pull before the merge window closes.


-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
