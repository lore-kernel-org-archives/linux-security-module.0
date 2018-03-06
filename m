From: tomas.winkler@intel.com (Winkler, Tomas)
Date: Tue, 6 Mar 2018 11:21:04 +0000
Subject: [PATCH 2/6] tpm: factor out tpm 1.2 duration calculation to
	tpm1-cmd.c
In-Reply-To: <1520335194.7549.7.camel@linux.intel.com>
References: <20180305202017.24008-1-tomas.winkler@intel.com>
	<20180305202017.24008-3-tomas.winkler@intel.com>
	<1520335194.7549.7.camel@linux.intel.com>
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9422F21B@hasmsx108.ger.corp.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org


> 
> On Mon, 2018-03-05 at 22:20 +0200, Tomas Winkler wrote:
> > Factor out tpm1.2 commands calculation into tpm1-cmd.c file.
> > and change the prefix from tpm_ to tpm1_.
> > No functional change is done here.
> >
> > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> 
> This a good idea but can you go on and move all TPM 1.x stuff to this new
> file while you are doing it?

Yes, see the next patch series.
Tomas

????{.n?+???????+%?????????w??{.n?+????{??????????v?^?)????w*jg??????????j????G?????????j:+v???w?j?m????????w?????f???h?????????
