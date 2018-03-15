From: tomas.winkler@intel.com (Winkler, Tomas)
Date: Thu, 15 Mar 2018 23:25:48 +0000
Subject: [PATCH v2 0/8] tpm: factor out tpm1 code into tpm1-cmd.c
In-Reply-To: <ee4a88f87158e8cb38f90b955af85d68b9105a97.camel@linux.intel.com>
References: <20180310082428.31519-1-tomas.winkler@intel.com>
	<ee4a88f87158e8cb38f90b955af85d68b9105a97.camel@linux.intel.com>
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B94237DDA@hasmsx108.ger.corp.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

> On Sat, 2018-03-10 at 10:24 +0200, Tomas Winkler wrote:
> > Move TPM1 implementation from tpm-interface.c to tpm1-cmd.c similarly
> > to tpm2-cmd.c, as well as move TPM2 open code flows into new functions
> > to tpm2-cmd.c The functions in tpm-interface.c should now be in form:
> 
> In which patch tpm1-cmd.c is created?

tpm: factor out tpm 1.2 duration calculation to tpm1-cmd.c

https://patchwork.kernel.org/patch/10259691/

> 
> /Jarkko
????{.n?+???????+%?????????w??{.n?+????{??????????v?^?)????w*jg??????????j????G?????????j:+v???w?j?m????????w?????f???h?????????
