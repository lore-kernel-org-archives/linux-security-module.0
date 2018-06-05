From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Tue, 5 Jun 2018 17:38:57 +0300
Subject: [GIT PULL] tpmdd 4.17 fixes
In-Reply-To: <alpine.LRH.2.21.1806050201050.30339@namei.org>
References: <20180602130001.GA5196@linux.intel.com>
	<alpine.LRH.2.21.1806050201050.30339@namei.org>
Message-ID: <20180605143857.GA6199@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Jun 05, 2018 at 02:01:29AM +1000, James Morris wrote:
> On Sat, 2 Jun 2018, Jarkko Sakkinen wrote:
> 
> > The following changes since commit 424eaf910c329ab06ad03a527ef45dcf6a328f00:
> > 
> >   tpm: reduce polling time to usecs for even finer granularity (2018-05-18 10:00:01 +0300)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.infradead.org/users/jjs/linux-tpmdd.git tags/tpmdd-next-20180602
> > 
> > for you to fetch changes up to 3ab2011ea368ec3433ad49e1b9e1c7b70d2e65df:
> > 
> >   tpm: fix race condition in tpm_common_write() (2018-05-30 20:11:31 +0300)
> 
> 4.17 was just released, I'll fold these into the 4.18 merge.

OK, thank you.

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
