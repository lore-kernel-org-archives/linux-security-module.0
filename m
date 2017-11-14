From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Tue, 14 Nov 2017 16:34:21 +0200
Subject: [PATCH v2] tpm: Move Linux RNG connection to hwrng
In-Reply-To: <20171107160404.GG21466@ziepe.ca>
References: <20171031200503.GC18578@ziepe.ca>
	<20171105110506.usxmuzrvcjvxahr6@linux.intel.com>
	<20171106022704.GD26011@ziepe.ca>
	<CANc+2y6dx_2zOzFA5aFs7RpEV8aNqxpDghmx+q_+XyendYJoew@mail.gmail.com>
	<20171107160404.GG21466@ziepe.ca>
Message-ID: <20171114143421.3jxn6fzvgp2xmyk6@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Nov 07, 2017 at 09:04:04AM -0700, Jason Gunthorpe wrote:
> On Tue, Nov 07, 2017 at 08:50:44AM +0530, PrasannaKumar Muralidharan wrote:
> 
> > I am assuming you are talking about the following patches - using
> > struct tpm_chip instead of chip number and this patch.
> 
> yes
> 
> > I won't be able to test if struct tpm_chip usage as I don't have
> > multiple tpm hw in one machine. In case of tpm rng changes I can test
> > only the lifecycle of tpm rng device. Is that enough? I feel my test
> > will be limited. Please provide your thoughts on this.
> 
> That is certainly better than no testing.
> 
> Jason

WFM too.

Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
