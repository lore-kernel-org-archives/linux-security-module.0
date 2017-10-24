From: prasannatsmkumar@gmail.com (PrasannaKumar Muralidharan)
Date: Tue, 24 Oct 2017 21:37:33 +0530
Subject: [tpmdd-devel] [PATCH] tpm: remove chip_num parameter from
	in-kernel API
In-Reply-To: <20171024155526.GA32250@obsidianresearch.com>
References: <20171023123817.18559-1-jarkko.sakkinen@linux.intel.com>
	<cbcb78c6-fa36-32d3-891e-96544875d97c@linux.vnet.ibm.com>
	<20171023163139.GA17394@obsidianresearch.com>
	<20171024154440.3jeupmus43jcgbbz@linux.intel.com>
	<CANc+2y4TbkfPT3d_sBd0MbE7ZJ4F7Sfsfvdv9V6=63=tRpWn4A@mail.gmail.com>
	<20171024155526.GA32250@obsidianresearch.com>
Message-ID: <CANc+2y6-P9MvjbL18h02SPwNMPyk4_cPFfL6LKHDXiKSHfv00A@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Jason,

On 24 October 2017 at 21:25, Jason Gunthorpe
<jgunthorpe@obsidianresearch.com> wrote:
> On Tue, Oct 24, 2017 at 09:21:15PM +0530, PrasannaKumar Muralidharan wrote:
>
>> Please check the RFC [1]. It does use chip id. The rfc has issues and
>> has to be fixed but still there could be users of the API.
>>
>> 1. https://www.spinics.net/lists/linux-crypto/msg28282.html
>
> That patch isn't safe at all. You need to store a kref to th chip in
> the hwrng, not parse a string.

The drivers/char/hw_random/tpm-rng.c module does not store the chip
reference so I guess the usage is safe. The RFC is just a sample use
case of the API.

Regards,
PrasannaKumar
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
