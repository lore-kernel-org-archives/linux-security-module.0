From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Sat, 26 Aug 2017 14:19:45 +0300
Subject: [PATCH RESEND] tpm: migrate pubek_show to struct tpm_buf
In-Reply-To: <20170826081004.cf3kbr5ild6vfv2y@linux.intel.com>
References: <20170825172946.18357-1-jarkko.sakkinen@linux.intel.com>
	<20170826081004.cf3kbr5ild6vfv2y@linux.intel.com>
Message-ID: <20170826111945.kelicskdcquf6ddz@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sat, Aug 26, 2017 at 11:10:04AM +0300, Jarkko Sakkinen wrote:
> On Fri, Aug 25, 2017 at 08:29:46PM +0300, Jarkko Sakkinen wrote:
> > Migrated pubek_show to struct tpm_buf and cleaned up its implementation.
> > Previously the output parameter structure was declared but left
> > completely unused. Now it is used to refer different fields of the
> > output. We can move it to tpm-sysfs.c as it does not have any use
> > outside of that file.
> > 
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> 
> I'm going to apply this if there are no obligations. I sent this updated
> patch 2017-06-20 based on feedback I got on [1].
> 
> [1] https://patchwork.kernel.org/patch/9749151/
> 
> /Jarkko

Applied (master, next).

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
