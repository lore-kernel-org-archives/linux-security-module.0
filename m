From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Mon, 02 Oct 2017 08:25:09 -0400
Subject: [RFC PATCH 3/3] fs: detect that the i_rwsem has already been
	taken exclusively
In-Reply-To: <87zi9ai63l.fsf@xmission.com>
References: <20170928220215.GC15067@dastard>
	<CA+55aFy-kDL5jQb0q2gHkcmhAwMatEf8YPx8Gh=yGp_VMoVxQA@mail.gmail.com>
	<1506643967.5691.46.camel@linux.vnet.ibm.com>
	<CA+55aFxqpTbC=sZXrbJ0x1OD-UA1NkejuR_s5LCazp+7yzvi3Q@mail.gmail.com>
	<1506649980.5691.100.camel@linux.vnet.ibm.com>
	<CA+55aFzZXBBn+HgLD_4C6DgpSiOMAP2WzuGPWRUkEXZJuz+QBQ@mail.gmail.com>
	<87mv5blki7.fsf@xmission.com>
	<CA+55aFx726wT4VprN-sHm6s8Q_PV_VjhTBC4goEbMcerYU1Tig@mail.gmail.com>
	<1506859691.5691.211.camel@linux.vnet.ibm.com>
	<CA+55aFwG65-1DZGLkxWzXiPHECjVvY+WHa0ihRq6MbJ4yrX-Sg@mail.gmail.com>
	<20171001223402.GG15067@dastard>
	<1506901362.5691.247.camel@linux.vnet.ibm.com>
	<87zi9ai63l.fsf@xmission.com>
Message-ID: <1506947109.5691.282.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, 2017-10-01 at 22:25 -0500, Eric W. Biederman wrote:
> Mimi Zohar <zohar@linux.vnet.ibm.com> writes:

> > There should be no open writers in ima_check_last_writer(), so the
> > file shouldn't be changing.
> 
> This is slightly tangential but I think important to consider.
> What do you do about distributed filesystems fuse, nfs, etc that
> can change the data behind the kernels back.

Exactly!

> Do you not support such systems or do you have a sufficient way to
> detect changes?

Currently, only the initial file access in policy is measured,
verified, audited. ?Even if there was a way of detecting the change,
since we can't trust these file systems, the performance would be
awful, but we should probably not be caching the
measurement/verification results.

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
