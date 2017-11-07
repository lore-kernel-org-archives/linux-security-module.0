From: jgg@ziepe.ca (Jason Gunthorpe)
Date: Tue, 7 Nov 2017 09:04:04 -0700
Subject: [PATCH v2] tpm: Move Linux RNG connection to hwrng
In-Reply-To: <CANc+2y6dx_2zOzFA5aFs7RpEV8aNqxpDghmx+q_+XyendYJoew@mail.gmail.com>
References: <20171031200503.GC18578@ziepe.ca>
	<20171105110506.usxmuzrvcjvxahr6@linux.intel.com>
	<20171106022704.GD26011@ziepe.ca>
	<CANc+2y6dx_2zOzFA5aFs7RpEV8aNqxpDghmx+q_+XyendYJoew@mail.gmail.com>
Message-ID: <20171107160404.GG21466@ziepe.ca>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Nov 07, 2017 at 08:50:44AM +0530, PrasannaKumar Muralidharan wrote:

> I am assuming you are talking about the following patches - using
> struct tpm_chip instead of chip number and this patch.

yes

> I won't be able to test if struct tpm_chip usage as I don't have
> multiple tpm hw in one machine. In case of tpm rng changes I can test
> only the lifecycle of tpm rng device. Is that enough? I feel my test
> will be limited. Please provide your thoughts on this.

That is certainly better than no testing.

Jason
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
