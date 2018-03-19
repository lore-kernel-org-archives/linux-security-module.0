From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Mon, 19 Mar 2018 23:06:21 +0200
Subject: [PATCH v3 1/5] tpm: fix intermittent failure with self tests
In-Reply-To: <1521249631.12827.5.camel@HansenPartnership.com>
References: <20180305165614.5469-1-jarkko.sakkinen@linux.intel.com>
	<20180305165614.5469-2-jarkko.sakkinen@linux.intel.com>
	<1521249631.12827.5.camel@HansenPartnership.com>
Message-ID: <20180319210620.GB14364@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Mar 16, 2018 at 06:20:31PM -0700, James Bottomley wrote:
> It turns out this bit is wrong ... I just discovered it testing the
> RC_RETRY code. ?You can't feed the buf back to tpm_transmit because the
> header has already been changed to give you back the return code. ?To
> make this work, you have to save the header and handle area and restore
> it before the command is resent.
> 
> I think the best solution for this hunk of code is to merge it with the
> retry code.

Yeah, right, so it is embarrasingly so :-) I wonder how I missed ths
during the review. Thanks for spotting this one out. Are you saying
that I should merge the patches into a single one? Perhaps you could
send me the merged patch if so?

If you agree, please send only that patch. I'll send v4 of my patch
set after 4.17 pull request.

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
