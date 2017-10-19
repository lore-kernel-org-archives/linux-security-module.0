From: james.l.morris@oracle.com (James Morris)
Date: Thu, 19 Oct 2017 12:13:49 +1100 (AEDT)
Subject: [GIT PULL] tpmdd updates for Linux 4.15
In-Reply-To: <20171018155749.q5sl6chmsr2cwu7n@linux.intel.com>
References: <20171018155749.q5sl6chmsr2cwu7n@linux.intel.com>
Message-ID: <alpine.LFD.2.20.1710191212390.780@t440.gateway.2wire.net>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 18 Oct 2017, Jarkko Sakkinen wrote:

> Hi
> 
> Contains mostly minor fixes.
> 
> Selected more essential changes:
> 
> * Essential clean up for tpm_crb so that ARM64 and x86 versions do not
>   distract each other as much as before.
> * /dev/tpm0 rejects now too short writes (shorter buffer than specified in
>   the command header.
> * Use DMA-safe buffer in tpm_tis_spi.
> 
> /Jarkko
> 
> The following changes since commit 25eabb13c7d67ae32298015c5e28d00f604f412c:
> 
>   Merge tag 'v4.14-rc2' into next-general (2017-09-24 22:41:55 -0700)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/users/jjs/linux-tpmdd.git tags/tpmdd-next-20171018


Thanks, merged to next-tpm and next-general in:
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git


- James

-- 
James Morris
<james.l.morris@oracle.com>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
