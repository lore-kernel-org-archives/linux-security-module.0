From: James.Bottomley@HansenPartnership.com (James Bottomley)
Date: Mon, 06 Aug 2018 17:35:45 -0700
Subject: [PATCH v3 RESEND 2/2] tpm: add support for nonblocking operation
In-Reply-To: <1064594c-3a3f-4d2a-5d94-e8314b330292@intel.com>
References: <153358975874.26901.16081444242758666628.stgit@tstruk-mobl1.jf.intel.com>
	<153359005823.27531.1050952672299708433.stgit@tstruk-mobl1.jf.intel.com>
	<1533596748.3159.19.camel@HansenPartnership.com>
	<1064594c-3a3f-4d2a-5d94-e8314b330292@intel.com>
Message-ID: <1533602145.3159.23.camel@HansenPartnership.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, 2018-08-06 at 17:09 -0700, Tadeusz Struk wrote:
> On 08/06/2018 04:05 PM, James Bottomley wrote:
> > For an async interface, shouldn't I be able to queue an
> > arbitrary number of commands without blocking?
> 
> That was the approach in the v1 version of this patch, but
> Jason requested this to be changed so that only one command
> at a time can be processed.

He did?  I don't remember that.  I think he told you the TPM itself can
only process one operation at once so you didn't need an elaborate
allocation scheme.

But anyway, if you're happy to limit the interface to block after one
command is issued, how is it useful as an asynchronous interface?  I
thought the whole argument for the patch was to avoid the producer-
consumer approach which is possible with the current interface and to
use a fully event driven polling interface which can be implemented
single threaded.  If you can block in submission, this latter isn't
really possible because your interface isn't really asynchronous.

James

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
