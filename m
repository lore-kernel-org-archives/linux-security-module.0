From: tomas.winkler@intel.com (Winkler, Tomas)
Date: Tue, 6 Mar 2018 11:34:50 +0000
Subject: [PATCH 3/4] tmp: factor out tpm1_get_random into tpm1-cmd.c
In-Reply-To: <1520335881.7549.9.camel@linux.intel.com>
References: <20180306093041.11996-1-tomas.winkler@intel.com>
	<20180306093041.11996-4-tomas.winkler@intel.com>
	<1520335881.7549.9.camel@linux.intel.com>
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9422F24F@hasmsx108.ger.corp.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org


> 
> On Tue, 2018-03-06 at 11:30 +0200, Tomas Winkler wrote:
> > Factor out get random implementation from tpm-interface.c into
> > tpm1_get_random function in tpm1-cmd.c.
> > No functional changes.
> >
> > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> 
> While you are doing this, please make it use tpm_buf so tha we get stuff out
> of that nasty union. Using "helper" structs is still fine, just move it right
> before the function implementation out of tpm.h (there are examples of this
> tpm2-cmd.c).

Sure, but not while moving code, this is dangerous. Should be done after code is moved.
Thanks
Tomas

????{.n?+???????+%?????????w??{.n?+????{??????????v?^?)????w*jg??????????j????G?????????j:+v???w?j?m????????w?????f???h?????????
