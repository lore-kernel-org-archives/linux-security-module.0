From: jarkko.sakkinen@intel.com (Jarkko Sakkinen)
Date: Tue, 11 Sep 2018 00:07:17 +0300
Subject: [RFC 09/12] mm: Restrict memory encryption to anonymous VMA's
In-Reply-To: <84154fd2-7c27-0fd2-f339-15e144a5df49@intel.com>
References: <cover.1536356108.git.alison.schofield@intel.com>
	<f69e3d4f96504185054d951c7c85075ebf63e47a.1536356108.git.alison.schofield@intel.com>
	<ae0288d5205a5c431e9a6bf0c9e68beded45e84b.camel@intel.com>
	<84154fd2-7c27-0fd2-f339-15e144a5df49@intel.com>
Message-ID: <20180910210716.GB26766@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Sep 10, 2018 at 11:57:49AM -0700, Dave Hansen wrote:
> On 09/10/2018 11:21 AM, Sakkinen, Jarkko wrote:
> >> +/*
> >> + * Encrypted mprotect is only supported on anonymous mappings.
> >> + * All VMA's in the requested range must be anonymous. If this
> >> + * test fails on any single VMA, the entire mprotect request fails.
> >> + */
> > kdoc
> 
> kdoc what?  You want this comment in kdoc format?  Why?

If there is a header comment for a function anyway, why wouldn't you
put it to kdoc-format?

/Jarkko
