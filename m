From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Tue, 6 Mar 2018 10:28:21 +0200
Subject: [PATCH 3/3] tpm_crb: use __le64 annotated variable for response
	buffer address
In-Reply-To: <20180305130320.GC3425@linux.intel.com>
References: <20180304121205.16934-1-tomas.winkler@intel.com>
	<20180304121205.16934-3-tomas.winkler@intel.com>
	<20180305130320.GC3425@linux.intel.com>
Message-ID: <20180306082821.GB5705@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Mar 05, 2018 at 03:03:20PM +0200, Jarkko Sakkinen wrote:
> On Sun, Mar 04, 2018 at 02:12:05PM +0200, Tomas Winkler wrote:
> > This suppresses sparse warning
> > drivers/char/tpm/tpm_crb.c:558:18: warning: cast to restricted __le64
> > 
> > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > ---
> >  drivers/char/tpm/tpm_crb.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> The guideline is that you should describe what is wrong rather than
> copy-paste the sparse message.

Jason, didn't yo give the feedback to some patch 1-2 years ago that
instead of copy-pasting parse error one should write a clear commit
msg or is this OK?

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
