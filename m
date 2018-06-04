From: jmorris@namei.org (James Morris)
Date: Tue, 5 Jun 2018 02:01:29 +1000 (AEST)
Subject: [GIT PULL] tpmdd 4.17 fixes
In-Reply-To: <20180602130001.GA5196@linux.intel.com>
References: <20180602130001.GA5196@linux.intel.com>
Message-ID: <alpine.LRH.2.21.1806050201050.30339@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sat, 2 Jun 2018, Jarkko Sakkinen wrote:

> The following changes since commit 424eaf910c329ab06ad03a527ef45dcf6a328f00:
> 
>   tpm: reduce polling time to usecs for even finer granularity (2018-05-18 10:00:01 +0300)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/users/jjs/linux-tpmdd.git tags/tpmdd-next-20180602
> 
> for you to fetch changes up to 3ab2011ea368ec3433ad49e1b9e1c7b70d2e65df:
> 
>   tpm: fix race condition in tpm_common_write() (2018-05-30 20:11:31 +0300)

4.17 was just released, I'll fold these into the 4.18 merge.



> 
> ----------------------------------------------------------------
> tpmdd fixes for Linux 4.17
> 
> ----------------------------------------------------------------
> Tadeusz Struk (1):
>       tpm: fix race condition in tpm_common_write()
> 
>  drivers/char/tpm/tpm-dev-common.c | 40 ++++++++++++++++++---------------------
>  drivers/char/tpm/tpm-dev.h        |  2 +-
>  2 files changed, 19 insertions(+), 23 deletions(-)
> 

-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
