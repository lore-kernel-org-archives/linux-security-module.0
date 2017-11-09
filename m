From: prasannatsmkumar@gmail.com (PrasannaKumar Muralidharan)
Date: Thu, 9 Nov 2017 21:49:33 +0530
Subject: [PATCH v2] tpm: Move Linux RNG connection to hwrng
In-Reply-To: <20171107160404.GG21466@ziepe.ca>
References: <20171031200503.GC18578@ziepe.ca>
	<20171105110506.usxmuzrvcjvxahr6@linux.intel.com>
	<20171106022704.GD26011@ziepe.ca>
	<CANc+2y6dx_2zOzFA5aFs7RpEV8aNqxpDghmx+q_+XyendYJoew@mail.gmail.com>
	<20171107160404.GG21466@ziepe.ca>
Message-ID: <CANc+2y4GFaAryTN0vdBqWi=tqGdc6AMZ5fLnyFg-Jsrv4g-p5g@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Jason,

On 7 November 2017 at 21:34, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> On Tue, Nov 07, 2017 at 08:50:44AM +0530, PrasannaKumar Muralidharan wrote:
>
>> I am assuming you are talking about the following patches - using
>> struct tpm_chip instead of chip number and this patch.
>
> yes
>
>> I won't be able to test if struct tpm_chip usage as I don't have
>> multiple tpm hw in one machine. In case of tpm rng changes I can test
>> only the lifecycle of tpm rng device. Is that enough? I feel my test
>> will be limited. Please provide your thoughts on this.
>
> That is certainly better than no testing.

The struct tpm_chip patch partially applied on linux next. I had to
manually change the code. In qemu tpm rng device did not show up on
loading tpm module. My laptop has tpm hw but Linux next did not work
properly in that. All my console were getting spammed with some USB
log message and I could not do anything. X did not start either. I
could not debug the issue as the logs were printing infinitely. Will
get little more time this weekend. Will do a proper test and provide
you the result.

Regards,
PrasannaKumar
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
