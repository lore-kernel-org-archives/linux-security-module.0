From: tomas.winkler@intel.com (Winkler, Tomas)
Date: Thu, 15 Mar 2018 23:24:23 +0000
Subject: [PATCH v2 3/8] tpm: factor out tpm1_get_random into tpm1-cmd.c
In-Reply-To: <9c096454a78283ee3871b5dd47ed0bf664d26b7e.camel@linux.intel.com>
References: <20180310082428.31519-1-tomas.winkler@intel.com>
	<20180310082428.31519-4-tomas.winkler@intel.com>
	<9c096454a78283ee3871b5dd47ed0bf664d26b7e.camel@linux.intel.com>
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B94237DCA@hasmsx108.ger.corp.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

> 
> On Sat, 2018-03-10 at 10:24 +0200, Tomas Winkler wrote:
> > +		rlength = be32_to_cpu(tpm_cmd.header.out.length);
> > +		if (rlength < offsetof(struct tpm_getrandom_out, rng_data) +
> > +			      recd) {
> > +			total = -EFAULT;
> > +			break;
> > +		}
> > +		memcpy(dest, tpm_cmd.params.getrandom_out.rng_data,
> recd);
> 
> This rlength stuff can be handled with tpm_buf_length() as I do in my
> pendig-for-review patch set:
> 
> https://patchwork.kernel.org/patch/10259331/

Right, as I wrote before not sure it's good to move and change the code more than necessary at the same time. 
I would leave the tpm_buf_ changes after this series. 

Thanks
Tomas

????{.n?+???????+%?????????w??{.n?+????{??????????v?^?)????w*jg??????????j????G?????????j:+v???w?j?m????????w?????f???h?????????
